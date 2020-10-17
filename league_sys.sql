/*
Navicat MySQL Data Transfer

Source Server         : mysql
Source Server Version : 50553
Source Host           : localhost:3306
Source Database       : league_sys

Target Server Type    : MYSQL
Target Server Version : 50553
File Encoding         : 65001

Date: 2020-10-16 17:51:30
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
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_bonus
-- ----------------------------
INSERT INTO `ds_bonus` VALUES ('1', '1', '19016.8244', '284683', '1601111595', '1601115195', '6.68');
INSERT INTO `ds_bonus` VALUES ('2', '1', '2291.8560', '17232', '1602145543', '1602181543', '13.30');
INSERT INTO `ds_bonus` VALUES ('3', '2', '310812.0000', '310812', '1602680466', '1602716466', '100.00');

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
  `types` tinyint(5) DEFAULT '1' COMMENT '类型 1:下线实名 2:下线订单返利',
  `is_cert` tinyint(4) NOT NULL DEFAULT '1' COMMENT '是否实名 1:否 2:是',
  `sub_mobile` varchar(50) DEFAULT NULL COMMENT '下级手机号码',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_invite_record
-- ----------------------------
INSERT INTO `ds_invite_record` VALUES ('1', '1', '0.00', '2', '一级下线实名', '1602645348', '1', '1', '2', '15888888888');
INSERT INTO `ds_invite_record` VALUES ('2', '1', '0.00', '28', '一级下线实名', '1602830796', '1', '1', '2', '15179811533');
INSERT INTO `ds_invite_record` VALUES ('3', '1', '0.00', '29', '一级下线实名', '1602833496', '1', '1', '2', '15179811534');
INSERT INTO `ds_invite_record` VALUES ('4', '2', '0.00', '30', '一级下线实名', '1602839699', '1', '1', '2', '15179811535');
INSERT INTO `ds_invite_record` VALUES ('5', '1', '0.00', '30', '二级下线实名', '1602839699', '2', '1', '2', '15179811535');

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
-- Table structure for `ds_league_bonus`
-- ----------------------------
DROP TABLE IF EXISTS `ds_league_bonus`;
CREATE TABLE `ds_league_bonus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `level` tinyint(10) DEFAULT NULL COMMENT '等级',
  `num` decimal(20,2) DEFAULT '0.00' COMMENT '数量',
  `add_time` int(11) DEFAULT NULL,
  `member_num` int(11) DEFAULT '0' COMMENT '用户会员数',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_league_bonus
-- ----------------------------
INSERT INTO `ds_league_bonus` VALUES ('1', '1', '2.00', '1602819000', '2');

-- ----------------------------
-- Table structure for `ds_league_bonus_detail`
-- ----------------------------
DROP TABLE IF EXISTS `ds_league_bonus_detail`;
CREATE TABLE `ds_league_bonus_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bonus_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL COMMENT '用户手机号',
  `level` tinyint(10) DEFAULT NULL COMMENT '联盟等级',
  `num` decimal(16,2) DEFAULT '0.00' COMMENT '分红奖励金额',
  `add_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_league_bonus_detail
-- ----------------------------
INSERT INTO `ds_league_bonus_detail` VALUES ('1', '1', '1', '18888888888', '1', '2.00', '1602819000');
INSERT INTO `ds_league_bonus_detail` VALUES ('2', '1', '2', '15888888888', '1', '2.00', '1602819000');

-- ----------------------------
-- Table structure for `ds_league_conf`
-- ----------------------------
DROP TABLE IF EXISTS `ds_league_conf`;
CREATE TABLE `ds_league_conf` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL COMMENT '名称',
  `push_level_one_num` varchar(50) DEFAULT '0' COMMENT '直推高级认证人数',
  `team_num` varchar(50) DEFAULT '0' COMMENT '团队高级认证人数',
  `push_level_one_ask` varchar(128) DEFAULT NULL COMMENT '直推要求',
  `team_buy_ask` varchar(128) DEFAULT NULL COMMENT '团队购买情况',
  `reward_product_id` int(11) DEFAULT NULL COMMENT '奖励矿机id',
  `sort` tinyint(10) DEFAULT NULL COMMENT '权重 越小越在前',
  `status` tinyint(4) DEFAULT '1' COMMENT '状态 1开启 0关闭',
  `trade_rate` decimal(10,2) DEFAULT NULL COMMENT '交易手续费',
  `bonus_rate` decimal(10,2) DEFAULT NULL COMMENT '分红手续费',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_league_conf
-- ----------------------------
INSERT INTO `ds_league_conf` VALUES ('1', '体验大使', '', '', '', '', '2', '1', '1', '0.10', '0.20');
INSERT INTO `ds_league_conf` VALUES ('2', '初级大使', '2', '2', '2', '2|3', '4', '2', '1', '0.20', '0.30');
INSERT INTO `ds_league_conf` VALUES ('3', '中级大使', '3', '4', '2', '3|4', '5', '3', '1', '0.25', '0.35');

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
) ENGINE=MyISAM AUTO_INCREMENT=141 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=68 ROW_FORMAT=DYNAMIC COMMENT='系统操作日志';

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
INSERT INTO `ds_log` VALUES ('118', '1602146409', 'admin', '127.0.0.1', '管理员[admin]登录', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('119', '1602216168', '18888888888', '127.0.0.1', '添加了一个新用户', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('120', '1602407877', '18888888888', '127.0.0.1', '添加一个新的角色', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('121', '1602408006', '18888888888', '127.0.0.1', '编辑ID为3的管理员', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('122', '1602408029', '18888888888', '127.0.0.1', '添加一个新的角色', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('123', '1602413810', 'admin', '127.0.0.1', '管理员admin登出', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('124', '1602414060', 'admin', '127.0.0.1', '管理员[admin]登录', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('125', '1602414071', '18888888888', '127.0.0.1', '编辑ID为3的管理员', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('126', '1602414190', '18888888888', '127.0.0.1', '编辑ID为3的管理员', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('127', '1602414197', '18888888888', '127.0.0.1', '编辑ID为3的管理员', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('128', '1602414284', '18888888888', '127.0.0.1', '编辑ID为3的管理员', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('129', '1602414457', '18888888888', '127.0.0.1', '编辑ID为3的管理员', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('130', '1602414562', '18888888888', '127.0.0.1', '添加了一个新用户', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('131', '1602414717', '18888888888', '127.0.0.1', '添加了一个新用户', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('132', '1602414837', '18888888888', '127.0.0.1', '添加了一个新用户', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('133', '1602415277', 'admin', '127.0.0.1', '管理员admin登出', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('134', '1602415429', 'kefu2', '127.0.0.1', '管理员[kefu2]登录', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('135', '1602425427', 'kefu2', '127.0.0.1', '管理员kefu2登出', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('136', '1602425453', 'admin', '127.0.0.1', '管理员[admin]登录', 'admin', '本机地址');
INSERT INTO `ds_log` VALUES ('137', '1602645207', '', '127.0.0.1', '会员退出', 'member', '本机地址');
INSERT INTO `ds_log` VALUES ('138', '1602820122', '', '127.0.0.1', '会员退出', 'member', '本机地址');
INSERT INTO `ds_log` VALUES ('139', '1602833229', '', '127.0.0.1', '会员退出', 'member', '本机地址');
INSERT INTO `ds_log` VALUES ('140', '1602839632', '', '127.0.0.1', '会员退出', 'member', '本机地址');

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
  `zfb` varchar(100) DEFAULT NULL COMMENT '支付宝账号',
  `wx` varchar(100) DEFAULT NULL COMMENT '微信账号',
  `zfb_img` varchar(100) DEFAULT NULL COMMENT '支付宝收款码',
  `wx_img` varchar(100) DEFAULT NULL COMMENT '微信收款码',
  `ane` decimal(20,2) DEFAULT '0.00' COMMENT 'ANE ',
  PRIMARY KEY (`id`,`parentcount`),
  KEY `username` (`username`),
  KEY `parent` (`parent`)
) ENGINE=MyISAM AUTO_INCREMENT=31 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=278 ROW_FORMAT=DYNAMIC COMMENT='会员';

-- ----------------------------
-- Records of ds_member
-- ----------------------------
INSERT INTO `ds_member` VALUES ('2', '15888888888', 'e10adc3949ba59abbe56e057f20f883e', '0', 'UGL289', '', '美国', '1584031737', '18888888888', '1', '', '103.85', null, '123123', '0.00', '1', '会员', '310812.0000', '初始账户2', null, '1584096019', '1', '0', '10', '1|1|', '1602820122', null, null, null, 'e10adc3949ba59abbe56e057f20f883e', '1', '123123', null, null, null, null, '6.00');
INSERT INTO `ds_member` VALUES ('3', '13888888888', 'e10adc3949ba59abbe56e057f20f883e', '0', 'YKB572', '', '美国', '1584031868', '15888888888', '2', '', '0.00', null, '', '0.00', '0', '会员', '0.0000', '初始账号3', null, '1584123247', '0', '3', '11', '1|1|26|', '1584125648', null, null, null, null, '-1', null, null, null, null, null, null);
INSERT INTO `ds_member` VALUES ('1', '18888888888', 'e10adc3949ba59abbe56e057f20f883e', '0', 'WSB903', '', '美国', '1584030607', '1550000000', '0', '', '13.30', null, '', '0.00', '1', '会员', '71308.6800', '初始账户1', null, '1601020191', '2', '0', '30', '1|', '1602838547', null, null, null, null, '1', null, '13166666666', '15222222223', '/Public/Uploads/cert/1602432304373.jpg', '/Public/Uploads/cert/1602432342894.jpg', '639.20');
INSERT INTO `ds_member` VALUES ('28', '15179811533', 'e10adc3949ba59abbe56e057f20f883e', '1', 'BAX256', '', '本机地址', '1602830796', '18888888888', '1', '', '100.00', null, '123123123', '0.00', '0', '张三', '0.0000', '张三', null, '0', '0', '0', '1', '1|1|', '1602833229', null, null, null, 'e10adc3949ba59abbe56e057f20f883e', '1', '', null, null, null, null, '0.00');
INSERT INTO `ds_member` VALUES ('29', '15179811534', 'e10adc3949ba59abbe56e057f20f883e', '1', 'DUS403', '', '本机地址', '1602833496', '18888888888', '1', '', '100.00', null, '123123123123', '0.00', '0', '李四', '0.0000', '王五', null, '0', '0', '0', '1', '1|1|', '1602839632', null, null, null, 'e10adc3949ba59abbe56e057f20f883e', '1', '', null, null, null, null, '68.00');
INSERT INTO `ds_member` VALUES ('30', '15179811535', 'e10adc3949ba59abbe56e057f20f883e', '1', 'THK710', '', '本机地址', '1602839699', '15888888888', '2', '', '100.00', null, '1231231231231231', '0.00', '0', '赵七', '0.0000', '赵七', null, '0', '0', '0', '1', '1|1|2|', '1602839854', null, null, null, 'e10adc3949ba59abbe56e057f20f883e', '1', '', null, null, null, null, '98.00');

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
-- Table structure for `ds_member_league`
-- ----------------------------
DROP TABLE IF EXISTS `ds_member_league`;
CREATE TABLE `ds_member_league` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `key` tinyint(10) DEFAULT '1' COMMENT '联盟等级',
  `push_level_one_num` varchar(50) DEFAULT '0' COMMENT '直推高级认证人数',
  `team_num` varchar(50) DEFAULT '0' COMMENT '团队高级认证人数',
  `push_level_one_ask` varchar(50) DEFAULT '0' COMMENT '下个等级的直推要求',
  `team_buy_ask_3` varchar(50) DEFAULT '0' COMMENT '下个等级团队购买情况(3代内)',
  `team_buy_ask_4` varchar(50) DEFAULT '0' COMMENT '下个等级团队购买情况(4代内)',
  `team_buy_ask_5` varchar(50) DEFAULT '0' COMMENT '下个等级团队购买情况(5代内)',
  `team_buy_ask_6` varchar(50) DEFAULT '0' COMMENT '下个等级团队购买情况(6代内)',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_member_league
-- ----------------------------
INSERT INTO `ds_member_league` VALUES ('1', '1', '2', '2', '3', '0', '2', '0', '0', '0');
INSERT INTO `ds_member_league` VALUES ('2', '2', '1', '1', '1', '1', '2', '0', '0', '0');
INSERT INTO `ds_member_league` VALUES ('3', '29', '1', '0', '0', '0', '0', '0', '0', '0');
INSERT INTO `ds_member_league` VALUES ('4', '30', '1', '0', '0', '0', '0', '0', '0', '0');

-- ----------------------------
-- Table structure for `ds_member_league_receive`
-- ----------------------------
DROP TABLE IF EXISTS `ds_member_league_receive`;
CREATE TABLE `ds_member_league_receive` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL COMMENT '用户手机号',
  `key` tinyint(10) DEFAULT '1' COMMENT '联盟等级',
  `last_key` tinyint(10) DEFAULT '0' COMMENT '升级前等级',
  `reward_product_id` int(11) DEFAULT NULL COMMENT '奖励矿机id',
  `add_time` int(11) DEFAULT NULL COMMENT '升级时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_member_league_receive
-- ----------------------------
INSERT INTO `ds_member_league_receive` VALUES ('1', '1', '18888888888', '1', '0', '2', '1602645132');
INSERT INTO `ds_member_league_receive` VALUES ('2', '2', '15888888888', '1', '0', '2', '1602646094');
INSERT INTO `ds_member_league_receive` VALUES ('3', '29', '15179811534', '1', '0', '2', '1602834249');
INSERT INTO `ds_member_league_receive` VALUES ('4', '30', '15179811535', '1', '0', '2', '1602839792');
INSERT INTO `ds_member_league_receive` VALUES ('5', '1', '18888888888', '2', '1', '4', '1602839792');

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
-- Table structure for `ds_member_senior_cert`
-- ----------------------------
DROP TABLE IF EXISTS `ds_member_senior_cert`;
CREATE TABLE `ds_member_senior_cert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `id_card_reverse` varchar(128) DEFAULT NULL COMMENT '身份证反面',
  `cert_fail_reason` varchar(128) DEFAULT NULL COMMENT '认证失败原因',
  `is_senior_cert` tinyint(6) DEFAULT '0' COMMENT '是否高级认证 0 未认证 1 已认证 2 认证中 3认证失败',
  `add_time` int(11) DEFAULT NULL,
  `update_time` int(11) DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_member_senior_cert
-- ----------------------------
INSERT INTO `ds_member_senior_cert` VALUES ('2', '1', '/Public/Uploads/cert/1602407356596.jpg', '', '1', '1602407357', '1602645132');
INSERT INTO `ds_member_senior_cert` VALUES ('3', '2', '/Public/Uploads/cert/1602645487773.jpg', '', '1', '1602645488', '1602645502');
INSERT INTO `ds_member_senior_cert` VALUES ('4', '29', '/Public/Uploads/cert/1602834040457.png', '', '1', '1602834044', '1602834249');
INSERT INTO `ds_member_senior_cert` VALUES ('5', '30', '/Public/Uploads/cert/1602839783842.png', '', '1', '1602839784', '1602839792');

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
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_member_sign_in
-- ----------------------------
INSERT INTO `ds_member_sign_in` VALUES ('3', '1', '6.68', '1601054353', '30');
INSERT INTO `ds_member_sign_in` VALUES ('4', '1', '6.62', '1602145213', '30');
INSERT INTO `ds_member_sign_in` VALUES ('5', '2', '3.85', '1602819701', '30');

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
  `id` tinyint(3) unsigned NOT NULL AUTO_INCREMENT,
  `product_name` varchar(30) NOT NULL COMMENT '工厂名称',
  `num` decimal(10,0) NOT NULL COMMENT '消耗ANE数量',
  `period` int(11) NOT NULL COMMENT '锁定周期',
  `status` tinyint(1) NOT NULL DEFAULT '1' COMMENT '开启状态1:开启:0:关闭',
  `logo_url` varchar(255) NOT NULL COMMENT '工厂logo',
  `energy_num` varchar(50) DEFAULT NULL COMMENT '产量',
  `hold_num` int(10) DEFAULT '1' COMMENT '最大可持有数量',
  `return_num` decimal(10,0) DEFAULT NULL COMMENT '总收益',
  `bg_color` varchar(128) DEFAULT NULL COMMENT '背景色',
  `level_one_return_candy` decimal(11,0) DEFAULT NULL COMMENT '一级下线租用返还糖果数量',
  `level_two_return_candy` decimal(11,0) DEFAULT NULL COMMENT '二级下线租用返还糖果数量',
  `sort` tinyint(5) DEFAULT '1' COMMENT '排序',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_product
-- ----------------------------
INSERT INTO `ds_product` VALUES ('1', '新手云空间 (赠)', '1', '730', '0', '/Public/Uploads/20201012/5f833ba79d884.png', '0.3', '1', '20', '#5991fe', '0', '0', '1');
INSERT INTO `ds_product` VALUES ('2', '迷你云空间', '50', '35', '1', '/Public/Uploads/20201012/5f833bb70ed7a.png', '2', '8', '50', '#568bfb', '2', '1', '2');
INSERT INTO `ds_product` VALUES ('3', '微型云空间', '2', '35', '1', '/Public/Uploads/20201012/5f833b91d4aa3.png', '0.3', '4', '50', '#eeae80', '4', '2', '3');
INSERT INTO `ds_product` VALUES ('4', '初级云空间', '50', '35', '1', '/Public/Uploads/20201012/5f833b7f85d93.png', '0.6', '2', '20', '#51c8b5', '20', '10', '4');
INSERT INTO `ds_product` VALUES ('5', '中级云空间', '30', '35', '1', '/Public/Uploads/20201012/5f833b6faad0a.png', '0.2', '2', '15', '#ff79b6', '40', '20', '5');
INSERT INTO `ds_product` VALUES ('6', '高级云空间', '30', '35', '1', '/Public/Uploads/20201012/5f833b5ce85e8.png', '0.2', '2', '11', '#6277ba', '200', '100', '6');
INSERT INTO `ds_product` VALUES ('7', '进阶云空间', '100', '35', '1', '/Public/Uploads/20201012/5f833b3ee1c6d.png', '0.4', '2', '12', '#6dc2f9', '400', '200', '7');
INSERT INTO `ds_product` VALUES ('8', '精英云空间', '50', '35', '1', '/Public/Uploads/20201012/5f833b2d45959.png', '0.5', '2', '0', '#ee73de', '2000', '1000', '8');
INSERT INTO `ds_product` VALUES ('9', '超级云空间', '100', '35', '1', '/Public/Uploads/20201012/5f833a66e4128.png', '0.4', '2', '12', '#f9c650', '4000', '2000', '9');

-- ----------------------------
-- Table structure for `ds_product_receive_record`
-- ----------------------------
DROP TABLE IF EXISTS `ds_product_receive_record`;
CREATE TABLE `ds_product_receive_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `mobile` varchar(50) DEFAULT NULL,
  `receive_time` int(11) DEFAULT NULL COMMENT '领取时间',
  `total_num` decimal(16,2) DEFAULT '0.00' COMMENT '实际收益',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_product_receive_record
-- ----------------------------
INSERT INTO `ds_product_receive_record` VALUES ('1', '1', '18888888888', '1602581972', '17.20');
INSERT INTO `ds_product_receive_record` VALUES ('2', '1', '18888888888', '1602582090', '17.00');
INSERT INTO `ds_product_receive_record` VALUES ('4', '1', '18888888888', '1602611771', '17.00');
INSERT INTO `ds_product_receive_record` VALUES ('5', '2', '15888888888', '1602745257', '2.00');
INSERT INTO `ds_product_receive_record` VALUES ('6', '29', '15179811534', '1602838403', '18.00');
INSERT INTO `ds_product_receive_record` VALUES ('7', '30', '15179811535', '1602839862', '2.00');

-- ----------------------------
-- Table structure for `ds_product_record`
-- ----------------------------
DROP TABLE IF EXISTS `ds_product_record`;
CREATE TABLE `ds_product_record` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL,
  `product_id` int(11) DEFAULT NULL COMMENT '工厂id',
  `period` int(11) DEFAULT NULL COMMENT '锁定天数',
  `is_run` tinyint(5) DEFAULT '0' COMMENT '是否运行 0未退租 1:已退租 ',
  `add_time` int(11) DEFAULT NULL COMMENT '创建时间',
  `last_receive_time` int(11) DEFAULT NULL COMMENT '上次领取时间',
  `receive_time` int(11) DEFAULT NULL COMMENT '领取时间',
  `hold_num` int(1) DEFAULT '1' COMMENT '持有数量',
  `num` decimal(10,0) DEFAULT '0' COMMENT '花费ANE数量',
  `return_num` decimal(10,0) DEFAULT '0' COMMENT '总收益',
  `actual_num` decimal(16,2) DEFAULT '0.00' COMMENT '实际收益',
  `energy_num` decimal(10,1) DEFAULT '0.0' COMMENT '日产量',
  `types` tinyint(6) DEFAULT '1' COMMENT '来源 1购买奖励 2团队奖励 3高级认证奖励',
  `receive_times` varchar(50) DEFAULT '0' COMMENT '领取次数',
  `total_receive_num` decimal(20,2) DEFAULT '0.00' COMMENT '领取总收益',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_product_record
-- ----------------------------
INSERT INTO `ds_product_record` VALUES ('1', '1', '2', '35', '0', '1602509073', null, '1602611771', '8', '50', '50', '16.00', '2.0', '1', '1', '16.00');
INSERT INTO `ds_product_record` VALUES ('2', '1', '3', '35', '0', '1602581584', null, '1602611771', '4', '15', '50', '1.20', '0.3', '1', '1', '1.20');
INSERT INTO `ds_product_record` VALUES ('3', '1', '2', '35', '0', '1602645132', null, null, '1', '50', '50', '0.00', '2.0', '3', '0', '0.00');
INSERT INTO `ds_product_record` VALUES ('4', '2', '2', '35', '0', '1602646094', null, '1602745257', '1', '50', '50', '2.00', '2.0', '3', '1', '2.00');
INSERT INTO `ds_product_record` VALUES ('5', '29', '2', '35', '0', '1602834249', null, '1602838403', '1', '50', '50', '2.00', '2.0', '3', '1', '2.00');
INSERT INTO `ds_product_record` VALUES ('6', '29', '2', '35', '0', '1602838388', null, '1602838403', '8', '50', '50', '16.00', '2.0', '1', '1', '16.00');
INSERT INTO `ds_product_record` VALUES ('7', '30', '2', '35', '0', '1602839792', null, '1602839862', '1', '50', '50', '2.00', '2.0', '3', '1', '2.00');
INSERT INTO `ds_product_record` VALUES ('8', '30', '3', '35', '0', '1602839951', null, null, '4', '2', '50', '0.00', '0.3', '1', '0', '0.00');
INSERT INTO `ds_product_record` VALUES ('9', '30', '3', '35', '0', '1602841024', null, null, '4', '2', '50', '0.00', '0.3', '1', '0', '0.00');
INSERT INTO `ds_product_record` VALUES ('10', '1', '4', '35', '0', '1602841308', null, null, '1', '0', '20', '0.00', '0.6', '2', '0', '0.00');

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
-- Table structure for `ds_role`
-- ----------------------------
DROP TABLE IF EXISTS `ds_role`;
CREATE TABLE `ds_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) DEFAULT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_role
-- ----------------------------
INSERT INTO `ds_role` VALUES ('1', '客服', '客服', '1');
INSERT INTO `ds_role` VALUES ('2', '管理员', '管理员', '1');

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
INSERT INTO `ds_session` VALUES ('sbkn4tojisi2uu7qe9ddes9944', '1602928263', 0x7665726966797C733A33323A223538366639623430333565353939376637373633356231336363303439383463223B69647C733A313A2231223B4B4546555F524F4C455F49447C623A313B5F4143434553535F4C4953547C613A303A7B7D39636230383230643666616137333130363235623762356133303231643034367C623A303B61646D696E757365726E616D657C733A353A2261646D696E223B6C6F6774696D657C733A31393A22323032302D31302D31312031393A30313A3030223B6C6F67696E69707C733A393A223132372E302E302E31223B737570657261646D696E7C623A313B6D69647C733A313A2231223B757365726E616D657C733A31313A223138383838383838383838223B6D656D6265727C733A31313A226D656D6265726C6F67696E223B);
INSERT INTO `ds_session` VALUES ('b9t4c4nco54270b8tgu3mc1an1', '1602917131', '');
INSERT INTO `ds_session` VALUES ('otqkg9m4hiri7u746nml982g83', '1602917139', '');
INSERT INTO `ds_session` VALUES ('oufvqi2t4jq16kv9ckai3366h6', '1602917140', '');
INSERT INTO `ds_session` VALUES ('v68d01rf0up0rabeaqhfov6mn1', '1602927427', 0x6D69647C733A323A223330223B757365726E616D657C733A31313A223135313739383131353335223B6D656D6265727C733A31313A226D656D6265726C6F67696E223B);

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
  `role_id` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM AUTO_INCREMENT=7 DEFAULT CHARSET=utf8 AVG_ROW_LENGTH=256 ROW_FORMAT=DYNAMIC;

-- ----------------------------
-- Records of ds_user
-- ----------------------------
INSERT INTO `ds_user` VALUES ('1', 'admin', 'e10adc3949ba59abbe56e057f20f883e', '1602425453', '127.0.0.1', '0', '0');
INSERT INTO `ds_user` VALUES ('3', 'kefu123', 'e10adc3949ba59abbe56e057f20f883e', '1602216168', '127.0.0.1', '0', '1');
INSERT INTO `ds_user` VALUES ('6', 'kefu2', 'e10adc3949ba59abbe56e057f20f883e', '1602415429', '127.0.0.1', '0', '1');

-- ----------------------------
-- Table structure for `ds_user_ane_log`
-- ----------------------------
DROP TABLE IF EXISTS `ds_user_ane_log`;
CREATE TABLE `ds_user_ane_log` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `num` decimal(20,2) NOT NULL COMMENT '变化的数量',
  `old` decimal(20,2) NOT NULL COMMENT '原来的魔石',
  `new` decimal(20,2) NOT NULL COMMENT '变化后的魔石',
  `remark` varchar(255) NOT NULL COMMENT '备注',
  `types` tinyint(8) NOT NULL DEFAULT '1' COMMENT '1 挖矿奖励 2 买入 3卖出 4 租用空间 5联盟奖励 6联盟分红',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `valid_period` int(11) DEFAULT '0' COMMENT '有效天数',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `type` (`types`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_user_ane_log
-- ----------------------------
INSERT INTO `ds_user_ane_log` VALUES ('1', '1', '-15.00', '582.00', '567.00', '租用空间消耗15ANE', '4', '1602581584', '0');
INSERT INTO `ds_user_ane_log` VALUES ('2', '1', '17.20', '567.00', '584.20', '挖矿奖励17.2ANE', '1', '1602581972', '0');
INSERT INTO `ds_user_ane_log` VALUES ('3', '1', '17.00', '584.20', '601.20', '挖矿奖励17ANE', '1', '1602582090', '0');
INSERT INTO `ds_user_ane_log` VALUES ('4', '1', '17.00', '601.20', '618.20', '挖矿奖励17ANE', '1', '1602611677', '0');
INSERT INTO `ds_user_ane_log` VALUES ('5', '1', '17.00', '618.20', '635.20', '挖矿奖励17ANE', '1', '1602611771', '0');
INSERT INTO `ds_user_ane_log` VALUES ('6', '2', '2.00', '0.00', '2.00', '挖矿奖励2ANE', '1', '1602745257', '0');
INSERT INTO `ds_user_ane_log` VALUES ('9', '1', '2.00', '637.20', '639.20', '联盟分红2联盟积分', '6', '1602819000', '0');
INSERT INTO `ds_user_ane_log` VALUES ('10', '2', '2.00', '4.00', '6.00', '联盟分红2联盟积分', '6', '1602819000', '0');
INSERT INTO `ds_user_ane_log` VALUES ('11', '29', '-50.00', '100.00', '50.00', '租用空间消耗50.0000ANE', '4', '1602838388', '0');
INSERT INTO `ds_user_ane_log` VALUES ('12', '29', '18.00', '50.00', '68.00', '挖矿奖励18ANE', '1', '1602838403', '0');
INSERT INTO `ds_user_ane_log` VALUES ('13', '30', '2.00', '0.00', '2.00', '挖矿奖励2.00ANE', '1', '1602839862', '0');
INSERT INTO `ds_user_ane_log` VALUES ('14', '30', '-2.00', '2.00', '0.00', '租用空间消耗2.0000ANE', '4', '1602839951', '0');
INSERT INTO `ds_user_ane_log` VALUES ('15', '30', '-2.00', '100.00', '98.00', '租用空间消耗2.00ANE', '4', '1602841024', '0');

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
  `types` tinyint(8) NOT NULL DEFAULT '1' COMMENT '1实名奖励 2签到奖励 3联盟奖励 4积分过期5订单奖励 6订单返利',
  `create_time` int(11) NOT NULL COMMENT '创建时间',
  `valid_period` int(11) DEFAULT '0' COMMENT '有效天数',
  PRIMARY KEY (`id`),
  KEY `user_id` (`user_id`) USING BTREE,
  KEY `type` (`types`) USING BTREE
) ENGINE=MyISAM AUTO_INCREMENT=10 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_user_eco_log
-- ----------------------------
INSERT INTO `ds_user_eco_log` VALUES ('3', '1', '6.68', '0.00', '6.68', '签到奖励6.68生态积分', '1', '1601054353', '30');
INSERT INTO `ds_user_eco_log` VALUES ('4', '1', '6.62', '6.68', '13.30', '签到奖励6.62生态积分', '1', '1602145213', '30');
INSERT INTO `ds_user_eco_log` VALUES ('5', '2', '100.00', '0.00', '100.00', '实名奖励100生态积分', '1', '1602645348', '9999');
INSERT INTO `ds_user_eco_log` VALUES ('6', '2', '3.85', '100.00', '103.85', '签到奖励3.85生态积分', '1', '1602819701', '30');
INSERT INTO `ds_user_eco_log` VALUES ('7', '28', '100.00', '0.00', '100.00', '实名奖励100生态积分', '1', '1602832414', '9999');
INSERT INTO `ds_user_eco_log` VALUES ('8', '29', '100.00', '0.00', '100.00', '实名奖励100生态积分', '1', '1602833978', '9999');
INSERT INTO `ds_user_eco_log` VALUES ('9', '30', '100.00', '0.00', '100.00', '实名奖励100生态积分', '1', '1602839744', '9999');

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
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_user_league_log
-- ----------------------------
INSERT INTO `ds_user_league_log` VALUES ('3', '1', '2291.8560', '69016.8244', '71308.6804', '生态分红2291.8560联盟积分', '1', '1602145543');
INSERT INTO `ds_user_league_log` VALUES ('2', '1', '19016.8244', '50000.0000', '69016.8244', '生态分红19016.8244联盟积分', '1', '1601111595');
INSERT INTO `ds_user_league_log` VALUES ('4', '2', '310812.0000', '0.0000', '310812.0000', '生态分红310812.0000联盟积分', '1', '1602680466');

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
  `total_product_receive` decimal(20,4) DEFAULT '0.0000' COMMENT '矿机领取总收益',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of ds_user_statistics
-- ----------------------------
INSERT INTO `ds_user_statistics` VALUES ('1', '1', '3', '0', '1', '0', '4', '68.2000');
INSERT INTO `ds_user_statistics` VALUES ('2', '2', '1', '0', '0', '0', '1', '2.0000');
INSERT INTO `ds_user_statistics` VALUES ('3', '29', '0', '0', '0', '0', '0', '18.0000');
INSERT INTO `ds_user_statistics` VALUES ('4', '30', '0', '0', '0', '0', '0', '2.0000');

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
