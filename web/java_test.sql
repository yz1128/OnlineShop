/*
 Navicat Premium Data Transfer

 Source Server         : localhost_3306
 Source Server Type    : MySQL
 Source Server Version : 80036
 Source Host           : localhost:3306
 Source Schema         : java_test

 Target Server Type    : MySQL
 Target Server Version : 80036
 File Encoding         : 65001

 Date: 06/05/2024 14:40:23
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cart
-- ----------------------------
DROP TABLE IF EXISTS `cart`;
CREATE TABLE `cart`  (
  `cartId` int NOT NULL AUTO_INCREMENT COMMENT '购物车编号',
  `goodsName` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '商品名称',
  `userName` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户姓名',
  `factory` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '生产厂家',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '图片',
  `unitPrice` decimal(10, 2) NOT NULL COMMENT '商品单价',
  `Numb` int NOT NULL COMMENT '下单数量',
  `userId` int NOT NULL,
  PRIMARY KEY (`cartId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 144 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cart
-- ----------------------------

-- ----------------------------
-- Table structure for goods
-- ----------------------------
DROP TABLE IF EXISTS `goods`;
CREATE TABLE `goods`  (
  `goodsId` int NOT NULL AUTO_INCREMENT COMMENT '商品编号',
  `goodsName` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '商品名称',
  `category` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '商品分类',
  `unitPrice` decimal(10, 2) NOT NULL COMMENT '商品单价',
  `stock` int NOT NULL COMMENT '商品库存',
  `factory` varchar(100) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '生产厂家',
  `image` varchar(255) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '商品封面',
  `details` text CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NULL COMMENT '商品详情',
  `viewCount` int NOT NULL DEFAULT 0 COMMENT '人们观看该商品的次数',
  `goodsState` int NOT NULL DEFAULT 0 COMMENT '商品当前状态：上架为0，下架为1',
  `addTime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '商品上架时间',
  `updataTime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  PRIMARY KEY (`goodsId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of goods
-- ----------------------------
INSERT INTO `goods` VALUES (1, 'iPhone17 Pro Max', '1', 999999.00, 999, 'Apple', '12.jpg', '12+1t 远峰蓝', 0, 1, '2024-04-28 10:16:49', '2024-04-28 10:16:49');
INSERT INTO `goods` VALUES (2, '82年可乐', '5', 200.00, 10, '可口可乐', 'Coke.jpg', '99成稀罕物儿', 35, 0, '2024-04-28 10:16:49', '2024-04-28 10:16:49');
INSERT INTO `goods` VALUES (3, '99年秘密文档', '4', 99999999.00, 1, '时空档案局', 'register_bg.jpg', '99年的事要暴露了吗？', 34, 0, '2024-04-27 23:46:01', '2024-04-27 23:46:01');
INSERT INTO `goods` VALUES (4, '小米12S Pro', '1', 3500.00, 69, 'Xiaomi', 'mi12SP.png', '12+256', 21, 0, '2024-04-27 23:46:01', '2024-04-27 23:46:01');
INSERT INTO `goods` VALUES (5, '小米13', '1', 4500.00, 300, 'Xiaomi', 'mi13.png', '12+512', 15, 0, '2024-04-27 23:46:01', '2024-04-27 23:46:01');
INSERT INTO `goods` VALUES (6, '小米13 Ultra', '1', 4500.00, 300, 'Xiaomi', 'mi13U.png', '12+256', 53, 0, '2024-04-27 23:46:01', '2024-04-27 23:46:01');
INSERT INTO `goods` VALUES (7, '小米14', '1', 4500.00, 350, 'Xiaomi', 'mi14.png', '12+256', 15, 0, '2024-04-27 23:46:01', '2024-04-27 23:46:01');
INSERT INTO `goods` VALUES (8, '小米14 Ultra', '1', 4500.00, 99, 'Xiaomi', 'mi14U.png', '12+512', 24, 0, '2024-04-27 23:46:01', '2024-04-27 23:46:01');
INSERT INTO `goods` VALUES (9, '小米pad5', '2', 3500.00, 350, 'Xiaomi', 'mipad5.png', '12+256', 5, 0, '2024-04-27 23:46:01', '2024-04-27 23:46:01');
INSERT INTO `goods` VALUES (10, '小米pad5 Pro', '2', 3500.00, 350, 'Xiaomi', 'mipad5P.png', '12+512', 78, 0, '2024-04-27 23:46:01', '2024-04-27 23:46:01');
INSERT INTO `goods` VALUES (11, '小米pad6 ', '2', 3500.00, 210, 'Xiaomi', 'mipad6.png', '12+256', 64, 0, '2024-04-27 23:46:01', '2024-04-27 23:46:01');
INSERT INTO `goods` VALUES (12, '小米pad6 Max', '2', 4500.00, 210, 'Xiaomi', 'mipad6Max.jpg', '12+512', 21, 0, '2024-04-27 23:46:01', '2024-04-27 23:46:01');
INSERT INTO `goods` VALUES (13, '小米pad6S Pro', '2', 4500.00, 85, 'Xiaomi', 'mipad6SP.png', '12+512', 15, 0, '2024-04-27 23:46:01', '2024-04-27 23:46:01');
INSERT INTO `goods` VALUES (14, '红米pad', '2', 4500.00, 200, 'Xiaomi', 'Rmipad.png', '12+256', 21, 0, '2024-04-27 23:46:01', '2024-04-27 23:46:01');
INSERT INTO `goods` VALUES (15, '小米 原装充电头', '4', 50.00, 200, 'Xiaomi', '充电头.jpg', '小米 原装充电头', 45, 0, '2024-04-27 23:46:01', '2024-04-27 23:46:01');
INSERT INTO `goods` VALUES (16, '小米 原装USB-C数据线', '4', 50.00, 300, 'Xiaomi', 'USB-C数据线.jpg', '6A充电线白色', 10, 0, '2024-04-27 23:46:01', '2024-04-27 23:46:01');
INSERT INTO `goods` VALUES (17, '小米Xiaomi 14 Ultra 专业影像套装', '4', 1200.00, 300, 'Xiaomi', 'yingxiang.jpg', '-黑色', 78, 0, '2024-04-27 23:46:01', '2024-04-27 23:46:01');

-- ----------------------------
-- Table structure for order
-- ----------------------------
DROP TABLE IF EXISTS `order`;
CREATE TABLE `order`  (
  `orderId` int NOT NULL AUTO_INCREMENT COMMENT '订单编号',
  `userId` int NOT NULL COMMENT '下单用户id',
  `totalPrice` decimal(10, 2) NOT NULL COMMENT '订单中商品总价',
  `orderState` int NOT NULL DEFAULT 0 COMMENT '0未付款，1已支付，2已发货，3订单取消',
  `userAddress` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '收货地址',
  `receiptName` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '收件人',
  `creationTime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '订单创建时间',
  `payTime` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '订单支付时间',
  PRIMARY KEY (`orderId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9587 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of order
-- ----------------------------
INSERT INTO `order` VALUES (1970, 15, 3700.00, 0, '45354', 'Yanz', '2024-05-06 14:39:37', '2024-05-06 14:39:37');
INSERT INTO `order` VALUES (6742, 1, 1450.00, 0, '452312', 'admin', '2024-05-06 14:39:40', '2024-05-06 14:39:40');
INSERT INTO `order` VALUES (8458, 1, 50.00, 0, '543453', 'admin', '2024-05-06 14:39:48', '2024-05-06 14:39:48');

-- ----------------------------
-- Table structure for orderdetail
-- ----------------------------
DROP TABLE IF EXISTS `orderdetail`;
CREATE TABLE `orderdetail`  (
  `orderId` int NOT NULL COMMENT '订单编号',
  `userId` int NOT NULL COMMENT '下单用户id',
  `goodsId` int NOT NULL COMMENT '商品编号',
  `orderNumb` int NOT NULL COMMENT '下单数量'
) ENGINE = InnoDB CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orderdetail
-- ----------------------------
INSERT INTO `orderdetail` VALUES (6742, 1, 2, 1);
INSERT INTO `orderdetail` VALUES (6742, 1, 15, 1);
INSERT INTO `orderdetail` VALUES (6742, 1, 17, 1);
INSERT INTO `orderdetail` VALUES (8458, 1, 15, 1);
INSERT INTO `orderdetail` VALUES (1970, 15, 4, 1);
INSERT INTO `orderdetail` VALUES (1970, 15, 2, 1);

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userId` int NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `userName` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户姓名',
  `userPassword` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户密码',
  `userEmail` varchar(30) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL DEFAULT '18' COMMENT '用户邮箱',
  `userAddress` varchar(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户地址',
  `userPhone` varchar(25) CHARACTER SET utf8mb3 COLLATE utf8mb3_general_ci NOT NULL COMMENT '用户手机号',
  `power` int NOT NULL DEFAULT 0 COMMENT '用户权限 （默认为0）（0为普通用户，1为管理员）',
  `balance` decimal(10, 2) NOT NULL DEFAULT 0.00 COMMENT '账户余额',
  PRIMARY KEY (`userId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb3 COLLATE = utf8mb3_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'admin', 'admin', '1364587971@qq.com', '河南省', '12545789654', 1, 4500.00);
INSERT INTO `user` VALUES (2, 'zhangsan', '123456', '1234@qq.com', '阿美利卡', '15478565754', 0, 0.00);
INSERT INTO `user` VALUES (14, 'admina', '123', '15435472@qq.com', 'local', '11235878451', 0, 0.00);
INSERT INTO `user` VALUES (15, 'Yanz', '123456', '86876786@qq.com', '梵蒂冈', '13587586951', 1, 96300.00);
INSERT INTO `user` VALUES (16, 'ads', '123456', '78978982@qq.com', '123', '13245612311', 0, 0.00);

SET FOREIGN_KEY_CHECKS = 1;
