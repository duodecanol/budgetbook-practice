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

/*Table structure for table `auth_group` */

DROP TABLE IF EXISTS `auth_group`;

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

/*Table structure for table `budgetbook_currency` */

DROP TABLE IF EXISTS `budgetbook_currency`;

CREATE TABLE `budgetbook_currency` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  `sign` varchar(6) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=180 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

/*Table structure for table `django_content_type` */

DROP TABLE IF EXISTS `django_content_type`;

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `django_migrations` */

DROP TABLE IF EXISTS `django_migrations`;

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `django_session` */

DROP TABLE IF EXISTS `django_session`;

CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/*Table structure for table `django_site` */

DROP TABLE IF EXISTS `django_site`;

CREATE TABLE `django_site` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_site_domain_a2e37b91_uniq` (`domain`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

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

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
