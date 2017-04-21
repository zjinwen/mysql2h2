package mysql2h2.convert;

import java.io.ByteArrayOutputStream;
import java.io.Closeable;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.InetAddress;
import java.net.ServerSocket;
import java.net.Socket;
import java.nio.ByteBuffer;
import java.util.Arrays;
import java.util.Date;
import java.util.concurrent.CountDownLatch;
 
/**
 * ��׼��socks�����������֧��sock4��sock4����
 * 
 * @author Administrator
 * 
 */
public class SocksServerOneThread implements Runnable {
 
    /**
     * ��Դ�Ĵ���socket
     */
    private final Socket socket;
    /**
     * �Ƿ���socks4����
     */
    private final boolean openSock4;
    /**
     * �Ƿ���socks5����
     */
    private final boolean openSock5;
    /**
     * socks5����ĵ�¼�û�������� ��Ϊ�ձ�ʾ��Ҫ��¼��֤
     */
    private final String user;
    /**
     * socks5����ĵ�¼���룬
     */
    private final String pwd;
    /**
     * socks�Ƿ���Ҫ���е�¼��֤
     */
    private final boolean socksNeekLogin;
 
    /**
     * @param socket
     *            ��Դ�Ĵ���socket
     * @param openSock4
     *            �Ƿ���socks4����
     * @param openSock5
     *            �Ƿ���socks5����
     * @param user
     *            socks5����ĵ�¼�û�������� ��Ϊ�ձ�ʾ��Ҫ��¼��֤
     * @param pwd
     *            socks5����ĵ�¼���룬
     */
    protected SocksServerOneThread(Socket socket, boolean openSock4, boolean openSock5, String user, String pwd) {
        this.socket = socket;
        this.openSock4 = openSock4;
        this.openSock5 = openSock5;
        this.user = user;
        this.pwd = pwd;
        this.socksNeekLogin = null != user;
    }
 
    public void run() {
        // ��ȡ��Դ�ĵ�ַ������־��ӡʹ��
        String addr = socket.getRemoteSocketAddress().toString();
        log("process one socket : %s", addr);
        // ������
        InputStream a_in = null, b_in = null;
        OutputStream a_out = null, b_out = null;
        Socket proxy_socket = null;
        ByteArrayOutputStream cache = null;
        try {
            a_in = socket.getInputStream();
            a_out = socket.getOutputStream();
 
            // ��ȡЭ��ͷ��ȡ��������ͣ�ֻ�� 4��5��
            byte[] tmp = new byte[1];
            int n = a_in.read(tmp);
            if (n == 1) {
                byte protocol = tmp[0];
                if ((openSock4 && 0x04 == protocol)) {// �����������4������socks4Э������
                    proxy_socket = sock4_check(a_in, a_out);
                } else if ((openSock5 && 0x05 == protocol)) {// �����������5������socks5Э������
                    proxy_socket = sock5_check(a_in, a_out);
                } else {// ��socks 4 ,5 Э�������
                    log("not socks proxy : %s  openSock4[] openSock5[]", tmp[0], openSock4, openSock5);
                }
                if (null != proxy_socket) {
                    CountDownLatch latch = new CountDownLatch(1);
                    b_in = proxy_socket.getInputStream();
                    b_out = proxy_socket.getOutputStream();
                    // ����������
                    if (80 == proxy_socket.getPort()) {
                        cache = new ByteArrayOutputStream();
                    }
                    transfer(latch, a_in, b_out, cache);
                    transfer(latch, b_in, a_out, cache);
                    try {
                        latch.await();
                    } catch (Exception e) {
                    }
                }
            } else {
                log("socks error : %s", Arrays.toString(tmp));
            }
        } catch (Exception e) {
            log("exception : %s %s", e.getClass(), e.getLocalizedMessage());
            e.printStackTrace();
        } finally {
            log("close socket, system cleanning ...  %s ", addr);
            closeIo(a_in);
            closeIo(b_in);
            closeIo(b_out);
            closeIo(a_out);
            closeIo(socket);
            closeIo(proxy_socket);
            if (null != cache) {
                cache2Local(cache);
            }
        }
    }
 
    private void cache2Local(ByteArrayOutputStream cache) {
        // OutputStream result = null;
        // try {
        // String fileName = System.currentTimeMillis() + "_"
        // + Thread.currentThread().getId();
        // result = new FileOutputStream("E:/cache/" + fileName + ".info");
        // result.write(cache.toByteArray());
        // } catch (Exception e) {
        // e.printStackTrace();
        // } finally {
        // closeIo(result);
        // }
    }
 
