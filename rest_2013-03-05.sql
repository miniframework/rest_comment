# ************************************************************
# Sequel Pro SQL dump
# Version 3408
#
# http://www.sequelpro.com/
# http://code.google.com/p/sequel-pro/
#
# Host: 127.0.0.1 (MySQL 5.6.5-m8)
# Database: rest
# Generation Time: 2013-03-05 04:16:15 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table app
# ------------------------------------------------------------

DROP TABLE IF EXISTS `app`;

CREATE TABLE `app` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(50) NOT NULL DEFAULT '',
  `summary` varchar(140) NOT NULL DEFAULT '',
  `url` varchar(255) NOT NULL DEFAULT '',
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `app` WRITE;
/*!40000 ALTER TABLE `app` DISABLE KEYS */;

INSERT INTO `app` (`id`, `title`, `summary`, `url`, `ctime`)
VALUES
	(16,'sina微薄api','sina 微薄api接口文档','https://api.weibo.com/2',1362455901);

/*!40000 ALTER TABLE `app` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table rest
# ------------------------------------------------------------

DROP TABLE IF EXISTS `rest`;

CREATE TABLE `rest` (
  `id` int(11) unsigned NOT NULL AUTO_INCREMENT,
  `appid` int(11) NOT NULL,
  `api` varchar(100) NOT NULL DEFAULT '',
  `method` char(10) NOT NULL DEFAULT '',
  `comment` varchar(100) NOT NULL DEFAULT '',
  `summary` varchar(250) NOT NULL DEFAULT '',
  `author` varchar(50) NOT NULL DEFAULT '',
  `demo` text NOT NULL,
  `params` text NOT NULL,
  `returns` text NOT NULL,
  `codes` text NOT NULL,
  `ctime` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `rest` WRITE;
/*!40000 ALTER TABLE `rest` DISABLE KEYS */;

