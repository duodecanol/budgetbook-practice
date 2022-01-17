/*
SQLyog Community v13.1.8 (64 bit)
MySQL - 5.7.36 : Database - sbb_db
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sbb_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */;

USE `sbb_db`;

/*Table structure for table `account_emailaddress` */

DROP TABLE IF EXISTS `account_emailaddress`;

CREATE TABLE `account_emailaddress` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `verified` tinyint(1) NOT NULL,
  `primary` tinyint(1) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `account_emailaddress_user_id_2c513194_fk_userprofile_user_id` (`user_id`),
  CONSTRAINT `account_emailaddress_user_id_2c513194_fk_userprofile_user_id` FOREIGN KEY (`user_id`) REFERENCES `userprofile_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `account_emailaddress` */

insert  into `account_emailaddress`(`id`,`email`,`verified`,`primary`,`user_id`) values 
(1,'test4@test.com',0,1,5),
(2,'test1@test.com',0,0,2);

/*Table structure for table `account_emailconfirmation` */

DROP TABLE IF EXISTS `account_emailconfirmation`;

CREATE TABLE `account_emailconfirmation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `created` datetime(6) NOT NULL,
  `sent` datetime(6) DEFAULT NULL,
  `key` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_address_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `key` (`key`),
  KEY `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` (`email_address_id`),
  CONSTRAINT `account_emailconfirm_email_address_id_5b7f8c58_fk_account_e` FOREIGN KEY (`email_address_id`) REFERENCES `account_emailaddress` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `account_emailconfirmation` */

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `auth_group` */

/*Table structure for table `auth_group_permissions` */

DROP TABLE IF EXISTS `auth_group_permissions`;

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `auth_group_permissions` */

/*Table structure for table `auth_permission` */

DROP TABLE IF EXISTS `auth_permission`;

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=85 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `auth_permission` */

insert  into `auth_permission`(`id`,`name`,`content_type_id`,`codename`) values 
(1,'Can add log entry',1,'add_logentry'),
(2,'Can change log entry',1,'change_logentry'),
(3,'Can delete log entry',1,'delete_logentry'),
(4,'Can view log entry',1,'view_logentry'),
(5,'Can add permission',2,'add_permission'),
(6,'Can change permission',2,'change_permission'),
(7,'Can delete permission',2,'delete_permission'),
(8,'Can view permission',2,'view_permission'),
(9,'Can add group',3,'add_group'),
(10,'Can change group',3,'change_group'),
(11,'Can delete group',3,'delete_group'),
(12,'Can view group',3,'view_group'),
(13,'Can add content type',4,'add_contenttype'),
(14,'Can change content type',4,'change_contenttype'),
(15,'Can delete content type',4,'delete_contenttype'),
(16,'Can view content type',4,'view_contenttype'),
(17,'Can add session',5,'add_session'),
(18,'Can change session',5,'change_session'),
(19,'Can delete session',5,'delete_session'),
(20,'Can view session',5,'view_session'),
(21,'Can add site',6,'add_site'),
(22,'Can change site',6,'change_site'),
(23,'Can delete site',6,'delete_site'),
(24,'Can view site',6,'view_site'),
(25,'Can add Token',7,'add_token'),
(26,'Can change Token',7,'change_token'),
(27,'Can delete Token',7,'delete_token'),
(28,'Can view Token',7,'view_token'),
(29,'Can add token',8,'add_tokenproxy'),
(30,'Can change token',8,'change_tokenproxy'),
(31,'Can delete token',8,'delete_tokenproxy'),
(32,'Can view token',8,'view_tokenproxy'),
(33,'Can add social application',9,'add_socialapp'),
(34,'Can change social application',9,'change_socialapp'),
(35,'Can delete social application',9,'delete_socialapp'),
(36,'Can view social application',9,'view_socialapp'),
(37,'Can add social account',10,'add_socialaccount'),
(38,'Can change social account',10,'change_socialaccount'),
(39,'Can delete social account',10,'delete_socialaccount'),
(40,'Can view social account',10,'view_socialaccount'),
(41,'Can add social application token',11,'add_socialtoken'),
(42,'Can change social application token',11,'change_socialtoken'),
(43,'Can delete social application token',11,'delete_socialtoken'),
(44,'Can view social application token',11,'view_socialtoken'),
(45,'Can add email address',12,'add_emailaddress'),
(46,'Can change email address',12,'change_emailaddress'),
(47,'Can delete email address',12,'delete_emailaddress'),
(48,'Can view email address',12,'view_emailaddress'),
(49,'Can add email confirmation',13,'add_emailconfirmation'),
(50,'Can change email confirmation',13,'change_emailconfirmation'),
(51,'Can delete email confirmation',13,'delete_emailconfirmation'),
(52,'Can view email confirmation',13,'view_emailconfirmation'),
(53,'Can add user',14,'add_user'),
(54,'Can change user',14,'change_user'),
(55,'Can delete user',14,'delete_user'),
(56,'Can view user',14,'view_user'),
(57,'Can add asset',15,'add_asset'),
(58,'Can change asset',15,'change_asset'),
(59,'Can delete asset',15,'delete_asset'),
(60,'Can view asset',15,'view_asset'),
(61,'Can add Category',16,'add_category'),
(62,'Can change Category',16,'change_category'),
(63,'Can delete Category',16,'delete_category'),
(64,'Can view Category',16,'view_category'),
(65,'Can add Currency',17,'add_currency'),
(66,'Can change Currency',17,'change_currency'),
(67,'Can delete Currency',17,'delete_currency'),
(68,'Can view Currency',17,'view_currency'),
(69,'Can add bank account',18,'add_bankaccount'),
(70,'Can change bank account',18,'change_bankaccount'),
(71,'Can delete bank account',18,'delete_bankaccount'),
(72,'Can view bank account',18,'view_bankaccount'),
(73,'Can add cash',19,'add_cash'),
(74,'Can change cash',19,'change_cash'),
(75,'Can delete cash',19,'delete_cash'),
(76,'Can view cash',19,'view_cash'),
(77,'Can add credit card',20,'add_creditcard'),
(78,'Can change credit card',20,'change_creditcard'),
(79,'Can delete credit card',20,'delete_creditcard'),
(80,'Can view credit card',20,'view_creditcard'),
(81,'Can add transaction',21,'add_transaction'),
(82,'Can change transaction',21,'change_transaction'),
(83,'Can delete transaction',21,'delete_transaction'),
(84,'Can view transaction',21,'view_transaction');

