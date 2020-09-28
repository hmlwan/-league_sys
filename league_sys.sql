/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : league_sys

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2020-09-28 21:22:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `codepay_order`
-- ----------------------------
DROP TABLE IF EXISTS `codepay_order`;
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

-- ----------------------------
-- Records of codepay_order
-- ----------------------------

-- ----------------------------
-- Table structure for `codepay_user`
-- ----------------------------
DROP TABLE IF EXISTS `codepay_user`;
CREATE TABLE `codepay_user` (
  `id` int(10) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user` varchar(100) NOT NULL DEFAULT '' COMMENT '用户名',
  `money` decimal(6,2) NOT NULL DEFAULT '0.00' COMMENT '金额',
  `vip` int(1) NOT NULL DEFAULT '0' COMMENT '会员开通',
  `status` int(1) NOT NULL DEFAULT '0' COMMENT '会员状态',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of codepay_user
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_announce`
-- ----------------------------
DROP TABLE IF EXISTS `ds_announce`;
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
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=755 ROW_FORMAT=DYNAMIC COMMENT='公告信息表';

-- ----------------------------
-- Records of ds_announce
-- ----------------------------
INSERT INTO `ds_announce` VALUES ('1', '测试', '测试', 'admin', '1584093263', '1584093263', '/Public/Uploads/zixun/20200313/5e6b585fcdaa6.png', 'all', '1');
INSERT INTO `ds_announce` VALUES ('2', '测试1', '1', 'admin', '1584114722', '1584114746', '/Public/Uploads/zixun/20200313/5e6bac3abd35a.png', 'all', '1');
INSERT INTO `ds_announce` VALUES ('3', '测试2', '123312', 'admin', '1584114750', '1584114750', '/Public/Uploads/zixun/20200313/5e6bac4440e62.png', 'all', '1');
INSERT INTO `ds_announce` VALUES ('4', '测试3', '123112', 'admin', '1584114758', '1584114758', '/Public/Uploads/zixun/20200313/5e6bac4df073c.png', 'all', '1');

-- ----------------------------
-- Table structure for `ds_announcetype`
-- ----------------------------
DROP TABLE IF EXISTS `ds_announcetype`;
CREATE TABLE `ds_announcetype` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT COMMENT '类别ID',
  `name` varchar(45) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=24 ROW_FORMAT=DYNAMIC COMMENT='公告类别';

-- ----------------------------
-- Records of ds_announcetype
-- ----------------------------
INSERT INTO `ds_announcetype` VALUES ('1', '官方公告');
INSERT INTO `ds_announcetype` VALUES ('15', '帮助中心');

-- ----------------------------
-- Table structure for `ds_announce_click`
-- ----------------------------
DROP TABLE IF EXISTS `ds_announce_click`;
CREATE TABLE `ds_announce_click` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `news_id` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=131519 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_announce_click
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_application`
-- ----------------------------
DROP TABLE IF EXISTS `ds_application`;
CREATE TABLE `ds_application` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) DEFAULT NULL,
  `name` varchar(100) DEFAULT NULL COMMENT '名称',
  `logo_url` varchar(216) DEFAULT NULL COMMENT 'LOGO',
  `jump_url` varchar(216) DEFAULT NULL COMMENT '点击跳转地址',
  `sort` tinyint(10) DEFAULT '0' COMMENT '权重: 权重越高越靠前',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态 1：开启 0关闭',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_application
-- ----------------------------
INSERT INTO `ds_application` VALUES ('3', '2', '滴滴', '/Public/Uploads/app/20200923/5f6ab38083216.png', 'https://www.baidu.com/', '1', '1');
INSERT INTO `ds_application` VALUES ('2', '2', '美团', '/Public/Uploads/app/20200923/5f6a39a0a483a.png', 'https://www.baidu.com/', '2', '1');
INSERT INTO `ds_application` VALUES ('4', '2', '携程', '/Public/Uploads/app/20200923/5f6ab3ecbdb96.png', 'https://www.baidu.com/', '5', '1');
INSERT INTO `ds_application` VALUES ('5', '2', '淘宝', '/Public/Uploads/app/20200923/5f6ab40c53476.png', 'https://www.baidu.com/', '6', '1');
INSERT INTO `ds_application` VALUES ('6', '3', '京东', '/Public/Uploads/app/20200923/5f6ab4296d286.png', 'https://www.baidu.com/', '2', '1');
INSERT INTO `ds_application` VALUES ('7', '3', '拼多多', '/Public/Uploads/app/20200923/5f6b61febb96e.png', 'https://www.baidu.com/', '1', '1');

-- ----------------------------
-- Table structure for `ds_application_type`
-- ----------------------------
DROP TABLE IF EXISTS `ds_application_type`;
CREATE TABLE `ds_application_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '主题',
  `num` int(10) DEFAULT '0' COMMENT '广告位数量',
  `sort` tinyint(10) DEFAULT '0' COMMENT '权重 越大越靠前',
  `status` tinyint(4) DEFAULT '1' COMMENT '1:开启 0：关闭',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_application_type
-- ----------------------------
INSERT INTO `ds_application_type` VALUES ('3', '生活购物', '8', '2', '1');
INSERT INTO `ds_application_type` VALUES ('2', '本地服务', '4', '3', '1');
INSERT INTO `ds_application_type` VALUES ('4', '金融借款', '4', '4', '1');
INSERT INTO `ds_application_type` VALUES ('5', '游戏娱乐', '4', '1', '1');

-- ----------------------------
-- Table structure for `ds_auth_group`
-- ----------------------------
DROP TABLE IF EXISTS `ds_auth_group`;
CREATE TABLE `ds_auth_group` (
  `id` mediumint(8) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(100) NOT NULL DEFAULT '',
  `status` tinyint(1) NOT NULL DEFAULT '1',
  `rules` varchar(500) NOT NULL DEFAULT '',
  `description` char(50) NOT NULL DEFAULT '',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_auth_group
-- ----------------------------
INSERT INTO `ds_auth_group` VALUES ('4', '超级管理员', '1', '13,14,15,16,17,18,19,20,21,22,23,24,25,26,89,27,28,29,30,31,32,80,81,33,34,35,36,37,38,39,41,42,43,44,45,46,47,48,49,50,51,52,82,83,84,85,87,88,9,10,11,12,86,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,7913,14,15,16,17,18,19,20,21,22,23,24,25,26,89,27,28,29,30,31,32,80,81,33,34,35,36,37,38,39,41,42,43,44,45,46,47,48,49,50,51,52,82,83,84,85,87,88,9,10,11,12,86,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79', '拥有所有权限的管理员');
INSERT INTO `ds_auth_group` VALUES ('7', '首页管理员', '1', '13,14,15,16,17,18,19,20,21,22,23,24,25,26,9', '能够管理首页推荐位');
INSERT INTO `ds_auth_group` VALUES ('8', '广告管理员', '1', '27,28,29,30,31,32,9', '管理全部广告');
INSERT INTO `ds_auth_group` VALUES ('9', '分类管理员', '1', '33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,9', '分类管理员');
INSERT INTO `ds_auth_group` VALUES ('10', '优惠券管理', '1', '53,54,55,56,57,58,59,60', '优惠券管理');

-- ----------------------------
-- Table structure for `ds_auth_group_access`
-- ----------------------------
DROP TABLE IF EXISTS `ds_auth_group_access`;
CREATE TABLE `ds_auth_group_access` (
  `uid` mediumint(8) unsigned NOT NULL,
  `group_id` mediumint(8) unsigned NOT NULL,
  UNIQUE KEY `uid_group_id` (`uid`,`group_id`),
  KEY `uid` (`uid`),
  KEY `group_id` (`group_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_auth_group_access
-- ----------------------------
INSERT INTO `ds_auth_group_access` VALUES ('2651', '4');

-- ----------------------------
-- Table structure for `ds_auth_rule`
-- ----------------------------
DROP TABLE IF EXISTS `ds_auth_rule`;
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

-- ----------------------------
-- Records of ds_auth_rule
-- ----------------------------
INSERT INTO `ds_auth_rule` VALUES ('9', 'Admin/Index/index', '登录首页', '1', '1', '', '9');
INSERT INTO `ds_auth_rule` VALUES ('10', 'Admin/Websetting/index', '基础配置', '1', '1', '', '9');
INSERT INTO `ds_auth_rule` VALUES ('11', 'Admin/Navsetting/index', '导航配置', '1', '1', '', '9');
INSERT INTO `ds_auth_rule` VALUES ('12', 'Admin/Friendlink/index', '友情链接配置', '1', '1', '', '9');
INSERT INTO `ds_auth_rule` VALUES ('13', 'Admin/Indexset/index', '查看首页管理', '1', '1', '', '1');
INSERT INTO `ds_auth_rule` VALUES ('14', 'Admin/Indexset/addFloor', '添加楼层', '1', '1', '', '1');
INSERT INTO `ds_auth_rule` VALUES ('15', 'Admin/Indexset/modifyFloor', '修改楼层', '1', '1', '', '1');
INSERT INTO `ds_auth_rule` VALUES ('16', 'Admin/Indexset/deleteFloor', '删除楼层', '1', '1', '', '1');
INSERT INTO `ds_auth_rule` VALUES ('17', 'Admin/Indexset/loadData', '显示楼层图片广告', '1', '1', '', '1');
INSERT INTO `ds_auth_rule` VALUES ('18', 'Admin/Indexset/viewClass', '查看可添加楼层', '1', '1', '', '1');
INSERT INTO `ds_auth_rule` VALUES ('19', 'Admin/Indexset/editAd', '修改楼层广告', '1', '1', '', '1');
INSERT INTO `ds_auth_rule` VALUES ('20', 'Admin/Indexset/insertAd', '添加楼层广告', '1', '1', '', '1');
INSERT INTO `ds_auth_rule` VALUES ('21', 'Admin/Indexset/deleteAd', '删除楼层广告', '1', '1', '', '1');
INSERT INTO `ds_auth_rule` VALUES ('22', 'Admin/Indexset/createPic', '添加楼层广告页面', '1', '1', '', '1');
INSERT INTO `ds_auth_rule` VALUES ('23', 'Admin/Indexset/createText', '添加楼层文字广告页面', '1', '1', '', '1');
INSERT INTO `ds_auth_rule` VALUES ('24', 'Admin/Indexset/editPic', '修改楼层广告页面', '1', '1', '', '1');
INSERT INTO `ds_auth_rule` VALUES ('25', 'Admin/Indexset/editText', '修改楼层文字广告页面', '1', '1', '', '1');
INSERT INTO `ds_auth_rule` VALUES ('26', 'Admin/Indexset/loadText', '显示楼层文字广告', '1', '1', '', '1');
INSERT INTO `ds_auth_rule` VALUES ('27', 'Admin/Adset/index', '广告管理首页', '1', '1', '', '2');
INSERT INTO `ds_auth_rule` VALUES ('28', 'Admin/Adset/createAd', '广告添加页面', '1', '1', '', '2');
INSERT INTO `ds_auth_rule` VALUES ('29', 'Admin/Adset/insertAd', '广告添加', '1', '1', '', '2');
INSERT INTO `ds_auth_rule` VALUES ('30', 'Admin/Adset/editAd', '广告修改页面', '1', '1', '', '2');
INSERT INTO `ds_auth_rule` VALUES ('31', 'Admin/Adset/updataAd', '广告修改', '1', '1', '', '2');
INSERT INTO `ds_auth_rule` VALUES ('32', 'Admin/Adset/deleteAd', '广告删除', '1', '1', '', '2');
INSERT INTO `ds_auth_rule` VALUES ('33', 'Admin/GoodsClass/index', '商品分类显示', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('34', 'Admin/GoodsClass/addClass', '商品分类添加页面', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('35', 'Admin/GoodsClass/modifyClass', '商品分类修改页面', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('36', 'Admin/GoodsClass/insertClass', '商品分类添加', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('37', 'Admin/GoodsClass/updataClass', '商品分类修改', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('38', 'Admin/GoodsClass/deleteClass', '商品分类删除', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('39', 'Admin/GoodsClass/viewClassId', '商品分类显示分类id', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('41', 'Admin/Goodsattr/index', '商品属性查看', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('42', 'Admin/Goodsattr/addAttr', '商品属性添加页面', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('43', 'Admin/Goodsattr/modifyAttr', '商品属性修改页面', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('44', 'Admin/Goodsattr/insertAttr', '商品属性添加', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('45', 'Admin/Goodsattr/updataAttr', '商品属性修改', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('46', 'Admin/Goodsattr/deleteAttr', '商品属性删除', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('47', 'Admin/Goodsbrand/index', '商品品牌查看', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('48', 'Admin/Goodsbrand/addBrand', '商品品牌添加页面', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('49', 'Admin/Goodsbrand/modifyBrand', '商品品牌修改页面', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('50', 'Admin/Goodsbrand/insertBrand', '商品品牌添加', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('51', 'Admin/Goodsbrand/updataBrand', '商品品牌修改', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('52', 'Admin/Goodsbrand/deleteBrand', '商品品牌删除', '1', '1', '', '4');
INSERT INTO `ds_auth_rule` VALUES ('53', 'Admin/Couponmanage/index', '显示优惠券组列表', '1', '1', '', '7');
INSERT INTO `ds_auth_rule` VALUES ('54', 'Admin/Couponmanage/coupons', '优惠券详情列表', '1', '1', '', '7');
INSERT INTO `ds_auth_rule` VALUES ('55', 'Admin/Couponmanage/addCoupon', '添加优惠券', '1', '1', '', '7');
INSERT INTO `ds_auth_rule` VALUES ('56', 'Admin/Couponmanage/modifyCoupon', '修改优惠券', '1', '1', '', '7');
INSERT INTO `ds_auth_rule` VALUES ('57', 'Admin/Couponmanage/insertCoupon', '优惠券添加', '1', '1', '', '7');
INSERT INTO `ds_auth_rule` VALUES ('58', 'Admin/Couponmanage/updataCoupon', '优惠券修改', '1', '1', '', '7');
INSERT INTO `ds_auth_rule` VALUES ('59', 'Admin/Couponmanage/deleteCoupon', '删除优惠券', '1', '1', '', '7');
INSERT INTO `ds_auth_rule` VALUES ('60', 'Admin/Couponmanage/couponState', '更新优惠券状态', '1', '1', '', '7');
INSERT INTO `ds_auth_rule` VALUES ('62', 'Admin/Accesslist/index', '权限列表页面', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('63', 'Admin/Accesslist/addAccess', '权限添加页面', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('64', 'Admin/Accesslist/modifyAccess', '权限修改页面', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('65', 'Admin/Accesslist/insertAccess', '权限添加', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('66', 'Admin/Accesslist/updataAccess', '权限修改', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('67', 'Admin/Accesslist/deleteAccess', '权限删除', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('68', 'Admin/Accesslist/accessState', '权限状态更新', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('69', 'Admin/Grouplist/index', '角色管理页面', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('70', 'Admin/Grouplist/addGroup', '角色添加页面', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('71', 'Admin/Grouplist/modifyGroup', '角色修改页面', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('72', 'Admin/Grouplist/insertGroup', '角色添加', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('73', 'Admin/Grouplist/updataGroup', '角色修改', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('74', 'Admin/Grouplist/deleteGroup', '角色删除', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('75', 'Admin/Grouplist/groupState', '角色状态更新', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('76', 'Admin/Grouplist/groupMem', '角色成员管理页面', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('77', 'Admin/Grouplist/addMem', '角色成员添加页面', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('78', 'Admin/Grouplist/insertMem', '角色成员添加', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('79', 'Admin/Grouplist/deleteMem', '角色成员删除', '1', '1', '', '10');
INSERT INTO `ds_auth_rule` VALUES ('80', 'Admin/Member/index', '用户管理', '1', '1', '', '3');
INSERT INTO `ds_auth_rule` VALUES ('81', 'Admin/Memlevel/index', '用户等级', '1', '1', '', '3');
INSERT INTO `ds_auth_rule` VALUES ('82', 'Admin/Goodsissue/index', '商品发布', '1', '1', '', '5');
INSERT INTO `ds_auth_rule` VALUES ('83', 'Admin/Goodsup/index', '商品上架', '1', '1', '', '5');
INSERT INTO `ds_auth_rule` VALUES ('84', 'Admin/Goodsdown/index', '商品下架', '1', '1', '', '5');
INSERT INTO `ds_auth_rule` VALUES ('85', 'Admin/Ordermanage/index', '订单管理', '1', '1', '', '6');
INSERT INTO `ds_auth_rule` VALUES ('86', 'Admin/Reviewmanage/index', '评价管理', '1', '1', '', '9');
INSERT INTO `ds_auth_rule` VALUES ('87', 'Admin/Articleclasses/index', '文章分类', '1', '1', '', '8');
INSERT INTO `ds_auth_rule` VALUES ('88', 'Admin/Articlemanage/index', '文章管理', '1', '1', '', '8');
INSERT INTO `ds_auth_rule` VALUES ('89', 'Admin/index/mang', '网站管理', '1', '1', '', '1');

-- ----------------------------
-- Table structure for `ds_bankcard`
-- ----------------------------
DROP TABLE IF EXISTS `ds_bankcard`;
CREATE TABLE `ds_bankcard` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userid` int(11) DEFAULT NULL,
  `name` varchar(200) DEFAULT NULL COMMENT '中文名',
  `card` varchar(100) DEFAULT NULL,
  `kaihuhang` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ds_bankcard
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_banner`
-- ----------------------------
DROP TABLE IF EXISTS `ds_banner`;
CREATE TABLE `ds_banner` (
  `id` int(10) NOT NULL,
  `path` varchar(100) NOT NULL,
  `href` varchar(100) DEFAULT NULL,
  `addtime` int(10) DEFAULT NULL,
  `sort` int(10) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_banner
-- ----------------------------
INSERT INTO `ds_banner` VALUES ('1', '/Public/Uploads/20181117/1.jpg', '#', '0', '0');
INSERT INTO `ds_banner` VALUES ('2', '/Public/Uploads/20181117/4.jpg', '#', '0', '0');
INSERT INTO `ds_banner` VALUES ('3', '/Public/Uploads/20181117/2.jpg', '#', '0', '0');

-- ----------------------------
-- Table structure for `ds_bonus`
-- ----------------------------
DROP TABLE IF EXISTS `ds_bonus`;
CREATE TABLE `ds_bonus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `num` decimal(20,4) DEFAULT NULL,
  `accumulate_minute` varchar(50) DEFAULT NULL COMMENT '累积秒数',
  `add_time` int(11) DEFAULT NULL,
  `next_receive_time` int(11) DEFAULT NULL,
  `sf_jifen` decimal(20,2) DEFAULT NULL COMMENT '生态积分',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_bonus
-- ----------------------------
INSERT INTO `ds_bonus` VALUES ('1', '1', '19016.8244', '284683', '1601111595', '1601115195', '6.68');

-- ----------------------------
-- Table structure for `ds_complete`
-- ----------------------------
DROP TABLE IF EXISTS `ds_complete`;
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

-- ----------------------------
-- Records of ds_complete
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_counsel`
-- ----------------------------
DROP TABLE IF EXISTS `ds_counsel`;
CREATE TABLE `ds_counsel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_id` int(11) DEFAULT NULL COMMENT '1:热门咨询 2:热门交易 3:热门项目',
  `name` varchar(100) DEFAULT NULL COMMENT '标题',
  `logo_url` varchar(256) DEFAULT NULL COMMENT 'LOGO',
  `jump_url` varchar(256) DEFAULT NULL COMMENT '点击跳转地址',
  `sort` tinyint(10) DEFAULT '0' COMMENT '权重: 权重越高越靠前',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态 1：开启 0关闭',
  `operator` varchar(50) DEFAULT NULL COMMENT '发布者',
  `content` varchar(512) DEFAULT NULL COMMENT '256',
  `summary` varchar(128) DEFAULT NULL COMMENT '简介',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_counsel
-- ----------------------------
INSERT INTO `ds_counsel` VALUES ('3', '2', '滴滴', '/Public/Uploads/app/20200923/5f6b6722915a6.png', 'https://www.baidu.com/', '1', '1', '李明', '', '五个字简介');
INSERT INTO `ds_counsel` VALUES ('2', '2', '美团', '/Public/Uploads/app/20200923/5f6b6714da986.png', 'https://www.baidu.com/', '2', '1', '李明', '五个字简介五个字简介五个字简介五个字简介五个字简介', '五个字简介');
INSERT INTO `ds_counsel` VALUES ('4', '2', '携程', '/Public/Uploads/app/20200923/5f6b66fb0dc2e.png', 'https://www.baidu.com/', '5', '1', '李明', '携程携程携程携程携程', '五个字简介');
INSERT INTO `ds_counsel` VALUES ('5', '2', '币世界', '/Public/Uploads/app/20200923/5f6b670720cde.png', 'https://www.baidu.com/', '6', '1', '李明', '<span><span id=\"__kindeditor_bookmark_start_22__\"></span>长文长文</span><span>长文长文</span><span>长文长文</span><span>长文长文</span><span>长文长文<span>长文长文</span><span>长文长文</span><span>长文长文</span><span>长文长文</span><span>长文长文</span><span>长文长文</span><span>长文长文</span><span>长文长文</span><span>长文长文</span><span>长文长文</span><span>长文长文</span><span>长文长文</span><span>长文长文</span><span>长文长文</span><span>长文长文</span></span><span id=\"__kindeditor_bookmark_end_23__\"></span>', '五个字简介');
INSERT INTO `ds_counsel` VALUES ('6', '3', '京东', '/Public/Uploads/app/20200923/5f6ab4296d286.png', 'https://www.baidu.com/', '2', '1', '', '五个字简介五个字简介五个字简介五个字简介五个字简介', '五个字简介');
INSERT INTO `ds_counsel` VALUES ('7', '1', '爆火币种', '/Public/Uploads/app/20200923/5f6b5d889f44e.png', 'https://www.baidu.com/', '1', '1', '', '五个字简介五个字简介五个字简介五个字简介五个字简介五个字简介五个字简介五个字简介', '五个字简介');
INSERT INTO `ds_counsel` VALUES ('8', '1', '酸碱度', '/Public/Uploads/app/20200923/5f6b618f116c6.png', 'https://www.baidu.com/', '3', '1', '李明', '酸碱度酸碱度酸碱度酸碱度酸碱度酸碱度酸碱度酸碱度', '五个字简介');

-- ----------------------------
-- Table structure for `ds_download`
-- ----------------------------
DROP TABLE IF EXISTS `ds_download`;
CREATE TABLE `ds_download` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(50) DEFAULT NULL COMMENT '唯一标识',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `logo_url` varchar(100) DEFAULT NULL COMMENT 'LOGO',
  `size` decimal(15,1) DEFAULT NULL COMMENT '文件大小(M)',
  `score` varchar(50) DEFAULT NULL COMMENT '评分',
  `person_num` varchar(50) DEFAULT NULL COMMENT '多少人评分',
  `person_num_unit` varchar(50) DEFAULT NULL COMMENT '多少人评分（ 单位）',
  `install_num` varchar(50) DEFAULT NULL COMMENT '安装次数',
  `install_num_unit` varchar(50) DEFAULT NULL COMMENT '安装次数(单位)',
  `content` varchar(1024) DEFAULT NULL COMMENT '简介',
  `android_url` varchar(128) DEFAULT NULL COMMENT '安装链接',
  `ios_url` varchar(128) DEFAULT NULL COMMENT 'ios链接',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态 1：开启 0：关闭',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_download
-- ----------------------------
INSERT INTO `ds_download` VALUES ('1', 'lm528', '币安网1', '/Public/Uploads/app/20200923/5f6aef3e73227.png', '32.5', '3.0', '10', '万', '10', '亿', '<p class=\"MsoNormal\">\r\n	<span>币安</span>(Binance)<span>，目前用户覆盖全球</span><span>180</span><span>多个国家和地区，以</span><span>140</span><span>万单</span><span>/</span><span>秒的核心内存撮合技术，是全球加密货币交易速度最快的平台之一，也是全球加密货币交易量最大的平台之一。</span> \r\n</p>', 'https://www.baidu.com/', 'https://www.baidu.com/', '1');

-- ----------------------------
-- Table structure for `ds_emoneydetail`
-- ----------------------------
DROP TABLE IF EXISTS `ds_emoneydetail`;
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

-- ----------------------------
-- Records of ds_emoneydetail
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_invite_record`
-- ----------------------------
DROP TABLE IF EXISTS `ds_invite_record`;
CREATE TABLE `ds_invite_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `num` decimal(20,2) DEFAULT '0.00' COMMENT '数量',
  `sub_user_id` int(11) DEFAULT NULL COMMENT '下级用户id',
  `content` varchar(400) DEFAULT NULL,
  `add_time` int(11) DEFAULT NULL,
  `level` tinyint(4) DEFAULT NULL COMMENT '等级 1:一级 2:二级',
  `types` tinyint(5) DEFAULT '1' COMMENT '类型 1:下线实名 2:联盟奖励',
  `is_cert` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否实名 1:否 2:是',
  `sub_mobile` varchar(50) DEFAULT NULL COMMENT '下级手机号码',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_invite_record
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_jinbidetail`
-- ----------------------------
DROP TABLE IF EXISTS `ds_jinbidetail`;
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

-- ----------------------------
-- Records of ds_jinbidetail
-- ----------------------------
INSERT INTO `ds_jinbidetail` VALUES ('1', '0', '0', null, '13888888888', '1000.00000', '0.00000', '1000.00000', '1584117561', '', '0', '平台充值', '1');
INSERT INTO `ds_jinbidetail` VALUES ('2', '0', '0', null, '13888888888', '0.00000', '1000.00000', '0.00000', '1584117608', '2020-03-14', '0', '购买沉香', '1');
INSERT INTO `ds_jinbidetail` VALUES ('3', '0', '2', '13888888888', '15888888888', '0.00000', '0.00000', '0.00000', '1584117608', '2020-03-14', '0', '1代生态奖励', '1');
INSERT INTO `ds_jinbidetail` VALUES ('4', '0', '2', '13888888888', '18888888888', '0.00000', '0.00000', '0.00000', '1584117608', '2020-03-14', '0', '2代生态奖励', '1');
INSERT INTO `ds_jinbidetail` VALUES ('5', '0', '2', '13888888888', '1550000000', '0.00000', '0.00000', '0.00000', '1584117608', '2020-03-14', '0', '3代生态奖励', '1');
INSERT INTO `ds_jinbidetail` VALUES ('6', '0', '0', null, '13888888888', '1000.00000', '0.00000', '1000.00000', '1584120358', '', '0', '平台充值', '1');
INSERT INTO `ds_jinbidetail` VALUES ('7', '0', '0', null, '13888888888', '0.00000', '1000.00000', '0.00000', '1584120366', '2020-03-14', '0', '购买沉香', '1');
INSERT INTO `ds_jinbidetail` VALUES ('8', '0', '2', '13888888888', '15888888888', '0.00000', '0.00000', '0.00000', '1584120366', '2020-03-14', '0', '1代生态奖励', '1');
INSERT INTO `ds_jinbidetail` VALUES ('9', '0', '2', '13888888888', '18888888888', '0.00000', '0.00000', '0.00000', '1584120366', '2020-03-14', '0', '2代生态奖励', '1');
INSERT INTO `ds_jinbidetail` VALUES ('10', '0', '2', '13888888888', '1550000000', '0.00000', '0.00000', '0.00000', '1584120366', '2020-03-14', '0', '3代生态奖励', '1');
INSERT INTO `ds_jinbidetail` VALUES ('11', '0', '0', null, '13888888888', '1000.00000', '0.00000', '1000.00000', '1584120402', '', '0', '平台充值', '1');
INSERT INTO `ds_jinbidetail` VALUES ('12', '0', '0', null, '13888888888', '0.00000', '1000.00000', '0.00000', '1584120412', '2020-03-14', '0', '购买沉香', '1');
INSERT INTO `ds_jinbidetail` VALUES ('13', '0', '2', '13888888888', '15888888888', '0.00000', '0.00000', '0.00000', '1584120412', '2020-03-14', '0', '1代生态奖励', '1');
INSERT INTO `ds_jinbidetail` VALUES ('14', '0', '2', '13888888888', '18888888888', '0.00000', '0.00000', '0.00000', '1584120412', '2020-03-14', '0', '2代生态奖励', '1');
INSERT INTO `ds_jinbidetail` VALUES ('15', '0', '2', '13888888888', '1550000000', '0.00000', '0.00000', '0.00000', '1584120412', '2020-03-14', '0', '3代生态奖励', '1');
INSERT INTO `ds_jinbidetail` VALUES ('16', '0', '0', null, '18888888888', '50000.00000', '0.00000', '50000.00000', '1592668110', '', '0', '平台充值', '1');

-- ----------------------------
-- Table structure for `ds_log`
-- ----------------------------
DROP TABLE IF EXISTS `ds_log`;
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
) ENGINE=MyISAM AUTO_INCREMENT=118 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=68 ROW_FORMAT=DYNAMIC COMMENT='系统操作日志';

-- ----------------------------
-- Records of ds_log
-- ----------------------------
INSERT INTO `ds_log` VALUES ('1', '1584029825', 'admin', '45.77.216.144', '管理员[admin]登录', 'admin', '美国');
INSERT INTO `ds_log` VALUES ('2', '1584029830', 'admin', '180.127.157.6', '管理员[admin]登录', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('3', '1584030590', '', '45.77.216.144', '会员退出', 'member', '美国');
INSERT INTO `ds_log` VALUES ('4', '1584030703', '', '36.184.184.72', '会员退出', 'member', '中国移动');
INSERT INTO `ds_log` VALUES ('5', '1584030723', '', '36.184.184.72', '会员退出', 'member', '中国移动');
INSERT INTO `ds_log` VALUES ('6', '1584031254', '', '36.184.184.72', '会员退出', 'member', '中国移动');
INSERT INTO `ds_log` VALUES ('7', '1584031258', '18888888888', '180.127.157.6', '备份数据库', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('8', '1584031475', '18888888888', '180.127.157.6', '编辑ID为1的管理员', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('9', '1584031483', '18888888888', '180.127.157.6', '编辑ID为1的管理员', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('10', '1584031542', '18888888888', '180.127.157.6', '编辑ID为1的管理员', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('11', '1584031545', 'admin', '180.127.157.6', '管理员admin登出', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('12', '1584031554', 'admin', '180.127.157.6', '管理员[admin]登录', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('13', '1584031644', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('14', '1584031667', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('15', '1584031822', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('16', '1584033619', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('17', '1584033918', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('18', '1584033982', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('19', '1584034093', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('20', '1584034722', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('21', '1584076883', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('22', '1584077844', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('23', '1584081217', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('24', '1584084196', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('25', '1584084806', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('26', '1584084935', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('27', '1584085061', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('28', '1584085363', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('29', '1584092819', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('30', '1584092886', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('31', '1584093007', '', '180.127.157.6', '删除公告类别', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('32', '1584093099', '', '180.127.157.6', '修改了一个公告类别', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('33', '1584093129', '', '180.127.157.6', '修改项目', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('34', '1584093254', '18888888888', '180.127.157.6', '修改项目', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('35', '1584093279', '18888888888', '180.127.157.6', '发布公告', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('36', '1584096008', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('37', '1584099207', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('38', '1584111774', '18888888888', '180.127.157.6', '备份数据库', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('39', '1584113451', 'admin', '42.235.163.145', '管理员[admin]登录', 'admin', '河南省联通');
INSERT INTO `ds_log` VALUES ('40', '1584113556', 'admin', '211.23.12.206', '管理员[admin]登录', 'admin', '台湾省中华电信');
INSERT INTO `ds_log` VALUES ('41', '1584114477', '15888888888', '42.235.163.145', '修改项目', 'admin', '河南省联通');
INSERT INTO `ds_log` VALUES ('42', '1584114492', '15888888888', '42.235.163.145', '修改项目', 'admin', '河南省联通');
INSERT INTO `ds_log` VALUES ('43', '1584114553', '15888888888', '42.235.163.145', '修改项目', 'admin', '河南省联通');
INSERT INTO `ds_log` VALUES ('44', '1584114562', '15888888888', '42.235.163.145', '修改项目', 'admin', '河南省联通');
INSERT INTO `ds_log` VALUES ('45', '1584114590', '15888888888', '42.235.163.145', '修改项目', 'admin', '河南省联通');
INSERT INTO `ds_log` VALUES ('46', '1584114668', '15888888888', '42.235.163.145', '修改项目', 'admin', '河南省联通');
INSERT INTO `ds_log` VALUES ('47', '1584114735', '18888888888', '180.127.157.6', '发布公告', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('48', '1584114746', '18888888888', '180.127.157.6', '修改公告', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('49', '1584114756', '18888888888', '180.127.157.6', '发布公告', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('50', '1584114766', '18888888888', '180.127.157.6', '发布公告', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('51', '1584115957', '18888888888', '180.127.157.6', '修改项目', 'admin', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('52', '1584116007', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('53', '1584117356', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('54', '1584117490', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('55', '1584123225', '', '180.127.157.6', '会员退出', 'member', '江苏省连云港市电信');
INSERT INTO `ds_log` VALUES ('56', '1592667795', 'admin', '121.207.163.113', '管理员[admin]登录', 'admin', '福建省厦门市电信');
INSERT INTO `ds_log` VALUES ('57', '1600327335', 'admin', '127.0.0.1', '管理员[admin]登录', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('58', '1600592601', 'admin', '127.0.0.1', '管理员[admin]登录', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('59', '1600604167', 'admin', '127.0.0.1', '管理员[admin]登录', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('60', '1600604951', '', '127.0.0.1', '会员退出', 'member', '本机地址');
INSERT INTO `ds_log` VALUES ('61', '1600683989', '', '127.0.0.1', '会员退出', 'member', '本机地址');
INSERT INTO `ds_log` VALUES ('62', '1600691653', 'admin', '127.0.0.1', '管理员[admin]登录', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('63', '1600691736', '18888888888', '127.0.0.1', '修改了一个公告类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('64', '1600691745', '18888888888', '127.0.0.1', '添加一个新的公告类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('65', '1600694625', 'admin', '127.0.0.1', '管理员[admin]登录', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('66', '1600795460', '18888888888', '127.0.0.1', '添加一个新的应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('67', '1600795723', '18888888888', '127.0.0.1', '添加一个新的应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('68', '1600795887', '18888888888', '127.0.0.1', '修改了一个应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('69', '1600795915', '18888888888', '127.0.0.1', '修改了一个应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('70', '1600795925', '18888888888', '127.0.0.1', '修改了一个应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('71', '1600796046', '18888888888', '127.0.0.1', '修改了一个应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('72', '1600796063', '18888888888', '127.0.0.1', '修改了一个应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('73', '1600796069', '18888888888', '127.0.0.1', '修改了一个应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('74', '1600796087', '18888888888', '127.0.0.1', '修改了一个应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('75', '1600796097', '18888888888', '127.0.0.1', '修改了一个应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('76', '1600796114', '18888888888', '127.0.0.1', '删除应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('77', '1600796912', '18888888888', '127.0.0.1', '发布公告', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('78', '1600797088', '18888888888', '127.0.0.1', '添加应用', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('79', '1600797720', '18888888888', '127.0.0.1', '删除公告', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('80', '1600797934', '18888888888', '127.0.0.1', '添加一个新的应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('81', '1600797941', '18888888888', '127.0.0.1', '修改了一个应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('82', '1600798198', '18888888888', '127.0.0.1', '修改应用', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('83', '1600798454', '18888888888', '127.0.0.1', '删除应用', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('84', '1600828195', '18888888888', '127.0.0.1', '添加一个新的应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('85', '1600828217', '18888888888', '127.0.0.1', '修改了一个应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('86', '1600828225', '18888888888', '127.0.0.1', '修改了一个应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('87', '1600828245', '18888888888', '127.0.0.1', '添加一个新的应用类别', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('88', '1600828264', '18888888888', '127.0.0.1', '修改应用', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('89', '1600828288', '18888888888', '127.0.0.1', '添加应用', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('90', '1600828396', '18888888888', '127.0.0.1', '添加应用', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('91', '1600828428', '18888888888', '127.0.0.1', '添加应用', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('92', '1600828457', '18888888888', '127.0.0.1', '添加应用', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('93', '1600843582', '18888888888', '127.0.0.1', '添加下载页', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('94', '1600865098', '18888888888', '127.0.0.1', '修改下载页', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('95', '1600866190', '18888888888', '127.0.0.1', '修改下载页', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('96', '1600866235', '18888888888', '127.0.0.1', '修改下载页', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('97', '1600871689', '18888888888', '127.0.0.1', '修改资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('98', '1600871707', '18888888888', '127.0.0.1', '修改资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('99', '1600871718', '18888888888', '127.0.0.1', '修改资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('100', '1600871731', '18888888888', '127.0.0.1', '修改资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('101', '1600871760', '18888888888', '127.0.0.1', '修改资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('102', '1600871766', '18888888888', '127.0.0.1', '修改资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('103', '1600871771', '18888888888', '127.0.0.1', '修改资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('104', '1600871782', '18888888888', '127.0.0.1', '修改资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('105', '1600871816', '18888888888', '127.0.0.1', '添加资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('106', '1600872847', '18888888888', '127.0.0.1', '添加资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('107', '1600872958', '18888888888', '127.0.0.1', '添加应用', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('108', '1600872968', '18888888888', '127.0.0.1', '修改应用', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('109', '1600873787', '18888888888', '127.0.0.1', '修改资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('110', '1600874160', '18888888888', '127.0.0.1', '修改资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('111', '1600874235', '18888888888', '127.0.0.1', '修改资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('112', '1600874247', '18888888888', '127.0.0.1', '修改资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('113', '1600874260', '18888888888', '127.0.0.1', '修改资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('114', '1600874274', '18888888888', '127.0.0.1', '修改资讯', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('115', '1601017457', 'admin', '127.0.0.1', '管理员[admin]登录', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('116', '1601019833', '', '127.0.0.1', '会员退出', 'member', '本机地址');
INSERT INTO `ds_log` VALUES ('117', '1601020186', '', '127.0.0.1', '会员退出', 'member', '本机地址');

-- ----------------------------
-- Table structure for `ds_member`
-- ----------------------------
DROP TABLE IF EXISTS `ds_member`;
CREATE TABLE `ds_member` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8 COLLATE utf8_bin DEFAULT NULL COMMENT '会员编号',
  `password` varchar(32) DEFAULT NULL COMMENT '一级密码',
  `level` int(4) DEFAULT '1' COMMENT '1普通会员 2高级会员3初级大使4中级大使5高级大使',
  `inviteCode` text NOT NULL,
  `avatar` text NOT NULL,
  `regaddress` varchar(255) DEFAULT NULL COMMENT 'IP地址',
  `regdate` int(11) DEFAULT NULL COMMENT '注册时间',
  `parent` varchar(255) DEFAULT NULL COMMENT '推荐人',
  `parent_id` int(11) unsigned NOT NULL COMMENT '推荐人ID',
  `pic` varchar(100) NOT NULL COMMENT '头像',
  `jifen` decimal(20,2) DEFAULT '0.00' COMMENT '积分',
  `erwei` varchar(255) DEFAULT NULL,
  `idcard` varchar(255) NOT NULL,
  `dongjie` decimal(15,2) DEFAULT '0.00' COMMENT '冻结金额',
  `parentcount` int(11) NOT NULL DEFAULT '0' COMMENT '推荐人数',
  `name` varchar(255) DEFAULT '会员',
  `lmjifen` decimal(20,4) unsigned DEFAULT '0.0000' COMMENT '联盟积分',
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
  `trade_password` varchar(32) DEFAULT NULL COMMENT '支付密码',
  `is_cert` tinyint(6) DEFAULT '-1' COMMENT '是否认证 -1 未认证 1 已认证 2认证失败',
  `card` varchar(50) DEFAULT NULL COMMENT '银行卡号',
  PRIMARY KEY (`id`,`parentcount`),
  KEY `username` (`username`),
  KEY `parent` (`parent`)
) ENGINE=MyISAM AUTO_INCREMENT=28 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=278 ROW_FORMAT=DYNAMIC COMMENT='会员';

-- ----------------------------
-- Records of ds_member
-- ----------------------------
INSERT INTO `ds_member` VALUES ('2', '15888888888', 'e10adc3949ba59abbe56e057f20f883e', '0', 'UGL289', '', '美国', '1584031737', '18888888888', '1', '', '0.00', null, '', '0.00', '1', '会员', '0.0000', '初始账户2', null, '1584096019', '1', '0', '9', '1|1|', '1584118053', null, null, null, null, '-1', null);
INSERT INTO `ds_member` VALUES ('3', '13888888888', 'e10adc3949ba59abbe56e057f20f883e', '0', 'YKB572', '', '美国', '1584031868', '15888888888', '2', '', '0.00', null, '', '0.00', '0', '会员', '0.0000', '初始账号3', null, '1584123247', '0', '3', '11', '1|1|26|', '1584125648', null, null, null, null, '-1', null);
INSERT INTO `ds_member` VALUES ('1', '18888888888', '96e79218965eb72c92a549dd5a330112', '0', 'WSB903', '', '美国', '1584030607', '1550000000', '0', '', '6.68', null, '', '0.00', '1', '会员', '69016.8244', '初始账户1', null, '1601020191', '2', '0', '27', '1|', '1601195382', null, null, null, null, '1', null);

-- ----------------------------
-- Table structure for `ds_member_award_log`
-- ----------------------------
DROP TABLE IF EXISTS `ds_member_award_log`;
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

-- ----------------------------
-- Records of ds_member_award_log
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_member_paylist`
-- ----------------------------
DROP TABLE IF EXISTS `ds_member_paylist`;
CREATE TABLE `ds_member_paylist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` text NOT NULL,
  `amount` int(11) NOT NULL,
  `imageUrl` text NOT NULL,
  `applyDate` text NOT NULL,
  `ordersn` text NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_member_paylist
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_member_rebate_order`
-- ----------------------------
DROP TABLE IF EXISTS `ds_member_rebate_order`;
CREATE TABLE `ds_member_rebate_order` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '绑定的用户',
  `order_no` varchar(50) DEFAULT NULL COMMENT '订单号',
  `title` varchar(100) DEFAULT NULL COMMENT '标题',
  `img` varchar(218) DEFAULT NULL COMMENT '图片',
  `order_time` int(11) DEFAULT NULL COMMENT '订单时间',
  `add_time` int(11) DEFAULT NULL,
  `is_receive` tinyint(4) DEFAULT '0' COMMENT '是否返利 1:是0:否',
  `num` decimal(20,2) DEFAULT NULL COMMENT '返利积分',
  `receive_time` int(11) DEFAULT NULL COMMENT '领取时间',
  `status` tinyint(6) DEFAULT '0' COMMENT '0待审核 1待结算 2 已结算 3已失效',
  `commission` decimal(16,2) DEFAULT NULL COMMENT '利润金',
  `price` decimal(16,2) DEFAULT NULL COMMENT '消费金额',
  `scene` tinyint(6) DEFAULT NULL COMMENT '场景 1 淘宝 2京东 3拼多多 4苏宁 5唯品会',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_member_rebate_order
-- ----------------------------
INSERT INTO `ds_member_rebate_order` VALUES ('1', '1', '5007100195544250472', null, null, null, '1601193865', '0', null, null, '0', null, null, '1');
INSERT INTO `ds_member_rebate_order` VALUES ('2', '1', '1204224531295221988', '消费体验单联盟体验所，是新版消费者联盟新人体验单', 'http://img.alicdn.com/tfscom/i2/2578038735/O1CN012EOg6KoElPxWdzK_!!2578038735.jpg', '1599138680', '1601195378', '0', '0.00', null, '2', '0.01', '0.03', '1');

-- ----------------------------
-- Table structure for `ds_member_receive`
-- ----------------------------
DROP TABLE IF EXISTS `ds_member_receive`;
CREATE TABLE `ds_member_receive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `account` text NOT NULL,
  `amount` int(11) NOT NULL,
  `location` text NOT NULL,
  `applyDate` text NOT NULL,
  `status` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_member_receive
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_member_recharge`
-- ----------------------------
DROP TABLE IF EXISTS `ds_member_recharge`;
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

-- ----------------------------
-- Records of ds_member_recharge
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_member_sign_in`
-- ----------------------------
DROP TABLE IF EXISTS `ds_member_sign_in`;
CREATE TABLE `ds_member_sign_in` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `num` decimal(11,2) DEFAULT '0.00' COMMENT '奖励积分',
  `add_time` int(11) DEFAULT NULL,
  `valid_period` int(11) DEFAULT NULL COMMENT '有效期',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_member_sign_in
-- ----------------------------
INSERT INTO `ds_member_sign_in` VALUES ('3', '1', '6.68', '1601054353', '30');

-- ----------------------------
-- Table structure for `ds_message`
-- ----------------------------
DROP TABLE IF EXISTS `ds_message`;
CREATE TABLE `ds_message` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `from` varchar(45) NOT NULL DEFAULT '' COMMENT '发件人',
  `pic` varchar(100) DEFAULT NULL COMMENT '头像',
  `truename` varchar(100) DEFAULT NULL,
  `content` text NOT NULL COMMENT '内容',
  `addtime` int(11) unsigned NOT NULL DEFAULT '0' COMMENT '发送时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=34 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='站内信息表';

-- ----------------------------
-- Records of ds_message
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_node`
-- ----------------------------
DROP TABLE IF EXISTS `ds_node`;
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

-- ----------------------------
-- Records of ds_node
-- ----------------------------
INSERT INTO `ds_node` VALUES ('1', 'systemlogined', '后台应用', '1', '', '1', '0', '1');
INSERT INTO `ds_node` VALUES ('6', 'Rbac', 'Rbac权限控制', '1', '', '6', '1', '2');
INSERT INTO `ds_node` VALUES ('7', 'Index', '后台首页', '1', '', '1', '1', '2');
INSERT INTO `ds_node` VALUES ('10', 'index', '用户列表', '1', '', '1', '6', '3');
INSERT INTO `ds_node` VALUES ('11', 'role', '角色列表', '1', '', '1', '6', '3');
INSERT INTO `ds_node` VALUES ('12', 'node', '节点列表', '1', '', '1', '6', '3');
INSERT INTO `ds_node` VALUES ('16', 'index', '后台首页', '1', '', '1', '7', '3');
INSERT INTO `ds_node` VALUES ('17', 'Member', '会员管理', '1', '', '2', '1', '2');
INSERT INTO `ds_node` VALUES ('18', 'uncheck', '未审核会员', '1', '', '1', '17', '3');
INSERT INTO `ds_node` VALUES ('19', 'check', '会员查询', '1', '', '1', '17', '3');
INSERT INTO `ds_node` VALUES ('20', 'pw_list', '团队排位图', '1', '', '1', '17', '3');
INSERT INTO `ds_node` VALUES ('22', 'Jinbidetail', '资金管理', '1', '', '4', '1', '2');
INSERT INTO `ds_node` VALUES ('23', 'index', 'pv明细', '1', '', '1', '22', '3');
INSERT INTO `ds_node` VALUES ('24', 'paylists', '充值管理', '1', '', '1', '22', '3');
INSERT INTO `ds_node` VALUES ('25', 'emoneyWithdraw', '提现管理', '1', '', '1', '22', '3');
INSERT INTO `ds_node` VALUES ('26', 'shop', '商城管理', '1', '', '3', '1', '2');
INSERT INTO `ds_node` VALUES ('27', 'type_list', '分类列表', '1', '', '1', '26', '3');
INSERT INTO `ds_node` VALUES ('28', 'Info', '信息交流', '1', '', '5', '1', '2');
INSERT INTO `ds_node` VALUES ('29', 'announce', '公告管理', '1', '', '1', '28', '3');
INSERT INTO `ds_node` VALUES ('30', 'annType', '公告类别', '1', '', '1', '28', '3');
INSERT INTO `ds_node` VALUES ('31', 'msgReceive', '收件箱', '1', '', '1', '28', '3');
INSERT INTO `ds_node` VALUES ('32', 'msgSend', '发件箱', '1', '', '1', '28', '3');
INSERT INTO `ds_node` VALUES ('33', 'System', '系统设置', '1', '', '7', '1', '2');
INSERT INTO `ds_node` VALUES ('34', 'backUp', '数据备份', '1', '', '1', '33', '3');
INSERT INTO `ds_node` VALUES ('35', 'customSetting', '自定义配置', '1', '', '1', '33', '3');
INSERT INTO `ds_node` VALUES ('36', ' jiangjin', '奖金查询', '1', '', '1', '22', '3');
INSERT INTO `ds_node` VALUES ('37', 'member_group', '会员等级', '1', '', '1', '17', '3');
INSERT INTO `ds_node` VALUES ('38', 'lists', '商品列表', '1', '', '1', '26', '3');
INSERT INTO `ds_node` VALUES ('39', 'orderlist', '订单列表', '1', '', '1', '26', '3');
INSERT INTO `ds_node` VALUES ('40', 'paylist', '零售管理', '1', '', '1', '22', '3');
INSERT INTO `ds_node` VALUES ('41', 'jinzhongzi', '重消明细', '1', '', '1', '22', '3');
INSERT INTO `ds_node` VALUES ('42', 'point', '代金券明细', '1', '', '1', '22', '3');
INSERT INTO `ds_node` VALUES ('43', 'editPay', '零售操作', '1', '', '1', '22', '3');
INSERT INTO `ds_node` VALUES ('44', 'editPays', '充值操作', '1', '', '1', '22', '3');
INSERT INTO `ds_node` VALUES ('45', 'editEmoney', '提现操作', '1', '', '1', '22', '3');
INSERT INTO `ds_node` VALUES ('46', 'editPayhandles', '充值提交操作', '1', '', '1', '22', '3');

-- ----------------------------
-- Table structure for `ds_order`
-- ----------------------------
DROP TABLE IF EXISTS `ds_order`;
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

-- ----------------------------
-- Records of ds_order
-- ----------------------------
INSERT INTO `ds_order` VALUES ('1', '13888888888', '15888888888', '3', '沉香', '0.00', '1000.00', '2020-03-14 00:40:08', '1584117608', '1', '3', '/Public/Uploads/20200313/5e6b31dbc9cb7.png', '2160', '0.74500000', 'C141760835', '0.00000000');
INSERT INTO `ds_order` VALUES ('2', '13888888888', '15888888888', '3', '沉香', '0.00', '1000.00', '2020-03-14 01:26:06', '1584120366', '1', '3', '/Public/Uploads/20200313/5e6b31dbc9cb7.png', '2160', '0.74500000', 'C142036628', '0.00000000');
INSERT INTO `ds_order` VALUES ('3', '13888888888', '15888888888', '3', '沉香', '0.00', '1000.00', '2020-03-14 01:26:52', '1584120412', '1', '3', '/Public/Uploads/20200313/5e6b31dbc9cb7.png', '2160', '0.74500000', 'C142041286', '0.00000000');

-- ----------------------------
-- Table structure for `ds_pay`
-- ----------------------------
DROP TABLE IF EXISTS `ds_pay`;
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

-- ----------------------------
-- Records of ds_pay
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_paydetail`
-- ----------------------------
DROP TABLE IF EXISTS `ds_paydetail`;
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

-- ----------------------------
-- Records of ds_paydetail
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_product`
-- ----------------------------
DROP TABLE IF EXISTS `ds_product`;
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

-- ----------------------------
-- Records of ds_product
-- ----------------------------
INSERT INTO `ds_product` VALUES ('1', '1', '树苗', '100.00', '18', '720', '0.168', '/Public/Uploads/20200313/5e6b2e0ca7520.png', '', '0', '1584081321', '1', '0');
INSERT INTO `ds_product` VALUES ('2', '2', '紫檀', '500.00', '100', '1440', '0.488', '/Public/Uploads/20200313/5e6b3154bccdc.png', '', '0', '1584083284', '3', '0');
INSERT INTO `ds_product` VALUES ('3', '3', '沉香', '1000.00', '47', '2160', '0.745', '/Public/Uploads/20200313/5e6b31dbc9cb7.png', '', '0', '1584083419', '3', '0');
INSERT INTO `ds_product` VALUES ('4', '4', '金丝楠', '3000.00', '30', '2160', '2.508', '/Public/Uploads/20200313/5e6b322b9cc1b.png', '', '0', '1584083499', '2', '0');
INSERT INTO `ds_product` VALUES ('5', '5', '黄花梨', '5000.00', '10', '2160', '4.648', '/Public/Uploads/20200313/5e6b326d4d295.png', '', '0', '1584083565', '1', '0');

-- ----------------------------
-- Table structure for `ds_profile_log`
-- ----------------------------
DROP TABLE IF EXISTS `ds_profile_log`;
CREATE TABLE `ds_profile_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `profile` decimal(10,5) DEFAULT NULL,
  `add_time` varchar(50) DEFAULT NULL,
  `scid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_profile_log
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_qjinbidetail`
-- ----------------------------
DROP TABLE IF EXISTS `ds_qjinbidetail`;
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

-- ----------------------------
-- Records of ds_qjinbidetail
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_session`
-- ----------------------------
DROP TABLE IF EXISTS `ds_session`;
CREATE TABLE `ds_session` (
  `session_id` varchar(255) NOT NULL DEFAULT '',
  `session_expire` int(11) NOT NULL,
  `session_data` blob,
  UNIQUE KEY `session_id` (`session_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=196 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ds_session
-- ----------------------------
INSERT INTO `ds_session` VALUES ('sbkn4tojisi2uu7qe9ddes9944', '1601281782', 0x7665726966797C733A33323A223062333638303935363664633037373363343337313539393063316331656266223B69647C733A313A2231223B61646D696E757365726E616D657C733A353A2261646D696E223B6C6F6774696D657C733A31393A22323032302D30392D32312032313A32333A3435223B6C6F67696E69707C733A393A223132372E302E302E31223B737570657261646D696E7C623A313B6D69647C733A313A2231223B757365726E616D657C733A31313A223138383838383838383838223B6D656D6265727C733A31313A226D656D6265726C6F67696E223B);

-- ----------------------------
-- Table structure for `ds_sms_log`
-- ----------------------------
DROP TABLE IF EXISTS `ds_sms_log`;
CREATE TABLE `ds_sms_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '表id',
  `mobile` varchar(11) DEFAULT '' COMMENT '手机号',
  `session_id` varchar(128) DEFAULT '' COMMENT 'session_id',
  `add_time` int(11) DEFAULT '0' COMMENT '发送时间',
  `code` varchar(10) DEFAULT '' COMMENT '验证码',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ds_sms_log
-- ----------------------------

-- ----------------------------
-- Table structure for `ds_type`
-- ----------------------------
DROP TABLE IF EXISTS `ds_type`;
CREATE TABLE `ds_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` char(32) NOT NULL,
  `pid` int(11) NOT NULL DEFAULT '0',
  `path` char(30) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ds_type
-- ----------------------------
INSERT INTO `ds_type` VALUES ('1', 'A', '0', '0');
INSERT INTO `ds_type` VALUES ('2', 'B', '0', '0');
INSERT INTO `ds_type` VALUES ('3', 'C', '0', '0');
INSERT INTO `ds_type` VALUES ('4', 'D', '0', '0');
INSERT INTO `ds_type` VALUES ('5', 'E', '0', '0');
INSERT INTO `ds_type` VALUES ('6', 'F', '0', '0');
INSERT INTO `ds_type` VALUES ('7', 'G', '0', '0');
INSERT INTO `ds_type` VALUES ('8', 'H', '0', '0');
INSERT INTO `ds_type` VALUES ('9', 'I', '0', '0');
INSERT INTO `ds_type` VALUES ('10', 'J', '0', '0');
INSERT INTO `ds_type` VALUES ('11', 'K', '0', '0');
INSERT INTO `ds_type` VALUES ('12', 'L', '0', '0');
INSERT INTO `ds_type` VALUES ('13', 'M', '0', '0');
INSERT INTO `ds_type` VALUES ('14', 'N', '0', '0');
INSERT INTO `ds_type` VALUES ('15', 'O', '0', '0');
INSERT INTO `ds_type` VALUES ('16', 'P', '0', '0');
INSERT INTO `ds_type` VALUES ('17', 'Q', '0', '0');
INSERT INTO `ds_type` VALUES ('18', 'R', '0', '0');
INSERT INTO `ds_type` VALUES ('19', 'S', '0', '0');
INSERT INTO `ds_type` VALUES ('20', 'T', '0', '0');
INSERT INTO `ds_type` VALUES ('21', 'U', '0', '0');
INSERT INTO `ds_type` VALUES ('22', 'V', '0', '0');
INSERT INTO `ds_type` VALUES ('23', 'W', '0', '0');
INSERT INTO `ds_type` VALUES ('24', 'X', '0', '0');
INSERT INTO `ds_type` VALUES ('25', 'Y', '0', '0');
INSERT INTO `ds_type` VALUES ('26', 'Z', '0', '0');

-- ----------------------------
-- Table structure for `ds_user`
-- ----------------------------
DROP TABLE IF EXISTS `ds_user`;
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

-- ----------------------------
-- Records of ds_user
-- ----------------------------
INSERT INTO `ds_user` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1601017457', '127.0.0.1', '0');

-- ----------------------------
-- Table structure for `ds_user_eco_log`
-- ----------------------------
DROP TABLE IF EXISTS `ds_user_eco_log`;
CREATE TABLE `ds_user_eco_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `num` decimal(20,2) NOT NULL COMMENT '变化的积分',
  `old` decimal(20,2) NOT NULL COMMENT '原来的魔石',
  `new` decimal(20,2) NOT NULL COMMENT '变化后的魔石',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  `types` tinyint(8) NOT NULL DEFAULT '1' COMMENT '1实名奖励 2签到奖励 3联盟奖励 4积分过期',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `valid_period` int(11) DEFAULT '0' COMMENT '有效天数',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `type` (`types`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_user_eco_log
-- ----------------------------
INSERT INTO `ds_user_eco_log` VALUES ('3', '1', '6.68', '0.00', '6.68', '签到奖励6.68生态积分', '1', '1601054353', '9999');

-- ----------------------------
-- Table structure for `ds_user_league_log`
-- ----------------------------
DROP TABLE IF EXISTS `ds_user_league_log`;
CREATE TABLE `ds_user_league_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `num` decimal(20,4) NOT NULL COMMENT '变化的积分',
  `old` decimal(20,4) NOT NULL COMMENT '原来的魔石',
  `new` decimal(20,4) NOT NULL COMMENT '变化后的魔石',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  `types` tinyint(8) NOT NULL DEFAULT '0' COMMENT '1分红',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `type` (`types`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_user_league_log
-- ----------------------------
INSERT INTO `ds_user_league_log` VALUES ('2', '1', '19016.8244', '50000.0000', '69016.8244', '生态分红19016.8244联盟积分', '1', '1601111595');

-- ----------------------------
-- Table structure for `ds_user_statistics`
-- ----------------------------
DROP TABLE IF EXISTS `ds_user_statistics`;
CREATE TABLE `ds_user_statistics` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `one_sub_cert_nums` int(11) DEFAULT '0' COMMENT '一级下线实名人数',
  `one_sub_nocert_nums` int(11) DEFAULT '0' COMMENT '一级下线未实名人数',
  `two_sub_cert_nums` int(11) DEFAULT '0' COMMENT '二级下线人数',
  `two_sub_nocert_nums` int(11) DEFAULT NULL,
  `total_sub_nums` int(11) DEFAULT '0' COMMENT '全部下线人数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=1112 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_user_statistics
-- ----------------------------
INSERT INTO `ds_user_statistics` VALUES ('1', '2', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('2', '4', '42', null, '1252', null, '1294');
INSERT INTO `ds_user_statistics` VALUES ('3', '7', '46', null, '525', null, '571');
INSERT INTO `ds_user_statistics` VALUES ('4', '6', '45', null, '129', null, '174');
INSERT INTO `ds_user_statistics` VALUES ('5', '13', '17', null, '74', null, '91');
INSERT INTO `ds_user_statistics` VALUES ('6', '22', '27', null, '84', null, '111');
INSERT INTO `ds_user_statistics` VALUES ('7', '9', '165', null, '420', null, '585');
INSERT INTO `ds_user_statistics` VALUES ('8', '31', '9', null, '0', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('9', '20', '23', null, '44', null, '67');
INSERT INTO `ds_user_statistics` VALUES ('10', '23', '6', null, '96', null, '102');
INSERT INTO `ds_user_statistics` VALUES ('11', '36', '10', null, '8', null, '18');
INSERT INTO `ds_user_statistics` VALUES ('12', '33', '6', null, '4', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('13', '44', '3', null, '16', null, '19');
INSERT INTO `ds_user_statistics` VALUES ('14', '19', '11', null, '80', null, '91');
INSERT INTO `ds_user_statistics` VALUES ('15', '39', '23', null, '24', null, '47');
INSERT INTO `ds_user_statistics` VALUES ('16', '43', '49', null, '58', null, '107');
INSERT INTO `ds_user_statistics` VALUES ('17', '40', '159', null, '1', null, '160');
INSERT INTO `ds_user_statistics` VALUES ('18', '26', '24', null, '234', null, '258');
INSERT INTO `ds_user_statistics` VALUES ('19', '62', '181', null, '450', null, '631');
INSERT INTO `ds_user_statistics` VALUES ('20', '25', '21', null, '9', null, '30');
INSERT INTO `ds_user_statistics` VALUES ('21', '24', '8', null, '196', null, '204');
INSERT INTO `ds_user_statistics` VALUES ('22', '5', '211', null, '851', null, '1062');
INSERT INTO `ds_user_statistics` VALUES ('23', '78', '18', null, '131', null, '149');
INSERT INTO `ds_user_statistics` VALUES ('24', '51', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('25', '32', '1', null, '42', null, '43');
INSERT INTO `ds_user_statistics` VALUES ('26', '61', '3', null, '4', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('27', '81', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('28', '34', '6', null, '3', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('29', '72', '8', null, '5', null, '13');
INSERT INTO `ds_user_statistics` VALUES ('30', '74', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('31', '116', '2', null, '12', null, '14');
INSERT INTO `ds_user_statistics` VALUES ('32', '59', '65', null, '0', null, '65');
INSERT INTO `ds_user_statistics` VALUES ('33', '142', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('34', '18', '11', null, '5', null, '16');
INSERT INTO `ds_user_statistics` VALUES ('35', '70', '5', null, '17', null, '22');
INSERT INTO `ds_user_statistics` VALUES ('36', '130', '1', null, '53', null, '54');
INSERT INTO `ds_user_statistics` VALUES ('37', '131', '19', null, '10', null, '29');
INSERT INTO `ds_user_statistics` VALUES ('38', '118', '1', null, '2', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('39', '144', '19', null, '42', null, '61');
INSERT INTO `ds_user_statistics` VALUES ('40', '86', '20', null, '13', null, '33');
INSERT INTO `ds_user_statistics` VALUES ('41', '37', '9', null, '71', null, '80');
INSERT INTO `ds_user_statistics` VALUES ('42', '75', '19', null, '29', null, '48');
INSERT INTO `ds_user_statistics` VALUES ('43', '115', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('44', '52', '14', null, '2', null, '16');
INSERT INTO `ds_user_statistics` VALUES ('45', '124', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('46', '76', '322', null, '116', null, '438');
INSERT INTO `ds_user_statistics` VALUES ('47', '11', '8', null, '7', null, '15');
INSERT INTO `ds_user_statistics` VALUES ('48', '64', '5', null, '2', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('49', '47', '7', null, '6', null, '13');
INSERT INTO `ds_user_statistics` VALUES ('50', '71', '10', null, '14', null, '24');
INSERT INTO `ds_user_statistics` VALUES ('51', '29', '7', null, '5', null, '12');
INSERT INTO `ds_user_statistics` VALUES ('52', '161', '1', null, '5', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('53', '141', '1', null, '10', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('54', '38', '5', null, '0', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('55', '15', '12', null, '1', null, '13');
INSERT INTO `ds_user_statistics` VALUES ('56', '114', '4', null, '4', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('57', '84', '18', null, '11', null, '29');
INSERT INTO `ds_user_statistics` VALUES ('58', '149', '1', null, '3', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('59', '77', '64', null, '0', null, '64');
INSERT INTO `ds_user_statistics` VALUES ('60', '82', '8', null, '0', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('61', '73', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('62', '125', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('63', '225', '10', null, '7', null, '17');
INSERT INTO `ds_user_statistics` VALUES ('64', '145', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('65', '228', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('66', '8', '8', null, '0', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('67', '200', '5', null, '0', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('68', '156', '53', null, '108', null, '161');
INSERT INTO `ds_user_statistics` VALUES ('69', '169', '13', null, '5', null, '18');
INSERT INTO `ds_user_statistics` VALUES ('70', '270', '8', null, '7', null, '15');
INSERT INTO `ds_user_statistics` VALUES ('71', '243', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('72', '48', '6', null, '52', null, '58');
INSERT INTO `ds_user_statistics` VALUES ('73', '97', '8', null, '0', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('74', '166', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('75', '264', '59', null, '79', null, '138');
INSERT INTO `ds_user_statistics` VALUES ('76', '154', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('77', '143', '4', null, '6', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('78', '158', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('79', '254', '3', null, '2', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('80', '283', '3', null, '1', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('81', '266', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('82', '45', '63', null, '0', null, '63');
INSERT INTO `ds_user_statistics` VALUES ('83', '210', '5', null, '0', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('84', '236', '3', null, '2', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('85', '234', '9', null, '2', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('86', '232', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('87', '160', '2', null, '1', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('88', '57', '174', null, '5', null, '179');
INSERT INTO `ds_user_statistics` VALUES ('89', '104', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('90', '184', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('91', '296', '5', null, '2', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('92', '354', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('93', '262', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('94', '68', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('95', '105', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('96', '307', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('97', '244', '6', null, '4', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('98', '252', '146', null, '43', null, '189');
INSERT INTO `ds_user_statistics` VALUES ('99', '245', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('100', '401', '18', null, '22', null, '40');
INSERT INTO `ds_user_statistics` VALUES ('101', '123', '42', null, '63', null, '105');
INSERT INTO `ds_user_statistics` VALUES ('102', '402', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('103', '267', '2', null, '13', null, '15');
INSERT INTO `ds_user_statistics` VALUES ('104', '450', '7', null, '0', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('105', '79', '3', null, '5', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('106', '163', '5', null, '4', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('107', '247', '30', null, '103', null, '133');
INSERT INTO `ds_user_statistics` VALUES ('108', '103', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('109', '63', '97', null, '148', null, '245');
INSERT INTO `ds_user_statistics` VALUES ('110', '537', '34', null, '30', null, '64');
INSERT INTO `ds_user_statistics` VALUES ('111', '557', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('112', '513', '16', null, '18', null, '34');
INSERT INTO `ds_user_statistics` VALUES ('113', '313', '16', null, '2', null, '18');
INSERT INTO `ds_user_statistics` VALUES ('114', '91', '9', null, '2', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('115', '558', '1', null, '14', null, '15');
INSERT INTO `ds_user_statistics` VALUES ('116', '486', '4', null, '1', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('117', '518', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('118', '553', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('119', '609', '6', null, '4', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('120', '525', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('121', '634', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('122', '610', '3', null, '1', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('123', '272', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('124', '588', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('125', '576', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('126', '568', '5', null, '1', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('127', '601', '27', null, '19', null, '46');
INSERT INTO `ds_user_statistics` VALUES ('128', '590', '9', null, '10', null, '19');
INSERT INTO `ds_user_statistics` VALUES ('129', '475', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('130', '579', '23', null, '207', null, '230');
INSERT INTO `ds_user_statistics` VALUES ('131', '324', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('132', '457', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('133', '605', '9', null, '4', null, '13');
INSERT INTO `ds_user_statistics` VALUES ('134', '572', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('135', '618', '14', null, '52', null, '66');
INSERT INTO `ds_user_statistics` VALUES ('136', '437', '31', null, '0', null, '31');
INSERT INTO `ds_user_statistics` VALUES ('137', '651', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('138', '533', '33', null, '167', null, '200');
INSERT INTO `ds_user_statistics` VALUES ('139', '672', '1', null, '14', null, '15');
INSERT INTO `ds_user_statistics` VALUES ('140', '678', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('141', '429', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('142', '122', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('143', '229', '1', null, '44', null, '45');
INSERT INTO `ds_user_statistics` VALUES ('144', '709', '63', null, '47', null, '110');
INSERT INTO `ds_user_statistics` VALUES ('145', '702', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('146', '532', '106', null, '161', null, '267');
INSERT INTO `ds_user_statistics` VALUES ('147', '415', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('148', '700', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('149', '707', '7', null, '2', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('150', '671', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('151', '581', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('152', '136', '3', null, '2', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('153', '500', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('154', '761', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('155', '773', '1', null, '93', null, '94');
INSERT INTO `ds_user_statistics` VALUES ('156', '734', '1', null, '2', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('157', '765', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('158', '559', '50', null, '0', null, '50');
INSERT INTO `ds_user_statistics` VALUES ('159', '578', '63', null, '43', null, '106');
INSERT INTO `ds_user_statistics` VALUES ('160', '755', '3', null, '28', null, '31');
INSERT INTO `ds_user_statistics` VALUES ('161', '543', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('162', '108', '1', null, '8', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('163', '770', '44', null, '123', null, '167');
INSERT INTO `ds_user_statistics` VALUES ('164', '791', '10', null, '0', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('165', '737', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('166', '795', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('167', '608', '94', null, '100', null, '194');
INSERT INTO `ds_user_statistics` VALUES ('168', '763', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('169', '627', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('170', '793', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('171', '574', '84', null, '37', null, '121');
INSERT INTO `ds_user_statistics` VALUES ('172', '570', '14', null, '6', null, '20');
INSERT INTO `ds_user_statistics` VALUES ('173', '814', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('174', '723', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('175', '856', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('176', '752', '140', null, '29', null, '169');
INSERT INTO `ds_user_statistics` VALUES ('177', '889', '28', null, '37', null, '65');
INSERT INTO `ds_user_statistics` VALUES ('178', '943', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('179', '908', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('180', '748', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('181', '746', '45', null, '35', null, '80');
INSERT INTO `ds_user_statistics` VALUES ('182', '843', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('183', '628', '172', null, '57', null, '229');
INSERT INTO `ds_user_statistics` VALUES ('184', '937', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('185', '926', '34', null, '7', null, '41');
INSERT INTO `ds_user_statistics` VALUES ('186', '866', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('187', '906', '5', null, '0', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('188', '965', '11', null, '0', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('189', '535', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('190', '487', '9', null, '1', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('191', '767', '65', null, '21', null, '86');
INSERT INTO `ds_user_statistics` VALUES ('192', '584', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('193', '56', '52', null, '1', null, '53');
INSERT INTO `ds_user_statistics` VALUES ('194', '932', '43', null, '0', null, '43');
INSERT INTO `ds_user_statistics` VALUES ('195', '952', '2', null, '1', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('196', '652', '14', null, '0', null, '14');
INSERT INTO `ds_user_statistics` VALUES ('197', '452', '162', null, '60', null, '222');
INSERT INTO `ds_user_statistics` VALUES ('198', '1010', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('199', '303', '6', null, '1', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('200', '927', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('201', '1036', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('202', '455', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('203', '1050', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('204', '682', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('205', '1078', '8', null, '0', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('206', '320', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('207', '1131', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('208', '1203', '4', null, '1', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('209', '848', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('210', '940', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('211', '1278', '5', null, '6', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('212', '1122', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('213', '1230', '8', null, '0', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('214', '1150', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('215', '1089', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('216', '1276', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('217', '642', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('218', '886', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('219', '1291', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('220', '677', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('221', '1253', '1', null, '277', null, '278');
INSERT INTO `ds_user_statistics` VALUES ('222', '812', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('223', '1373', '1', null, '4', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('224', '1363', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('225', '1192', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('226', '1186', '11', null, '3', null, '14');
INSERT INTO `ds_user_statistics` VALUES ('227', '787', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('228', '800', '116', null, '1', null, '117');
INSERT INTO `ds_user_statistics` VALUES ('229', '1227', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('230', '1419', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('231', '864', '2', null, '4', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('232', '840', '93', null, '6', null, '99');
INSERT INTO `ds_user_statistics` VALUES ('233', '1397', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('234', '842', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('235', '214', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('236', '1293', '3', null, '1', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('237', '515', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('238', '1494', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('239', '1439', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('240', '426', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('241', '1437', '8', null, '4', null, '12');
INSERT INTO `ds_user_statistics` VALUES ('242', '1321', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('243', '1603', '6', null, '10', null, '16');
INSERT INTO `ds_user_statistics` VALUES ('244', '1411', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('245', '1579', '2', null, '4', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('246', '895', '3', null, '3', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('247', '1484', '2', null, '9', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('248', '1008', '14', null, '7', null, '21');
INSERT INTO `ds_user_statistics` VALUES ('249', '959', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('250', '544', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('251', '657', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('252', '83', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('253', '1652', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('254', '904', '8', null, '19', null, '27');
INSERT INTO `ds_user_statistics` VALUES ('255', '1586', '16', null, '54', null, '70');
INSERT INTO `ds_user_statistics` VALUES ('256', '1460', '277', null, '67', null, '344');
INSERT INTO `ds_user_statistics` VALUES ('257', '174', '26', null, '0', null, '26');
INSERT INTO `ds_user_statistics` VALUES ('258', '1252', '21', null, '8', null, '29');
INSERT INTO `ds_user_statistics` VALUES ('259', '1289', '4', null, '2', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('260', '1640', '24', null, '5', null, '29');
INSERT INTO `ds_user_statistics` VALUES ('261', '996', '43', null, '0', null, '43');
INSERT INTO `ds_user_statistics` VALUES ('262', '731', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('263', '1718', '10', null, '7', null, '17');
INSERT INTO `ds_user_statistics` VALUES ('264', '1663', '9', null, '5', null, '14');
INSERT INTO `ds_user_statistics` VALUES ('265', '1839', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('266', '718', '2', null, '2', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('267', '1781', '9', null, '25', null, '34');
INSERT INTO `ds_user_statistics` VALUES ('268', '1724', '5', null, '6', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('269', '1649', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('270', '1678', '9', null, '3', null, '12');
INSERT INTO `ds_user_statistics` VALUES ('271', '1747', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('272', '384', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('273', '666', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('274', '1853', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('275', '1821', '8', null, '0', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('276', '1189', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('277', '1840', '1', null, '14', null, '15');
INSERT INTO `ds_user_statistics` VALUES ('278', '1935', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('279', '757', '14', null, '3', null, '17');
INSERT INTO `ds_user_statistics` VALUES ('280', '1732', '6', null, '4', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('281', '335', '5', null, '5', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('282', '802', '27', null, '2', null, '29');
INSERT INTO `ds_user_statistics` VALUES ('283', '1801', '13', null, '12', null, '25');
INSERT INTO `ds_user_statistics` VALUES ('284', '1876', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('285', '1471', '4', null, '7', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('286', '1879', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('287', '1971', '14', null, '0', null, '14');
INSERT INTO `ds_user_statistics` VALUES ('288', '1106', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('289', '1882', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('290', '1368', '35', null, '0', null, '35');
INSERT INTO `ds_user_statistics` VALUES ('291', '1923', '42', null, '142', null, '184');
INSERT INTO `ds_user_statistics` VALUES ('292', '1461', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('293', '612', '10', null, '0', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('294', '1891', '1', null, '9', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('295', '1919', '17', null, '419', null, '436');
INSERT INTO `ds_user_statistics` VALUES ('296', '1938', '3', null, '135', null, '138');
INSERT INTO `ds_user_statistics` VALUES ('297', '2024', '3', null, '41', null, '44');
INSERT INTO `ds_user_statistics` VALUES ('298', '1783', '69', null, '2', null, '71');
INSERT INTO `ds_user_statistics` VALUES ('299', '2120', '7', null, '0', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('300', '2073', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('301', '1671', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('302', '1199', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('303', '2085', '415', null, '26', null, '441');
INSERT INTO `ds_user_statistics` VALUES ('304', '14', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('305', '2046', '1', null, '25', null, '26');
INSERT INTO `ds_user_statistics` VALUES ('306', '1542', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('307', '1888', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('308', '1907', '4', null, '29', null, '33');
INSERT INTO `ds_user_statistics` VALUES ('309', '2141', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('310', '1890', '4', null, '3', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('311', '1706', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('312', '1946', '3', null, '2', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('313', '1758', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('314', '2182', '91', null, '83', null, '174');
INSERT INTO `ds_user_statistics` VALUES ('315', '2227', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('316', '1005', '25', null, '0', null, '25');
INSERT INTO `ds_user_statistics` VALUES ('317', '720', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('318', '2078', '9', null, '6', null, '15');
INSERT INTO `ds_user_statistics` VALUES ('319', '2294', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('320', '863', '81', null, '1', null, '82');
INSERT INTO `ds_user_statistics` VALUES ('321', '2258', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('322', '2265', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('323', '2261', '1', null, '8', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('324', '2097', '134', null, '111', null, '245');
INSERT INTO `ds_user_statistics` VALUES ('325', '2349', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('326', '2389', '7', null, '3', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('327', '2413', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('328', '2337', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('329', '218', '10', null, '0', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('330', '2277', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('331', '2114', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('332', '2456', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('333', '531', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('334', '2291', '1', null, '113', null, '114');
INSERT INTO `ds_user_statistics` VALUES ('335', '2514', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('336', '128', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('337', '2416', '8', null, '4', null, '12');
INSERT INTO `ds_user_statistics` VALUES ('338', '2232', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('339', '2445', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('340', '1557', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('341', '1703', '15', null, '13', null, '28');
INSERT INTO `ds_user_statistics` VALUES ('342', '960', '29', null, '0', null, '29');
INSERT INTO `ds_user_statistics` VALUES ('343', '2153', '64', null, '17', null, '81');
INSERT INTO `ds_user_statistics` VALUES ('344', '345', '2', null, '2', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('345', '1773', '27', null, '0', null, '27');
INSERT INTO `ds_user_statistics` VALUES ('346', '2192', '25', null, '31', null, '56');
INSERT INTO `ds_user_statistics` VALUES ('347', '1309', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('348', '1105', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('349', '2609', '1', null, '14', null, '15');
INSERT INTO `ds_user_statistics` VALUES ('350', '2525', '11', null, '2', null, '13');
INSERT INTO `ds_user_statistics` VALUES ('351', '2490', '41', null, '2', null, '43');
INSERT INTO `ds_user_statistics` VALUES ('352', '2433', '3', null, '3', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('353', '2640', '1', null, '12', null, '13');
INSERT INTO `ds_user_statistics` VALUES ('354', '2510', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('355', '2645', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('356', '2424', '17', null, '17', null, '34');
INSERT INTO `ds_user_statistics` VALUES ('357', '2671', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('358', '630', '9', null, '3', null, '12');
INSERT INTO `ds_user_statistics` VALUES ('359', '2515', '2', null, '3', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('360', '2592', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('361', '2681', '4', null, '4', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('362', '2691', '12', null, '37', null, '49');
INSERT INTO `ds_user_statistics` VALUES ('363', '2647', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('364', '2704', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('365', '2741', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('366', '2637', '14', null, '0', null, '14');
INSERT INTO `ds_user_statistics` VALUES ('367', '2760', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('368', '1997', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('369', '2428', '3', null, '22', null, '25');
INSERT INTO `ds_user_statistics` VALUES ('370', '2580', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('371', '2266', '10', null, '26', null, '36');
INSERT INTO `ds_user_statistics` VALUES ('372', '2780', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('373', '1861', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('374', '2775', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('375', '2810', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('376', '1628', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('377', '2777', '17', null, '9', null, '26');
INSERT INTO `ds_user_statistics` VALUES ('378', '2839', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('379', '2577', '3', null, '19', null, '22');
INSERT INTO `ds_user_statistics` VALUES ('380', '2802', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('381', '2497', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('382', '2146', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('383', '2857', '9', null, '0', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('384', '2863', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('385', '2770', '19', null, '41', null, '60');
INSERT INTO `ds_user_statistics` VALUES ('386', '2867', '19', null, '35', null, '54');
INSERT INTO `ds_user_statistics` VALUES ('387', '2900', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('388', '2759', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('389', '2893', '7', null, '0', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('390', '2944', '1', null, '2', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('391', '1549', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('392', '2943', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('393', '2450', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('394', '2993', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('395', '2301', '8', null, '0', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('396', '2988', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('397', '2156', '67', null, '98', null, '165');
INSERT INTO `ds_user_statistics` VALUES ('398', '2987', '47', null, '46', null, '93');
INSERT INTO `ds_user_statistics` VALUES ('399', '1883', '103', null, '166', null, '269');
INSERT INTO `ds_user_statistics` VALUES ('400', '3053', '2', null, '38', null, '40');
INSERT INTO `ds_user_statistics` VALUES ('401', '2796', '63', null, '44', null, '107');
INSERT INTO `ds_user_statistics` VALUES ('402', '3077', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('403', '3097', '1', null, '4', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('404', '3049', '5', null, '0', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('405', '3086', '38', null, '78', null, '116');
INSERT INTO `ds_user_statistics` VALUES ('406', '3118', '5', null, '0', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('407', '1277', '8', null, '38', null, '46');
INSERT INTO `ds_user_statistics` VALUES ('408', '1894', '30', null, '0', null, '30');
INSERT INTO `ds_user_statistics` VALUES ('409', '2530', '113', null, '7', null, '120');
INSERT INTO `ds_user_statistics` VALUES ('410', '3102', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('411', '3063', '104', null, '4', null, '108');
INSERT INTO `ds_user_statistics` VALUES ('412', '3158', '3', null, '34', null, '37');
INSERT INTO `ds_user_statistics` VALUES ('413', '3007', '4', null, '6', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('414', '3218', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('415', '3125', '4', null, '2', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('416', '3256', '1', null, '22', null, '23');
INSERT INTO `ds_user_statistics` VALUES ('417', '3046', '10', null, '11', null, '21');
INSERT INTO `ds_user_statistics` VALUES ('418', '3079', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('419', '3230', '11', null, '0', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('420', '3191', '2', null, '51', null, '53');
INSERT INTO `ds_user_statistics` VALUES ('421', '3183', '39', null, '0', null, '39');
INSERT INTO `ds_user_statistics` VALUES ('422', '2976', '3', null, '7', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('423', '27', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('424', '2891', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('425', '3288', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('426', '1823', '6', null, '6', null, '12');
INSERT INTO `ds_user_statistics` VALUES ('427', '3323', '35', null, '57', null, '92');
INSERT INTO `ds_user_statistics` VALUES ('428', '3306', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('429', '3350', '51', null, '0', null, '51');
INSERT INTO `ds_user_statistics` VALUES ('430', '3242', '6', null, '4', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('431', '3368', '3', null, '14', null, '17');
INSERT INTO `ds_user_statistics` VALUES ('432', '3417', '39', null, '51', null, '90');
INSERT INTO `ds_user_statistics` VALUES ('433', '3275', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('434', '3453', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('435', '3259', '13', null, '0', null, '13');
INSERT INTO `ds_user_statistics` VALUES ('436', '3399', '14', null, '1', null, '15');
INSERT INTO `ds_user_statistics` VALUES ('437', '3035', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('438', '3493', '15', null, '11', null, '26');
INSERT INTO `ds_user_statistics` VALUES ('439', '3553', '194', null, '0', null, '194');
INSERT INTO `ds_user_statistics` VALUES ('440', '3569', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('441', '3294', '10', null, '0', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('442', '3241', '17', null, '0', null, '17');
INSERT INTO `ds_user_statistics` VALUES ('443', '2033', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('444', '2010', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('445', '2774', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('446', '3596', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('447', '3481', '10', null, '1', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('448', '3709', '1', null, '7', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('449', '3491', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('450', '3586', '11', null, '0', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('451', '3655', '19', null, '1', null, '20');
INSERT INTO `ds_user_statistics` VALUES ('452', '3735', '2', null, '3', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('453', '3591', '14', null, '16', null, '30');
INSERT INTO `ds_user_statistics` VALUES ('454', '3716', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('455', '3565', '5', null, '5', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('456', '3820', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('457', '3791', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('458', '982', '1', null, '12', null, '13');
INSERT INTO `ds_user_statistics` VALUES ('459', '3821', '5', null, '0', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('460', '3811', '6', null, '1', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('461', '3724', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('462', '2471', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('463', '3784', '10', null, '4', null, '14');
INSERT INTO `ds_user_statistics` VALUES ('464', '3891', '2', null, '20', null, '22');
INSERT INTO `ds_user_statistics` VALUES ('465', '2255', '62', null, '0', null, '62');
INSERT INTO `ds_user_statistics` VALUES ('466', '1332', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('467', '3120', '35', null, '0', null, '35');
INSERT INTO `ds_user_statistics` VALUES ('468', '1354', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('469', '3899', '20', null, '3', null, '23');
INSERT INTO `ds_user_statistics` VALUES ('470', '3993', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('471', '3122', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('472', '4002', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('473', '3090', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('474', '1900', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('475', '2924', '6', null, '1', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('476', '3936', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('477', '2239', '12', null, '0', null, '12');
INSERT INTO `ds_user_statistics` VALUES ('478', '4037', '3', null, '1', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('479', '3402', '113', null, '0', null, '113');
INSERT INTO `ds_user_statistics` VALUES ('480', '4092', '1', null, '8', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('481', '4063', '7', null, '0', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('482', '4073', '3', null, '5', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('483', '4054', '7', null, '1', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('484', '4049', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('485', '831', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('486', '2576', '3', null, '1', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('487', '4141', '1', null, '4', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('488', '3916', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('489', '4185', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('490', '4119', '1', null, '3', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('491', '4174', '7', null, '9', null, '16');
INSERT INTO `ds_user_statistics` VALUES ('492', '4206', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('493', '4164', '9', null, '2', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('494', '3562', '9', null, '2', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('495', '2018', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('496', '4159', '3', null, '2', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('497', '4220', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('498', '4179', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('499', '4229', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('500', '4212', '4', null, '1', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('501', '1171', '2', null, '3', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('502', '257', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('503', '4236', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('504', '50', '22', null, '0', null, '22');
INSERT INTO `ds_user_statistics` VALUES ('505', '3626', '12', null, '8', null, '20');
INSERT INTO `ds_user_statistics` VALUES ('506', '1412', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('507', '4297', '9', null, '1', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('508', '4343', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('509', '4111', '8', null, '1', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('510', '805', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('511', '4424', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('512', '4428', '3', null, '1', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('513', '4290', '9', null, '0', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('514', '3282', '22', null, '0', null, '22');
INSERT INTO `ds_user_statistics` VALUES ('515', '238', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('516', '3415', '5', null, '2', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('517', '4014', '3', null, '2', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('518', '4444', '39', null, '0', null, '39');
INSERT INTO `ds_user_statistics` VALUES ('519', '4528', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('520', '2013', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('521', '4298', '3', null, '4', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('522', '2927', '10', null, '0', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('523', '207', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('524', '565', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('525', '1574', '14', null, '6', null, '20');
INSERT INTO `ds_user_statistics` VALUES ('526', '4519', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('527', '4730', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('528', '1576', '4', null, '2', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('529', '4374', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('530', '4244', '3', null, '3', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('531', '4427', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('532', '593', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('533', '4676', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('534', '4764', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('535', '3807', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('536', '3840', '12', null, '22', null, '34');
INSERT INTO `ds_user_statistics` VALUES ('537', '3726', '7', null, '0', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('538', '4099', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('539', '4699', '57', null, '0', null, '57');
INSERT INTO `ds_user_statistics` VALUES ('540', '2782', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('541', '4573', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('542', '4421', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('543', '4383', '7', null, '0', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('544', '4743', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('545', '1498', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('546', '4596', '6', null, '2', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('547', '1865', '1', null, '2', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('548', '4530', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('549', '3981', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('550', '4863', '9', null, '0', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('551', '4922', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('552', '1858', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('553', '5004', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('554', '4947', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('555', '4919', '23', null, '0', null, '23');
INSERT INTO `ds_user_statistics` VALUES ('556', '5003', '8', null, '1', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('557', '4999', '7', null, '2', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('558', '4437', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('559', '5078', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('560', '5132', '166', null, '36', null, '202');
INSERT INTO `ds_user_statistics` VALUES ('561', '4937', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('562', '5135', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('563', '4868', '5', null, '3', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('564', '1011', '48', null, '3', null, '51');
INSERT INTO `ds_user_statistics` VALUES ('565', '3033', '11', null, '4', null, '15');
INSERT INTO `ds_user_statistics` VALUES ('566', '4552', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('567', '4724', '25', null, '7', null, '32');
INSERT INTO `ds_user_statistics` VALUES ('568', '1609', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('569', '3382', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('570', '4772', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('571', '5116', '3', null, '3', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('572', '5161', '4', null, '2', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('573', '945', '3', null, '5', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('574', '5268', '10', null, '6', null, '16');
INSERT INTO `ds_user_statistics` VALUES ('575', '4572', '8', null, '0', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('576', '4892', '2', null, '31', null, '33');
INSERT INTO `ds_user_statistics` VALUES ('577', '3197', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('578', '5316', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('579', '3989', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('580', '1218', '3', null, '1', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('581', '4487', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('582', '5364', '2', null, '4', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('583', '3390', '3', null, '2', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('584', '4382', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('585', '1134', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('586', '4387', '43', null, '0', null, '43');
INSERT INTO `ds_user_statistics` VALUES ('587', '5367', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('588', '3968', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('589', '5376', '1', null, '6', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('590', '5389', '9', null, '1', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('591', '5288', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('592', '5498', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('593', '5512', '4', null, '8', null, '12');
INSERT INTO `ds_user_statistics` VALUES ('594', '5453', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('595', '5475', '7', null, '3', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('596', '5444', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('597', '4398', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('598', '5291', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('599', '4929', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('600', '2712', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('601', '5391', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('602', '5561', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('603', '5483', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('604', '4588', '2', null, '1', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('605', '5544', '1', null, '2', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('606', '5581', '3', null, '4', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('607', '4210', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('608', '5185', '5', null, '30', null, '35');
INSERT INTO `ds_user_statistics` VALUES ('609', '5608', '51', null, '0', null, '51');
INSERT INTO `ds_user_statistics` VALUES ('610', '5626', '1', null, '126', null, '127');
INSERT INTO `ds_user_statistics` VALUES ('611', '1559', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('612', '5310', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('613', '253', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('614', '2300', '66', null, '0', null, '66');
INSERT INTO `ds_user_statistics` VALUES ('615', '5731', '28', null, '85', null, '113');
INSERT INTO `ds_user_statistics` VALUES ('616', '4592', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('617', '5390', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('618', '5555', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('619', '5701', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('620', '5533', '19', null, '46', null, '65');
INSERT INTO `ds_user_statistics` VALUES ('621', '5113', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('622', '5477', '21', null, '4', null, '25');
INSERT INTO `ds_user_statistics` VALUES ('623', '5685', '9', null, '3', null, '12');
INSERT INTO `ds_user_statistics` VALUES ('624', '5744', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('625', '5530', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('626', '5802', '7', null, '7', null, '14');
INSERT INTO `ds_user_statistics` VALUES ('627', '5798', '11', null, '12', null, '23');
INSERT INTO `ds_user_statistics` VALUES ('628', '5274', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('629', '5702', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('630', '5549', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('631', '1750', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('632', '3059', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('633', '3454', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('634', '5203', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('635', '1024', '39', null, '0', null, '39');
INSERT INTO `ds_user_statistics` VALUES ('636', '5536', '10', null, '1', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('637', '4371', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('638', '5009', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('639', '5616', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('640', '5788', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('641', '5881', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('642', '5912', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('643', '5856', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('644', '5885', '11', null, '2', null, '13');
INSERT INTO `ds_user_statistics` VALUES ('645', '5534', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('646', '308', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('647', '5546', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('648', '2737', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('649', '5666', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('650', '5884', '2', null, '2', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('651', '735', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('652', '4877', '32', null, '20', null, '52');
INSERT INTO `ds_user_statistics` VALUES ('653', '5949', '5', null, '1', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('654', '1529', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('655', '5740', '126', null, '0', null, '126');
INSERT INTO `ds_user_statistics` VALUES ('656', '5811', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('657', '4269', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('658', '5758', '2', null, '2', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('659', '6064', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('660', '4932', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('661', '6039', '27', null, '0', null, '27');
INSERT INTO `ds_user_statistics` VALUES ('662', '5499', '5', null, '0', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('663', '5898', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('664', '6001', '10', null, '0', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('665', '5215', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('666', '5568', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('667', '5567', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('668', '2953', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('669', '6169', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('670', '5914', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('671', '4087', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('672', '6150', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('673', '2962', '22', null, '0', null, '22');
INSERT INTO `ds_user_statistics` VALUES ('674', '5719', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('675', '6044', '22', null, '4', null, '26');
INSERT INTO `ds_user_statistics` VALUES ('676', '6438', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('677', '2410', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('678', '4709', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('679', '616', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('680', '1209', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('681', '6333', '2', null, '19', null, '21');
INSERT INTO `ds_user_statistics` VALUES ('682', '6337', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('683', '4455', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('684', '6474', '31', null, '49', null, '80');
INSERT INTO `ds_user_statistics` VALUES ('685', '6248', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('686', '5119', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('687', '6543', '3', null, '8', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('688', '5107', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('689', '3682', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('690', '6493', '1', null, '3', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('691', '4081', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('692', '6087', '5', null, '0', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('693', '6615', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('694', '1805', '5', null, '16', null, '21');
INSERT INTO `ds_user_statistics` VALUES ('695', '5343', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('696', '5362', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('697', '3878', '149', null, '8', null, '157');
INSERT INTO `ds_user_statistics` VALUES ('698', '6834', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('699', '6193', '26', null, '29', null, '55');
INSERT INTO `ds_user_statistics` VALUES ('700', '6319', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('701', '6820', '6', null, '4', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('702', '6844', '2', null, '1', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('703', '6858', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('704', '6870', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('705', '5429', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('706', '4457', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('707', '5315', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('708', '6893', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('709', '6903', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('710', '5791', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('711', '5950', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('712', '6867', '1', null, '4', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('713', '387', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('714', '3517', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('715', '7025', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('716', '6928', '1', null, '4', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('717', '6855', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('718', '4102', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('719', '4798', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('720', '5854', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('721', '2002', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('722', '6942', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('723', '6920', '4', null, '3', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('724', '6605', '19', null, '0', null, '19');
INSERT INTO `ds_user_statistics` VALUES ('725', '7095', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('726', '2925', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('727', '3969', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('728', '6937', '46', null, '0', null, '46');
INSERT INTO `ds_user_statistics` VALUES ('729', '7001', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('730', '7056', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('731', '3548', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('732', '6904', '13', null, '3', null, '16');
INSERT INTO `ds_user_statistics` VALUES ('733', '7014', '4', null, '2', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('734', '5839', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('735', '7190', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('736', '7209', '6', null, '5', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('737', '7252', '1', null, '8', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('738', '3318', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('739', '492', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('740', '7307', '7', null, '19', null, '26');
INSERT INTO `ds_user_statistics` VALUES ('741', '7297', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('742', '7181', '1', null, '2', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('743', '7319', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('744', '7329', '8', null, '0', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('745', '2298', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('746', '6728', '3', null, '3', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('747', '6091', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('748', '7207', '3', null, '1', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('749', '7264', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('750', '797', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('751', '7387', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('752', '7379', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('753', '7321', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('754', '6590', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('755', '6865', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('756', '1283', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('757', '7324', '5', null, '4', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('758', '7441', '7', null, '0', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('759', '1225', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('760', '7365', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('761', '7491', '1', null, '10', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('762', '7538', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('763', '7120', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('764', '7342', '19', null, '0', null, '19');
INSERT INTO `ds_user_statistics` VALUES ('765', '7450', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('766', '2283', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('767', '7397', '50', null, '0', null, '50');
INSERT INTO `ds_user_statistics` VALUES ('768', '7485', '53', null, '0', null, '53');
INSERT INTO `ds_user_statistics` VALUES ('769', '7395', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('770', '5559', '3', null, '2', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('771', '4671', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('772', '1088', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('773', '7153', '7', null, '0', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('774', '5655', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('775', '2098', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('776', '7706', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('777', '613', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('778', '7853', '14', null, '11', null, '25');
INSERT INTO `ds_user_statistics` VALUES ('779', '3179', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('780', '7863', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('781', '7899', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('782', '7353', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('783', '7769', '3', null, '3', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('784', '7812', '1', null, '7', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('785', '7914', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('786', '5418', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('787', '7966', '2', null, '8', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('788', '944', '3', null, '5', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('789', '675', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('790', '6007', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('791', '4394', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('792', '1446', '107', null, '0', null, '107');
INSERT INTO `ds_user_statistics` VALUES ('793', '7997', '7', null, '0', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('794', '7725', '46', null, '3', null, '49');
INSERT INTO `ds_user_statistics` VALUES ('795', '7864', '2', null, '28', null, '30');
INSERT INTO `ds_user_statistics` VALUES ('796', '8060', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('797', '8070', '5', null, '0', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('798', '8137', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('799', '4865', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('800', '7836', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('801', '8111', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('802', '7651', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('803', '7351', '20', null, '0', null, '20');
INSERT INTO `ds_user_statistics` VALUES ('804', '8125', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('805', '8162', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('806', '7999', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('807', '8141', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('808', '8132', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('809', '60', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('810', '8179', '2', null, '25', null, '27');
INSERT INTO `ds_user_statistics` VALUES ('811', '7418', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('812', '8143', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('813', '8072', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('814', '7973', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('815', '8297', '25', null, '1', null, '26');
INSERT INTO `ds_user_statistics` VALUES ('816', '4553', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('817', '5777', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('818', '6726', '7', null, '1', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('819', '1001', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('820', '2399', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('821', '8153', '27', null, '0', null, '27');
INSERT INTO `ds_user_statistics` VALUES ('822', '6978', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('823', '7734', '46', null, '3', null, '49');
INSERT INTO `ds_user_statistics` VALUES ('824', '5890', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('825', '5436', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('826', '6528', '2', null, '1', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('827', '6103', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('828', '6009', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('829', '8536', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('830', '7595', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('831', '8566', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('832', '589', '39', null, '0', null, '39');
INSERT INTO `ds_user_statistics` VALUES ('833', '7962', '5', null, '1', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('834', '8589', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('835', '8620', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('836', '7641', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('837', '5025', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('838', '8642', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('839', '8611', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('840', '545', '3', null, '2', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('841', '6677', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('842', '3960', '2', null, '4', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('843', '8225', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('844', '8551', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('845', '8636', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('846', '3252', '7', null, '0', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('847', '8721', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('848', '8562', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('849', '8667', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('850', '7652', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('851', '6453', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('852', '8704', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('853', '7391', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('854', '3734', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('855', '8818', '1', null, '12', null, '13');
INSERT INTO `ds_user_statistics` VALUES ('856', '5766', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('857', '2878', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('858', '8709', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('859', '3702', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('860', '8809', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('861', '5105', '2', null, '1', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('862', '8665', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('863', '8508', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('864', '8553', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('865', '4490', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('866', '9043', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('867', '6265', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('868', '8462', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('869', '685', '9', null, '0', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('870', '3722', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('871', '9009', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('872', '9095', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('873', '7887', '37', null, '47', null, '84');
INSERT INTO `ds_user_statistics` VALUES ('874', '1874', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('875', '8909', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('876', '8871', '11', null, '0', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('877', '5704', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('878', '2295', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('879', '7327', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('880', '8954', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('881', '9119', '1', null, '3', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('882', '8442', '6', null, '0', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('883', '9198', '3', null, '9', null, '12');
INSERT INTO `ds_user_statistics` VALUES ('884', '3308', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('885', '5863', '7', null, '0', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('886', '8945', '1', null, '64', null, '65');
INSERT INTO `ds_user_statistics` VALUES ('887', '8841', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('888', '7679', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('889', '3161', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('890', '2963', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('891', '9106', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('892', '6763', '3', null, '8', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('893', '9244', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('894', '7488', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('895', '9250', '64', null, '0', null, '64');
INSERT INTO `ds_user_statistics` VALUES ('896', '4254', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('897', '9001', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('898', '9309', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('899', '6443', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('900', '8629', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('901', '6347', '11', null, '3', null, '14');
INSERT INTO `ds_user_statistics` VALUES ('902', '7438', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('903', '9328', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('904', '6368', '1', null, '13', null, '14');
INSERT INTO `ds_user_statistics` VALUES ('905', '9345', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('906', '6776', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('907', '9271', '7', null, '0', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('908', '9360', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('909', '8937', '12', null, '0', null, '12');
INSERT INTO `ds_user_statistics` VALUES ('910', '9382', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('911', '3939', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('912', '6633', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('913', '9195', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('914', '7074', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('915', '9431', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('916', '8989', '7', null, '2', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('917', '9468', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('918', '240', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('919', '9370', '13', null, '5', null, '18');
INSERT INTO `ds_user_statistics` VALUES ('920', '8628', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('921', '9406', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('922', '9133', '45', null, '4', null, '49');
INSERT INTO `ds_user_statistics` VALUES ('923', '2075', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('924', '9516', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('925', '1436', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('926', '6288', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('927', '5405', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('928', '9573', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('929', '9456', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('930', '9581', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('931', '9580', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('932', '6852', '14', null, '0', null, '14');
INSERT INTO `ds_user_statistics` VALUES ('933', '9289', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('934', '9650', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('935', '9584', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('936', '9562', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('937', '9684', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('938', '8504', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('939', '8461', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('940', '5739', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('941', '9377', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('942', '8823', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('943', '9694', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('944', '9651', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('945', '241', '1', null, '2', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('946', '9521', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('947', '6090', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('948', '6698', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('949', '9731', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('950', '8429', '2', null, '3', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('951', '9405', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('952', '9770', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('953', '8630', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('954', '9855', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('955', '9652', '14', null, '12', null, '26');
INSERT INTO `ds_user_statistics` VALUES ('956', '9783', '2', null, '2', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('957', '9701', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('958', '9901', '3', null, '10', null, '13');
INSERT INTO `ds_user_statistics` VALUES ('959', '9479', '1', null, '23', null, '24');
INSERT INTO `ds_user_statistics` VALUES ('960', '6038', '31', null, '0', null, '31');
INSERT INTO `ds_user_statistics` VALUES ('961', '9838', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('962', '7522', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('963', '1450', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('964', '9875', '3', null, '1', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('965', '9935', '2', null, '1', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('966', '9733', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('967', '7920', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('968', '6313', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('969', '9672', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('970', '9948', '23', null, '0', null, '23');
INSERT INTO `ds_user_statistics` VALUES ('971', '9867', '57', null, '0', null, '57');
INSERT INTO `ds_user_statistics` VALUES ('972', '3058', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('973', '6269', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('974', '10047', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('975', '251', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('976', '9037', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('977', '10119', '7', null, '1', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('978', '6774', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('979', '6706', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('980', '3419', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('981', '10055', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('982', '10156', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('983', '10083', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('984', '9825', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('985', '10194', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('986', '6129', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('987', '4784', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('988', '8813', '7', null, '0', null, '7');
INSERT INTO `ds_user_statistics` VALUES ('989', '10013', '2', null, '2', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('990', '954', '4', null, '9', null, '13');
INSERT INTO `ds_user_statistics` VALUES ('991', '6786', '3', null, '3', null, '6');
INSERT INTO `ds_user_statistics` VALUES ('992', '9208', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('993', '7614', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('994', '8896', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('995', '10135', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('996', '10247', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('997', '4786', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('998', '9842', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('999', '10323', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1000', '10296', '8', null, '0', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('1001', '10342', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1002', '6457', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('1003', '1693', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1004', '10267', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1005', '6676', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1006', '5273', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1007', '8685', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1008', '4481', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1009', '9421', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('1010', '4375', '1', null, '3', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('1011', '10162', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1012', '7586', '10', null, '0', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('1013', '6284', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1014', '8752', '2', null, '1', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('1015', '4619', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1016', '9487', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1017', '10480', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('1018', '7154', '3', null, '8', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('1019', '5829', '5', null, '0', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('1020', '10535', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1021', '5986', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1022', '1990', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1023', '10449', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1024', '7745', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1025', '2513', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1026', '9939', '11', null, '0', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('1027', '10626', '4', null, '1', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('1028', '10483', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1029', '10658', '1', null, '8', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('1030', '10621', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1031', '10355', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1032', '818', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1033', '10590', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('1034', '10725', '8', null, '0', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('1035', '4323', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1036', '10735', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1037', '10577', '1', null, '3', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('1038', '10695', '36', null, '0', null, '36');
INSERT INTO `ds_user_statistics` VALUES ('1039', '10534', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1040', '9740', '8', null, '1', null, '9');
INSERT INTO `ds_user_statistics` VALUES ('1041', '5194', '5', null, '3', null, '8');
INSERT INTO `ds_user_statistics` VALUES ('1042', '10686', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1043', '10679', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1044', '10766', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1045', '4367', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1046', '849', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1047', '2264', '3', null, '2', null, '5');
INSERT INTO `ds_user_statistics` VALUES ('1048', '796', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1049', '10895', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1050', '10955', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1051', '10298', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1052', '10773', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1053', '10936', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1054', '8016', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1055', '10362', '20', null, '0', null, '20');
INSERT INTO `ds_user_statistics` VALUES ('1056', '5846', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1057', '10431', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1058', '2836', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1059', '11017', '2', null, '1', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('1060', '10830', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('1061', '10559', '2', null, '1', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('1062', '7612', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1063', '10897', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('1064', '9947', '10', null, '0', null, '10');
INSERT INTO `ds_user_statistics` VALUES ('1065', '10875', '11', null, '0', null, '11');
INSERT INTO `ds_user_statistics` VALUES ('1066', '11011', '12', null, '10', null, '22');
INSERT INTO `ds_user_statistics` VALUES ('1067', '1220', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1068', '10956', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1069', '10610', '4', null, '0', null, '4');
INSERT INTO `ds_user_statistics` VALUES ('1070', '10951', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1071', '11083', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1072', '7289', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1073', '5076', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('1074', '10461', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1075', '1794', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1076', '11092', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1077', '11120', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1078', '11012', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1079', '11115', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1080', '4152', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1081', '11032', '1', null, '1', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1082', '8774', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1083', '11172', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('1084', '10933', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1085', '11234', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1086', '11184', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1087', '6070', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1088', '11268', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1089', '2022', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1090', '7738', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1091', '11241', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('1092', '11069', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1093', '10713', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1094', '5595', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1095', '11391', '3', null, '0', null, '3');
INSERT INTO `ds_user_statistics` VALUES ('1096', '6524', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1097', '9398', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1098', '11077', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1099', '11160', '2', null, '0', null, '2');
INSERT INTO `ds_user_statistics` VALUES ('1100', '11079', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1101', '10921', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1102', '5479', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1103', '11351', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1104', '11298', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1105', '8049', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1106', '7911', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1107', '11023', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1108', '11431', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1109', '10660', '1', null, '0', null, '1');
INSERT INTO `ds_user_statistics` VALUES ('1110', '1', '0', null, '4', null, '504');
INSERT INTO `ds_user_statistics` VALUES ('1111', '2338', '0', null, '3', null, '3');

-- ----------------------------
-- Table structure for `ds_xiangmu`
-- ----------------------------
DROP TABLE IF EXISTS `ds_xiangmu`;
CREATE TABLE `ds_xiangmu` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `title` char(60) NOT NULL DEFAULT '' COMMENT '标题',
  `content` text NOT NULL COMMENT '内容',
  `addtime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '添加时间',
  `edittime` int(10) unsigned NOT NULL DEFAULT '0' COMMENT '修改时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=755 ROW_FORMAT=DYNAMIC COMMENT='公告信息表';

-- ----------------------------
-- Records of ds_xiangmu
-- ----------------------------
INSERT INTO `ds_xiangmu` VALUES ('1', '东鸿益森生态帮助中心', '项目测试', '0', '1584115957');