INSERT INTO `rest` (`id`, `appid`, `api`, `method`, `comment`, `summary`, `author`, `demo`, `params`, `returns`, `codes`, `ctime`)
VALUES
	(4,16,'/statuses/public_timeline.json','get','返回最新的200条公共微博','返回最新的200条公共微博，返回结果非完全实时','api@sina.com.cn','{\r\n    \"statuses\": [\r\n        {\r\n            \"created_at\": \"Tue May 31 17:46:55 +0800 2011\",\r\n            \"id\": 11488058246,\r\n            \"text\": \"求关注。\",\r\n            \"source\": \"<a href=\"http://weibo.com\" rel=\"nofollow\">新浪微博</a>\",\r\n            \"favorited\": false,\r\n            \"truncated\": false,\r\n            \"in_reply_to_status_id\": \"\",\r\n            \"in_reply_to_user_id\": \"\",\r\n            \"in_reply_to_screen_name\": \"\",\r\n            \"geo\": null,\r\n            \"mid\": \"5612814510546515491\",\r\n            \"reposts_count\": 8,\r\n            \"comments_count\": 9,\r\n            \"annotations\": [],\r\n            \"user\": {\r\n                \"id\": 1404376560,\r\n                \"screen_name\": \"zaku\",\r\n                \"name\": \"zaku\",\r\n                \"province\": \"11\",\r\n                \"city\": \"5\",\r\n                \"location\": \"北京 朝阳区\",\r\n                \"description\": \"人生五十年，乃如梦如幻；有生斯有死，壮士复何憾。\",\r\n                \"url\": \"http://blog.sina.com.cn/zaku\",\r\n                \"profile_image_url\": \"http://tp1.sinaimg.cn/1404376560/50/0/1\",\r\n                \"domain\": \"zaku\",\r\n                \"gender\": \"m\",\r\n                \"followers_count\": 1204,\r\n                \"friends_count\": 447,\r\n                \"statuses_count\": 2908,\r\n                \"favourites_count\": 0,\r\n                \"created_at\": \"Fri Aug 28 00:00:00 +0800 2009\",\r\n                \"following\": false,\r\n                \"allow_all_act_msg\": false,\r\n                \"remark\": \"\",\r\n                \"geo_enabled\": true,\r\n                \"verified\": false,\r\n                \"allow_all_comment\": true,\r\n                \"avatar_large\": \"http://tp1.sinaimg.cn/1404376560/180/0/1\",\r\n                \"verified_reason\": \"\",\r\n                \"follow_me\": false,\r\n                \"online_status\": 0,\r\n                \"bi_followers_count\": 215\r\n            }\r\n        },\r\n        ...\r\n    ],\r\n    \"previous_cursor\": 0,                    // 暂未支持\r\n    \"next_cursor\": 11488013766,     // 暂未支持\r\n    \"total_number\": 81655\r\n}','[{\"descript\": \"\\u91c7\\u7528OAuth\\u6388\\u6743\\u65b9\\u5f0f\\u4e0d\\u9700\\u8981\\u6b64\\u53c2\\u6570\\uff0c\\u5176\\u4ed6\\u6388\\u6743\\u65b9\\u5f0f\\u4e3a\\u5fc5\\u586b\\u53c2\\u6570\\uff0c\\u6570\\u503c\\u4e3a\\u5e94\\u7528\\u7684AppKey\\u3002\", \"required\": \"1\", \"type\": \"string\", \"param\": \"source\"}, {\"descript\": \"\\u91c7\\u7528OAuth\\u6388\\u6743\\u65b9\\u5f0f\\u4e3a\\u5fc5\\u586b\\u53c2\\u6570\\uff0c\\u5176\\u4ed6\\u6388\\u6743\\u65b9\\u5f0f\\u4e0d\\u9700\\u8981\\u6b64\\u53c2\\u6570\\uff0cOAuth\\u6388\\u6743\\u540e\\u83b7\\u5f97\\u3002\", \"required\": \"1\", \"type\": \"string\", \"param\": \"access_token\"}, {\"descript\": \"\\u5355\\u9875\\u8fd4\\u56de\\u7684\\u8bb0\\u5f55\\u6761\\u6570\\uff0c\\u6700\\u5927\\u4e0d\\u8d85\\u8fc7200\\uff0c\\u9ed8\\u8ba4\\u4e3a20\\u3002\", \"required\": \"1\", \"type\": \"int\", \"param\": \"count\"}]','[{\"rdescript\": \"\\u5fae\\u535a\\u521b\\u5efa\\u65f6\\u95f4\", \"rparam\": \"created_at\", \"rtype\": \"string\"}, {\"rdescript\": \"\\u5fae\\u535aID\", \"rparam\": \"id\", \"rtype\": \"int64\"}, {\"rdescript\": \"\\u5fae\\u535aMID\", \"rparam\": \"mid\", \"rtype\": \"int64\"}]','[{\"code\": \"200\", \"codenote\": \"success\"}]',1362456106),
	(5,16,'/friendships/create','post','关注一个用户','支持格式:JSON,需要登录,访问级别：普通接口','api@sina.com.cn','{\r\n    \"id\": 1404376560,\r\n    \"screen_name\": \"zaku\",\r\n    \"name\": \"zaku\",\r\n    \"province\": \"11\",\r\n    \"city\": \"5\",\r\n    \"location\": \"北京 朝阳区\",\r\n    \"description\": \"人生五十年，乃如梦如幻；有生斯有死，壮士复何憾。\",\r\n    \"url\": \"http://blog.sina.com.cn/zaku\",\r\n    \"profile_image_url\": \"http://tp1.sinaimg.cn/1404376560/50/0/1\",\r\n    \"domain\": \"zaku\",\r\n    \"gender\": \"m\",\r\n    \"followers_count\": 1204,\r\n    \"friends_count\": 447,\r\n    \"statuses_count\": 2908,\r\n    \"favourites_count\": 0,\r\n    \"created_at\": \"Fri Aug 28 00:00:00 +0800 2009\",\r\n    \"following\": false,\r\n    \"allow_all_act_msg\": false,\r\n    \"geo_enabled\": true,\r\n    \"verified\": false,\r\n    \"status\": {\r\n        \"created_at\": \"Tue May 24 18:04:53 +0800 2011\",\r\n        \"id\": 11142488790,\r\n        \"text\": \"我的相机到了。\",\r\n        \"source\": \"<a href=\"http://weibo.com\" rel=\"nofollow\">新浪微博</a>\",\r\n        \"favorited\": false,\r\n        \"truncated\": false,\r\n        \"in_reply_to_status_id\": \"\",\r\n        \"in_reply_to_user_id\": \"\",\r\n        \"in_reply_to_screen_name\": \"\",\r\n        \"geo\": null,\r\n        \"mid\": \"5610221544300749636\",\r\n        \"annotations\": [],\r\n        \"reposts_count\": 5,\r\n        \"comments_count\": 8\r\n    },\r\n    \"allow_all_comment\": true,\r\n    \"avatar_large\": \"http://tp1.sinaimg.cn/1404376560/180/0/1\",\r\n    \"verified_reason\": \"\",\r\n    \"follow_me\": false,\r\n    \"online_status\": 0,\r\n    \"bi_followers_count\": 215\r\n}','[{\"descript\": \"\\u9700\\u8981\\u5173\\u6ce8\\u7684\\u7528\\u6237ID\\u3002\", \"required\": \"0\", \"type\": \"int64\", \"param\": \"uid\"}, {\"descript\": \"\\u9700\\u8981\\u5173\\u6ce8\\u7684\\u7528\\u6237\\u6635\\u79f0\\u3002\", \"required\": \"0\", \"type\": \"string\", \"param\": \"screen_name\"}]','[{\"rdescript\": \"\\u7528\\u6237UID\", \"rparam\": \"id\", \"rtype\": \"int64\"}, {\"rdescript\": \"\\u7528\\u6237\\u6240\\u5728\\u7701\\u7ea7ID\", \"rparam\": \"province\", \"rtype\": \"int\"}]','[{\"code\": \"200\", \"codenote\": \"success\"}]',1362456618);

/*!40000 ALTER TABLE `rest` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