/*Table structure for table `authtoken_token` */

DROP TABLE IF EXISTS `authtoken_token`;

CREATE TABLE `authtoken_token` (
  `key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime(6) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`key`),
  UNIQUE KEY `user_id` (`user_id`),
  CONSTRAINT `authtoken_token_user_id_35299eff_fk_userprofile_user_id` FOREIGN KEY (`user_id`) REFERENCES `userprofile_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `authtoken_token` */

insert  into `authtoken_token`(`key`,`created`,`user_id`) values 
('3cb154026a2408ca5bcff180749e64e787c46593','2022-01-17 11:51:45.878267',5),
('abe36adf7b30e8633dee814b99c13c7d479dd8f1','2022-01-17 11:46:44.936712',2);

/*Table structure for table `budgetbook_asset` */

DROP TABLE IF EXISTS `budgetbook_asset`;

CREATE TABLE `budgetbook_asset` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(65,4) NOT NULL,
  `create_date` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `data` json DEFAULT NULL,
  `owner_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `budgetbook_asset_owner_id_d8e58985_fk_userprofile_user_id` (`owner_id`),
  CONSTRAINT `budgetbook_asset_owner_id_d8e58985_fk_userprofile_user_id` FOREIGN KEY (`owner_id`) REFERENCES `userprofile_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `budgetbook_asset` */

insert  into `budgetbook_asset`(`id`,`deleted_at`,`name`,`amount`,`create_date`,`is_active`,`data`,`owner_id`) values 
(1,NULL,'희망찬 주거래통장',62332120.0000,'2022-01-17 12:31:31.276227',1,NULL,5),
(2,NULL,'해바라기 입출금통장',50000.0000,'2022-01-17 12:37:09.107168',1,NULL,5),
(3,NULL,'좋은카드',0.0000,'2022-01-17 12:39:40.849908',1,NULL,5),
(4,NULL,'보통카드',0.0000,'2022-01-17 12:41:47.392473',1,NULL,5),
(5,NULL,'비상금',500000.0000,'2022-01-17 12:44:16.060316',1,NULL,5);

/*Table structure for table `budgetbook_bankaccount` */

DROP TABLE IF EXISTS `budgetbook_bankaccount`;

CREATE TABLE `budgetbook_bankaccount` (
  `asset_ptr_id` bigint(20) NOT NULL,
  `bank_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `account_number` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_id` bigint(20) NOT NULL,
  PRIMARY KEY (`asset_ptr_id`),
  UNIQUE KEY `account_number` (`account_number`),
  KEY `budgetbook_bankaccou_currency_id_f31198b2_fk_budgetboo` (`currency_id`),
  CONSTRAINT `budgetbook_bankaccou_asset_ptr_id_af1763eb_fk_budgetboo` FOREIGN KEY (`asset_ptr_id`) REFERENCES `budgetbook_asset` (`id`),
  CONSTRAINT `budgetbook_bankaccou_currency_id_f31198b2_fk_budgetboo` FOREIGN KEY (`currency_id`) REFERENCES `budgetbook_currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `budgetbook_bankaccount` */

insert  into `budgetbook_bankaccount`(`asset_ptr_id`,`bank_name`,`account_number`,`currency_id`) values 
(1,'국민은행','3655315-01-1054654',85),
(2,'긴긴은행','21321-01-999999',85);

/*Table structure for table `budgetbook_cash` */

DROP TABLE IF EXISTS `budgetbook_cash`;

CREATE TABLE `budgetbook_cash` (
  `asset_ptr_id` bigint(20) NOT NULL,
  `currency_id` bigint(20) NOT NULL,
  PRIMARY KEY (`asset_ptr_id`),
  KEY `budgetbook_cash_currency_id_0c648fba_fk_budgetbook_currency_id` (`currency_id`),
  CONSTRAINT `budgetbook_cash_asset_ptr_id_82c49cf0_fk_budgetbook_asset_id` FOREIGN KEY (`asset_ptr_id`) REFERENCES `budgetbook_asset` (`id`),
  CONSTRAINT `budgetbook_cash_currency_id_0c648fba_fk_budgetbook_currency_id` FOREIGN KEY (`currency_id`) REFERENCES `budgetbook_currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `budgetbook_cash` */

insert  into `budgetbook_cash`(`asset_ptr_id`,`currency_id`) values 
(5,85);

/*Table structure for table `budgetbook_category` */

DROP TABLE IF EXISTS `budgetbook_category`;

CREATE TABLE `budgetbook_category` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted_at` datetime(6) DEFAULT NULL,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `classification` int(11) NOT NULL,
  `create_date` datetime(6) NOT NULL,
  `last_modified` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `parent_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `budgetbook_category_parent_id_e5ab76bd_fk_budgetbook_category_id` (`parent_id`),
  CONSTRAINT `budgetbook_category_parent_id_e5ab76bd_fk_budgetbook_category_id` FOREIGN KEY (`parent_id`) REFERENCES `budgetbook_category` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `budgetbook_category` */

insert  into `budgetbook_category`(`id`,`deleted_at`,`name`,`description`,`classification`,`create_date`,`last_modified`,`is_active`,`parent_id`) values 
(1,NULL,'생활','생활',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(2,NULL,'온라인쇼핑','veniam consequat adipisicing deserunt',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(3,NULL,'주거/통신','labore qui cillum dolore',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(4,NULL,'한식','amet reprehenderit eiusmod ut',2,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,38),
(5,NULL,'중식','amet reprehenderit eiusmod ut',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,38),
(6,NULL,'일식','amet reprehenderit eiusmod ut',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,38),
(7,NULL,'양식','amet reprehenderit eiusmod ut',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,38),
(8,NULL,'치킨','amet reprehenderit eiusmod ut',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,38),
(9,NULL,'생필품','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,1),
(10,NULL,'편의점','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,1),
(11,NULL,'마트','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,1),
(12,NULL,'생활서비스','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,1),
(13,NULL,'가구/가전','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,1),
(14,NULL,'인터넷쇼핑','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,2),
(15,NULL,'홈쇼핑','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,2),
(16,NULL,'결제/충전','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,2),
(17,NULL,'앱스토어','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,2),
(18,NULL,'서비스구독','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,2),
(19,NULL,'휴대폰','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,3),
(20,NULL,'인터넷','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,3),
(21,NULL,'월세','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,3),
(22,NULL,'관리비','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,3),
(23,NULL,'가스비','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,3),
(24,NULL,'전기세','culpa laboris ut fugiat',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,3),
(25,NULL,'급여','culpa laboris ut fugiat',1,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(26,NULL,'용돈','culpa laboris ut fugiat',1,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(27,NULL,'금융수입','culpa laboris ut fugiat',1,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(28,NULL,'사업수입','culpa laboris ut fugiat',1,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(29,NULL,'기타수입','culpa laboris ut fugiat',1,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(30,NULL,'내계좌이체','culpa laboris ut fugiat',2,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(31,NULL,'이체','culpa laboris ut fugiat',2,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(32,NULL,'카드대금','culpa laboris ut fugiat',2,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(33,NULL,'저축','culpa laboris ut fugiat',2,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(34,NULL,'현금','culpa laboris ut fugiat',2,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(35,NULL,'투자','culpa laboris ut fugiat',2,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(36,NULL,'대출','culpa laboris ut fugiat',2,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(37,NULL,'보험','culpa laboris ut fugiat',2,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL),
(38,NULL,'식비','식비',0,'2022-01-15 16:07:14.310000','2022-01-15 16:07:14.310000',1,NULL);

/*Table structure for table `budgetbook_creditcard` */

DROP TABLE IF EXISTS `budgetbook_creditcard`;

CREATE TABLE `budgetbook_creditcard` (
  `asset_ptr_id` bigint(20) NOT NULL,
  `card_company_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `credit_limit` decimal(65,4) DEFAULT NULL,
  `statement_balance` decimal(65,4) DEFAULT NULL,
  `outstanding_balance` decimal(65,4) DEFAULT NULL,
  `billing_cycle_date` int(11) NOT NULL,
  `currency_id` bigint(20) NOT NULL,
  PRIMARY KEY (`asset_ptr_id`),
  KEY `budgetbook_creditcar_currency_id_b9726378_fk_budgetboo` (`currency_id`),
  CONSTRAINT `budgetbook_creditcar_asset_ptr_id_7337a3b2_fk_budgetboo` FOREIGN KEY (`asset_ptr_id`) REFERENCES `budgetbook_asset` (`id`),
  CONSTRAINT `budgetbook_creditcar_currency_id_b9726378_fk_budgetboo` FOREIGN KEY (`currency_id`) REFERENCES `budgetbook_currency` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `budgetbook_creditcard` */

insert  into `budgetbook_creditcard`(`asset_ptr_id`,`card_company_name`,`credit_limit`,`statement_balance`,`outstanding_balance`,`billing_cycle_date`,`currency_id`) values 
(3,'신항카드',60000.0000,1000.0000,20.0000,10,85),
(4,'온누리카드',60000.0000,1000.0000,20.0000,10,85);

/*Table structure for table `budgetbook_currency` */

DROP TABLE IF EXISTS `budgetbook_currency`;

CREATE TABLE `budgetbook_currency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sign` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `budgetbook_currency` */

insert  into `budgetbook_currency`(`id`,`name`,`code`,`sign`) values 
(1,'Euro','EUR','€'),
(2,'Swiss Franc','CHF','CHF'),
(3,'Hungarian forint','HUF','Ft'),
(4,'Thai baht','THB','฿'),
(5,'Malaysian ringgit','MYR','MYR'),
(6,'Philippine piso','PHP','PHP'),
(7,'United States dollar','USD','$'),
(8,'Japanese yen','JPY','¥'),
(9,'Pound sterling','GBP','£'),
(10,'Bitcoin','BTC','BTC'),
(11,'United Arab Emirates dirham','AED','AED'),
(12,'Afghan afghani','AFN','AFN'),
(13,'Albanian lek','ALL','ALL'),
(14,'Armenian dram','AMD','AMD'),
(15,'Netherlands Antillean guilder','ANG','ANG'),
(16,'Angolan kwanza','AOA','AOA'),
(17,'Argentine peso','ARS','ARS'),
(18,'Australian dollar','AUD','AUD'),
(19,'Aruban florin','AWG','AWG'),
(20,'Azerbaijani manat','AZN','AZN'),
(21,'Bosnia and Herzegovina convertible mark','BAM','BAM'),
(22,'Barbados dollar','BBD','BBD'),
(23,'Bangladeshi taka','BDT','BDT'),
(24,'Bulgarian lev','BGN','BGN'),
(25,'Bahraini dinar','BHD','BHD'),
(26,'Burundian franc','BIF','BIF'),
(27,'Bermudian dollar','BMD','BMD'),
(28,'Brunei dollar','BND','BND'),
(29,'Boliviano','BOB','BOB'),
(30,'Bolivian Mvdol (funds code)','BOV','BOV'),
(31,'Brazilian real','BRL','BRL'),
(32,'Bahamian dollar','BSD','BSD'),
(33,'Bhutanese ngultrum','BTN','BTN'),
(34,'Botswana pula','BWP','BWP'),
(35,'Belarusian ruble','BYN','BYN'),
(36,'Belize dollar','BZD','BZD'),
(37,'Canadian dollar','CAD','CAD'),
(38,'Congolese franc','CDF','CDF'),
(39,'WIR Euro (complementary currency)','CHE','CHE'),
(40,'WIR Franc (complementary currency)','CHW','CHW'),
(41,'Unidad de Fomento (funds code)','CLF','CLF'),
(42,'Chilean peso','CLP','CLP'),
(43,'Chinese yuan','CNY','CNY'),
(44,'Colombian peso','COP','COP'),
(45,'Unidad de Valor Real (UVR) (funds code)[7]','COU','COU'),
(46,'Costa Rican colon','CRC','CRC'),
(47,'Cuban convertible peso','CUC','CUC'),
(48,'Cuban peso','CUP','CUP'),
(49,'Cape Verde escudo','CVE','CVE'),
(50,'Czech koruna','CZK','CZK'),
(51,'Djiboutian franc','DJF','DJF'),
(52,'Danish krone','DKK','DKK'),
(53,'Dominican peso','DOP','DOP'),
(54,'Algerian dinar','DZD','DZD'),
(55,'Egyptian pound','EGP','EGP'),
(56,'Eritrean nakfa','ERN','ERN'),
(57,'Ethiopian birr','ETB','ETB'),
(58,'Fiji dollar','FJD','FJD'),
(59,'Falkland Islands pound','FKP','FKP'),
(61,'Georgian lari','GEL','GEL'),
(62,'Ghanaian cedi','GHS','GHS'),
(63,'Gibraltar pound','GIP','GIP'),
(64,'Gambian dalasi','GMD','GMD'),
(65,'Guinean franc','GNF','GNF'),
(66,'Guatemalan quetzal','GTQ','GTQ'),
(67,'Guyanese dollar','GYD','GYD'),
(68,'Hong Kong dollar','HKD','HKD'),
(69,'Honduran lempira','HNL','HNL'),
(70,'Croatian kuna','HRK','HRK'),
(71,'Haitian gourde','HTG','HTG'),
(72,'Indonesian rupiah','IDR','IDR'),
(73,'Israeli new shekel','ILS','ILS'),
(74,'Indian rupee','INR','INR'),
(75,'Iraqi dinar','IQD','IQD'),
(76,'Iranian rial','IRR','IRR'),
(77,'Icelandic króna','ISK','ISK'),
(78,'Jamaican dollar','JMD','JMD'),
(79,'Jordanian dinar','JOD','JOD'),
(80,'Kenyan shilling','KES','KES'),
(81,'Kyrgyzstani som','KGS','KGS'),
(82,'Cambodian riel','KHR','KHR'),
(83,'Comoro franc','KMF','KMF'),
(84,'North Korean won','KPW','KPW'),
(85,'South Korean won','KRW','₩'),
(86,'Kuwaiti dinar','KWD','KWD'),
(87,'Cayman Islands dollar','KYD','KYD'),
(88,'Kazakhstani tenge','KZT','KZT'),
(89,'Lao kip','LAK','LAK'),
(90,'Lebanese pound','LBP','LBP'),
(91,'Sri Lankan rupee','LKR','LKR'),
(92,'Liberian dollar','LRD','LRD'),
(93,'Lesotho loti','LSL','LSL'),
(94,'Libyan dinar','LYD','LYD'),
(95,'Moroccan dirham','MAD','MAD'),
(96,'Moldovan leu','MDL','MDL'),
(97,'Malagasy ariary','MGA','MGA'),
(98,'Macedonian denar','MKD','MKD'),
(99,'Myanmar kyat','MMK','MMK'),
(100,'Mongolian tögrög','MNT','MNT'),
(101,'Macanese pataca','MOP','MOP'),
(102,'Mauritanian ouguiya','MRO','MRO'),
(103,'Mauritian rupee','MUR','MUR'),
(104,'Maldivian rufiyaa','MVR','MVR'),
(105,'Malawian kwacha','MWK','MWK'),
(106,'Mexican peso','MXN','MXN'),
(107,'Mexican Unidad de Inversion (UDI) (funds code)','MXV','MXV'),
(108,'Mozambican metical','MZN','MZN'),
(109,'Namibian dollar','NAD','NAD'),
(110,'Nigerian naira','NGN','NGN'),
(111,'Nicaraguan córdoba','NIO','NIO'),
(112,'Norwegian krone','NOK','NOK'),
(113,'Nepalese rupee','NPR','NPR'),
(114,'New Zealand dollar','NZD','NZD'),
(115,'Omani rial','OMR','OMR'),
(116,'Panamanian balboa','PAB','PAB'),
(117,'Peruvian Sol','PEN','PEN'),
(118,'Papua New Guinean kina','PGK','PGK'),
(119,'Pakistani rupee','PKR','PKR'),
(120,'Polish złoty','PLN','PLN'),
(121,'Paraguayan guaraní','PYG','PYG'),
(122,'Qatari riyal','QAR','QAR'),
(123,'Romanian leu','RON','RON'),
(124,'Serbian dinar','RSD','RSD'),
(125,'Russian ruble','RUB','RUB'),
(126,'Rwandan franc','RWF','RWF'),
(127,'Saudi riyal','SAR','SAR'),
(128,'Solomon Islands dollar','SBD','SBD'),
(129,'Seychelles rupee','SCR','SCR'),
(130,'Sudanese pound','SDG','SDG'),
(131,'Swedish krona/kronor','SEK','SEK'),
(132,'Singapore dollar','SGD','SGD'),
(133,'Saint Helena pound','SHP','SHP'),
(134,'Sierra Leonean leone','SLL','SLL'),
(135,'Somali shilling','SOS','SOS'),
(136,'Surinamese dollar','SRD','SRD'),
(137,'South Sudanese pound','SSP','SSP'),
(138,'São Tomé and Príncipe dobra','STD','STD'),
(139,'Salvadoran colón','SVC','SVC'),
(140,'Syrian pound','SYP','SYP'),
(141,'Swazi lilangeni','SZL','SZL'),
(142,'Tajikistani somoni','TJS','TJS'),
(143,'Turkmenistan manat','TMT','TMT'),
(144,'Tunisian dinar','TND','TND'),
(145,'Tongan paʻanga','TOP','TOP'),
(146,'Turkish lira','TRY','TRY'),
(147,'Trinidad and Tobago dollar','TTD','TTD'),
(148,'New Taiwan dollar','TWD','TWD'),
(149,'Tanzanian shilling','TZS','TZS'),
(150,'Ukrainian hryvnia','UAH','UAH'),
(151,'Ugandan shilling','UGX','UGX'),
(152,'United States dollar (next day) (funds code)','USN','USN'),
(153,'Uruguay Peso en Unidades Indexadas (URUIURUI) (funds code)','UYI','UYI'),
(154,'Uruguayan peso','UYU','UYU'),
(155,'Uzbekistan som','UZS','UZS'),
(156,'Venezuelan bolívar','VEF','VEF'),
(157,'Vietnamese đồng','VND','VND'),
(158,'Vanuatu vatu','VUV','VUV'),
(159,'Samoan tala','WST','WST'),
(160,'CFA franc BEAC','XAF','XAF'),
(161,'East Caribbean dollar','XCD','XCD'),
(162,'CFA franc BCEAO','XOF','XOF'),
(163,'CFP franc (franc Pacifique)    ','XPF','XPF'),
(164,'Yemeni rial','YER','YER'),
(165,'South African rand','ZAR','ZAR'),
(166,'Zambian kwacha','ZMW','ZMW'),
(167,'Zimbabwean dollar A/10','ZWL','ZWL'),
(168,'Ethereum','ETH','ETH'),
(169,'Dash','DASH','DASH'),
(170,'Bitcoin Cash','BTH','BTH'),
(171,'Stellar Lumen','XLM','XLM'),
(172,'Zcash','ZEC','ZEC'),
(173,'Ripple','XRP','XRP'),
(174,'IOTA','IOT','IOT'),
(175,'Bitcoin Gold','BTG','BTG'),
(176,'Neo','NEO','NEO'),
(177,'Ethereum Classic','ETC','ETC'),
(178,'Litecoin','LTC','LTC'),
(179,'OmiseGO','OMG','OMG');

/*Table structure for table `budgetbook_currency_favorite` */

DROP TABLE IF EXISTS `budgetbook_currency_favorite`;

CREATE TABLE `budgetbook_currency_favorite` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `currency_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `budgetbook_currency_favorite_currency_id_user_id_bf79eab1_uniq` (`currency_id`,`user_id`),
  KEY `budgetbook_currency__user_id_a651df4b_fk_userprofi` (`user_id`),
  CONSTRAINT `budgetbook_currency__currency_id_6e4c9897_fk_budgetboo` FOREIGN KEY (`currency_id`) REFERENCES `budgetbook_currency` (`id`),
  CONSTRAINT `budgetbook_currency__user_id_a651df4b_fk_userprofi` FOREIGN KEY (`user_id`) REFERENCES `userprofile_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `budgetbook_currency_favorite` */

/*Table structure for table `budgetbook_transaction` */

DROP TABLE IF EXISTS `budgetbook_transaction`;

CREATE TABLE `budgetbook_transaction` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `deleted_at` datetime(6) DEFAULT NULL,
  `title` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(65,4) NOT NULL,
  `classification` int(11) NOT NULL,
  `seller` varchar(127) COLLATE utf8mb4_unicode_ci NOT NULL,
  `transaction_datetime` datetime(6) DEFAULT NULL,
  `data` json DEFAULT NULL,
  `create_date` datetime(6) NOT NULL,
  `last_modified` datetime(6) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `category_id` bigint(20) DEFAULT NULL,
  `currency_id` bigint(20) NOT NULL,
  `payment_method_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `budgetbook_transacti_category_id_1e661338_fk_budgetboo` (`category_id`),
  KEY `budgetbook_transacti_currency_id_7b3f6115_fk_budgetboo` (`currency_id`),
  KEY `budgetbook_transacti_payment_method_id_452c9e15_fk_budgetboo` (`payment_method_id`),
  CONSTRAINT `budgetbook_transacti_category_id_1e661338_fk_budgetboo` FOREIGN KEY (`category_id`) REFERENCES `budgetbook_category` (`id`),
  CONSTRAINT `budgetbook_transacti_currency_id_7b3f6115_fk_budgetboo` FOREIGN KEY (`currency_id`) REFERENCES `budgetbook_currency` (`id`),
  CONSTRAINT `budgetbook_transacti_payment_method_id_452c9e15_fk_budgetboo` FOREIGN KEY (`payment_method_id`) REFERENCES `budgetbook_asset` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `budgetbook_transaction` */

/*Table structure for table `django_admin_log` */

DROP TABLE IF EXISTS `django_admin_log`;

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint(5) unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_userprofile_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_userprofile_user_id` FOREIGN KEY (`user_id`) REFERENCES `userprofile_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `django_admin_log` */

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `django_content_type` */

insert  into `django_content_type`(`id`,`app_label`,`model`) values 
(12,'account','emailaddress'),
(13,'account','emailconfirmation'),
(1,'admin','logentry'),
(10,'allauth','socialaccount'),
(9,'allauth','socialapp'),
(11,'allauth','socialtoken'),
(3,'auth','group'),
(2,'auth','permission'),
(7,'authtoken','token'),
(8,'authtoken','tokenproxy'),
(15,'budgetbook','asset'),
(18,'budgetbook','bankaccount'),
(19,'budgetbook','cash'),
(16,'budgetbook','category'),
(20,'budgetbook','creditcard'),
(17,'budgetbook','currency'),
(21,'budgetbook','transaction'),
(4,'contenttypes','contenttype'),
(5,'sessions','session'),
(6,'sites','site'),
(14,'userprofile','user');

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `django_migrations` */

insert  into `django_migrations`(`id`,`app`,`name`,`applied`) values 
(1,'contenttypes','0001_initial','2022-01-17 09:33:16.219368'),
(2,'contenttypes','0002_remove_content_type_name','2022-01-17 09:33:16.393305'),
(3,'auth','0001_initial','2022-01-17 09:33:17.004697'),
(4,'auth','0002_alter_permission_name_max_length','2022-01-17 09:33:17.096220'),
(5,'auth','0003_alter_user_email_max_length','2022-01-17 09:33:17.110205'),
(6,'auth','0004_alter_user_username_opts','2022-01-17 09:33:17.123772'),
(7,'auth','0005_alter_user_last_login_null','2022-01-17 09:33:17.137350'),
(8,'auth','0006_require_contenttypes_0002','2022-01-17 09:33:17.147132'),
(9,'auth','0007_alter_validators_add_error_messages','2022-01-17 09:33:17.160823'),
(10,'auth','0008_alter_user_username_max_length','2022-01-17 09:33:17.175411'),
(11,'auth','0009_alter_user_last_name_max_length','2022-01-17 09:33:17.188989'),
(12,'auth','0010_alter_group_name_max_length','2022-01-17 09:33:17.221901'),
(13,'auth','0011_update_proxy_permissions','2022-01-17 09:33:17.237781'),
(14,'auth','0012_alter_user_first_name_max_length','2022-01-17 09:33:17.251743'),
(15,'userprofile','0001_initial','2022-01-17 09:33:18.106999'),
(16,'account','0001_initial','2022-01-17 09:33:18.535186'),
(17,'account','0002_email_max_length','2022-01-17 09:33:18.585429'),
(18,'admin','0001_initial','2022-01-17 09:33:18.932673'),
(19,'admin','0002_logentry_remove_auto_add','2022-01-17 09:33:18.958012'),
(20,'admin','0003_logentry_add_action_flag_choices','2022-01-17 09:33:18.983471'),
(21,'authtoken','0001_initial','2022-01-17 09:33:19.180120'),
(22,'authtoken','0002_auto_20160226_1747','2022-01-17 09:33:19.230185'),
(23,'authtoken','0003_tokenproxy','2022-01-17 09:33:19.251392'),
(24,'budgetbook','0001_initial','2022-01-17 09:33:20.613750'),
(25,'budgetbook','0002_initial','2022-01-17 09:33:21.579784'),
(26,'sessions','0001_initial','2022-01-17 09:33:21.720246'),
(27,'sites','0001_initial','2022-01-17 09:33:21.824009'),
(28,'sites','0002_alter_domain_unique','2022-01-17 09:33:21.894741');

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `django_session` */

insert  into `django_session`(`session_key`,`session_data`,`expire_date`) values 
('f71sopui0mjzdasj9of2wjluckswyqxs','.eJxVjEEOgjAURO_StSH8X2ipO7kImf7WlEhKIu3KeHfBsNDlvJl5LzWhljTVLT6nOair6tXll3nII-ajwLIcuIHIWnNpvpuz3prbnmIus6DMax7P158qYUu7h5zn0LnIMDIYcAsEJ9xJZ7inAQ5MHJwNlkBttOR15CCkYfW991q9P7ecPCw:1n9RHC:BxVkwcRErz3kBOriUbT44MbLUE-uIFKzK8-YupMJs6I','2022-01-31 12:38:22.585967'),
('fxkg5h6l9sts6lil7krepz0i3o3lqptt','.eJxVjEEOgjAURO_StSH8X2ipO7kImf7WlEhKIu3KeHfBsNDlvJl5LzWhljTVLT6nOair6tXll3nII-ajwLIcuIHIWnNpvpuz3prbnmIus6DMax7P158qYUu7h5zn0LnIMDIYcAsEJ9xJZ7inAQ5MHJwNlkBttOR15CCkYfW991q9P7ecPCw:1n9QY5:2rdniHdEvb6LApruGERMPikCvt7qBifC067tJyN6uYY','2022-01-31 11:51:45.897046');

/*Table structure for table `django_site` */

DROP TABLE IF EXISTS `django_site`;

CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `django_site` */

insert  into `django_site`(`id`,`domain`,`name`) values 
(1,'example.com','example.com');

/*Table structure for table `userprofile_user` */

DROP TABLE IF EXISTS `userprofile_user`;

CREATE TABLE `userprofile_user` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `photo` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `date_of_birth` date DEFAULT NULL,
  `mobile_number` varchar(15) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rrn` varchar(63) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_of_origin` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`),
  UNIQUE KEY `rrn` (`rrn`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `userprofile_user` */

insert  into `userprofile_user`(`id`,`password`,`last_login`,`is_superuser`,`username`,`first_name`,`last_name`,`email`,`is_staff`,`is_active`,`date_joined`,`photo`,`date_of_birth`,`mobile_number`,`rrn`,`country_of_origin`,`location`,`deleted_at`) values 
(1,'pbkdf2_sha256$260000$G8Y19BJoMcZRitwubs5tkV$oa5d4z3TwVYJM11zejO0saKHmpDOPG78VFAEnO7QY84=','2022-01-17 10:47:23.708159',1,'admin@test.com','','','admin@test.com',1,1,'2022-01-17 10:45:23.585972','',NULL,NULL,NULL,NULL,NULL,NULL),
(2,'pbkdf2_sha256$260000$E8gegUAlGWdcs7fbgk8E6b$3I5IzpIe2msT5W57cUa4vWFAc+qU5GiXDcR8yqhTijQ=','2022-01-17 12:03:23.913385',0,'test1@test.com','','','test1@test.com',0,1,'2022-01-17 11:13:04.518602','',NULL,NULL,NULL,NULL,NULL,NULL),
(3,'pbkdf2_sha256$260000$58M5GBgnUMYJoaBKFrxAUQ$9YCfxbzc1B2tMoMLZcIez2jB77gnt9//xZthziOhZZA=',NULL,0,'test2@test.com','','','test2@test.com',0,1,'2022-01-17 11:13:04.620988','',NULL,NULL,NULL,NULL,NULL,NULL),
(4,'pbkdf2_sha256$260000$zSbP6JC95QPZxKQvH4Wo4q$si+qGZxJofugvopaAtPUHQJq4xaG0bXAsH4IijY/8EM=',NULL,0,'test3@test.com','','','test3@test.com',0,1,'2022-01-17 11:13:04.725941','',NULL,NULL,NULL,NULL,NULL,NULL),
(5,'pbkdf2_sha256$260000$6KLlMGBoH9UOXaqg8GezLh$f5fU6WZ0ncngboI35sndWc7/gurgWiS9Yrj+o2IOWOc=','2022-01-17 12:38:22.566430',0,'test4','','','test4@test.com',0,1,'2022-01-17 11:29:33.217456','',NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `userprofile_user_groups` */

DROP TABLE IF EXISTS `userprofile_user_groups`;

CREATE TABLE `userprofile_user_groups` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userprofile_user_groups_user_id_group_id_90ce1781_uniq` (`user_id`,`group_id`),
  KEY `userprofile_user_groups_group_id_c7eec74e_fk_auth_group_id` (`group_id`),
  CONSTRAINT `userprofile_user_groups_group_id_c7eec74e_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `userprofile_user_groups_user_id_5e712a24_fk_userprofile_user_id` FOREIGN KEY (`user_id`) REFERENCES `userprofile_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `userprofile_user_groups` */

/*Table structure for table `userprofile_user_user_permissions` */

DROP TABLE IF EXISTS `userprofile_user_user_permissions`;

CREATE TABLE `userprofile_user_user_permissions` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `userprofile_user_user_pe_user_id_permission_id_706d65c8_uniq` (`user_id`,`permission_id`),
  KEY `userprofile_user_use_permission_id_1caa8a71_fk_auth_perm` (`permission_id`),
  CONSTRAINT `userprofile_user_use_permission_id_1caa8a71_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `userprofile_user_use_user_id_6d654469_fk_userprofi` FOREIGN KEY (`user_id`) REFERENCES `userprofile_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Data for the table `userprofile_user_user_permissions` */

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