    /**
     * sock5����ͷ����
     * 
     * @param in
     * @param out
     * @return
     * @throws IOException
     */
    private Socket sock5_check(InputStream in, OutputStream out) throws IOException {
        byte[] tmp = new byte[2];
        in.read(tmp);
        boolean isLogin = false;
        byte method = tmp[1];
        if (0x02 == tmp[0]) {
            method = 0x00;
            in.read();
        }
        if (socksNeekLogin) {
            method = 0x02;
        }
        tmp = new byte[] { 0x05, method };
        out.write(tmp);
        out.flush();
        // Socket result = null;
        Object resultTmp = null;
        if (0x02 == method) {// �����¼.
            int b = in.read();
            String user = null;
            String pwd = null;
            if (0x01 == b) {
                b = in.read();
                tmp = new byte[b];
                in.read(tmp);
                user = new String(tmp);
                b = in.read();
                tmp = new byte[b];
                in.read(tmp);
                pwd = new String(tmp);
                if (null != user && user.trim().equals(this.user) && null != pwd && pwd.trim().equals(this.pwd)) {// Ȩ�޹���
                    isLogin = true;
                    tmp = new byte[] { 0x05, 0x00 };// ��¼�ɹ�
                    out.write(tmp);
                    out.flush();
                    log("%s login success !", user);
                } else {
                    log("%s login faild !", user);
                }
            }
        }
        byte cmd = 0;
        if (!socksNeekLogin || isLogin) {// ��֤�Ƿ���Ҫ��¼
            tmp = new byte[4];
            in.read(tmp);
            log("proxy header >>  %s", Arrays.toString(tmp));
            cmd = tmp[1];
            String host = getHost(tmp[3], in);
            tmp = new byte[2];
            in.read(tmp);
            int port = ByteBuffer.wrap(tmp).asShortBuffer().get() & 0xFFFF;
            log("connect %s:%s", host, port);
            ByteBuffer rsv = ByteBuffer.allocate(10);
            rsv.put((byte) 0x05);
            try {
                if (0x01 == cmd) {
                    resultTmp = new Socket(host, port);
                    rsv.put((byte) 0x00);
                } else if (0x02 == cmd) {
                    resultTmp = new ServerSocket(port);
                    rsv.put((byte) 0x00);
                } else {
                    rsv.put((byte) 0x05);
                    resultTmp = null;
                }
            } catch (Exception e) {
                rsv.put((byte) 0x05);
                resultTmp = null;
            }
            rsv.put((byte) 0x00);
            rsv.put((byte) 0x01);
            rsv.put(socket.getLocalAddress().getAddress());
            Short localPort = (short) ((socket.getLocalPort()) & 0xFFFF);
            rsv.putShort(localPort);
            tmp = rsv.array();
        } else {
            tmp = new byte[] { 0x05, 0x01 };// ��¼ʧ��
            log("socks server need login,but no login info .");
        }
        out.write(tmp);
        out.flush();
        if (null != resultTmp && 0x02 == cmd) {
            ServerSocket ss = (ServerSocket) resultTmp;
            try {
                resultTmp = ss.accept();
            } catch (Exception e) {
            } finally {
                closeIo(ss);
            }
        }
        return (Socket) resultTmp;
    }
 
    /**
     * sock4�����ͷ����
     * 
     * @param in
     * @param out
     * @return
     * @throws IOException
     */
    private Socket sock4_check(InputStream in, OutputStream out) throws IOException {
        Socket proxy_socket = null;
        byte[] tmp = new byte[3];
        in.read(tmp);
        // ����Э��|VN1|CD1|DSTPORT2|DSTIP4|NULL1|
        int port = ByteBuffer.wrap(tmp, 1, 2).asShortBuffer().get() & 0xFFFF;
        String host = getHost((byte) 0x01, in);
        in.read();
        byte[] rsv = new byte[8];// ����һ��8λ����ӦЭ��
        // |VN1|CD1|DSTPORT2|DSTIP 4|
        try {
            proxy_socket = new Socket(host, port);
            log("connect [%s] %s:%s", tmp[1], host, port);
            rsv[1] = 90;// ����ɹ�
        } catch (Exception e) {
            log("connect exception  %s:%s", host, port);
            rsv[1] = 91;// ����ʧ��.
        }
        out.write(rsv);
        out.flush();
        return proxy_socket;
    }
 
