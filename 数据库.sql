-- MySQL dump 10.13  Distrib 5.6.44, for Win64 (x86_64)
--
-- Host: localhost    Database: b021_q6688_xyz
-- ------------------------------------------------------
-- Server version	5.6.44-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `codepay_order`
--

DROP TABLE IF EXISTS `codepay_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `codepay_order` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `pay_id` varchar(50) NOT NULL COMMENT '用户ID或订单ID',
  `money` decimal(6,2) unsigned NOT NULL COMMENT '实际金额',
  `price` decimal(6,2) unsigned NOT NULL COMMENT '原价',
  `type` int(1) NOT NULL DEFAULT '1' COMMENT '支付方式',
  `pay_no` varchar(100) NOT NULL COMMENT '流水号',
  `param` varchar(200) DEFAULT NULL COMMENT '自定义参数',
  `pay_time` bigint(11) NOT NULL DEFAULT '0' COMMENT '付款时间',
  `pay_tag` varchar(100) NOT NULL DEFAULT '0' COMMENT '金额的备注',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '订单状态',
  `creat_time` bigint(11) NOT NULL DEFAULT '0' COMMENT '创建时间',
  `up_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`id`),
  UNIQUE KEY `main` (`pay_id`,`pay_time`,`money`,`type`,`pay_tag`),
  UNIQUE KEY `pay_no` (`pay_no`,`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用于区分是否已经处理';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `codepay_order`
--

LOCK TABLES `codepay_order` WRITE;
/*!40000 ALTER TABLE `codepay_order` DISABLE KEYS */;
/*!40000 ALTER TABLE `codepay_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `codepay_user`
--

DROP TABLE IF EXISTS `codepay_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `codepay_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user` varchar(100) NOT NULL DEFAULT '' COMMENT '用户名',
  `money` decimal(6,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `vip` int(1) NOT NULL DEFAULT '0' COMMENT '会员开通',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '会员状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `codepay_user`
--

LOCK TABLES `codepay_user` WRITE;
/*!40000 ALTER TABLE `codepay_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `codepay_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_announce`
--

DROP TABLE IF EXISTS `ds_announce`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_announce` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(60) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `operator` varchar(45) NOT NULL DEFAULT '' COMMENT '发布人',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `edittime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  `image` varchar(255) NOT NULL COMMENT '标题图像',
  `viewer` varchar(10) NOT NULL DEFAULT 'all' COMMENT '查看权限 all:所有人  member:会员  center:报单中心 ',
  `tid` int(10) unsigned NOT NULL COMMENT '类别ID',
  PRIMARY KEY (`id`),
  KEY `tid` (`tid`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=755 ROW_FORMAT=DYNAMIC COMMENT='公告信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_announce`
--

LOCK TABLES `ds_announce` WRITE;
/*!40000 ALTER TABLE `ds_announce` DISABLE KEYS */;
INSERT INTO `ds_announce` VALUES (1,'测试','测试','admin',1584093263,1584093263,'/Public/Uploads/zixun/20200313/5e6b585fcdaa6.png','all',1),(2,'测试1','1','admin',1584114722,1584114746,'/Public/Uploads/zixun/20200313/5e6bac3abd35a.png','all',1),(3,'测试2','123312','admin',1584114750,1584114750,'/Public/Uploads/zixun/20200313/5e6bac4440e62.png','all',1),(4,'测试3','123112','admin',1584114758,1584114758,'/Public/Uploads/zixun/20200313/5e6bac4df073c.png','all',1);
/*!40000 ALTER TABLE `ds_announce` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_announce_click`
--

DROP TABLE IF EXISTS `ds_announce_click`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_announce_click` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `news_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=131519 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_announce_click`
--

LOCK TABLES `ds_announce_click` WRITE;
/*!40000 ALTER TABLE `ds_announce_click` DISABLE KEYS */;
/*!40000 ALTER TABLE `ds_announce_click` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_announcetype`
--

DROP TABLE IF EXISTS `ds_announcetype`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_announcetype` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '类别ID',
  `name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=15 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=24 ROW_FORMAT=DYNAMIC COMMENT='公告类别';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_announcetype`
--

LOCK TABLES `ds_announcetype` WRITE;
/*!40000 ALTER TABLE `ds_announcetype` DISABLE KEYS */;
INSERT INTO `ds_announcetype` VALUES (1,'生态公告');
/*!40000 ALTER TABLE `ds_announcetype` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_auth_group`
--

DROP TABLE IF EXISTS `ds_auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(500) NOT NULL DEFAULT '',
  `description` char(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_auth_group`
--

LOCK TABLES `ds_auth_group` WRITE;
/*!40000 ALTER TABLE `ds_auth_group` DISABLE KEYS */;
INSERT INTO `ds_auth_group` VALUES (4,'超级管理员',1,'13,14,15,16,17,18,19,20,21,22,23,24,25,26,89,27,28,29,30,31,32,80,81,33,34,35,36,37,38,39,41,42,43,44,45,46,47,48,49,50,51,52,82,83,84,85,87,88,9,10,11,12,86,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,7913,14,15,16,17,18,19,20,21,22,23,24,25,26,89,27,28,29,30,31,32,80,81,33,34,35,36,37,38,39,41,42,43,44,45,46,47,48,49,50,51,52,82,83,84,85,87,88,9,10,11,12,86,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79','拥有所有权限的管理员'),(7,'首页管理员',1,'13,14,15,16,17,18,19,20,21,22,23,24,25,26,9','能够管理首页推荐位'),(8,'广告管理员',1,'27,28,29,30,31,32,9','管理全部广告'),(9,'分类管理员',1,'33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,9','分类管理员'),(10,'优惠券管理',1,'53,54,55,56,57,58,59,60','优惠券管理');
/*!40000 ALTER TABLE `ds_auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_auth_group_access`
--

DROP TABLE IF EXISTS `ds_auth_group_access`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_auth_group_access`
--

LOCK TABLES `ds_auth_group_access` WRITE;
/*!40000 ALTER TABLE `ds_auth_group_access` DISABLE KEYS */;
INSERT INTO `ds_auth_group_access` VALUES (2651,4);
/*!40000 ALTER TABLE `ds_auth_group_access` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_auth_rule`
--

DROP TABLE IF EXISTS `ds_auth_rule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_auth_rule` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `name` char(80) NOT NULL DEFAULT '',
  `title` char(20) NOT NULL DEFAULT '',
  `type` tinyint(1) NOT NULL DEFAULT '1',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `condition` char(100) NOT NULL DEFAULT '',
  `mid` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=MyISAM AUTO_INCREMENT=92 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_auth_rule`
--

LOCK TABLES `ds_auth_rule` WRITE;
/*!40000 ALTER TABLE `ds_auth_rule` DISABLE KEYS */;
INSERT INTO `ds_auth_rule` VALUES (9,'Admin/Index/index','登录首页',1,1,'',9),(10,'Admin/Websetting/index','基础配置',1,1,'',9),(11,'Admin/Navsetting/index','导航配置',1,1,'',9),(12,'Admin/Friendlink/index','友情链接配置',1,1,'',9),(13,'Admin/Indexset/index','查看首页管理',1,1,'',1),(14,'Admin/Indexset/addFloor','添加楼层',1,1,'',1),(15,'Admin/Indexset/modifyFloor','修改楼层',1,1,'',1),(16,'Admin/Indexset/deleteFloor','删除楼层',1,1,'',1),(17,'Admin/Indexset/loadData','显示楼层图片广告',1,1,'',1),(18,'Admin/Indexset/viewClass','查看可添加楼层',1,1,'',1),(19,'Admin/Indexset/editAd','修改楼层广告',1,1,'',1),(20,'Admin/Indexset/insertAd','添加楼层广告',1,1,'',1),(21,'Admin/Indexset/deleteAd','删除楼层广告',1,1,'',1),(22,'Admin/Indexset/createPic','添加楼层广告页面',1,1,'',1),(23,'Admin/Indexset/createText','添加楼层文字广告页面',1,1,'',1),(24,'Admin/Indexset/editPic','修改楼层广告页面',1,1,'',1),(25,'Admin/Indexset/editText','修改楼层文字广告页面',1,1,'',1),(26,'Admin/Indexset/loadText','显示楼层文字广告',1,1,'',1),(27,'Admin/Adset/index','广告管理首页',1,1,'',2),(28,'Admin/Adset/createAd','广告添加页面',1,1,'',2),(29,'Admin/Adset/insertAd','广告添加',1,1,'',2),(30,'Admin/Adset/editAd','广告修改页面',1,1,'',2),(31,'Admin/Adset/updataAd','广告修改',1,1,'',2),(32,'Admin/Adset/deleteAd','广告删除',1,1,'',2),(33,'Admin/GoodsClass/index','商品分类显示',1,1,'',4),(34,'Admin/GoodsClass/addClass','商品分类添加页面',1,1,'',4),(35,'Admin/GoodsClass/modifyClass','商品分类修改页面',1,1,'',4),(36,'Admin/GoodsClass/insertClass','商品分类添加',1,1,'',4),(37,'Admin/GoodsClass/updataClass','商品分类修改',1,1,'',4),(38,'Admin/GoodsClass/deleteClass','商品分类删除',1,1,'',4),(39,'Admin/GoodsClass/viewClassId','商品分类显示分类id',1,1,'',4),(41,'Admin/Goodsattr/index','商品属性查看',1,1,'',4),(42,'Admin/Goodsattr/addAttr','商品属性添加页面',1,1,'',4),(43,'Admin/Goodsattr/modifyAttr','商品属性修改页面',1,1,'',4),(44,'Admin/Goodsattr/insertAttr','商品属性添加',1,1,'',4),(45,'Admin/Goodsattr/updataAttr','商品属性修改',1,1,'',4),(46,'Admin/Goodsattr/deleteAttr','商品属性删除',1,1,'',4),(47,'Admin/Goodsbrand/index','商品品牌查看',1,1,'',4),(48,'Admin/Goodsbrand/addBrand','商品品牌添加页面',1,1,'',4),(49,'Admin/Goodsbrand/modifyBrand','商品品牌修改页面',1,1,'',4),(50,'Admin/Goodsbrand/insertBrand','商品品牌添加',1,1,'',4),(51,'Admin/Goodsbrand/updataBrand','商品品牌修改',1,1,'',4),(52,'Admin/Goodsbrand/deleteBrand','商品品牌删除',1,1,'',4),(53,'Admin/Couponmanage/index','显示优惠券组列表',1,1,'',7),(54,'Admin/Couponmanage/coupons','优惠券详情列表',1,1,'',7),(55,'Admin/Couponmanage/addCoupon','添加优惠券',1,1,'',7),(56,'Admin/Couponmanage/modifyCoupon','修改优惠券',1,1,'',7),(57,'Admin/Couponmanage/insertCoupon','优惠券添加',1,1,'',7),(58,'Admin/Couponmanage/updataCoupon','优惠券修改',1,1,'',7),(59,'Admin/Couponmanage/deleteCoupon','删除优惠券',1,1,'',7),(60,'Admin/Couponmanage/couponState','更新优惠券状态',1,1,'',7),(62,'Admin/Accesslist/index','权限列表页面',1,1,'',10),(63,'Admin/Accesslist/addAccess','权限添加页面',1,1,'',10),(64,'Admin/Accesslist/modifyAccess','权限修改页面',1,1,'',10),(65,'Admin/Accesslist/insertAccess','权限添加',1,1,'',10),(66,'Admin/Accesslist/updataAccess','权限修改',1,1,'',10),(67,'Admin/Accesslist/deleteAccess','权限删除',1,1,'',10),(68,'Admin/Accesslist/accessState','权限状态更新',1,1,'',10),(69,'Admin/Grouplist/index','角色管理页面',1,1,'',10),(70,'Admin/Grouplist/addGroup','角色添加页面',1,1,'',10),(71,'Admin/Grouplist/modifyGroup','角色修改页面',1,1,'',10),(72,'Admin/Grouplist/insertGroup','角色添加',1,1,'',10),(73,'Admin/Grouplist/updataGroup','角色修改',1,1,'',10),(74,'Admin/Grouplist/deleteGroup','角色删除',1,1,'',10),(75,'Admin/Grouplist/groupState','角色状态更新',1,1,'',10),(76,'Admin/Grouplist/groupMem','角色成员管理页面',1,1,'',10),(77,'Admin/Grouplist/addMem','角色成员添加页面',1,1,'',10),(78,'Admin/Grouplist/insertMem','角色成员添加',1,1,'',10),(79,'Admin/Grouplist/deleteMem','角色成员删除',1,1,'',10),(80,'Admin/Member/index','用户管理',1,1,'',3),(81,'Admin/Memlevel/index','用户等级',1,1,'',3),(82,'Admin/Goodsissue/index','商品发布',1,1,'',5),(83,'Admin/Goodsup/index','商品上架',1,1,'',5),(84,'Admin/Goodsdown/index','商品下架',1,1,'',5),(85,'Admin/Ordermanage/index','订单管理',1,1,'',6),(86,'Admin/Reviewmanage/index','评价管理',1,1,'',9),(87,'Admin/Articleclasses/index','文章分类',1,1,'',8),(88,'Admin/Articlemanage/index','文章管理',1,1,'',8),(89,'Admin/index/mang','网站管理',1,1,'',1);
/*!40000 ALTER TABLE `ds_auth_rule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_bankcard`
--

DROP TABLE IF EXISTS `ds_bankcard`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_bankcard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL COMMENT '中文名',
  `card` varchar(100) DEFAULT NULL,
  `kaihuhang` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_bankcard`
--

LOCK TABLES `ds_bankcard` WRITE;
/*!40000 ALTER TABLE `ds_bankcard` DISABLE KEYS */;
/*!40000 ALTER TABLE `ds_bankcard` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_banner`
--

DROP TABLE IF EXISTS `ds_banner`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_banner` (
  `id` int(10) NOT NULL,
  `path` varchar(100) NOT NULL,
  `href` varchar(100) DEFAULT NULL,
  `addtime` int(10) DEFAULT NULL,
  `sort` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_banner`
--

LOCK TABLES `ds_banner` WRITE;
/*!40000 ALTER TABLE `ds_banner` DISABLE KEYS */;
INSERT INTO `ds_banner` VALUES (1,'/Public/Uploads/20181117/1.jpg','#',0,0),(2,'/Public/Uploads/20181117/4.jpg','#',0,0),(3,'/Public/Uploads/20181117/2.jpg','#',0,0);
/*!40000 ALTER TABLE `ds_banner` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_complete`
--

DROP TABLE IF EXISTS `ds_complete`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_complete` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '会员编号',
  `pic` varchar(100) NOT NULL COMMENT '头像',
  `jinbi` decimal(10,2) DEFAULT NULL,
  `status` tinyint(4) DEFAULT '0',
  `addtime` int(10) NOT NULL COMMENT '发布时间',
  PRIMARY KEY (`id`),
  KEY `username` (`username`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=278 ROW_FORMAT=DYNAMIC COMMENT='会员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_complete`
--

LOCK TABLES `ds_complete` WRITE;
/*!40000 ALTER TABLE `ds_complete` DISABLE KEYS */;
/*!40000 ALTER TABLE `ds_complete` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_emoneydetail`
--

DROP TABLE IF EXISTS `ds_emoneydetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_emoneydetail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(20) NOT NULL COMMENT '会员号',
  `mode` varchar(100) DEFAULT NULL,
  `amount` decimal(10,0) NOT NULL COMMENT '提现金额',
  `charge` decimal(15,0) DEFAULT NULL COMMENT '手续费',
  `payment` decimal(10,0) DEFAULT NULL COMMENT '实际支付',
  `kaihuhang` varchar(100) DEFAULT NULL,
  `card` varchar(255) NOT NULL COMMENT '提现银行卡',
  `wei` varchar(255) DEFAULT NULL,
  `zhifu` varchar(255) DEFAULT NULL,
  `addtime` int(10) DEFAULT NULL COMMENT '提现时间',
  `type` int(4) NOT NULL DEFAULT '0' COMMENT '状态',
  `remark` varchar(100) NOT NULL COMMENT '描述',
  `status` int(4) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_emoneydetail`
--

LOCK TABLES `ds_emoneydetail` WRITE;
/*!40000 ALTER TABLE `ds_emoneydetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `ds_emoneydetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_jinbidetail`
--

DROP TABLE IF EXISTS `ds_jinbidetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_jinbidetail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `jid` int(10) unsigned NOT NULL DEFAULT '0',
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `tgaward` varchar(255) DEFAULT NULL,
  `member` varchar(255) DEFAULT '' COMMENT '会员编号',
  `adds` decimal(15,5) unsigned DEFAULT '0.00000' COMMENT '添加',
  `reduce` decimal(15,5) unsigned DEFAULT '0.00000' COMMENT '减少',
  `balance` decimal(15,5) unsigned DEFAULT '0.00000' COMMENT '余额',
  `addtime` int(10) DEFAULT '0' COMMENT '操作时间',
  `queryTime` text NOT NULL,
  `statustime` int(11) unsigned NOT NULL DEFAULT '0',
  `desc` varchar(255) DEFAULT '' COMMENT '说明',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `member` (`member`),
  KEY `jid` (`jid`),
  KEY `addtime` (`addtime`)
) ENGINE=MyISAM AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=68 ROW_FORMAT=DYNAMIC COMMENT='金币明细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_jinbidetail`
--

LOCK TABLES `ds_jinbidetail` WRITE;
/*!40000 ALTER TABLE `ds_jinbidetail` DISABLE KEYS */;
INSERT INTO `ds_jinbidetail` VALUES (1,0,0,NULL,'13888888888',1000.00000,0.00000,1000.00000,1584117561,'',0,'平台充值',1),(2,0,0,NULL,'13888888888',0.00000,1000.00000,0.00000,1584117608,'2020-03-14',0,'购买沉香',1),(3,0,2,'13888888888','15888888888',0.00000,0.00000,0.00000,1584117608,'2020-03-14',0,'1代生态奖励',1),(4,0,2,'13888888888','18888888888',0.00000,0.00000,0.00000,1584117608,'2020-03-14',0,'2代生态奖励',1),(5,0,2,'13888888888','1550000000',0.00000,0.00000,0.00000,1584117608,'2020-03-14',0,'3代生态奖励',1),(6,0,0,NULL,'13888888888',1000.00000,0.00000,1000.00000,1584120358,'',0,'平台充值',1),(7,0,0,NULL,'13888888888',0.00000,1000.00000,0.00000,1584120366,'2020-03-14',0,'购买沉香',1),(8,0,2,'13888888888','15888888888',0.00000,0.00000,0.00000,1584120366,'2020-03-14',0,'1代生态奖励',1),(9,0,2,'13888888888','18888888888',0.00000,0.00000,0.00000,1584120366,'2020-03-14',0,'2代生态奖励',1),(10,0,2,'13888888888','1550000000',0.00000,0.00000,0.00000,1584120366,'2020-03-14',0,'3代生态奖励',1),(11,0,0,NULL,'13888888888',1000.00000,0.00000,1000.00000,1584120402,'',0,'平台充值',1),(12,0,0,NULL,'13888888888',0.00000,1000.00000,0.00000,1584120412,'2020-03-14',0,'购买沉香',1),(13,0,2,'13888888888','15888888888',0.00000,0.00000,0.00000,1584120412,'2020-03-14',0,'1代生态奖励',1),(14,0,2,'13888888888','18888888888',0.00000,0.00000,0.00000,1584120412,'2020-03-14',0,'2代生态奖励',1),(15,0,2,'13888888888','1550000000',0.00000,0.00000,0.00000,1584120412,'2020-03-14',0,'3代生态奖励',1),(16,0,0,NULL,'18888888888',50000.00000,0.00000,50000.00000,1592668110,'',0,'平台充值',1);
/*!40000 ALTER TABLE `ds_jinbidetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_log`
--

DROP TABLE IF EXISTS `ds_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_log` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `logtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '操作时间',
  `logaccount` varchar(45) NOT NULL DEFAULT '' COMMENT '操作对应的账号',
  `logip` varchar(100) NOT NULL DEFAULT '' COMMENT '操作者IP',
  `logdesc` varchar(200) NOT NULL DEFAULT '' COMMENT '操作描述',
  `logtype` varchar(10) NOT NULL DEFAULT '' COMMENT '日志类型: member:会员日志 admin:管理员日志',
  `logiplocal` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `logtype` (`logtype`)
) ENGINE=MyISAM AUTO_INCREMENT=57 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=68 ROW_FORMAT=DYNAMIC COMMENT='系统操作日志';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_log`
--

LOCK TABLES `ds_log` WRITE;
/*!40000 ALTER TABLE `ds_log` DISABLE KEYS */;
INSERT INTO `ds_log` VALUES (1,1584029825,'admin','45.77.216.144','管理员[admin]登录','admin','美国'),(2,1584029830,'admin','180.127.157.6','管理员[admin]登录','admin','江苏省连云港市电信'),(3,1584030590,'','45.77.216.144','会员退出','member','美国'),(4,1584030703,'','36.184.184.72','会员退出','member','中国移动'),(5,1584030723,'','36.184.184.72','会员退出','member','中国移动'),(6,1584031254,'','36.184.184.72','会员退出','member','中国移动'),(7,1584031258,'18888888888','180.127.157.6','备份数据库','admin','江苏省连云港市电信'),(8,1584031475,'18888888888','180.127.157.6','编辑ID为1的管理员','admin','江苏省连云港市电信'),(9,1584031483,'18888888888','180.127.157.6','编辑ID为1的管理员','admin','江苏省连云港市电信'),(10,1584031542,'18888888888','180.127.157.6','编辑ID为1的管理员','admin','江苏省连云港市电信'),(11,1584031545,'admin','180.127.157.6','管理员admin登出','admin','江苏省连云港市电信'),(12,1584031554,'admin','180.127.157.6','管理员[admin]登录','admin','江苏省连云港市电信'),(13,1584031644,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(14,1584031667,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(15,1584031822,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(16,1584033619,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(17,1584033918,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(18,1584033982,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(19,1584034093,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(20,1584034722,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(21,1584076883,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(22,1584077844,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(23,1584081217,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(24,1584084196,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(25,1584084806,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(26,1584084935,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(27,1584085061,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(28,1584085363,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(29,1584092819,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(30,1584092886,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(31,1584093007,'','180.127.157.6','删除公告类别','admin','江苏省连云港市电信'),(32,1584093099,'','180.127.157.6','修改了一个公告类别','admin','江苏省连云港市电信'),(33,1584093129,'','180.127.157.6','修改项目','admin','江苏省连云港市电信'),(34,1584093254,'18888888888','180.127.157.6','修改项目','admin','江苏省连云港市电信'),(35,1584093279,'18888888888','180.127.157.6','发布公告','admin','江苏省连云港市电信'),(36,1584096008,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(37,1584099207,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(38,1584111774,'18888888888','180.127.157.6','备份数据库','admin','江苏省连云港市电信'),(39,1584113451,'admin','42.235.163.145','管理员[admin]登录','admin','河南省联通'),(40,1584113556,'admin','211.23.12.206','管理员[admin]登录','admin','台湾省中华电信'),(41,1584114477,'15888888888','42.235.163.145','修改项目','admin','河南省联通'),(42,1584114492,'15888888888','42.235.163.145','修改项目','admin','河南省联通'),(43,1584114553,'15888888888','42.235.163.145','修改项目','admin','河南省联通'),(44,1584114562,'15888888888','42.235.163.145','修改项目','admin','河南省联通'),(45,1584114590,'15888888888','42.235.163.145','修改项目','admin','河南省联通'),(46,1584114668,'15888888888','42.235.163.145','修改项目','admin','河南省联通'),(47,1584114735,'18888888888','180.127.157.6','发布公告','admin','江苏省连云港市电信'),(48,1584114746,'18888888888','180.127.157.6','修改公告','admin','江苏省连云港市电信'),(49,1584114756,'18888888888','180.127.157.6','发布公告','admin','江苏省连云港市电信'),(50,1584114766,'18888888888','180.127.157.6','发布公告','admin','江苏省连云港市电信'),(51,1584115957,'18888888888','180.127.157.6','修改项目','admin','江苏省连云港市电信'),(52,1584116007,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(53,1584117356,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(54,1584117490,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(55,1584123225,'','180.127.157.6','会员退出','member','江苏省连云港市电信'),(56,1592667795,'admin','121.207.163.113','管理员[admin]登录','admin','福建省厦门市电信');
/*!40000 ALTER TABLE `ds_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_member`
--

DROP TABLE IF EXISTS `ds_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_member` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '会员编号',
  `password` varchar(32) DEFAULT NULL COMMENT '一级密码',
  `level` int(4) DEFAULT '0',
  `inviteCode` text NOT NULL,
  `avatar` text NOT NULL,
  `regaddress` varchar(255) DEFAULT NULL COMMENT 'IP地址',
  `regdate` int(10) DEFAULT NULL COMMENT '注册时间',
  `parent` varchar(255) DEFAULT NULL COMMENT '推荐人',
  `parent_id` int(11) unsigned NOT NULL COMMENT '推荐人ID',
  `pic` varchar(100) NOT NULL COMMENT '头像',
  `jifen` decimal(10,0) DEFAULT '0',
  `erwei` varchar(255) DEFAULT NULL,
  `idcard` varchar(255) NOT NULL,
  `dongjie` decimal(15,2) DEFAULT '0.00' COMMENT '冻结金额',
  `parentcount` int(11) DEFAULT '0' COMMENT '推荐人数',
  `name` varchar(255) DEFAULT '会员',
  `money` decimal(15,2) unsigned DEFAULT '0.00' COMMENT '金币数量',
  `truename` varchar(255) DEFAULT NULL COMMENT '真实姓名',
  `mobile` varchar(20) DEFAULT NULL COMMENT '手机',
  `logintime` int(10) DEFAULT '0' COMMENT '本次登录时间',
  `gamecount` int(10) DEFAULT '0',
  `robotcount` int(10) DEFAULT '0' COMMENT '机器人总数',
  `logincount` int(10) DEFAULT '0' COMMENT '登录总次数',
  `parentpath` longtext COMMENT '推荐遗传码',
  `online_time` int(10) DEFAULT NULL COMMENT '最后登陆时间',
  `wei` varchar(100) DEFAULT NULL,
  `zhifu` varchar(100) DEFAULT NULL,
  `lock` tinyint(4) DEFAULT NULL COMMENT '锁定',
  PRIMARY KEY (`id`),
  KEY `username` (`username`),
  KEY `parent` (`parent`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=278 ROW_FORMAT=DYNAMIC COMMENT='会员';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_member`
--

LOCK TABLES `ds_member` WRITE;
/*!40000 ALTER TABLE `ds_member` DISABLE KEYS */;
INSERT INTO `ds_member` VALUES (2,'15888888888','e10adc3949ba59abbe56e057f20f883e',0,'UGL289','','美国',1584031737,'18888888888',1,'',0,NULL,'',0.00,1,'会员',0.00,'初始账户2',NULL,1584096019,1,0,9,'1|1|',1584118053,NULL,NULL,NULL),(3,'13888888888','e10adc3949ba59abbe56e057f20f883e',0,'YKB572','','美国',1584031868,'15888888888',2,'',0,NULL,'',0.00,0,'会员',0.00,'初始账号3',NULL,1584123247,0,3,11,'1|1|26|',1584125648,NULL,NULL,NULL),(1,'18888888888','e10adc3949ba59abbe56e057f20f883e',0,'WSB903','','美国',1584030607,'1550000000',0,'',0,NULL,'',0.00,1,'会员',50000.00,'初始账户1',NULL,1592667910,2,0,14,'1|',1592668143,NULL,NULL,NULL);
/*!40000 ALTER TABLE `ds_member` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_member_award_log`
--

DROP TABLE IF EXISTS `ds_member_award_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_member_award_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `send_type` tinyint(1) NOT NULL,
  `userortype_id` int(11) NOT NULL,
  `send_style` tinyint(1) NOT NULL,
  `num` int(11) NOT NULL,
  `add_time` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_member_award_log`
--

LOCK TABLES `ds_member_award_log` WRITE;
/*!40000 ALTER TABLE `ds_member_award_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `ds_member_award_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_member_paylist`
--

DROP TABLE IF EXISTS `ds_member_paylist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_member_paylist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` text NOT NULL,
  `amount` int(11) NOT NULL,
  `imageUrl` text NOT NULL,
  `applyDate` text NOT NULL,
  `ordersn` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_member_paylist`
--

LOCK TABLES `ds_member_paylist` WRITE;
/*!40000 ALTER TABLE `ds_member_paylist` DISABLE KEYS */;
/*!40000 ALTER TABLE `ds_member_paylist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_member_receive`
--

DROP TABLE IF EXISTS `ds_member_receive`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_member_receive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` text NOT NULL,
  `amount` int(11) NOT NULL,
  `location` text NOT NULL,
  `applyDate` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_member_receive`
--

LOCK TABLES `ds_member_receive` WRITE;
/*!40000 ALTER TABLE `ds_member_receive` DISABLE KEYS */;
/*!40000 ALTER TABLE `ds_member_receive` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_member_recharge`
--

DROP TABLE IF EXISTS `ds_member_recharge`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_member_recharge` (
  `r_id` int(11) NOT NULL AUTO_INCREMENT,
  `order_sn` varchar(100) NOT NULL,
  `fkzh` varchar(255) NOT NULL,
  `user_id` int(11) NOT NULL,
  `gbc` decimal(15,2) NOT NULL,
  `rmb` decimal(15,2) NOT NULL,
  `bili` varchar(30) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT '0',
  `pay_type` varchar(30) NOT NULL,
  `note` varchar(100) NOT NULL,
  `add_time` int(11) NOT NULL,
  PRIMARY KEY (`r_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COMMENT='会员充值表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_member_recharge`
--

LOCK TABLES `ds_member_recharge` WRITE;
/*!40000 ALTER TABLE `ds_member_recharge` DISABLE KEYS */;
/*!40000 ALTER TABLE `ds_member_recharge` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_message`
--

DROP TABLE IF EXISTS `ds_message`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from` varchar(45) NOT NULL DEFAULT '' COMMENT '发件人',
  `pic` varchar(100) DEFAULT NULL COMMENT '头像',
  `truename` varchar(100) DEFAULT NULL,
  `content` text NOT NULL COMMENT '内容',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发送时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='站内信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_message`
--

LOCK TABLES `ds_message` WRITE;
/*!40000 ALTER TABLE `ds_message` DISABLE KEYS */;
/*!40000 ALTER TABLE `ds_message` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_node`
--

DROP TABLE IF EXISTS `ds_node`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_node` (
  `id` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(20) NOT NULL DEFAULT '',
  `title` varchar(50) DEFAULT NULL,
  `status` tinyint(1) DEFAULT '0',
  `remark` varchar(255) DEFAULT NULL,
  `sort` smallint(6) unsigned DEFAULT NULL,
  `pid` smallint(6) unsigned NOT NULL,
  `level` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `level` (`level`),
  KEY `name` (`name`),
  KEY `pid` (`pid`),
  KEY `status` (`status`)
) ENGINE=MyISAM AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=35 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_node`
--

LOCK TABLES `ds_node` WRITE;
/*!40000 ALTER TABLE `ds_node` DISABLE KEYS */;
INSERT INTO `ds_node` VALUES (1,'systemlogined','后台应用',1,'',1,0,1),(6,'Rbac','Rbac权限控制',1,'',6,1,2),(7,'Index','后台首页',1,'',1,1,2),(10,'index','用户列表',1,'',1,6,3),(11,'role','角色列表',1,'',1,6,3),(12,'node','节点列表',1,'',1,6,3),(16,'index','后台首页',1,'',1,7,3),(17,'Member','会员管理',1,'',2,1,2),(18,'uncheck','未审核会员',1,'',1,17,3),(19,'check','会员查询',1,'',1,17,3),(20,'pw_list','团队排位图',1,'',1,17,3),(22,'Jinbidetail','资金管理',1,'',4,1,2),(23,'index','pv明细',1,'',1,22,3),(24,'paylists','充值管理',1,'',1,22,3),(25,'emoneyWithdraw','提现管理',1,'',1,22,3),(26,'shop','商城管理',1,'',3,1,2),(27,'type_list','分类列表',1,'',1,26,3),(28,'Info','信息交流',1,'',5,1,2),(29,'announce','公告管理',1,'',1,28,3),(30,'annType','公告类别',1,'',1,28,3),(31,'msgReceive','收件箱',1,'',1,28,3),(32,'msgSend','发件箱',1,'',1,28,3),(33,'System','系统设置',1,'',7,1,2),(34,'backUp','数据备份',1,'',1,33,3),(35,'customSetting','自定义配置',1,'',1,33,3),(36,' jiangjin','奖金查询',1,'',1,22,3),(37,'member_group','会员等级',1,'',1,17,3),(38,'lists','商品列表',1,'',1,26,3),(39,'orderlist','订单列表',1,'',1,26,3),(40,'paylist','零售管理',1,'',1,22,3),(41,'jinzhongzi','重消明细',1,'',1,22,3),(42,'point','代金券明细',1,'',1,22,3),(43,'editPay','零售操作',1,'',1,22,3),(44,'editPays','充值操作',1,'',1,22,3),(45,'editEmoney','提现操作',1,'',1,22,3),(46,'editPayhandles','充值提交操作',1,'',1,22,3);
/*!40000 ALTER TABLE `ds_node` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_order`
--

DROP TABLE IF EXISTS `ds_order`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_order` (
  `id` int(255) unsigned NOT NULL AUTO_INCREMENT,
  `user` varchar(30) DEFAULT NULL,
  `tuijian` varchar(255) DEFAULT NULL COMMENT '推荐人',
  `user_id` int(11) unsigned NOT NULL,
  `project` varchar(30) DEFAULT NULL,
  `count` decimal(10,2) DEFAULT '0.00',
  `sumprice` decimal(10,2) NOT NULL,
  `addtime` varchar(30) DEFAULT NULL,
  `UG_getTime` int(11) unsigned NOT NULL DEFAULT '0',
  `zt` int(10) NOT NULL DEFAULT '0',
  `sid` int(11) DEFAULT NULL,
  `imagepath` text,
  `yxzq` varchar(60) DEFAULT NULL COMMENT '可运行时间小时',
  `shouyi` decimal(15,8) DEFAULT NULL COMMENT '收益每小时',
  `kjbh` varchar(255) DEFAULT NULL,
  `already_profit` decimal(15,8) NOT NULL COMMENT '已经收益',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_order`
--

LOCK TABLES `ds_order` WRITE;
/*!40000 ALTER TABLE `ds_order` DISABLE KEYS */;
INSERT INTO `ds_order` VALUES (1,'13888888888','15888888888',3,'沉香',0.00,1000.00,'2020-03-14 00:40:08',1584117608,1,3,'/Public/Uploads/20200313/5e6b31dbc9cb7.png','2160',0.74500000,'C141760835',0.00000000),(2,'13888888888','15888888888',3,'沉香',0.00,1000.00,'2020-03-14 01:26:06',1584120366,1,3,'/Public/Uploads/20200313/5e6b31dbc9cb7.png','2160',0.74500000,'C142036628',0.00000000),(3,'13888888888','15888888888',3,'沉香',0.00,1000.00,'2020-03-14 01:26:52',1584120412,1,3,'/Public/Uploads/20200313/5e6b31dbc9cb7.png','2160',0.74500000,'C142041286',0.00000000);
/*!40000 ALTER TABLE `ds_order` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_pay`
--

DROP TABLE IF EXISTS `ds_pay`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_pay` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pay_no` text NOT NULL,
  `pay_id` text NOT NULL,
  `type` int(11) NOT NULL,
  `pay_time` bigint(20) NOT NULL,
  `status` int(11) NOT NULL,
  `price` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_pay`
--

LOCK TABLES `ds_pay` WRITE;
/*!40000 ALTER TABLE `ds_pay` DISABLE KEYS */;
/*!40000 ALTER TABLE `ds_pay` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_paydetail`
--

DROP TABLE IF EXISTS `ds_paydetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_paydetail` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `member` varchar(20) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `type` varchar(100) NOT NULL,
  `account` varchar(100) NOT NULL,
  `name` varchar(100) NOT NULL,
  `content` varchar(100) NOT NULL,
  `remark` varchar(100) NOT NULL,
  `addtime` int(11) unsigned NOT NULL,
  `status` tinyint(3) unsigned NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_paydetail`
--

LOCK TABLES `ds_paydetail` WRITE;
/*!40000 ALTER TABLE `ds_paydetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `ds_paydetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_product`
--

DROP TABLE IF EXISTS `ds_product`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_product` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `tid` int(11) NOT NULL,
  `title` char(255) NOT NULL,
  `price` decimal(10,2) NOT NULL DEFAULT '0.00',
  `stock` mediumint(9) NOT NULL DEFAULT '0',
  `yxzq` mediumint(8) unsigned NOT NULL DEFAULT '0',
  `shouyi` decimal(15,3) unsigned NOT NULL DEFAULT '0.000',
  `thumb` char(255) NOT NULL DEFAULT 'pic.png',
  `content` varchar(255) NOT NULL,
  `pid` int(11) NOT NULL,
  `inputtime` int(11) unsigned NOT NULL,
  `xiangou` int(11) NOT NULL COMMENT '限购',
  `is_on` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_product`
--

LOCK TABLES `ds_product` WRITE;
/*!40000 ALTER TABLE `ds_product` DISABLE KEYS */;
INSERT INTO `ds_product` VALUES (1,1,'树苗',100.00,18,720,0.168,'/Public/Uploads/20200313/5e6b2e0ca7520.png','',0,1584081321,1,0),(2,2,'紫檀',500.00,100,1440,0.488,'/Public/Uploads/20200313/5e6b3154bccdc.png','',0,1584083284,3,0),(3,3,'沉香',1000.00,47,2160,0.745,'/Public/Uploads/20200313/5e6b31dbc9cb7.png','',0,1584083419,3,0),(4,4,'金丝楠',3000.00,30,2160,2.508,'/Public/Uploads/20200313/5e6b322b9cc1b.png','',0,1584083499,2,0),(5,5,'黄花梨',5000.00,10,2160,4.648,'/Public/Uploads/20200313/5e6b326d4d295.png','',0,1584083565,1,0);
/*!40000 ALTER TABLE `ds_product` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_profile_log`
--

DROP TABLE IF EXISTS `ds_profile_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_profile_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `profile` decimal(10,5) DEFAULT NULL,
  `add_time` varchar(50) DEFAULT NULL,
  `scid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_profile_log`
--

LOCK TABLES `ds_profile_log` WRITE;
/*!40000 ALTER TABLE `ds_profile_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `ds_profile_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_qjinbidetail`
--

DROP TABLE IF EXISTS `ds_qjinbidetail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_qjinbidetail` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `type` tinyint(4) NOT NULL DEFAULT '0',
  `member` varchar(255) DEFAULT '' COMMENT '会员编号',
  `adds` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '添加',
  `reduce` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '减少',
  `balance` decimal(12,2) unsigned DEFAULT '0.00' COMMENT '余额',
  `addtime` int(10) DEFAULT '0' COMMENT '操作时间',
  `statustime` int(11) unsigned NOT NULL DEFAULT '0',
  `desc` varchar(255) DEFAULT '' COMMENT '说明',
  `status` tinyint(4) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `type` (`type`),
  KEY `member` (`member`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=68 ROW_FORMAT=DYNAMIC COMMENT='欠钱明细';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_qjinbidetail`
--

LOCK TABLES `ds_qjinbidetail` WRITE;
/*!40000 ALTER TABLE `ds_qjinbidetail` DISABLE KEYS */;
/*!40000 ALTER TABLE `ds_qjinbidetail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_session`
--

DROP TABLE IF EXISTS `ds_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_session` (
  `session_id` varchar(255) NOT NULL DEFAULT '',
  `session_expire` int(11) NOT NULL,
  `session_data` blob,
  UNIQUE KEY `session_id` (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=196 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_session`
--

LOCK TABLES `ds_session` WRITE;
/*!40000 ALTER TABLE `ds_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `ds_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_sms_log`
--

DROP TABLE IF EXISTS `ds_sms_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_sms_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '表id',
  `mobile` varchar(11) DEFAULT '' COMMENT '手机号',
  `session_id` varchar(128) DEFAULT '' COMMENT 'session_id',
  `add_time` int(11) DEFAULT '0' COMMENT '发送时间',
  `code` varchar(10) DEFAULT '' COMMENT '验证码',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_sms_log`
--

LOCK TABLES `ds_sms_log` WRITE;
/*!40000 ALTER TABLE `ds_sms_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `ds_sms_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_type`
--

DROP TABLE IF EXISTS `ds_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(32) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `path` char(30) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_type`
--

LOCK TABLES `ds_type` WRITE;
/*!40000 ALTER TABLE `ds_type` DISABLE KEYS */;
INSERT INTO `ds_type` VALUES (1,'A',0,'0'),(2,'B',0,'0'),(3,'C',0,'0'),(4,'D',0,'0'),(5,'E',0,'0'),(6,'F',0,'0'),(7,'G',0,'0'),(8,'H',0,'0'),(9,'I',0,'0'),(10,'J',0,'0'),(11,'K',0,'0'),(12,'L',0,'0'),(13,'M',0,'0'),(14,'N',0,'0'),(15,'O',0,'0'),(16,'P',0,'0'),(17,'Q',0,'0'),(18,'R',0,'0'),(19,'S',0,'0'),(20,'T',0,'0'),(21,'U',0,'0'),(22,'V',0,'0'),(23,'W',0,'0'),(24,'X',0,'0'),(25,'Y',0,'0'),(26,'Z',0,'0');
/*!40000 ALTER TABLE `ds_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_user`
--

DROP TABLE IF EXISTS `ds_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_user` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `username` char(20) NOT NULL DEFAULT '',
  `password` char(32) NOT NULL DEFAULT '',
  `logtime` int(10) NOT NULL,
  `loginip` char(30) NOT NULL DEFAULT '',
  `lock` tinyint(1) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=256 ROW_FORMAT=DYNAMIC;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_user`
--

LOCK TABLES `ds_user` WRITE;
/*!40000 ALTER TABLE `ds_user` DISABLE KEYS */;
INSERT INTO `ds_user` VALUES (1,'admin','e10adc3949ba59abbe56e057f20f883e',1592667795,'121.207.163.113',0);
/*!40000 ALTER TABLE `ds_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ds_xiangmu`
--

DROP TABLE IF EXISTS `ds_xiangmu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ds_xiangmu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(60) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `edittime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=755 ROW_FORMAT=DYNAMIC COMMENT='公告信息表';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ds_xiangmu`
--

LOCK TABLES `ds_xiangmu` WRITE;
/*!40000 ALTER TABLE `ds_xiangmu` DISABLE KEYS */;
INSERT INTO `ds_xiangmu` VALUES (1,'东鸿益森生态帮助中心','项目测试',0,1584115957);
/*!40000 ALTER TABLE `ds_xiangmu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'b021_q6688_xyz'
--
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-20 23:49:10
