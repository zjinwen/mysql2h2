/*
Navicat MySQL Data Transfer

Source Server         : 114.55.109.155合肥测试
Source Server Version : 50615
Source Host           : 114.55.109.155:3306
Source Database       : clearing

Target Server Type    : MYSQL
Target Server Version : 50615
File Encoding         : 65001

Date: 2017-04-07 16:22:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for account_money_inout_diff
-- ----------------------------

CREATE TABLE ""ACCOUNT_MONEY_INOUT_DIFF"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""ACCOUNT_ID"" int(11) NOT NULL COMMENT '对账ID ，对应bank_market_account 的ID',
  ""BANK_SERIAL"" varchar(50) DEFAULT NULL COMMENT '银行流水号',
  ""TYPE"" smallint(6) DEFAULT NULL COMMENT '类型     1 入金   2 出金',
  ""BANK_REC_TIME"" datetime DEFAULT NULL COMMENT '银行记录时间',
  ""BANK_REC_AMOUNT"" decimal(16,4) DEFAULT NULL COMMENT '银行记录金额',
  ""BANK_REC_USERID"" varchar(20) DEFAULT NULL COMMENT '银行记录用户ID',
  ""BANK_REC_STATUS"" varchar(10) DEFAULT NULL COMMENT '银行记录状态',
  ""MARKET_REC_TIME"" datetime DEFAULT NULL COMMENT '市场记录时间',
  ""MARKET_REC_AMOUNT"" decimal(16,4) DEFAULT NULL COMMENT '市场记录金额',
  ""MARKET_REC_USERID"" varchar(10) DEFAULT NULL COMMENT '市场记录用户ID',
  ""MARKET_REC_STATUS"" varchar(10) DEFAULT NULL COMMENT '市场记录状态',
  ""ACCOUNT_STATUS"" smallint(6) DEFAULT NULL COMMENT '处理状态   1. 未处理    2 已处理',
  ""FLAG"" tinyint(255) DEFAULT NULL COMMENT '是否以银行为准',
  ""CHANNEL_ID"" int(11) DEFAULT NULL,
  ""TYPE_DESC"" varchar(50) DEFAULT NULL COMMENT '出入金类型描述',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for admin
-- ----------------------------

CREATE TABLE ""ADMIN"" (
  ""ID"" varchar(32) NOT NULL COMMENT 'id',
  ""ADMIN_ID"" varchar(64) NOT NULL COMMENT '用户名',
  ""REAL_NAME"" varchar(32) DEFAULT NULL COMMENT '真实姓名',
  ""EMPLOYEE_NO"" varchar(64) DEFAULT NULL COMMENT '员工编号',
  ""PASSWORD"" varchar(64) NOT NULL COMMENT '密码',
  ""DEPT"" int(11) DEFAULT NULL COMMENT '部门',
  ""EMAIL"" varchar(100) DEFAULT NULL,
  ""ID_CARD_NO"" varchar(32) DEFAULT NULL COMMENT '身份证号',
  ""MOBILE"" varchar(25) DEFAULT NULL,
  ""CITY"" int(11) DEFAULT NULL COMMENT '城市',
  ""POST"" varchar(32) DEFAULT NULL COMMENT '职位',
  ""CREATE_TIME"" datetime DEFAULT NULL COMMENT '创建日期',
  ""CREATOR"" varchar(64) DEFAULT NULL COMMENT '创建人员',
  ""AUDITOR"" varchar(64) DEFAULT NULL COMMENT '审核人',
  ""AUDIT_TIME"" datetime DEFAULT NULL COMMENT '审核日期',
  ""AUDIT_STATUS"" char(1) DEFAULT NULL COMMENT '审核状态',
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for admin_log
-- ----------------------------

CREATE TABLE ""ADMIN_LOG"" (
  ""ID"" varchar(32) NOT NULL COMMENT 'id',
  ""USER_ID"" varchar(64) NOT NULL COMMENT '用户名',
  ""LOGIN_TIME"" datetime DEFAULT NULL COMMENT '登录时间',
  ""IP_ADDRESS"" varchar(32) DEFAULT NULL COMMENT 'ip地址',
  ""LOGIN_RESULT"" varchar(16) DEFAULT NULL COMMENT '登录结果0:成功;1:失败',
  ""RES_INFO"" varchar(225) DEFAULT NULL,
  PRIMARY KEY (id)


);

-- ----------------------------
-- Table structure for area
-- ----------------------------

CREATE TABLE ""AREA"" (
  ""ID"" varchar(32) NOT NULL COMMENT 'id',
  ""NAME"" varchar(50) NOT NULL COMMENT '名称',
  ""SHORT_NAME"" varchar(50) DEFAULT NULL,
  ""PID"" varchar(32) DEFAULT NULL COMMENT '父级id',
  ""SEQ_NUM"" int(11) DEFAULT NULL COMMENT '排序',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for balance_check
-- ----------------------------

CREATE TABLE ""BALANCE_CHECK"" (
  ""ID"" bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  ""CHANNEL_ID"" int(11) DEFAULT NULL COMMENT '渠道编号',
  ""CLEARING_ID"" varchar(32) NOT NULL COMMENT '清算id',
  ""BANK_CUST_ACCT_ID"" varchar(64) DEFAULT NULL COMMENT '子账号',
  ""BANK_MAIN_ACCT_ID"" varchar(64) DEFAULT NULL COMMENT '上级监管账号',
  ""BANK_CUST_NAME"" varchar(64) DEFAULT NULL COMMENT '用户银行账号名称',
  ""BANK_CUST_STATUS"" tinyint(4) DEFAULT NULL COMMENT '银行账户状态:1：正常  2：已销户',
  ""FREE"" decimal(13,2) DEFAULT '0.00' COMMENT '可用余额',
  ""FREEZE"" decimal(13,2) DEFAULT '0.00' COMMENT '冻结余额',
  ""TOTAL_AMOUNT"" decimal(13,2) DEFAULT '0.00' COMMENT '总额',
  ""CREATED_AT"" datetime NOT NULL COMMENT '创建日期',
  PRIMARY KEY (id)



);

-- ----------------------------
-- Table structure for balance_check_account
-- ----------------------------

CREATE TABLE ""BALANCE_CHECK_ACCOUNT"" (
  ""ID"" bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  ""STATUS"" tinyint(4) DEFAULT NULL COMMENT '状态:0--已请求对帐，1--文件已生成，2--已匹配完成,但未确认, 3--失败',
  ""ACCOUNT_TIME"" date DEFAULT NULL COMMENT '对帐时间',
  ""INSERT_TIME"" datetime DEFAULT NULL COMMENT '插入时间',
  ""CHANNEL_ID"" int(11) DEFAULT NULL COMMENT '渠道',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for balance_check_diff
-- ----------------------------

CREATE TABLE ""BALANCE_CHECK_DIFF"" (
  ""ID"" bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  ""CHANNEL_ID"" int(11) DEFAULT NULL COMMENT '渠道编号',
  ""USER_ID"" varchar(32) NOT NULL COMMENT '用户id',
  ""MARKET_FREE"" decimal(13,2) NOT NULL DEFAULT '0.00' COMMENT '市场可用余额',
  ""MARKET_FREEZE"" decimal(13,2) NOT NULL DEFAULT '0.00' COMMENT '市场冻结余额',
  ""BANK_FREE"" decimal(13,2) NOT NULL DEFAULT '0.00' COMMENT '银行可用余额',
  ""BANK_FREEZE"" decimal(13,2) NOT NULL DEFAULT '0.00' COMMENT '银行冻结余额',
  ""FREE_DIFF"" decimal(13,2) NOT NULL DEFAULT '0.00' COMMENT '可用差额',
  ""FREEZE_DIFF"" decimal(13,2) NOT NULL DEFAULT '0.00' COMMENT '冻结差额',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for balance_transfer
-- ----------------------------

CREATE TABLE ""BALANCE_TRANSFER"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""TYPE"" varchar(30) NOT NULL COMMENT '类型   余额划转   待结转转出   待结转转入  利息  收益  银行轧差',
  ""AMOUNT"" decimal(16,2) NOT NULL,
  ""STATUS"" varchar(10) DEFAULT NULL COMMENT '状态   成功 失败',
  ""INSERT_TIME"" datetime DEFAULT NULL,
  ""SERIAL"" varchar(50) DEFAULT NULL,
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for bankno_cfg
-- ----------------------------

CREATE TABLE ""BANKNO_CFG"" (
  ""STD_BANK_NO"" varchar(3)  NOT NULL COMMENT '标准银行编号',
  ""CPCN_BANK_NO"" varchar(3)  NOT NULL COMMENT '中金银行编号',
  ""BANK_NAME"" varchar(50)  DEFAULT NULL COMMENT '银行名字',
  PRIMARY KEY (std_bank_no)
);

-- ----------------------------
-- Table structure for bank_bind
-- ----------------------------

CREATE TABLE ""BANK_BIND"" (
  ""ID"" bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  ""CHANNEL_ID"" int(11) DEFAULT NULL COMMENT '渠道编号',
  ""RECORD_NO"" varchar(4) DEFAULT NULL COMMENT '记录编号',
  ""BANK_SERIAL"" varchar(50) DEFAULT NULL COMMENT '银行流水号',
  ""STATUS"" tinyint(4) DEFAULT NULL COMMENT '开销户状态',
  ""BANK_ACCOUNT"" varchar(32) DEFAULT NULL COMMENT '银行帐号',
  ""ACCOUNT_FLAG"" tinyint(4) DEFAULT NULL COMMENT '帐户性质',
  ""ACCOUNT_NAME"" varchar(120) DEFAULT NULL COMMENT '子帐户名称',
  ""USER_ID"" varchar(32) NOT NULL COMMENT '用户编号',
  ""TRAN_DATE"" datetime DEFAULT NULL COMMENT '交易日期',
  ""COUNTER_ID"" varchar(12) DEFAULT NULL COMMENT '操作员编号',
  ""RESERVE"" varchar(120) DEFAULT NULL COMMENT '保留域',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for bank_bind_account
-- ----------------------------

CREATE TABLE ""BANK_BIND_ACCOUNT"" (
  ""ID"" bigint(20) NOT NULL AUTO_INCREMENT COMMENT '状态',
  ""MARKET_SERIAL"" varchar(32) DEFAULT NULL COMMENT '市场流水线',
  ""STATUS"" tinyint(4) DEFAULT NULL COMMENT '状态:0--未请求，1--请求中，2--已生成文件 ，3--已匹配完成',
  ""ACCOUNT_TIME"" date DEFAULT NULL COMMENT '对帐时间',
  ""INSERT_TIME"" datetime DEFAULT NULL COMMENT '插入时间',
  ""CHANNEL_ID"" int(11) DEFAULT NULL COMMENT '渠道',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for bank_bind_diff
-- ----------------------------

CREATE TABLE ""BANK_BIND_DIFF"" (
  ""ID"" bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  ""ACCOUNT_ID"" bigint(20) DEFAULT NULL COMMENT '记帐ID',
  ""CHANNEL_ID"" int(11) DEFAULT NULL COMMENT '渠道编号',
  ""BANK_ACCOUNT"" varchar(32) DEFAULT NULL COMMENT '银行帐号',
  ""BANK_UID"" bigint(20) DEFAULT NULL COMMENT '银行帐号绑定用户编号',
  ""BANK_STATUS"" tinyint(4) DEFAULT NULL COMMENT '银行帐号状态',
  ""BANK_ACCOUNT_NAME"" varchar(120) DEFAULT NULL COMMENT '银行帐号帐户名称',
  ""CLEARING_ACCOUNT"" varchar(32) DEFAULT NULL COMMENT '清算中心银行帐号',
  ""CLEARING_BANK_STATUS"" tinyint(4) DEFAULT NULL COMMENT '清算中心银行帐号状态',
  ""CLEARING_BANK_NAME"" varchar(120) DEFAULT NULL COMMENT '清算中心银行帐号帐户名称',
  ""CLEARING_BANK_UID"" bigint(20) DEFAULT NULL COMMENT '清算中心用户编号',
  ""STATUS"" tinyint(4) DEFAULT NULL COMMENT '状态 0-未同步,1--已同步',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for bank_capital_adjust
-- ----------------------------

CREATE TABLE ""BANK_CAPITAL_ADJUST"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""CHANNEL_ID"" int(11) DEFAULT NULL COMMENT '银行渠道ID',
  ""BANK_SERIAL"" varchar(50) DEFAULT NULL COMMENT '银行流水号',
  ""USER_ID"" varchar(20) DEFAULT NULL COMMENT '用户ID',
  ""TRANSFER_OPTION"" int(11) DEFAULT NULL COMMENT '入金或出金   0 入金    1 出金',
  ""TRANSFER_AMOUNT"" decimal(16,2) DEFAULT NULL COMMENT '转账金额',
  ""STATUS"" int(11) DEFAULT NULL COMMENT '处理状态  0 未处理   1 已处理',
  ""INSERT_TIME"" datetime DEFAULT NULL COMMENT '记录时间',
  ""UPDATE_TIME"" datetime DEFAULT NULL,
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for bank_card_bin
-- ----------------------------

CREATE TABLE ""BANK_CARD_BIN"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  ""BANKNO"" char(12) NOT NULL COMMENT '行号',
  ""FULLNAME"" varchar(100) NOT NULL COMMENT '银行全称',
  ""SHORTNAME"" varchar(20) NOT NULL COMMENT '银行简称',
  ""CARDTEMPLATE"" varchar(19) NOT NULL COMMENT '卡号模板',
  ""CARDLEN"" int(11) NOT NULL COMMENT '卡号长度',
  ""CARDBINLEN"" int(11) NOT NULL COMMENT '卡bin长度',
  ""CARDBIN"" varchar(19) NOT NULL COMMENT '卡bin',
  ""CARDTYPE"" varchar(20) NOT NULL COMMENT '卡类型名称',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for bank_charge_withdraw
-- ----------------------------

CREATE TABLE ""BANK_CHARGE_WITHDRAW"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""CHANNEL_ID"" int(11) DEFAULT NULL COMMENT '银行渠道ID',
  ""USER_ID"" varchar(20) DEFAULT NULL COMMENT '用户ID',
  ""MARKET_SERIAL"" varchar(50) DEFAULT NULL COMMENT '市场流水号',
  ""BANK_SERIAL"" varchar(50) DEFAULT NULL COMMENT '银行流水号',
  ""STATUS"" int(11) DEFAULT NULL COMMENT '处理状态  0 未处理   1 已处理   2 取消',
  ""TRANSFER_AMOUNT"" decimal(16,2) DEFAULT NULL COMMENT '转账金额',
  ""INSERT_TIME"" datetime DEFAULT NULL COMMENT '记录时间',
  ""TRANSFER_OPTION"" int(11) DEFAULT NULL COMMENT '入金或出金   0 入金    1 出金',
  ""UPDATE_TIME"" datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (id)



);

-- ----------------------------
-- Table structure for bank_clearing_diff
-- ----------------------------

CREATE TABLE ""BANK_CLEARING_DIFF"" (
  ""ID"" int(11) NOT NULL,
  ""MARKET_CODE"" varchar(10) NOT NULL COMMENT '市场编号',
  ""TRADE_SOURCE"" varchar(1) NOT NULL COMMENT '交易发起方',
  ""BANK_SERIAL"" varchar(50) NOT NULL COMMENT '银行流水号',
  ""MARKET_SERIAL"" varchar(50) NOT NULL COMMENT '市场流水号',
  ""INST_FUND_ACC"" varchar(20) NOT NULL COMMENT '交易商资金账号',
  ""MONEY_KIND"" varchar(10) NOT NULL COMMENT '币种',
  ""BANK_MONEY"" decimal(16,2) NOT NULL COMMENT '监管金额',
  ""MARKET_MONEY"" decimal(16,2) NOT NULL COMMENT '市场金额',
  ""RTN_CODE"" varchar(5) NOT NULL COMMENT '错误码',
  ""RTN_INFO"" varchar(250) DEFAULT NULL COMMENT '错误描述',
  ""DATE"" varchar(10) DEFAULT NULL COMMENT '交易日期',
  ""TIME"" varchar(10) DEFAULT NULL COMMENT '交易时间',
  ""SUMMARY1"" varchar(70) DEFAULT NULL COMMENT '业务备注',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for bank_market_account
-- ----------------------------

CREATE TABLE ""BANK_MARKET_ACCOUNT"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""CHANNEL_ID"" int(11) DEFAULT NULL COMMENT '渠道',
  ""ACCOUNT_TIME"" varchar(20) DEFAULT NULL COMMENT '对账日期',
  ""BANK_IN"" int(11) DEFAULT NULL COMMENT '银行入金数',
  ""BANK_IN_AMOUNT"" decimal(20,2) DEFAULT NULL COMMENT '银行入金金额',
  ""BANK_OUT"" int(11) DEFAULT NULL COMMENT '银行出金数',
  ""BANK_OUT_AMOUNT"" decimal(20,2) DEFAULT NULL COMMENT '银行出金金额',
  ""BANK_NETTING_AMOUNT"" decimal(20,2) DEFAULT NULL,
  ""MARKET_IN"" int(11) DEFAULT NULL COMMENT '市场入金数',
  ""MARKET_IN_AMOUNT"" decimal(20,2) DEFAULT NULL COMMENT '市场入金金额',
  ""MARKET_OUT"" int(11) DEFAULT NULL COMMENT '市场出金数',
  ""MARKET_OUT_AMOUNT"" decimal(20,2) DEFAULT NULL COMMENT '市场出金金额',
  ""MARKET_NETTING_AMOUNT"" decimal(20,2) DEFAULT NULL,
  ""INSERT_TIME"" datetime DEFAULT NULL COMMENT '记录时间',
  ""STATUS"" smallint(6) DEFAULT NULL COMMENT '状态  1 已生成出入金对账文件  2 已生成出入金对账记录 3 出入金对账完成',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for bank_transfer
-- ----------------------------

CREATE TABLE ""BANK_TRANSFER"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""TRADE_SOURCE"" varchar(1) NOT NULL COMMENT '交易发起方',
  ""INSTRUCTION_CODE"" varchar(10) NOT NULL COMMENT '交易码',
  ""BANK_SERIAL"" varchar(50) DEFAULT NULL COMMENT '银行流水号',
  ""BANK_ACCOUNT"" varchar(50) NOT NULL COMMENT '交易商银行账号',
  ""MARKET_CODE"" varchar(10) NOT NULL COMMENT '市场编号',
  ""INST_FUND_ACC"" varchar(20) NOT NULL COMMENT '资金账号',
  ""CLIENT_NAME"" varchar(60) DEFAULT NULL COMMENT '交易商姓名',
  ""CERT_TYPE"" varchar(1) DEFAULT NULL COMMENT '交易商证件类型',
  ""CERT_ID"" varchar(30) DEFAULT NULL COMMENT '交易商证件号',
  ""MONEY_KIND"" varchar(5) NOT NULL COMMENT '币种',
  ""TRANSFER_AMOUNT"" decimal(16,2) NOT NULL,
  ""SUMMARY1"" varchar(60) DEFAULT NULL COMMENT '业务备注1',
  ""SUMMARY2"" varchar(60) DEFAULT NULL COMMENT '业务备注2',
  ""DATE"" varchar(10) NOT NULL COMMENT '交易日期',
  ""TIME"" varchar(10) NOT NULL COMMENT '交易时间',
  ""MARKET_ACCT_NO"" varchar(50) DEFAULT NULL COMMENT '市场结算账号',
  ""CHANNEL_ID"" int(11) DEFAULT NULL,
  ""HAND_FEE"" varchar(15) DEFAULT NULL,
  ""FEE_CUST_ACCT_ID"" varchar(32) DEFAULT NULL,
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for bank_transfer_exchange
-- ----------------------------

CREATE TABLE ""BANK_TRANSFER_EXCHANGE"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""TYPE"" int(11) DEFAULT NULL COMMENT '1 入金    2 出金',
  ""BANK_SERIAL"" varchar(50)  DEFAULT NULL,
  ""BANK_ACCOUNT"" varchar(50)  DEFAULT NULL COMMENT '银行账号',
  ""USER_ID"" varchar(20)  DEFAULT NULL COMMENT '用户账号',
  ""USER_NAME"" varchar(255)  DEFAULT NULL COMMENT '用户名',
  ""TRANSFER_AMOUNT"" decimal(16,2) DEFAULT NULL COMMENT '入金或出金数量',
  ""DATE"" varchar(10)  DEFAULT NULL COMMENT '日期',
  ""TIME"" varchar(10)  DEFAULT NULL COMMENT '时间',
  ""EXCHANGE_ID"" int(11) DEFAULT NULL COMMENT '交易所ID',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for bank_verify_detail
-- ----------------------------

CREATE TABLE ""BANK_VERIFY_DETAIL"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""CLIENT_NAME"" varchar(32) DEFAULT NULL COMMENT '户名',
  ""STATUS"" varchar(32) DEFAULT NULL COMMENT '交易方式 如转账',
  ""TRANS_TIME"" timestamp NULL DEFAULT NULL COMMENT '交易日期',
  ""CHARGE_TIME"" timestamp NULL DEFAULT NULL COMMENT '记账日期',
  ""INSERT_TIME"" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '插入数据库时间',
  ""HOURS_MIN"" varchar(32) DEFAULT NULL COMMENT '时间时分',
  ""EXCHANGE_SERIAL"" varchar(32) DEFAULT NULL COMMENT '通讯流水号',
  ""TRANS_SERIAL"" varchar(32) DEFAULT NULL COMMENT '业务流水号',
  ""AMOUNT"" decimal(11,2) DEFAULT NULL COMMENT '交易金额',
  ""TYPE"" varchar(32) DEFAULT NULL COMMENT '交易类型如 DEBIT  CREDIT',
  ""PART1"" varchar(32) DEFAULT NULL COMMENT '银行名1',
  ""PART2"" varchar(32) DEFAULT NULL COMMENT '银行名2',
  ""CORE_TYPE"" varchar(32) DEFAULT NULL COMMENT '文件中两种  互联网核心 大额',
  ""CARD_NO"" varchar(32) DEFAULT NULL COMMENT '交易卡号',
  ""FILE_NAME"" varchar(255) DEFAULT NULL COMMENT '来源文件名',
  ""TRAN_ABS"" varchar(32) DEFAULT NULL COMMENT '交易摘要',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for bank_verify_file
-- ----------------------------

CREATE TABLE ""BANK_VERIFY_FILE"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""FILE_NAME"" varchar(255) DEFAULT NULL COMMENT '文件全名',
  ""FILE_TIME"" timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '查询时间 默认插入数据库时间',
  ""ALL_COUNT"" int(11) DEFAULT NULL COMMENT '总的交易笔数',
  ""DEB_COUNT"" int(11) DEFAULT NULL COMMENT '借款笔数',
  ""DEB_ALL_AMOUNT"" decimal(10,0) DEFAULT NULL COMMENT '总的借款金额',
  ""LEND_COUNT"" int(11) DEFAULT NULL COMMENT '贷款笔数',
  ""LEND_ALL_AMOUNT"" decimal(10,0) DEFAULT NULL COMMENT '总的贷款金额',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for channel
-- ----------------------------

CREATE TABLE ""CHANNEL"" (
  ""ID"" tinyint(4) NOT NULL AUTO_INCREMENT,
  ""CHANNEL_NAME"" varchar(10) NOT NULL COMMENT '渠道名',
  ""MARKET_CODE"" varchar(10) NOT NULL COMMENT '市场编号',
  ""CHANNEL_CODE"" varchar(5) NOT NULL COMMENT '渠道号',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for city
-- ----------------------------

CREATE TABLE ""CITY"" (
  ""CITY_CODE"" varchar(20) NOT NULL COMMENT '城市编码',
  ""CITY_NAME"" varchar(255) NOT NULL COMMENT '城市名称',
  ""PROVINCE_NAME"" varchar(255) NOT NULL COMMENT '所属省份名称',
  PRIMARY KEY (city_code)
);

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------

CREATE TABLE ""DICTIONARY"" (
  ""ID"" varchar(32) NOT NULL COMMENT 'id',
  ""TYPE_CODE"" varchar(64) DEFAULT NULL COMMENT '类型编码',
  ""TYPE_NAME"" varchar(64) DEFAULT NULL COMMENT '类型名称',
  ""CODE"" varchar(64) DEFAULT NULL COMMENT '编码',
  ""DISPLAY_NAME"" varchar(64) DEFAULT NULL COMMENT '名称',
  ""PID"" varchar(32) DEFAULT NULL COMMENT '父级id',
  ""SEQ_NUM"" int(11) DEFAULT NULL COMMENT '排序',
  ""DESCRIPTION"" varchar(100) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for exchange
-- ----------------------------

CREATE TABLE ""EXCHANGE"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  ""EXCHANGE_NAME"" varchar(100) NOT NULL COMMENT '交易所名称',
  ""DESCRIPTION"" varchar(100) DEFAULT NULL COMMENT '交易所名称',
  ""STATUS"" tinyint(4) DEFAULT NULL COMMENT '交易所状态 1已签到 2已前腿',
  ""ROOT_URL"" varchar(255) DEFAULT NULL COMMENT '交易所接口地址',
  ""AUDIT_DURATION"" smallint(6) NOT NULL DEFAULT '0',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for exch_daily_snapshot_product_price
-- ----------------------------

CREATE TABLE ""EXCH_DAILY_SNAPSHOT_PRODUCT_PRICE"" (
  ""EXCHANGE_ID"" int(11) NOT NULL DEFAULT '0' COMMENT '所属交易所',
  ""ID"" bigint(20) NOT NULL,
  ""SYMBOL"" varchar(100) DEFAULT NULL COMMENT '产品代码',
  ""PRICE"" decimal(12,2) DEFAULT NULL COMMENT '交易价格',
  ""TIME"" date DEFAULT NULL COMMENT '交易时间',
  ""PREV_CLOSE"" decimal(12,5) DEFAULT NULL COMMENT '昨收价格',
  ""OPEN"" decimal(12,5) DEFAULT NULL COMMENT '开盘价格',
  ""HIGH"" decimal(12,5) DEFAULT NULL,
  ""LOW"" decimal(12,5) DEFAULT NULL,
  ""VOLUME"" bigint(20) DEFAULT NULL COMMENT '成交量',
  ""TRADED_MONEY"" decimal(12,2) DEFAULT NULL COMMENT '成交额',
  ""CIRCULATION"" bigint(20) DEFAULT NULL COMMENT '流通量',
  ""TOTAL"" decimal(12,2) DEFAULT NULL COMMENT '总量',
  ""MAX_MIN_STATUS"" tinyint(4) DEFAULT '0' COMMENT '是否涨停跌停，0，无涨跌停；1，涨停；2，跌停',
  PRIMARY KEY (exchange_id,id)

);

-- ----------------------------
-- Table structure for exch_lottery
-- ----------------------------

CREATE TABLE ""EXCH_LOTTERY"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT COMMENT '摇号',
  ""EXCHANGE_ID"" int(11) NOT NULL DEFAULT '0' COMMENT '所属交易所',
  ""USER_ID"" varchar(64) DEFAULT NULL COMMENT '用户id',
  ""PROJECT_ID"" int(11) DEFAULT NULL COMMENT '项目Id',
  ""START"" bigint(11) DEFAULT NULL,
  ""END"" bigint(11) DEFAULT NULL,
  ""PURCHASE_NUM"" int(11) DEFAULT NULL COMMENT '申购数量',
  ""PURCHASE_TIME"" datetime DEFAULT NULL,
  ""STATUS"" int(11) DEFAULT '0',
  ""WIN_NUMBER"" int(11) DEFAULT NULL COMMENT '中签数量',
  ""TRAN_ID"" int(11) DEFAULT NULL,
  ""PURCHASE_PRICE"" decimal(10,2) DEFAULT NULL,
  ""COST"" decimal(10,2) DEFAULT NULL,
  ""FEE"" decimal(10,2) DEFAULT '0.00',
  PRIMARY KEY (id)


);

-- ----------------------------
-- Table structure for exch_order_history
-- ----------------------------

CREATE TABLE ""EXCH_ORDER_HISTORY"" (
  ""EXCHANGE_ID"" int(11) NOT NULL DEFAULT '0' COMMENT '所属交易所',
  ""ID"" bigint(20) NOT NULL,
  ""ORDER_ID"" decimal(12,0) NOT NULL COMMENT '订单号',
  ""SYMBOL"" varchar(10) NOT NULL COMMENT '产品代码',
  ""ACCOUNT_ID"" decimal(12,0) NOT NULL COMMENT '交易账号',
  ""ORIG_CLIENT_ORDER_ID"" varchar(100) DEFAULT NULL COMMENT '原始客户单号',
  ""CLIENT_ORDER_ID"" varchar(100) DEFAULT NULL COMMENT '客户单号',
  ""PRICE"" decimal(12,5) DEFAULT NULL COMMENT '价格',
  ""ORIG_QTY"" decimal(12,5) NOT NULL COMMENT '下单数量',
  ""EXECUTED_QTY"" decimal(12,5) DEFAULT NULL COMMENT '成交数量',
  ""STATUS"" varchar(50) NOT NULL COMMENT '状态(NEW: 未成交, PARTIALLY_FILLED: 部分成交, FILLED: 全部成交, CANCELLED: 已撤销)',
  ""TIME_IN_FORCE"" varchar(10) DEFAULT NULL COMMENT '订单生存周期',
  ""TYPE"" varchar(10) NOT NULL COMMENT '订单类型',
  ""SIDE"" varchar(10) NOT NULL COMMENT '买卖方向',
  ""STOP_PRICE"" decimal(12,5) DEFAULT NULL COMMENT '突破价格',
  ""UPDATE_TIME"" datetime DEFAULT NULL COMMENT '订单更新时间',
  ""TIME"" datetime NOT NULL COMMENT '下单时间',
  PRIMARY KEY (exchange_id,id)




);

-- ----------------------------
-- Table structure for exch_product
-- ----------------------------

CREATE TABLE ""EXCH_PRODUCT"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""EXCHANGE_ID"" int(11) NOT NULL DEFAULT '0' COMMENT '所属交易所',
  ""PRODUCT_CODE"" varchar(10) NOT NULL,
  ""PRODUCT_NAME"" varchar(50) DEFAULT NULL,
  ""INITIAL"" varchar(20) DEFAULT NULL COMMENT '产品名称拼音首字母缩写',
  ""PRODUCT_TYPE"" tinyint(4) DEFAULT NULL,
  ""PRODUCT_FEE"" decimal(20,4) DEFAULT '0.0000',
  ""MIN_PRODUCT_WITHDRAW"" int(11) DEFAULT '0',
  ""PRODUCT_DESC"" text,
  ""PRODUCT_PIC"" varchar(1000) DEFAULT NULL,
  ""WITHDRAW_INTEGER_MULTIPLE"" int(11) DEFAULT NULL,
  PRIMARY KEY (id)


);

-- ----------------------------
-- Table structure for exch_project
-- ----------------------------

CREATE TABLE ""EXCH_PROJECT"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  ""EXCHANGE_ID"" int(11) NOT NULL DEFAULT '0' COMMENT '所属交易所',
  ""PROJECT_ID"" int(11) NOT NULL COMMENT '项目ID',
  ""PROJECT_CODE"" varchar(10) DEFAULT NULL COMMENT '项目代码',
  ""PROJECT_NAME"" varchar(100) DEFAULT NULL COMMENT '项目名称',
  ""PRODUCT_CODE"" varchar(10) NOT NULL COMMENT '产品代码',
  ""IN_MARKET_RATIO"" decimal(5,4) DEFAULT NULL COMMENT '面市比例',
  ""IN_MARKET_NUM"" int(11) DEFAULT NULL COMMENT '面市数量',
  ""DISTRIBUTE_RATIO"" decimal(5,4) DEFAULT NULL COMMENT '发行比例',
  ""NON_CIRCULATE_NUM"" int(11) DEFAULT NULL,
  ""DISTRIBUTE_NUM"" int(11) DEFAULT NULL COMMENT '发行数量',
  ""DISTRIBUTE_RATE"" decimal(5,4) DEFAULT NULL COMMENT '发行费率',
  ""PROJECT_DESC"" text COMMENT '项目简介',
  ""BG_PLACING_RATIO"" decimal(5,4) DEFAULT NULL COMMENT '后台配售比例',
  ""BG_PLACING_NUM"" int(11) DEFAULT NULL COMMENT '后台配售数量',
  ""BG_PLACING_PRICE"" decimal(10,2) DEFAULT NULL COMMENT '后台配售价格',
  ""BG_SUBSCRIPTION_RATE"" decimal(5,4) DEFAULT NULL COMMENT '后台认购费率',
  ""FT_PLACING_NUM"" int(11) DEFAULT NULL COMMENT '前台配售数量',
  ""FT_PLACING_PRICE"" decimal(10,2) DEFAULT NULL COMMENT '前台配售价格',
  ""FT_PLACING_RATE"" decimal(5,4) DEFAULT '0.0000' COMMENT '前台配售手续费',
  ""FT_PLACING_START_TIME"" datetime DEFAULT NULL COMMENT '前台配售开始时间',
  ""FT_PLACING_END_TIME"" datetime DEFAULT NULL COMMENT '前台配售结束时间',
  ""FT_PURCHASE_TYPE"" tinyint(4) DEFAULT NULL COMMENT '前台购买类型1:先到先得 2：摇号购买',
  ""FT_CROWNDFUND_NUM"" int(11) DEFAULT NULL COMMENT '前台总筹数量',
  ""FT_DISTRIBUTE_PRICE"" decimal(10,2) DEFAULT NULL COMMENT '前台发行价格',
  ""FT_DISTRIBUTE_AMOUNT"" decimal(22,2) DEFAULT NULL COMMENT '前台发行总额',
  ""FT_START_DATE"" datetime DEFAULT NULL COMMENT '总筹开始时间',
  ""FT_END_DATE"" datetime DEFAULT NULL COMMENT '总筹结束时间',
  ""FT_DISTRIBUTE_SUCCESS_RATIO"" decimal(5,4) DEFAULT NULL COMMENT '众筹成功发行比例',
  ""FT_MAX_SUBSCRIPTION_NUM"" int(11) DEFAULT NULL COMMENT '最高认购数量',
  ""FT_SUBSCRIPTION_RATE"" decimal(5,4) DEFAULT NULL COMMENT '前台总筹认购费率',
  ""SC_REVENUE_SHARING_RATIO"" decimal(5,4) DEFAULT NULL COMMENT '明星卡收益分成比例',
  ""SC_REVENUE_DISTRIBUTE_CYCLE"" decimal(3,1) DEFAULT NULL COMMENT '收益分成周期',
  ""SC_RENEW_START_DATE"" datetime DEFAULT NULL COMMENT '续存开始时间',
  ""SC_RENEW_END_DATE"" datetime DEFAULT NULL COMMENT '续存结束时间',
  ""PROJECT_DETAILED_DESC"" text COMMENT '项目详细描述',
  ""PROJECT_STATUS"" varchar(4) DEFAULT NULL COMMENT '项目状态  0 未上架   1.预热中  2. 发行中   3. 发行成功  4. 发行失败    5 已扣款 6 已上市',
  ""INSERT_TIME"" datetime DEFAULT NULL COMMENT '生成时间',
  ""UPDATE_TIME"" datetime DEFAULT NULL COMMENT '更新时间',
  ""PREHEAT_TIME"" datetime DEFAULT NULL COMMENT '预热时间',
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for exch_project_purchase
-- ----------------------------

CREATE TABLE ""EXCH_PROJECT_PURCHASE"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""EXCHANGE_ID"" int(11) NOT NULL DEFAULT '0' COMMENT '所属交易所',
  ""PROJECT_ID"" int(11) NOT NULL COMMENT '申购项目ID',
  ""USER_ID"" varchar(64) NOT NULL COMMENT '用户ID',
  ""PURCHASE_PRICE"" decimal(10,2) NOT NULL COMMENT '购买单价',
  ""PURCHASE_NUM"" int(11) NOT NULL COMMENT '申购数量',
  ""PURCHASE_DATE"" datetime NOT NULL COMMENT '申购时间',
  ""TRAN_ID"" bigint(20) DEFAULT NULL COMMENT '流水号',
  ""TYPE"" tinyint(4) DEFAULT NULL COMMENT '类型：1，前台购买，2后台配售',
  ""STATUS"" tinyint(4) DEFAULT NULL COMMENT '状态：0进行中 1成功 2失败',
  ""FEE"" decimal(10,2) DEFAULT '0.00',
  ""COST"" decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (id)



);

-- ----------------------------
-- Table structure for exch_trade_history
-- ----------------------------

CREATE TABLE ""EXCH_TRADE_HISTORY"" (
  ""EXCHANGE_ID"" int(11) NOT NULL DEFAULT '0' COMMENT '所属交易所',
  ""ID"" bigint(20) NOT NULL,
  ""TRADE_ID"" decimal(12,0) NOT NULL COMMENT '交易单号',
  ""SYMBOL"" varchar(100) NOT NULL COMMENT '产品代码',
  ""BUYER_ORDER_ID"" decimal(12,0) DEFAULT NULL COMMENT '买单编号',
  ""SELLER_ORDER_ID"" decimal(12,0) DEFAULT NULL COMMENT '卖单编号',
  ""BUYER_FEE"" decimal(12,5) DEFAULT NULL COMMENT '买家交易费',
  ""SELLER_FEE"" decimal(12,5) DEFAULT NULL COMMENT '卖家交易费',
  ""PRICE"" decimal(12,5) NOT NULL COMMENT '交易价格',
  ""QTY"" decimal(12,5) NOT NULL COMMENT '交易数量',
  ""ACTIVE_BUY"" bit(1) DEFAULT '0' COMMENT '是否主动买',
  ""TIME"" datetime NOT NULL COMMENT '交易时间',
  PRIMARY KEY (exchange_id,id)





);

-- ----------------------------
-- Table structure for exch_trading_statistics
-- ----------------------------

CREATE TABLE ""EXCH_TRADING_STATISTICS"" (
  ""EXCHANGE_ID"" int(11) NOT NULL DEFAULT '0' COMMENT '所属交易所',
  ""ID"" int(11) NOT NULL,
  ""USER_ID"" varchar(64) DEFAULT NULL,
  ""AGENT_ID"" varchar(64) DEFAULT NULL,
  ""AGENT_LEVEL"" int(11) DEFAULT NULL,
  ""DATE"" date DEFAULT NULL,
  ""TOTAL_COUNT"" decimal(20,2) DEFAULT NULL COMMENT '总交易量',
  ""TOTAL_AMOUNT"" decimal(20,2) DEFAULT NULL COMMENT '总交易额',
  ""BUY_COUNT"" decimal(20,2) DEFAULT NULL COMMENT '买量',
  ""BUY_AMOUNT"" decimal(20,2) DEFAULT NULL COMMENT '买额',
  ""SELL_COUNT"" decimal(20,2) DEFAULT NULL COMMENT '卖量',
  ""SELL_AMOUNT"" decimal(20,2) DEFAULT NULL COMMENT '卖额',
  ""COMMISSION"" decimal(20,2) DEFAULT NULL COMMENT '佣金',
  ""FEE"" decimal(20,2) DEFAULT '0.00' COMMENT '手续费',
  ""DESCRIPTION"" varchar(128) DEFAULT NULL,
  PRIMARY KEY (exchange_id,id)

);

-- ----------------------------
-- Table structure for exch_user
-- ----------------------------

CREATE TABLE ""EXCH_USER"" (
  ""EXCHANGE_ID"" int(11) NOT NULL DEFAULT '0' COMMENT '所属交易所',
  ""USER_ID"" varchar(64) NOT NULL COMMENT '用户名',
  ""PARENT"" varchar(64) DEFAULT NULL COMMENT '主账户',
  ""AGENT_ID"" varchar(64) DEFAULT NULL COMMENT '经纪人代码',
  ""AGENT_LEVEL"" int(11) DEFAULT NULL COMMENT '经纪人级别',
  ""SALEMAN"" varchar(64) DEFAULT NULL COMMENT '业务员',
  ""AGENT_PROVINCE"" int(11) DEFAULT NULL COMMENT '经纪人负责的省份',
  ""AGENT_REWARD_RATIO"" decimal(6,6) DEFAULT NULL COMMENT '经纪人返佣比例',
  ""TRADING_ACCOUNT"" decimal(10,0) DEFAULT NULL COMMENT '用户交易账户',
  ""BUYER_COMMISSION"" decimal(6,6) DEFAULT '0.000000' COMMENT '买方交易手续费',
  ""SELLER_COMMISSION"" decimal(6,6) DEFAULT '0.000000' COMMENT '卖方交易手续费',
  ""CREATE_TIME"" datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (exchange_id,user_id)



);

-- ----------------------------
-- Table structure for exch_user_asset
-- ----------------------------

CREATE TABLE ""EXCH_USER_ASSET"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""EXCHANGE_ID"" int(11) NOT NULL DEFAULT '0' COMMENT '所属交易所',
  ""UID"" varchar(32) NOT NULL COMMENT '用户ID',
  ""PRODUCT_SYMBOL"" varchar(32) NOT NULL COMMENT '产品代码',
  ""FREE"" decimal(14,4) NOT NULL DEFAULT '0.0000' COMMENT '可用持仓',
  ""LOCKED"" decimal(14,4) NOT NULL DEFAULT '0.0000' COMMENT '下单冻结',
  ""T_PLUS_LOCKED"" decimal(14,5) NOT NULL DEFAULT '0.00000' COMMENT 'T+N 锁定数量',
  ""FREEZE"" decimal(14,4) DEFAULT '0.0000' COMMENT '冻结资产',
  ""WITHDRAWING"" decimal(14,4) DEFAULT '0.0000' COMMENT '提货中',
  ""IPOING"" decimal(14,4) NOT NULL DEFAULT '0.0000' COMMENT '正在发行中',
  ""IPOABLE"" decimal(14,4) NOT NULL DEFAULT '0.0000' COMMENT '可发行的',
  ""STORAGE"" decimal(14,4) NOT NULL DEFAULT '0.0000' COMMENT '库存量',
  ""COST"" decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '持仓成本',
  ""REAL_COST"" decimal(14,2) NOT NULL DEFAULT '0.00',
  ""EOD_PNL"" decimal(14,2) NOT NULL DEFAULT '0.00' COMMENT '日终盈亏',
  ""MODIFIED_AT"" datetime NOT NULL COMMENT '修改时间',
  ""CREATED_AT"" datetime NOT NULL COMMENT '创建时间',
  ""LAST_ASSET"" decimal(14,2) DEFAULT NULL,
  PRIMARY KEY (id)


);

-- ----------------------------
-- Table structure for exch_user_asset_log
-- ----------------------------

CREATE TABLE ""EXCH_USER_ASSET_LOG"" (
  ""EXCHANGE_ID"" int(11) NOT NULL DEFAULT '0' COMMENT '所属交易所',
  ""ID"" bigint(20) NOT NULL,
  ""TRAN_ID"" bigint(20) NOT NULL COMMENT '流水单号',
  ""UID"" varchar(32) NOT NULL COMMENT '用户ID',
  ""PRODUCT_SYMBOL"" varchar(32) NOT NULL COMMENT '产品代码',
  ""TYPE"" int(11) NOT NULL COMMENT '更改类型',
  ""DELTA"" decimal(14,4) DEFAULT NULL COMMENT '更改数量',
  ""FREE"" decimal(14,4) NOT NULL COMMENT '可用持仓',
  ""LOCKED"" decimal(14,4) NOT NULL COMMENT '下单冻结',
  ""FREEZE"" decimal(14,4) DEFAULT NULL COMMENT '冻结资产',
  ""WITHDRAWING"" decimal(14,4) DEFAULT NULL COMMENT '提货中',
  ""IPOING"" decimal(14,4) DEFAULT NULL COMMENT '正在发行中',
  ""IPOABLE"" decimal(14,4) DEFAULT NULL COMMENT '可发行的',
  ""STORAGE"" decimal(14,4) DEFAULT NULL,
  ""COST"" decimal(14,2) DEFAULT NULL COMMENT '持仓成本',
  ""EOD_PNL"" decimal(14,2) DEFAULT NULL,
  ""INFO"" varchar(32) DEFAULT NULL COMMENT '更改描述',
  ""TIME"" datetime NOT NULL COMMENT '更改时间',
  ""REAL_COST"" decimal(14,2) DEFAULT NULL,
  ""REAL_PNL"" decimal(14,2) DEFAULT NULL,
  PRIMARY KEY (exchange_id,id)



);

-- ----------------------------
-- Table structure for exch_user_data
-- ----------------------------

CREATE TABLE ""EXCH_USER_DATA"" (
  ""EXCHANGE_ID"" int(11) DEFAULT NULL COMMENT '所属交易所',
  ""USER_ID"" varchar(64) NOT NULL COMMENT '用户ID',
  ""ACTIVE"" tinyint(1) DEFAULT NULL COMMENT '是否激活0:否;1:是',
  ""PURCHASE"" tinyint(1) DEFAULT NULL COMMENT '是否可申购0:否;1:是',
  ""TRADE"" tinyint(1) DEFAULT NULL COMMENT '是否可交易0:否;1:是',
  ""CHANGE_PASS"" tinyint(1) DEFAULT NULL,
  ""FULL_DEPTH"" tinyint(1) DEFAULT '0' COMMENT '0：非全部深度 1:全部深度',
  ""CHILDREN"" tinyint(1) DEFAULT NULL COMMENT '是否有子账户   1 有子账户   0或空 没有',
  ""AGENT_COMMENT"" varchar(128) DEFAULT NULL COMMENT '经纪人描述',
  ""COMMENT"" varchar(64) DEFAULT NULL COMMENT '备注',
  ""ACTIVATE_TIME"" datetime DEFAULT NULL COMMENT '激活时间',
  ""UPDATE_TIME"" datetime DEFAULT NULL COMMENT '更新时间',
  ""PROTOCOL_CONFIRM"" tinyint(1) DEFAULT NULL,
  ""USER_TYPE"" varchar(32) DEFAULT NULL COMMENT '投资者类型',
  ""UNION_ID"" varchar(64) DEFAULT NULL COMMENT '微信unionid'

);

-- ----------------------------
-- Table structure for exch_user_security
-- ----------------------------

CREATE TABLE ""EXCH_USER_SECURITY"" (
  ""ID"" int(12) NOT NULL AUTO_INCREMENT COMMENT 'id',
  ""EXCHANGE_ID"" int(11) DEFAULT NULL COMMENT '所属交易所',
  ""USER_ID"" varchar(64) NOT NULL COMMENT '用户名',
  ""LAST_LOGIN_TIME"" datetime DEFAULT NULL COMMENT '上次登录时间',
  ""LOGIN_FAILED_NUM"" int(11) DEFAULT NULL COMMENT '当日密码错误次数',
  ""LOGIN_FAILED_TIME"" datetime DEFAULT NULL COMMENT '登录失败日期',
  ""CASH_PASSWORD"" varchar(32) DEFAULT NULL COMMENT '交易密码',
  ""PAY_PWD_FAILED_NUM"" int(11) DEFAULT NULL,
  ""DISABLE_TIME"" datetime DEFAULT NULL COMMENT '禁用时间',
  ""USER_TYPE"" varchar(16) DEFAULT NULL COMMENT '用户类型P:普通用户;A:后台用户;M:入驻商户',
  ""STATUS"" char(16) DEFAULT NULL COMMENT '状态:0,正常;1,禁用;2,锁定',
  ""SECRET_KEY"" varchar(32) DEFAULT NULL,
  ""VALIDATION_STATUS"" int(11) DEFAULT NULL,
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for market_clearing
-- ----------------------------

CREATE TABLE ""MARKET_CLEARING"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""ACCOUNT_ID"" int(11) NOT NULL COMMENT '余额对账ID',
  ""USER_ID"" varchar(10) DEFAULT NULL COMMENT '交易商资金账号',
  ""BEGINNING_BALANCE"" decimal(16,2) DEFAULT NULL COMMENT '期初余额',
  ""TRAS_COMM"" decimal(16,2) DEFAULT NULL COMMENT '手续费',
  ""CHANGE_MONEY"" decimal(16,2) DEFAULT NULL COMMENT '资金变动',
  ""COMP_ENABLE_MONEY"" decimal(16,2) DEFAULT NULL COMMENT '账户余额',
  ""EXCHANGE_ID"" int(11) DEFAULT NULL COMMENT '交易所ID',
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for market_clearing_account
-- ----------------------------

CREATE TABLE ""MARKET_CLEARING_ACCOUNT"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""STATUS"" smallint(6) DEFAULT NULL COMMENT '状态   0 文件未生成  1 文件已生成  2 对账已完成   3 对账已确认',
  ""INSERT_TIME"" datetime DEFAULT NULL COMMENT '操作时间',
  ""FILE_NAME"" varchar(200) DEFAULT NULL COMMENT '生成的交易对账文件名',
  ""MD5"" varchar(64) DEFAULT NULL,
  ""EXCHANGE_ID"" int(11) DEFAULT NULL COMMENT '交易所ID',
  ""CHANNEL_ID"" int(11) DEFAULT NULL COMMENT '渠道',
  ""ACCOUNT_DATE"" varchar(15) DEFAULT NULL COMMENT '对账日期',
  ""FILE_LEN"" bigint(20) DEFAULT '0' COMMENT '文件大小(单位: bytes)',
  ""CLEARING_STATUS"" tinyint(4) DEFAULT '0' COMMENT '清算状态，0--不可用状态, 1--清算进行中,2--清算成功,3--清算失败,4--对帐不平',
  ""CLEARING_INFO"" varchar(200) DEFAULT NULL COMMENT '清算结果信息，平安银行为文件名',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for market_clearing_diff
-- ----------------------------

CREATE TABLE ""MARKET_CLEARING_DIFF"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""ACCOUNT_ID"" int(11) NOT NULL COMMENT '对账ID',
  ""USER_ID"" varchar(10)  DEFAULT NULL COMMENT '交易商资金账号',
  ""COMM"" decimal(16,2) DEFAULT NULL COMMENT '手续费',
  ""BEGIN_BALANCE"" decimal(16,2) DEFAULT NULL COMMENT '期初余额',
  ""CHANGE_MONEY"" decimal(16,2) DEFAULT NULL COMMENT '资金变动',
  ""CLEARING_BALANCE"" decimal(16,2) DEFAULT NULL COMMENT '结算账户余额',
  ""ACTUAL_BALANCE"" decimal(16,2) DEFAULT '0.00' COMMENT '实际账户余额',
  ""DIFFERENCE"" decimal(16,2) DEFAULT '0.00' COMMENT '差额',
  ""INSERT_TIME"" datetime DEFAULT NULL,
  ""DIFF_TYPE"" int(255) DEFAULT NULL COMMENT '1 用户有问题的账务   2 问题总   3 ',
  ""EXCHANGE_ID"" int(11) DEFAULT NULL COMMENT '交易所ID',
  ""MONEY_IN"" decimal(16,2) DEFAULT NULL COMMENT '入金总和',
  ""MONEY_OUT"" decimal(16,2) DEFAULT NULL COMMENT '出金总和',
  ""ERROR_MSG"" varchar(1000)  DEFAULT NULL,
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for market_clearing_total
-- ----------------------------

CREATE TABLE ""MARKET_CLEARING_TOTAL"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""ACCOUNT_ID"" int(11) NOT NULL COMMENT '余额对账ID',
  ""BANK_ACCT_NO"" varchar(50) NOT NULL COMMENT '客户银行账号',
  ""MARKET_CODE"" varchar(10) NOT NULL COMMENT '市场编号',
  ""INST_FUND_ACC"" varchar(10) DEFAULT NULL COMMENT '交易商资金账号',
  ""TRAS_COMM"" decimal(16,4) DEFAULT NULL COMMENT '手续费',
  ""CHANGE_MONEY"" decimal(16,4) DEFAULT NULL COMMENT '资金变动',
  ""COMP_ENABLE_MONEY"" decimal(16,4) DEFAULT NULL COMMENT '账户余额',
  ""MONEY_TYPE"" varchar(5) NOT NULL COMMENT '币种   CNY',
  ""SUMMARY1"" varchar(80) DEFAULT NULL COMMENT '业务备注',
  ""DATE"" varchar(10) NOT NULL COMMENT '交易日期',
  ""TIME"" varchar(10) NOT NULL COMMENT '交易时间',
  ""MARKET_ACC_NO"" varchar(40) NOT NULL COMMENT '市场结算账号',
  ""BANK_ACCT_NAME"" varchar(200) DEFAULT NULL COMMENT '银行卡账户名称',
  ""CHANNEL_ID"" int(11) DEFAULT NULL,
  PRIMARY KEY (id)


);

-- ----------------------------
-- Table structure for money_inout_success_time
-- ----------------------------

CREATE TABLE ""MONEY_INOUT_SUCCESS_TIME"" (
  ""LAST_SUCCESS_TIME"" datetime DEFAULT NULL
);

-- ----------------------------
-- Table structure for money_inout_time
-- ----------------------------

CREATE TABLE ""MONEY_INOUT_TIME"" (
  ""CREATE_MONEY_INOUT_TIME"" datetime NOT NULL
);

-- ----------------------------
-- Table structure for openbankno
-- ----------------------------

CREATE TABLE ""OPENBANKNO"" (
  ""BANK_NO"" varchar(20) NOT NULL,
  ""EFFECTIVE_DATE"" varchar(20) DEFAULT NULL,
  ""TERMINATE_DATE"" varchar(20) DEFAULT NULL,
  ""BANK_CODE"" varchar(20) DEFAULT NULL,
  ""CITY"" varchar(20) DEFAULT NULL,
  ""BANK_NAME"" varchar(100) DEFAULT NULL,
  PRIMARY KEY (bank_no)


);

-- ----------------------------
-- Table structure for operate_log
-- ----------------------------

CREATE TABLE ""OPERATE_LOG"" (
  ""ID"" varchar(32) NOT NULL COMMENT 'id',
  ""USER_ID"" varchar(64) NOT NULL COMMENT '用户名',
  ""OPERATE_TIME"" datetime DEFAULT NULL COMMENT '操作时间',
  ""IP_ADDRESS"" varchar(32) DEFAULT NULL COMMENT 'ip地址',
  ""OPERATE_TYPE"" varchar(32) DEFAULT NULL COMMENT '操作类型',
  ""OPERATE_MODEL"" varchar(32) DEFAULT NULL COMMENT '操作模块',
  ""OPERATE_RESULT"" varchar(16) DEFAULT NULL COMMENT '操作结果',
  ""RES_INFO"" varchar(225) DEFAULT NULL,
  ""USER_TYPE"" varchar(32) DEFAULT NULL,
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for permission
-- ----------------------------

CREATE TABLE ""PERMISSION"" (
  ""ID"" varchar(32) NOT NULL,
  ""CODE"" varchar(100) NOT NULL,
  ""LABEL"" varchar(100) NOT NULL,
  ""SYS_TYPE"" varchar(32) NOT NULL,
  ""PERMISSION_TYPE"" varchar(32) DEFAULT NULL,
  ""URL"" varchar(1000) DEFAULT NULL,
  ""PID"" varchar(32) DEFAULT NULL,
  ""STATUS"" varchar(1) NOT NULL,
  ""DESCRIPTION"" varchar(1000) DEFAULT NULL,
  ""EXPANDED"" varchar(1) DEFAULT NULL,
  ""LANGUAGE"" varchar(10) DEFAULT '*',
  ""TARGET"" varchar(20) DEFAULT '_self',
  ""ICON"" varchar(80) DEFAULT NULL,
  ""SEQ_NUM"" int(11) DEFAULT NULL,
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for role
-- ----------------------------

CREATE TABLE ""ROLE"" (
  ""ID"" varchar(32) NOT NULL,
  ""CODE"" varchar(100) NOT NULL,
  ""NAME"" varchar(100) NOT NULL,
  ""PID"" varchar(32) DEFAULT NULL,
  ""DESCRIPTION"" varchar(500) DEFAULT NULL,
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for role_permission
-- ----------------------------

CREATE TABLE ""ROLE_PERMISSION"" (
  ""ID"" varchar(32) NOT NULL COMMENT 'id',
  ""ROLE_ID"" varchar(32) NOT NULL,
  ""PERMISSION_ID"" varchar(32) NOT NULL,
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for sign_on_off
-- ----------------------------

CREATE TABLE ""SIGN_ON_OFF"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""EXCHANGE_ID"" int(11) DEFAULT NULL COMMENT '交易所ID',
  ""ACTION"" varchar(10) NOT NULL COMMENT '操作动作  签到或签退',
  ""OPERATOR"" varchar(50) DEFAULT NULL,
  ""OPERATE_TIME"" datetime NOT NULL COMMENT '操作时间',
  ""CHANNEL_CODE"" varchar(10) DEFAULT NULL,
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for socket_asyn_rec
-- ----------------------------

CREATE TABLE ""SOCKET_ASYN_REC"" (
  ""ID"" bigint(20) NOT NULL AUTO_INCREMENT,
  ""MARKET_SERIAL"" varchar(50) DEFAULT NULL COMMENT '市场流水号',
  ""INSTRUCTION_CODE"" varchar(10) NOT NULL COMMENT '交易码',
  ""BANK_SERIAL"" varchar(50) DEFAULT NULL COMMENT '银行流水号',
  ""STATUS"" smallint(6) DEFAULT NULL COMMENT '状态 0 处理中      1 处理成功       2 处理失败',
  ""INSERT_TIME"" datetime DEFAULT NULL,
  ""UPDATE_TIME"" datetime DEFAULT NULL,
  ""MSG"" varchar(2000) DEFAULT NULL COMMENT '返回的信息',
  ""USER_ID"" varchar(50) DEFAULT NULL,
  PRIMARY KEY (id)


);

-- ----------------------------
-- Table structure for socket_asyn_rec_history
-- ----------------------------

CREATE TABLE ""SOCKET_ASYN_REC_HISTORY"" (
  ""ID"" bigint(20) NOT NULL,
  ""MARKET_SERIAL"" varchar(50) DEFAULT NULL COMMENT '市场流水号',
  ""INSTRUCTION_CODE"" varchar(5) NOT NULL COMMENT '交易码',
  ""BANK_SERIAL"" varchar(50) DEFAULT NULL COMMENT '银行流水号',
  ""STATUS"" smallint(6) DEFAULT NULL COMMENT '状态 0 处理中      1 处理成功       2 处理失败',
  ""INSERT_TIME"" datetime DEFAULT NULL,
  ""UPDATE_TIME"" datetime DEFAULT NULL,
  ""MSG"" varchar(2000) DEFAULT NULL COMMENT '返回的信息',
  ""USER_ID"" varchar(20) DEFAULT NULL,
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for socket_page_data
-- ----------------------------

CREATE TABLE ""SOCKET_PAGE_DATA"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""EXCHANGE_ID"" int(11) NOT NULL COMMENT '交易所ID',
  ""USER_ID"" varchar(20) DEFAULT NULL COMMENT '用户编码',
  ""SERIAL"" varchar(50) NOT NULL COMMENT '流水号',
  ""NAME"" varchar(32) DEFAULT NULL COMMENT '用户姓名',
  ""CERTI_ID"" varchar(64) DEFAULT NULL COMMENT '证件号码',
  ""BANK_CODE"" varchar(10) DEFAULT NULL COMMENT '银行编码',
  ""OPEN_BANKNO"" varchar(30) DEFAULT NULL COMMENT '开户行号',
  ""BANK_ACCOUNT"" varchar(30) DEFAULT NULL COMMENT '银行卡号',
  ""BANK_RESERVE_MOBILE"" varchar(20) DEFAULT NULL COMMENT '银行预留手机',
  ""INSERT_TIME"" datetime DEFAULT NULL,
  ""CLIENT_KIND"" smallint(6) DEFAULT '1' COMMENT '客户类型 0-企业 1-个人',
  ""CERT_TYPE"" varchar(1) DEFAULT 'A' COMMENT '证件类型 A-身份证  G-法人组织结构号码',
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for socket_page_data_history
-- ----------------------------

CREATE TABLE ""SOCKET_PAGE_DATA_HISTORY"" (
  ""ID"" int(11) NOT NULL,
  ""EXCHANGE_ID"" int(11) NOT NULL COMMENT '交易所ID',
  ""USER_ID"" varchar(20) DEFAULT NULL COMMENT '用户编码',
  ""SERIAL"" varchar(50) NOT NULL COMMENT '流水号',
  ""NAME"" varchar(32) DEFAULT NULL COMMENT '用户姓名',
  ""CERTI_ID"" varchar(64) DEFAULT NULL COMMENT '证件号码',
  ""BANK_CODE"" varchar(10) DEFAULT NULL COMMENT '银行编码',
  ""OPEN_BANKNO"" varchar(30) DEFAULT NULL COMMENT '开户行号',
  ""BANK_ACCOUNT"" varchar(30) DEFAULT NULL COMMENT '银行卡号',
  ""BANK_RESERVE_MOBILE"" varchar(20) DEFAULT NULL COMMENT '银行预留手机',
  ""INSERT_TIME"" datetime DEFAULT NULL,
  ""CLIENT_KIND"" smallint(6) DEFAULT '1' COMMENT '用户类型 0-企业  1-个人',
  ""CERT_TYPE"" varchar(1) DEFAULT NULL COMMENT '证件类型   A-身份证   G-法人组织机构号码'

);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------

CREATE TABLE ""SYS_CONFIG"" (
  ""ID"" varchar(32) NOT NULL COMMENT 'id',
  ""DISPLAY_NAME"" varchar(64) DEFAULT NULL COMMENT '名称',
  ""CODE"" varchar(1000) DEFAULT NULL COMMENT '编码',
  ""DESCRIPTION"" varchar(100) DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for table_map
-- ----------------------------

CREATE TABLE ""TABLE_MAP"" (
  ""BEGIN"" datetime NOT NULL COMMENT '开始时间(包含)',
  ""END"" datetime NOT NULL COMMENT '结束时间(不包含)',
  ""POSTFIX"" varchar(50) NOT NULL COMMENT '映射表名',
  PRIMARY KEY (begin,end)

);

-- ----------------------------
-- Table structure for trade_history
-- ----------------------------

CREATE TABLE ""TRADE_HISTORY"" (
  ""ID"" bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  ""EXCHANGE_ID"" int(11) NOT NULL COMMENT '交易所ID',
  ""TRADE_ID"" decimal(12,0) NOT NULL COMMENT '交易单号',
  ""SYMBOL"" varchar(100) NOT NULL COMMENT '产品代码',
  ""BUYER_ID"" bigint(20) DEFAULT NULL COMMENT '买家ID',
  ""SELLER_ID"" bigint(20) DEFAULT NULL COMMENT '卖家ID',
  ""BUYER_FEE"" decimal(12,5) DEFAULT NULL COMMENT '买家交易费',
  ""SELLER_FEE"" decimal(12,5) DEFAULT NULL COMMENT '卖家交易费',
  ""PRICE"" decimal(12,5) NOT NULL COMMENT '交易价格',
  ""QTY"" decimal(12,5) NOT NULL COMMENT '交易数量',
  ""TIME"" datetime NOT NULL COMMENT '交易时间',
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for trading_ledger
-- ----------------------------

CREATE TABLE ""TRADING_LEDGER"" (
  ""ID"" bigint(20) NOT NULL AUTO_INCREMENT,
  ""EXCHANGE_ID"" int(11) NOT NULL COMMENT '交易所ID',
  ""TRAN_ID"" bigint(20) NOT NULL COMMENT '流水单号',
  ""TRADE_ID"" decimal(12,0) NOT NULL COMMENT '交易单号',
  ""SYMBOL"" varchar(100) NOT NULL COMMENT '产品代号',
  ""USER_ID"" varchar(64) NOT NULL COMMENT '用户ID',
  ""DIRECTION"" varchar(10) NOT NULL COMMENT '买卖方向',
  ""COMMISSION"" decimal(13,2) NOT NULL COMMENT '总交易费',
  ""AGENT1"" varchar(64) DEFAULT NULL COMMENT '一级经纪人',
  ""AGENT_REWARD1"" decimal(13,2) DEFAULT NULL COMMENT '一级经纪人返佣',
  ""AGENT2"" varchar(64) DEFAULT NULL COMMENT '二级经纪人',
  ""AGENT_REWARD2"" decimal(13,2) DEFAULT NULL COMMENT '二级经纪人返佣',
  ""AGENT3"" varchar(64) DEFAULT NULL COMMENT '三级经纪人',
  ""AGENT_REWARD3"" decimal(13,2) DEFAULT NULL COMMENT '三级经纪人返佣',
  ""AGENT4"" varchar(64) DEFAULT NULL COMMENT '四级经纪人',
  ""AGENT_REWARD4"" decimal(13,2) DEFAULT NULL COMMENT '四级经纪人返佣',
  ""AGENT5"" varchar(64) DEFAULT NULL COMMENT '五级经纪人',
  ""AGENT_REWARD5"" decimal(13,2) DEFAULT NULL COMMENT '五级经纪人返佣',
  ""SUPER_AGENT_REWARD"" decimal(13,2) DEFAULT NULL COMMENT '超级经纪人返佣',
  ""EXCHANGE_INCOME"" decimal(13,2) DEFAULT NULL COMMENT '交易所收益',
  ""EXCHANGE_CLEARING_FEE"" decimal(13,2) DEFAULT NULL COMMENT '交易所清算费收入',
  ""VENDOR_CLEARING_FEE"" decimal(13,2) DEFAULT NULL COMMENT '系统供应商清算费收入',
  ""TIME"" datetime NOT NULL COMMENT '交易时间',
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for user
-- ----------------------------

CREATE TABLE ""USER"" (
  ""ID"" bigint(20) NOT NULL COMMENT '用户代码',
  ""CLEARING_ID"" varchar(20) NOT NULL COMMENT '清算系统使用的用户ID,用于和银行通信',
  ""EMAIL"" varchar(100) DEFAULT NULL COMMENT '邮箱',
  ""PASSWORD"" varchar(64) NOT NULL COMMENT '密码',
  ""PAY_PWD"" varchar(64) DEFAULT NULL COMMENT '支付密码',
  ""SALT"" varchar(16) DEFAULT NULL COMMENT '加密盐',
  ""REAL_NAME"" varchar(32) DEFAULT NULL COMMENT '真实姓名',
  ""NICK_NAME"" varchar(32) DEFAULT NULL COMMENT '昵称',
  ""GENDER"" varchar(2) DEFAULT NULL COMMENT '性别:F女，M男',
  ""MOBILE"" varchar(32) DEFAULT NULL COMMENT '手机号',
  ""CERTIFICATE_TYPE"" varchar(32) DEFAULT NULL COMMENT '证件类型 A: 身份证 G: 组织机构代码 X: 社会信用代码 ',
  ""CERTIFICATE_NO"" varchar(64) DEFAULT NULL COMMENT '证件号',
  ""AUTH_TIME"" datetime DEFAULT NULL COMMENT '认证时间',
  ""MODIFIED_AT"" datetime DEFAULT NULL COMMENT '修改时间',
  ""CREATED_AT"" datetime DEFAULT NULL COMMENT '创建时间',
  ""IS_AUTH"" tinyint(1) DEFAULT '0',
  ""CLIENT_KIND"" smallint(6) DEFAULT '1' COMMENT '客户类型 0-企业  1-个人',
  ""EXISTING_ONLY"" varchar(1) DEFAULT NULL COMMENT '此标记表示只在所属的交易所登陆（Y） 或可以多交易所登陆（N或空)',
  PRIMARY KEY (id)




);

-- ----------------------------
-- Table structure for user_bank
-- ----------------------------

CREATE TABLE ""USER_BANK"" (
  ""ID"" int(32) NOT NULL AUTO_INCREMENT COMMENT 'id',
  ""CHANNEL_ID"" tinyint(4) DEFAULT NULL COMMENT '支付渠道号   如1 代表上海银行支付  2为建设银行支付',
  ""USER_ID"" bigint(20) DEFAULT NULL COMMENT '用户编号',
  ""NAME"" varchar(100) DEFAULT NULL COMMENT '名称',
  ""BANK_NO"" varchar(128) DEFAULT NULL COMMENT '银行编号',
  ""BANK_ACCOUNT"" varchar(100) DEFAULT NULL COMMENT '银行卡号',
  ""EBANK_ACCOUNT"" varchar(100) DEFAULT NULL COMMENT 'e账号',
  ""BANK"" varchar(100) DEFAULT NULL COMMENT '银行名称',
  ""OWNER_NAME"" varchar(200) DEFAULT NULL COMMENT '银行卡账户名称',
  ""OPEN_ACCT_BANK"" varchar(100) DEFAULT NULL COMMENT '开户支行代码',
  ""BANK_TYPE"" varchar(100) DEFAULT NULL COMMENT '账户类型',
  ""BANK_CITY"" varchar(100) DEFAULT NULL COMMENT '银行所在城市',
  ""BANK_PROVINCE"" varchar(100) DEFAULT NULL COMMENT '银行所在省份',
  ""MOBILE"" varchar(32) DEFAULT NULL COMMENT '直销银行登陆手机号(不可更改)',
  ""EPHONE_NUMBER"" varchar(32) DEFAULT NULL COMMENT '用户预留手机号(可更改)',
  ""STATE"" varchar(50) DEFAULT NULL COMMENT '状态',
  ""CREATE_TIME"" datetime DEFAULT NULL COMMENT '时间',
  ""FIVE_FACTOR_AUTH_INDI"" varchar(1) DEFAULT NULL COMMENT '上海银行渠道代扣5要素验证是否通过  Y 通过  否则未通过',
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for user_bank_copy
-- ----------------------------

CREATE TABLE ""USER_BANK_COPY"" (
  ""ID"" int(32) NOT NULL AUTO_INCREMENT COMMENT 'id',
  ""CHANNEL_ID"" tinyint(4) DEFAULT NULL COMMENT '支付渠道号   如1 代表上海银行支付  2为建设银行支付',
  ""USER_ID"" bigint(20) DEFAULT NULL COMMENT '用户编号',
  ""NAME"" varchar(100) DEFAULT NULL COMMENT '名称',
  ""BANK_NO"" varchar(128) DEFAULT NULL COMMENT '银行编号',
  ""BANK_ACCOUNT"" varchar(100) DEFAULT NULL COMMENT '银行卡号',
  ""EBANK_ACCOUNT"" varchar(100) DEFAULT NULL COMMENT 'e账号',
  ""BANK"" varchar(100) DEFAULT NULL COMMENT '银行名称',
  ""OWNER_NAME"" varchar(200) DEFAULT NULL COMMENT '银行卡账户名称',
  ""OPEN_ACCT_BANK"" varchar(100) DEFAULT NULL COMMENT '开户支行代码',
  ""BANK_TYPE"" varchar(100) DEFAULT NULL COMMENT '账户类型',
  ""BANK_CITY"" varchar(100) DEFAULT NULL COMMENT '银行所在城市',
  ""BANK_PROVINCE"" varchar(100) DEFAULT NULL COMMENT '银行所在省份',
  ""MOBILE"" varchar(32) DEFAULT NULL COMMENT '直销银行登陆手机号(不可更改)',
  ""EPHONE_NUMBER"" varchar(32) DEFAULT NULL COMMENT '用户预留手机号(可更改)',
  ""STATE"" varchar(50) DEFAULT NULL COMMENT '状态',
  ""CREATE_TIME"" datetime DEFAULT NULL COMMENT '时间',
  ""FIVE_FACTOR_AUTH_INDI"" varchar(1) DEFAULT NULL COMMENT '上海银行渠道代扣5要素验证是否通过  Y 通过  否则未通过',
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for user_bank_ext
-- ----------------------------

CREATE TABLE ""USER_BANK_EXT"" (
  ""ID"" bigint(20) NOT NULL AUTO_INCREMENT COMMENT '编号',
  ""CUST_ACCT_ID"" varchar(32) DEFAULT NULL COMMENT '子帐号',
  ""USER_ID"" bigint(20) DEFAULT NULL COMMENT '用户编号',
  ""RELATED_ACCT_ID"" varchar(32) DEFAULT NULL COMMENT '出/入金帐号',
  ""ACCT_FLAG"" tinyint(1) DEFAULT NULL COMMENT '帐号性质 1、出金帐号，2、入金帐号，3 出金帐号&入金帐号',
  ""TRAN_TYPE"" tinyint(1) DEFAULT NULL COMMENT '转账方式 1、本行 2、同城  3：异地汇款',
  ""ACCT_NAME"" varchar(120) DEFAULT NULL COMMENT '帐号名称',
  ""BANK_CODE"" varchar(12) DEFAULT NULL COMMENT '联行号',
  ""BANK_NAME"" varchar(120) DEFAULT NULL COMMENT '开户行名称',
  ""ADDRESS"" varchar(120) DEFAULT NULL COMMENT '付款人/收款人地址',
  ""OLD_RELATED_ACCT_ID"" varchar(32) DEFAULT NULL COMMENT '原出入金账号 ',
  ""RESERVE"" varchar(120) DEFAULT NULL COMMENT '保留域',
  ""STATE"" tinyint(4) DEFAULT '0' COMMENT '状态：1，可用；2，默认的出入金账号；3，删除',
  ""CREATE_TIME"" datetime DEFAULT NULL COMMENT '创建时间',
  ""UPDATE_TIME"" datetime DEFAULT NULL COMMENT '更改时间',
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for user_charge
-- ----------------------------

CREATE TABLE ""USER_CHARGE"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""EXCHANGE_ID"" int(11) DEFAULT NULL,
  ""USER_ID"" varchar(10) NOT NULL,
  ""TRAN_ID"" bigint(20) DEFAULT NULL,
  ""SERIAL"" varchar(50) DEFAULT NULL COMMENT '市场流水号',
  ""BANK_SERIAL"" varchar(50) DEFAULT NULL COMMENT '银行流水号',
  ""BANK_NAME"" varchar(50) DEFAULT NULL COMMENT '银行名字',
  ""TRANSFER_ACCOUNT"" varchar(50) DEFAULT NULL COMMENT '转账账号',
  ""TRANSFER_AMOUNT"" decimal(20,2) NOT NULL,
  ""TRANSFER_TYPE"" smallint(6) DEFAULT NULL COMMENT '入金类型 1网银入金 2 线下入金 3 提现退回 5 快捷支付 6 e账户转账 7 平安虚拟账户',
  ""STATUS"" smallint(6) NOT NULL COMMENT '审核状态   0 未审核    1 同意   2 拒绝   3 成功   4失败',
  ""INSERT_TIME"" datetime DEFAULT NULL COMMENT '记录时间',
  ""UPDATE_TIME"" datetime DEFAULT NULL COMMENT '更新时间',
  ""AUDIT_OPINION"" varchar(500) DEFAULT NULL COMMENT '审核意见',
  ""AUDITOR"" varchar(64) DEFAULT NULL COMMENT '审核人',
  ""AUDIT_TIME"" datetime DEFAULT NULL COMMENT '审核时间',
  ""WITHDRAWAL_REASON"" varchar(500) DEFAULT NULL COMMENT '退汇原因',
  ""COMMENTS"" varchar(500) DEFAULT NULL COMMENT '入金失败原因或退汇原因或其他注释,用来代替withdrawal_reason 字段',
  PRIMARY KEY (id)



);

-- ----------------------------
-- Table structure for user_data
-- ----------------------------

CREATE TABLE ""USER_DATA"" (
  ""ID"" bigint(20) NOT NULL COMMENT '用户代码',
  ""BIRTHDAY"" date DEFAULT NULL COMMENT '生日',
  ""COUNTRY"" int(11) DEFAULT NULL COMMENT '所在国家',
  ""PROVINCE"" int(11) DEFAULT NULL COMMENT '所在省',
  ""CITY"" int(11) DEFAULT NULL COMMENT '所在城市',
  ""COUNTY"" int(11) DEFAULT NULL COMMENT '所在县',
  ""HOME_ADDRESS"" varchar(100) DEFAULT NULL COMMENT '家庭住址',
  ""PHOTO"" varchar(500) DEFAULT NULL COMMENT '头像',
  ""EMERGENCY_CONTACT"" varchar(64) DEFAULT NULL,
  ""EMERGENCY_PHONE"" varchar(64) DEFAULT NULL,
  ""EMERGENCY_RELATION"" varchar(32) DEFAULT NULL,
  ""IDENTITY_STATUS"" tinyint(4) DEFAULT '0' COMMENT '0:未上传身份证照片,1:已上传身份证照片,2:验证失败',
  ""IDENTITY_FRONT_URL"" varchar(512) DEFAULT NULL COMMENT '身份证正面照片',
  ""IDENTITY_BACK_URL"" varchar(512) DEFAULT NULL COMMENT '身份证反面照片',
  ""POST_CODE"" varchar(32) DEFAULT NULL,
  ""MODIFIED_AT"" datetime DEFAULT NULL COMMENT '修改时间',
  ""CREATED_AT"" datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for user_money
-- ----------------------------

CREATE TABLE ""USER_MONEY"" (
  ""ID"" bigint(20) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  ""EXCHANGE_ID"" int(11) NOT NULL COMMENT '交易所ID',
  ""UID"" bigint(20) NOT NULL COMMENT 'user id',
  ""FREE"" decimal(13,2) NOT NULL DEFAULT '0.00' COMMENT '可用余额',
  ""LOCKED"" decimal(13,2) NOT NULL DEFAULT '0.00' COMMENT '下单冻结',
  ""WITHDRAW_FREEZE"" decimal(13,2) DEFAULT '0.00' COMMENT '提现冻结',
  ""WITHDRAWABLE"" decimal(13,2) DEFAULT '0.00' COMMENT '可提现金额',
  ""WITHDRAWING"" decimal(13,2) DEFAULT '0.00' COMMENT '提现中金额',
  ""FREEZE"" decimal(13,2) DEFAULT '0.00' COMMENT '冻结资金',
  ""PREV_FREE"" decimal(13,2) DEFAULT '0.00' COMMENT '前一天的可用余额',
  ""MODIFIED_AT"" datetime NOT NULL COMMENT '修改时间',
  ""CREATED_AT"" datetime NOT NULL COMMENT '创建时间',
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for user_money_log
-- ----------------------------

CREATE TABLE ""USER_MONEY_LOG"" (
  ""ID"" bigint(20) NOT NULL AUTO_INCREMENT,
  ""EXCHANGE_ID"" int(11) NOT NULL COMMENT '交易所ID',
  ""TRAN_ID"" bigint(20) NOT NULL COMMENT '流水单号',
  ""UID"" varchar(32) NOT NULL COMMENT '用户ID',
  ""TYPE"" int(11) NOT NULL COMMENT '更改类型',
  ""DELTA"" decimal(13,2) NOT NULL COMMENT '变动金额',
  ""FREE"" decimal(13,2) NOT NULL COMMENT '可用余额',
  ""LOCKED"" decimal(13,2) NOT NULL COMMENT '下单冻结',
  ""WITHDRAW_FREEZE"" decimal(13,2) DEFAULT NULL COMMENT '提现冻结',
  ""WITHDRAWING"" decimal(13,2) DEFAULT NULL,
  ""FREEZE"" decimal(13,2) DEFAULT NULL COMMENT '冻结资金',
  ""PREV_FREE"" decimal(13,2) DEFAULT NULL COMMENT '前一天的可用余额',
  ""INFO"" varchar(32) DEFAULT NULL COMMENT '更改描述',
  ""TIME"" datetime NOT NULL COMMENT '更改时间',
  PRIMARY KEY (id)



);

-- ----------------------------
-- Table structure for user_role
-- ----------------------------

CREATE TABLE ""USER_ROLE"" (
  ""ID"" varchar(32) NOT NULL COMMENT 'id',
  ""USER_ID"" varchar(32) NOT NULL,
  ""ROLE_ID"" varchar(32) NOT NULL,
  PRIMARY KEY (id)
);

-- ----------------------------
-- Table structure for user_security
-- ----------------------------

CREATE TABLE ""USER_SECURITY"" (
  ""ID"" varchar(32) NOT NULL COMMENT 'id',
  ""USER_ID"" varchar(64) NOT NULL COMMENT '用户名',
  ""LAST_LOGIN_TIME"" datetime DEFAULT NULL COMMENT '上次登录时间',
  ""LOGIN_FAILED_NUM"" int(11) DEFAULT NULL COMMENT '当日密码错误次数',
  ""LOGIN_FAILED_TIME"" datetime DEFAULT NULL COMMENT '登录失败日期',
  ""DISABLE_TIME"" datetime DEFAULT NULL COMMENT '禁用时间',
  ""USER_TYPE"" varchar(16) DEFAULT NULL COMMENT '用户类型P:普通用户;A:后台用户;M:入驻商户',
  ""STATUS"" char(16) DEFAULT NULL COMMENT '状态:0,正常;1,禁用;2,锁定',
  ""SECRET_KEY"" varchar(32) DEFAULT NULL,
  PRIMARY KEY (id)

);

-- ----------------------------
-- Table structure for whitelist
-- ----------------------------

CREATE TABLE ""WHITELIST"" (
  ""ADDRESS"" varchar(100) NOT NULL COMMENT '白名单地址',
  PRIMARY KEY (address)
);

-- ----------------------------
-- Table structure for withdraw
-- ----------------------------

CREATE TABLE ""WITHDRAW"" (
  ""ID"" int(32) NOT NULL AUTO_INCREMENT COMMENT 'id',
  ""EXCHANGE_ID"" int(11) DEFAULT NULL,
  ""TRAN_ID"" bigint(20) DEFAULT NULL,
  ""USER_ID"" varchar(64) NOT NULL COMMENT '用户编号',
  ""ORDER_ID"" varchar(50) DEFAULT NULL COMMENT '市场流水号',
  ""BANK_SERIAL"" varchar(50) DEFAULT NULL COMMENT '银行流水号',
  ""BANK_CARD_ID"" varchar(32) DEFAULT NULL COMMENT '银行卡编号',
  ""WITHDRAW_WAY"" varchar(32) DEFAULT NULL COMMENT '提现方式',
  ""AMT"" decimal(20,2) DEFAULT NULL COMMENT '实际交易金额',
  ""ACTUAL_MONEY"" decimal(20,2) DEFAULT NULL COMMENT '到账金额',
  ""FEE"" decimal(20,2) DEFAULT NULL COMMENT '提现手续费',
  ""FEE_CHILD_ACCTNO"" varchar(64) DEFAULT NULL COMMENT '手续费子账户号',
  ""FEE_ACCT_NO"" varchar(64) DEFAULT NULL COMMENT '手续费客户号',
  ""THIRD_ACCT_NO"" varchar(64) DEFAULT NULL COMMENT '是投资账户还是借款账户提现',
  ""CASH_FINE"" decimal(20,2) DEFAULT NULL COMMENT '提现罚金',
  ""STATE"" smallint(6) DEFAULT NULL COMMENT '0待审核   1审核通过 2 拒绝   3 成功   4失败',
  ""APPLY_TIME"" datetime DEFAULT NULL COMMENT '提交申请时间',
  ""ACCEPT_TIME"" datetime DEFAULT NULL COMMENT '申请受理时间',
  ""AUDIT_TIME"" datetime DEFAULT NULL COMMENT '审核时间',
  ""AUDIT_OPINION"" varchar(500) DEFAULT NULL COMMENT '审核信息',
  ""AUDITOR"" varchar(64) DEFAULT NULL COMMENT '审核人编号',
  ""HY_FEE"" decimal(20,2) DEFAULT NULL,
  ""SEND_TIME"" datetime DEFAULT NULL,
  ""COMPLETE_TIME"" datetime DEFAULT NULL,
  ""ERROR_MSG"" varchar(1000) DEFAULT NULL COMMENT '失败消息',
  ""TYPE"" smallint(4) DEFAULT '0' COMMENT '出金类型：0，交易所出金申请；1，银行异步出金申请',
  PRIMARY KEY (id)



);

-- ----------------------------
-- Table structure for yst_pre_bind
-- ----------------------------

CREATE TABLE ""YST_PRE_BIND"" (
  ""ID"" int(11) NOT NULL AUTO_INCREMENT,
  ""EXCHANGE_ID"" int(11) NOT NULL COMMENT '交易所ID',
  ""STATUS"" int(11) NOT NULL COMMENT '状态 0 已提交状态     3 最终状态   (此字段以后会加审核状态)',
  ""CHANNEL_CODE"" varchar(20) NOT NULL COMMENT '银行代码，对应clearing.channel.channel_code',
  ""CLIENT_KIND"" smallint(6) DEFAULT NULL COMMENT '客户类型 0-企业  1-个人',
  ""USER_ID"" varchar(20) NOT NULL COMMENT '用户编码',
  ""NAME"" varchar(32) DEFAULT NULL COMMENT '用户姓名',
  ""CERTIFICATE_TYPE"" varchar(32) DEFAULT NULL COMMENT '不同银行使用不同的数据字典 建行:证件类型 A: 身份证 P: 组织机构代码,三证合一截取9-17 九位 ',
  ""CERTIFICATE_NO"" varchar(64) DEFAULT NULL COMMENT '证件号码',
  ""BANK_ACCOUNT"" varchar(30) DEFAULT NULL COMMENT '银行卡号',
  ""INSERT_TIME"" datetime DEFAULT NULL COMMENT '创建时间',
  PRIMARY KEY (id)

);