    /**
     * ��ȡĿ��ķ�������ַ
     * 
     * @createTime 2014��12��14�� ����8:32:15
     * @param type
     * @param in
     * @return
     * @throws IOException
     */
    private String getHost(byte type, InputStream in) throws IOException {
        String host = null;
        byte[] tmp = null;
        switch (type) {
        case 0x01:// IPV4Э��
            tmp = new byte[4];
            in.read(tmp);
            host = InetAddress.getByAddress(tmp).getHostAddress();
            break;
        case 0x03:// ʹ������
            int l = in.read();
            tmp = new byte[l];
            in.read(tmp);
            host = new String(tmp);
            break;
        case 0x04:// ʹ��IPV6
            tmp = new byte[16];
            in.read(tmp);
            host = InetAddress.getByAddress(tmp).getHostAddress();
            break;
        default:
            break;
        }
        return host;
    }
 
    /**
     * IO�����й�ͬ�Ĺرշ���
     * 
     * @createTime 2014��12��14�� ����7:50:56
     * @param socket
     */
    protected static final void closeIo(Socket closeable) {
        if (null != closeable) {
            try {
                closeable.close();
            } catch (IOException e) {
            }
        }
    }
 
    /**
     * IO�����й�ͬ�Ĺرշ���
     * 
     * @createTime 2014��12��14�� ����7:50:56
     * @param socket
     */
    protected static final void closeIo(Closeable closeable) {
        if (null != closeable) {
            try {
                closeable.close();
            } catch (IOException e) {
            }
        }
    }
 
    /**
     * ���ݽ���.��Ҫ����tcpЭ��Ľ���
     * 
     * @createTime 2014��12��13�� ����11:06:47
     * @param lock
     *            ��
     * @param in
     *            ������
     * @param out
     *            �����
     */
    protected static final void transfer(final CountDownLatch latch, final InputStream in, final OutputStream out,
            final OutputStream cache) {
        new Thread() {
            public void run() {
                byte[] bytes = new byte[1024];
                int n = 0;
                try {
                    while ((n = in.read(bytes)) > 0) {
                        out.write(bytes, 0, n);
                        out.flush();
                        if (null != cache) {
                            synchronized (cache) {
                                cache.write(bytes, 0, n);
                            }
                        }
                    }
                } catch (Exception e) {
                }
                if (null != latch) {
                    latch.countDown();
                }
            };
        }.start();
    }
 
    private final static void log(String message, Object... args) {
        Date dat = new Date();
        String msg = String.format("%1$tF %1$tT %2$-5s %3$s%n", dat, Thread.currentThread().getId(),
                String.format(message, args));
        System.out.print(msg);
    }
 
    public static void startServer(int port, boolean openSock4, boolean openSock5, String user, String pwd)
            throws IOException {
        log("config >> port[%s] openSock4[%s] openSock5[%s] user[%s] pwd[%s]", port, openSock4, openSock5, user, pwd);
        ServerSocket ss = new ServerSocket(port);
        Socket socket = null;
        log("Socks server port : %s listenning...", port);
        while (null != (socket = ss.accept())) {
            new Thread(new SocksServerOneThread(socket, openSock4, openSock5, user, pwd)).start();
        }
        ss.close();
    }
 
    public static void main(String[] args) throws IOException {
        java.security.Security.setProperty("networkaddress.cache.ttl", "86400");
        log("\n\tUSing port openSock4 openSock5 user pwd");
        int port = 1080;
        boolean openSock4 = true;
        boolean openSock5 = true;
        String user = null, pwd = null;
        // user = "user";
        pwd = "123456";
        int i = 0;
        if (args.length > i && null != args[i++]) {
            port = Integer.valueOf(args[i].trim());
        }
        if (args.length > i && null != args[i++]) {
            openSock4 = Boolean.valueOf(args[i].trim());
        }
        if (args.length > i && null != args[i++]) {
            openSock5 = Boolean.valueOf(args[i].trim());
        }
        if (args.length > i && null != args[i++]) {
            user = args[i].trim();
        }
        if (args.length > i && null != args[i++]) {
            pwd = args[i].trim();
        }
        SocksServerOneThread.startServer(port, openSock4, openSock5, user, pwd);
    }
}