package mysql2h2.convert;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.util.Random;

public class MysqlConvert {

	public static void main(String[] args) throws IOException {
		//input sql file ddl
		// String fileName="D:\\workspace-master\\common-test\\src\\main\\resources\\shopxx\\shopxxb2b2c.sql";
		 String fileName="D:\\workspace-master\\shopxxb2b2c.sql";
		//ouput sql file ddl
		 String outFile="data2.sql";
		 
		 BufferedReader reader=new BufferedReader(new InputStreamReader(new FileInputStream(fileName),"UTF-8"));
		 PrintWriter writer=new PrintWriter(new OutputStreamWriter(new FileOutputStream(outFile),"UTF-8"));
		 String line=null;
		 String pre=null;
		 while((line=reader.readLine())!=null){
			String dropTable="DROP TABLE IF EXISTS ";
			String creatTable="CREATE TABLE ";
			String innoDBTable=") ENGINE=InnoDB";
			String unqiueKeyTable="  UNIQUE KEY ";
			String keyTable="  KEY ";
			String foreignTable=" FOREIGN KEY ";
			String pkTable="  PRIMARY KEY ";
			
			String filedTable="  ";
			String newLine=line;
			
			if(line.startsWith(dropTable)){
				newLine="";
			}else if(line.contains(foreignTable)){
				
				newLine="";
				
			}else if(line.startsWith(pkTable)){
				
			}else if(line.startsWith(creatTable)){
				int sec = line.indexOf(" (", creatTable.length()+1);
				String name=line.substring(creatTable.length(),sec );
				newLine=creatTable+"\""+name.toUpperCase()+"\" "+line.substring(sec+1);
			}else if(line.startsWith(innoDBTable)){
				newLine=");";
			}else if(line.startsWith(unqiueKeyTable)){
				int sec = line.indexOf(" ", unqiueKeyTable.length());
				String filedName=line.substring(unqiueKeyTable.length(),sec);
				Random r=new Random();
				newLine=unqiueKeyTable+filedName+r.nextInt(10000)+" "+line.substring(sec+1);
				newLine="";
				
			}else if(line.startsWith(keyTable)){
				int sec = line.indexOf(" ", keyTable.length());
				String filedName=line.substring(keyTable.length(),sec);
				Random r=new Random();
				newLine=keyTable+/*filedName+r.nextInt(10000)+*/" "+line.substring(sec+1);
				
				newLine="";
			}else if(line.startsWith(filedTable)){
				int sec = line.indexOf(" ", filedTable.length());
				String filedName=line.substring(filedTable.length(),sec);
				newLine=filedTable+"\""+filedName.toUpperCase()+"\" "+line.substring(sec+1);;
			}else{
				   
			}
			  if(pre!=null&&pre.endsWith(",")&&newLine.trim().length()==0){
				  pre= pre.substring(0,  pre.length()-1);
			  }
			  if(pre!=null){
				  System.out.println(pre);
				  writer.println(pre);
			  }
				
			  
			  pre=newLine;
			  
		 }
		 
		  System.out.println(pre);
		  writer.println(pre);
		  reader.close();
		  writer.close();

	}

	private static String mixLen(String line, int len) {
	     if(line.length()<len){
	        for(int i=0,z=len-line.length();i<z;i++){
	        	line+=" ";
	        }
	     }
		return line;
	}

}
