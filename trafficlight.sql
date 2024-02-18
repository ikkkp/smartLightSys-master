/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 80023
 Source Host           : localhost:3306
 Source Schema         : trafficlight

 Target Server Type    : MySQL
 Target Server Version : 80023
 File Encoding         : 65001

 Date: 18/02/2024 14:04:08
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for file
-- ----------------------------
DROP TABLE IF EXISTS `file`;
CREATE TABLE `file`  (
  `file_id` int NOT NULL AUTO_INCREMENT COMMENT '文件ID',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `abstract_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '概括描述',
  `file_type` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件类型',
  `size` int NULL DEFAULT NULL COMMENT '大小',
  `folder_id` int NULL DEFAULT NULL COMMENT '所属文件夹ID（文件组文件不是null）',
  `preview_picture_object_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'OSS位置 缩略图',
  `preview_pdf_object_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'OSS位置 PDF预览文件',
  `upload_username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上传者',
  `upload_date` datetime NULL DEFAULT NULL COMMENT '上传时间',
  `real_object_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'OSS位置 真实文件',
  `payment_method` int NULL DEFAULT NULL COMMENT '下载付费方式(1-free 2-coin 3-ticket)',
  `payment_amount` int NULL DEFAULT NULL COMMENT '费用',
  `hide_score` double(11, 5) NULL DEFAULT 0.00000 COMMENT '隐藏分（用于排序）',
  `is_approved` tinyint(1) NULL DEFAULT 0 COMMENT '是否已经通过审核（未审核搜索不可见）',
  `is_allow_anon` tinyint(1) NULL DEFAULT 0 COMMENT '文件是否允许匿名访问',
  `is_allow_vipfree` tinyint(1) NULL DEFAULT 0 COMMENT '文件是否允许VIP免费下载（参与分成）',
  `is_allow_comment` tinyint(1) NULL DEFAULT 0 COMMENT '文件是否允许评论',
  `index_string` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '索引字符串（一个文件唯一）',
  `type_id` int NULL DEFAULT NULL COMMENT '文件分类（一个文件分类唯一）',
  PRIMARY KEY (`file_id`) USING BTREE,
  INDEX `upload_username`(`upload_username`) USING BTREE,
  INDEX `folder_id`(`folder_id`) USING BTREE,
  INDEX `type_id`(`type_id`) USING BTREE,
  CONSTRAINT `file_ibfk_1` FOREIGN KEY (`upload_username`) REFERENCES `user` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `file_ibfk_2` FOREIGN KEY (`folder_id`) REFERENCES `file` (`file_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for file_check
-- ----------------------------
DROP TABLE IF EXISTS `file_check`;
CREATE TABLE `file_check`  (
  `file_id` int NOT NULL,
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '是否驳回',
  `notice` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `processing_time` datetime NULL DEFAULT NULL,
  `reject_reason` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '若驳回需填写驳回理由',
  PRIMARY KEY (`file_id`) USING BTREE,
  CONSTRAINT `file_check_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `file` (`file_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for file_extra
-- ----------------------------
DROP TABLE IF EXISTS `file_extra`;
CREATE TABLE `file_extra`  (
  `file_id` int NOT NULL,
  `score` double(11, 1) NULL DEFAULT 5.0,
  `raters_num` int NULL DEFAULT 1,
  `read_num` int NULL DEFAULT 1,
  `like_num` int NULL DEFAULT 0,
  `download_num` int NULL DEFAULT 0,
  `collection_num` int NULL DEFAULT 0,
  `comment_num` int NULL DEFAULT 0,
  `is_pro_cert` tinyint NULL DEFAULT 0,
  `is_official` tinyint NULL DEFAULT 0,
  `is_vip_income` tinyint NULL DEFAULT 0,
  `is_original` tinyint NULL DEFAULT NULL,
  `original_author` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `copyright_notice` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '',
  `dislike_num` int NULL DEFAULT 0,
  PRIMARY KEY (`file_id`) USING BTREE,
  CONSTRAINT `file_extra_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `file` (`file_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for file_index_group
-- ----------------------------
DROP TABLE IF EXISTS `file_index_group`;
CREATE TABLE `file_index_group`  (
  `group_id` int NOT NULL AUTO_INCREMENT COMMENT '组ID',
  `group_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组名',
  `is_forever` tinyint NOT NULL COMMENT '是否永久固定',
  `show_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示位置',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图标（当显示位置为Top生效）',
  `extra_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '额外描述',
  `include_tag` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '为空则在检索type不筛选tag',
  `include_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '为空显示index子节点下全部的类型',
  `include_index` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '为空则检索时需要用户自行提供/自行选择',
  PRIMARY KEY (`group_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for file_search
-- ----------------------------
DROP TABLE IF EXISTS `file_search`;
CREATE TABLE `file_search`  (
  `file_id` int NOT NULL,
  `content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `keyword` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`file_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for file_tag
-- ----------------------------
DROP TABLE IF EXISTS `file_tag`;
CREATE TABLE `file_tag`  (
  `tag_id` int NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `add_time` datetime NULL DEFAULT NULL,
  `add_username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_base` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for file_tag_map
-- ----------------------------
DROP TABLE IF EXISTS `file_tag_map`;
CREATE TABLE `file_tag_map`  (
  `tag_map_id` int NOT NULL AUTO_INCREMENT,
  `file_id` int NOT NULL,
  `tag_id` int NOT NULL,
  PRIMARY KEY (`tag_map_id`) USING BTREE,
  INDEX `file_id`(`file_id`) USING BTREE,
  INDEX `tag_id`(`tag_id`) USING BTREE,
  CONSTRAINT `file_tag_map_ibfk_1` FOREIGN KEY (`file_id`) REFERENCES `file` (`file_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `file_tag_map_ibfk_2` FOREIGN KEY (`tag_id`) REFERENCES `file_tag` (`tag_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for file_type
-- ----------------------------
DROP TABLE IF EXISTS `file_type`;
CREATE TABLE `file_type`  (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for file_upload_temp
-- ----------------------------
DROP TABLE IF EXISTS `file_upload_temp`;
CREATE TABLE `file_upload_temp`  (
  `upload_id` int NOT NULL AUTO_INCREMENT COMMENT '文件上传临时ID',
  `title` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '标题',
  `size` int NULL DEFAULT NULL COMMENT '大小',
  `file_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'OSS位置 真实文件',
  `file_suffix` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件类型',
  `preview_pdf_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'OSS位置 PDF预览文件',
  `upload_username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上传者',
  `upload_date` datetime NULL DEFAULT NULL COMMENT '上传时间',
  `upload_app` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '上传应用（微信/App/Web/QQ）',
  `is_available` tinyint NULL DEFAULT NULL COMMENT '当前是否有效',
  PRIMARY KEY (`upload_id`) USING BTREE,
  INDEX `upload_username`(`upload_username`) USING BTREE,
  CONSTRAINT `file_upload_temp_ibfk_1` FOREIGN KEY (`upload_username`) REFERENCES `user` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for light
-- ----------------------------
DROP TABLE IF EXISTS `light`;
CREATE TABLE `light`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `lng` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `lat` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `location` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  `name` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for lights
-- ----------------------------
DROP TABLE IF EXISTS `lights`;
CREATE TABLE `lights`  (
  `id` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `idmsg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for note
-- ----------------------------
DROP TABLE IF EXISTS `note`;
CREATE TABLE `note`  (
  `note_id` int NULL DEFAULT NULL,
  `note_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `like_num` int NULL DEFAULT NULL,
  `comment_num` int NULL DEFAULT NULL,
  `read_num` int NULL DEFAULT NULL,
  `refresh_date` datetime NULL DEFAULT NULL,
  `build_date` datetime NULL DEFAULT NULL,
  `build_username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_anon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_approved` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_allow_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for note_type
-- ----------------------------
DROP TABLE IF EXISTS `note_type`;
CREATE TABLE `note_type`  (
  `type_id` int NOT NULL,
  `type_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `type_icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`type_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for tip_off
-- ----------------------------
DROP TABLE IF EXISTS `tip_off`;
CREATE TABLE `tip_off`  (
  `tip_off_id` int NOT NULL,
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `target_id` int NULL DEFAULT NULL,
  `target_type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `build_username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `build_date` datetime NULL DEFAULT NULL,
  `is_approved` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `notice` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `processing_time` datetime NULL DEFAULT NULL,
  PRIMARY KEY (`tip_off_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `nickname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `phone_num` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_valid` tinyint(1) NOT NULL,
  `reg_date` datetime NOT NULL,
  `role` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '身份',
  `student_id` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '校园第三方登录',
  `realname` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `level_grade` int NOT NULL DEFAULT 0,
  `cert_id` int NULL DEFAULT NULL,
  `email` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`username`) USING BTREE,
  INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for user_certification
-- ----------------------------
DROP TABLE IF EXISTS `user_certification`;
CREATE TABLE `user_certification`  (
  `cert_id` int NOT NULL,
  `cert_name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `cert_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  PRIMARY KEY (`cert_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for user_extra
-- ----------------------------
DROP TABLE IF EXISTS `user_extra`;
CREATE TABLE `user_extra`  (
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `college` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `major` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `birthday` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `sex` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `personal_signature` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `like_num` int NULL DEFAULT NULL,
  `file_collected_num` int NULL DEFAULT NULL,
  PRIMARY KEY (`username`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users`  (
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `user_passport` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `timestamp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for wallet
-- ----------------------------
DROP TABLE IF EXISTS `wallet`;
CREATE TABLE `wallet`  (
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `coin` int NOT NULL DEFAULT 0,
  `exp` int NOT NULL DEFAULT 0,
  `ticket` int NOT NULL DEFAULT 0,
  `is_vip` tinyint NOT NULL DEFAULT 0,
  `vip_valid_date` datetime NULL DEFAULT NULL,
  INDEX `username`(`username`) USING BTREE,
  CONSTRAINT `wallet_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for wallet_change_record
-- ----------------------------
DROP TABLE IF EXISTS `wallet_change_record`;
CREATE TABLE `wallet_change_record`  (
  `username` varchar(32) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `item_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `change_num` int NOT NULL,
  `reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  `pay_file_id` int NULL DEFAULT NULL,
  `time` datetime NULL DEFAULT NULL,
  INDEX `username`(`username`) USING BTREE,
  CONSTRAINT `wallet_change_record_ibfk_1` FOREIGN KEY (`username`) REFERENCES `user` (`username`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Triggers structure for table file
-- ----------------------------
DROP TRIGGER IF EXISTS `new_check`;
delimiter ;;
CREATE TRIGGER `new_check` AFTER INSERT ON `file` FOR EACH ROW INSERT INTO file_check VALUES (new.file_id,0,NULL,NULL,NULL)
;
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table file_check
-- ----------------------------
DROP TRIGGER IF EXISTS `auto_approved`;
delimiter ;;
CREATE TRIGGER `auto_approved` AFTER UPDATE ON `file_check` FOR EACH ROW UPDATE file SET file.is_approved = new.`status` WHERE file.file_id = new.file_id
;
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table file_extra
-- ----------------------------
DROP TRIGGER IF EXISTS `hide_score`;
delimiter ;;
CREATE TRIGGER `hide_score` AFTER UPDATE ON `file_extra` FOR EACH ROW UPDATE file SET hide_score = ( SELECT ((score/raters_num)*ATAN(raters_num/50)/5)*(like_num/20 + download_num/20 + read_num/50) FROM file_extra WHERE file_extra.file_id = new.file_id ) WHERE file.file_id = new.file_id
;
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table user
-- ----------------------------
DROP TRIGGER IF EXISTS `add_wallet`;
delimiter ;;
CREATE TRIGGER `add_wallet` AFTER INSERT ON `user` FOR EACH ROW INSERT INTO wallet VALUES (new.username,10,10,1,0,null)
;
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table user
-- ----------------------------
DROP TRIGGER IF EXISTS `add_extra`;
delimiter ;;
CREATE TRIGGER `add_extra` AFTER INSERT ON `user` FOR EACH ROW INSERT INTO user_extra VALUES (new.username,null,null,null,null,null,0,0)
;
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
