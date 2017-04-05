-- mysqldump-php https://github.com/ifsnop/mysqldump-php
--
-- Host: localhost	Database: tilstaelsen_craft
-- ------------------------------------------------------
-- Server version 	5.6.28
-- Date: Wed, 05 Apr 2017 21:08:48 +0000

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
-- Table structure for table `craft_amnav_navs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_amnav_navs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_amnav_navs_handle_unq_idx` (`handle`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_amnav_navs`
--

LOCK TABLES `craft_amnav_navs` WRITE;
/*!40000 ALTER TABLE `craft_amnav_navs` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_amnav_navs` VALUES (1,'Navigasjon','navigasjon','{\"entrySources\":\"*\",\"maxLevels\":\"\",\"canMoveFromLevel\":\"\",\"canDeleteFromLevel\":\"\"}','2017-03-29 14:03:49','2017-03-29 14:03:49','a1874241-9efe-446e-92d9-19cd52287111');
/*!40000 ALTER TABLE `craft_amnav_navs` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_amnav_nodes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_amnav_nodes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `navId` int(11) NOT NULL,
  `parentId` int(11) DEFAULT NULL,
  `order` int(11) DEFAULT '0',
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `listClass` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `blank` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `elementId` int(11) DEFAULT NULL,
  `elementType` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_amnav_nodes_elementId_elementType_locale_idx` (`elementId`,`elementType`,`locale`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_amnav_nodes`
--

LOCK TABLES `craft_amnav_nodes` WRITE;
/*!40000 ALTER TABLE `craft_amnav_nodes` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_amnav_nodes` VALUES (1,1,0,0,'Hjem',NULL,'',0,1,2,'Entry','nb_no','2017-03-29 14:04:12','2017-04-03 13:23:00','d6ff82d4-26c9-48da-a8d7-a1808f38a573'),(2,1,0,1,'Historien',NULL,NULL,0,1,3,'Entry','nb_no','2017-03-29 14:04:17','2017-04-05 21:08:43','b9ffa9af-60b6-4caf-907b-03589fc8a18f'),(3,1,0,2,'Publisert',NULL,NULL,0,1,4,'Entry','nb_no','2017-03-29 14:04:19','2017-04-03 14:56:59','00a4ccb7-2ab2-452e-93d5-633690225d45'),(4,1,0,3,'Journalistene',NULL,NULL,0,1,5,'Entry','nb_no','2017-03-29 14:04:21','2017-03-29 14:04:21','f18f2649-c4e2-441e-95c1-ad45db782aa6');
/*!40000 ALTER TABLE `craft_amnav_nodes` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_assetfiles`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetfiles` (
  `id` int(11) NOT NULL,
  `sourceId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `kind` varchar(50) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetfiles_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `craft_assetfiles_sourceId_fk` (`sourceId`),
  KEY `craft_assetfiles_folderId_fk` (`folderId`),
  CONSTRAINT `craft_assetfiles_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `craft_assetfolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assetfiles_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assetfiles_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_assetsources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assetfiles`
--

LOCK TABLES `craft_assetfiles` WRITE;
/*!40000 ALTER TABLE `craft_assetfiles` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_assetfiles` VALUES (6,1,1,'Drapsmannen_15l.jpg','image',1798,1200,882147,'2017-03-30 13:10:45','2017-03-30 13:10:45','2017-03-30 13:10:45','d09352fc-9b25-4300-9a9b-3a208e4e8b1c'),(7,1,1,'Drapsmannen_16.jpg','image',760,507,221749,'2017-03-30 13:10:46','2017-03-30 13:10:46','2017-03-30 13:10:46','9ebe4773-517b-4082-8b6f-740db626598d'),(8,1,1,'Nidarvoll_01.jpg','image',760,541,154355,'2017-03-30 13:10:46','2017-03-30 13:10:46','2017-03-30 13:10:46','a2f48d1d-69e2-4f0a-bcfa-cef2279613b9'),(9,1,1,'Stavne_sletta_03.jpg','image',760,541,316023,'2017-03-30 13:10:47','2017-03-30 13:10:47','2017-03-30 13:10:47','a3bb88c1-e46c-4150-96d2-6fc1fbfcf778');
/*!40000 ALTER TABLE `craft_assetfiles` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_assetfolders`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetfolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `sourceId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetfolders_name_parentId_sourceId_unq_idx` (`name`,`parentId`,`sourceId`),
  KEY `craft_assetfolders_parentId_fk` (`parentId`),
  KEY `craft_assetfolders_sourceId_fk` (`sourceId`),
  CONSTRAINT `craft_assetfolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `craft_assetfolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_assetfolders_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_assetsources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assetfolders`
--

LOCK TABLES `craft_assetfolders` WRITE;
/*!40000 ALTER TABLE `craft_assetfolders` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_assetfolders` VALUES (1,NULL,1,'Bilder','','2015-10-23 11:09:33','2015-10-23 11:09:33','f3142658-3fb9-4b94-92e5-763bed9dc7d7');
/*!40000 ALTER TABLE `craft_assetfolders` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_assetindexdata`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '',
  `sourceId` int(10) NOT NULL,
  `offset` int(10) NOT NULL,
  `uri` text COLLATE utf8_unicode_ci,
  `size` bigint(20) unsigned DEFAULT NULL,
  `recordId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetindexdata_sessionId_sourceId_offset_unq_idx` (`sessionId`,`sourceId`,`offset`),
  KEY `craft_assetindexdata_sourceId_fk` (`sourceId`),
  CONSTRAINT `craft_assetindexdata_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_assetsources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assetindexdata`
--

LOCK TABLES `craft_assetindexdata` WRITE;
/*!40000 ALTER TABLE `craft_assetindexdata` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_assetindexdata` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_assetsources`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assetsources` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `fieldLayoutId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assetsources_name_unq_idx` (`name`),
  UNIQUE KEY `craft_assetsources_handle_unq_idx` (`handle`),
  KEY `craft_assetsources_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_assetsources_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assetsources`
--

LOCK TABLES `craft_assetsources` WRITE;
/*!40000 ALTER TABLE `craft_assetsources` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_assetsources` VALUES (1,'Bilder','bilder','Local','{\"path\":\"dynamic\\/upload\\/bilder\\/\",\"publicURLs\":\"1\",\"url\":\"{cdnUrl}dynamic\\/upload\\/bilder\\/\"}',1,35,'2015-10-23 11:09:33','2016-06-08 08:27:39','5d69cfc0-d339-4cdc-a766-5021734e479a');
/*!40000 ALTER TABLE `craft_assetsources` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_assettransformindex`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fileId` int(11) NOT NULL,
  `filename` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `format` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `location` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sourceId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT NULL,
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_assettransformindex_sourceId_fileId_location_idx` (`sourceId`,`fileId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assettransformindex`
--

LOCK TABLES `craft_assettransformindex` WRITE;
/*!40000 ALTER TABLE `craft_assettransformindex` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_assettransformindex` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_assettransforms`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `mode` enum('stretch','fit','crop') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'center-center',
  `height` int(10) DEFAULT NULL,
  `width` int(10) DEFAULT NULL,
  `format` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `quality` int(10) DEFAULT NULL,
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `craft_assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_assettransforms`
--

LOCK TABLES `craft_assettransforms` WRITE;
/*!40000 ALTER TABLE `craft_assettransforms` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_assettransforms` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_categories`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_categories_groupId_fk` (`groupId`),
  CONSTRAINT `craft_categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categories_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_categories`
--

LOCK TABLES `craft_categories` WRITE;
/*!40000 ALTER TABLE `craft_categories` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_categories` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_categorygroups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hasUrls` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `template` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `craft_categorygroups_handle_unq_idx` (`handle`),
  KEY `craft_categorygroups_structureId_fk` (`structureId`),
  KEY `craft_categorygroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_categorygroups`
--

LOCK TABLES `craft_categorygroups` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_categorygroups` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_categorygroups_i18n`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_categorygroups_i18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `urlFormat` text COLLATE utf8_unicode_ci,
  `nestedUrlFormat` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_categorygroups_i18n_groupId_locale_unq_idx` (`groupId`,`locale`),
  KEY `craft_categorygroups_i18n_locale_fk` (`locale`),
  CONSTRAINT `craft_categorygroups_i18n_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_categorygroups_i18n_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_categorygroups_i18n`
--

LOCK TABLES `craft_categorygroups_i18n` WRITE;
/*!40000 ALTER TABLE `craft_categorygroups_i18n` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_categorygroups_i18n` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_content`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `title` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_fokuspunkt` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_alt` text COLLATE utf8_unicode_ci,
  `field_rikTekst` text COLLATE utf8_unicode_ci,
  `field_posisjonBilde` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `field_tekst` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_content_elementId_locale_unq_idx` (`elementId`,`locale`),
  KEY `craft_content_title_idx` (`title`),
  KEY `craft_content_locale_fk` (`locale`),
  CONSTRAINT `craft_content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_content_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_content`
--

LOCK TABLES `craft_content` WRITE;
/*!40000 ALTER TABLE `craft_content` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_content` VALUES (1,1,'nb_no',NULL,NULL,NULL,NULL,NULL,0,'2014-10-08 10:49:48','2017-04-03 14:50:05','22bdfcbe-634e-4e2b-aa58-5153c4ae4ef9'),(2,2,'nb_no','Forside',NULL,NULL,'<h1>Tilståelsen</h1><p>Like før jul i 2005 ble det gjennom media kjent at en person i Trøndelag, Tor Hepsø, kort tid før han avgikk ved døden 20. desember 2005, skulle ha erkjent å stå bak drapene på Sigrid Heggheim og Torunn Finstad. De samme drapene døvstumme Fritz Moen hadde sonet 18 år i fengsel for.<br /></p>',NULL,0,'2017-03-29 14:00:56','2017-04-03 13:23:00','058ef4c7-1153-411e-b78e-9c5626e02681'),(3,3,'nb_no','Historien',NULL,NULL,'<p><b>Historien bak tilståelsen</b></p><p><img src=\"{asset:8:url}\" alt=\"Nidarvoll_01.jpg#asset:8\" />11.September 1976 ble Sigrid Heggheim (20) fra Jølster funnet drept på et jorde på Nidarvoll i Trondheim. Sigrid var ny i  i byen og ble sist sett på Studentersamfundet kvelden 4. september.<br /></p>',NULL,0,'2017-03-29 14:01:55','2017-04-05 21:08:43','c6f7590d-de00-4abe-a08e-e2f47d949a74'),(4,4,'nb_no','Publisert',NULL,NULL,NULL,NULL,0,'2017-03-29 14:02:42','2017-04-03 14:56:59','279f7b2b-13f5-49e4-a2c6-3a8eba373d42'),(5,5,'nb_no','Journalistene',NULL,NULL,NULL,NULL,0,'2017-03-29 14:03:05','2017-03-29 14:03:05','d740303f-e3dd-4419-962c-5a12aced952c'),(6,6,'nb_no','Drapsmannen 15L',NULL,NULL,NULL,NULL,0,'2017-03-30 13:10:45','2017-03-30 13:10:45','f24ab0ad-d0ee-4496-9d46-a2d6d0883eb4'),(7,7,'nb_no','Drapsmannen 16',NULL,NULL,NULL,NULL,0,'2017-03-30 13:10:46','2017-03-30 13:10:46','00ca48ca-e66b-435c-9798-a6b97a3c8ac7'),(8,8,'nb_no','Nidarvoll 01',NULL,NULL,NULL,NULL,0,'2017-03-30 13:10:46','2017-03-30 13:10:46','cbc30d50-9e9c-41f7-83d2-1c595e219b2e'),(9,9,'nb_no','Stavne Sletta 03',NULL,NULL,NULL,NULL,0,'2017-03-30 13:10:47','2017-03-30 13:10:47','9381cd41-c957-4ade-92fa-c94ebf9b6e26'),(10,10,'nb_no',NULL,NULL,NULL,'<p>11.September 1976 ble Sigrid Heggheim (20) fra Jølster funnet drept på et jorde på Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett på Studentersamfundet kvelden 4. september.</p>','left',1,'2017-03-30 13:38:56','2017-04-05 21:08:43','b221e889-51cc-43c0-add9-bedc4b159ff7'),(11,11,'nb_no',NULL,NULL,NULL,'<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet på Sigrid Heggheim elleve måneder tidligere var så mange at politiet mente at de måtte være samme gjerningsmann.</p>','left',1,'2017-03-30 13:38:56','2017-04-05 21:08:43','433a536b-7d1b-42ef-9b22-3d9f1929229e'),(12,12,'nb_no',NULL,NULL,NULL,'<p>Tor Hepsø var 38 år i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han å jobbe på oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperatør og hadde ansvar for stabiliteten på plattformen. Det var her han jobbet da drapene på de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Hepsø hadde friturnus da begge drapene ble begått. I konklusjonen som Kriposetterforsker Asbjørn Hansen skrev etter å ha undersøkt om Hepsøs tilståelse kunne være sann står det: Ut fra den etterforskning vi objektivet har gjennomført, kan vi ikke bevise at Tor Hepsø har begått drapene på Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilstått. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder på det motsatte- at han ikke kan ha drept dem.</p>','right',1,'2017-03-30 13:38:56','2017-04-05 21:08:43','feeeccf8-8aaa-4b1d-af9d-6a1b82dcc7e9'),(13,13,'nb_no',NULL,NULL,NULL,'','full',0,'2017-03-30 13:38:56','2017-04-05 21:08:43','a92db7e8-d277-4250-b06f-92398fdb085f'),(14,14,'nb_no',NULL,NULL,NULL,'<h3>Historien bak tilståelsen</h3>','left',1,'2017-03-30 13:46:52','2017-04-05 21:08:43','ea6dd93f-ece3-4027-a518-272ef4a18491'),(15,15,'nb_no',NULL,NULL,NULL,'<p>Tor Hepsø var 38 år i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han å jobbe på oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperatør og hadde ansvar for stabiliteten på plattformen. Det var her han jobbet da drapene på de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Hepsø hadde friturnus da begge drapene ble begått. I konklusjonen som Kriposetterforsker Asbjørn Hansen skrev etter å ha undersøkt om Hepsøs tilståelse kunne være sann står det: Ut fra den etterforskning vi objektivet har gjennomført, kan vi ikke bevise at Tor Hepsø har begått drapene på Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilstått. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder på det motsatte- at han ikke kan ha drept dem.</p>','left',1,'2017-03-30 14:40:03','2017-04-05 21:08:43','76d42c44-1a86-462b-a80f-cf45fc0bc5d2'),(16,16,'nb_no',NULL,NULL,NULL,'<p>sdfgsdfgsdfgsdfg</p>','full',1,'2017-03-30 14:40:03','2017-04-05 21:08:43','bf23d1ac-04ee-41ad-bf63-458472436dd8');
/*!40000 ALTER TABLE `craft_content` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_cpnav_layouts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_cpnav_layouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `isDefault` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `permissions` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_cpnav_layouts`
--

LOCK TABLES `craft_cpnav_layouts` WRITE;
/*!40000 ALTER TABLE `craft_cpnav_layouts` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_cpnav_layouts` VALUES (1,'Default',1,NULL,'2015-10-25 12:33:16','2015-10-25 12:33:16','33b57956-f2e1-4083-8cab-fe3c86d701c2');
/*!40000 ALTER TABLE `craft_cpnav_layouts` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_cpnav_navs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_cpnav_navs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) DEFAULT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `prevLabel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `currLabel` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `order` int(10) DEFAULT '0',
  `prevUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `url` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `icon` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `customIcon` text COLLATE utf8_unicode_ci,
  `manualNav` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `newWindow` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_cpnav_navs_layoutId_fk` (`layoutId`),
  CONSTRAINT `craft_cpnav_navs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_cpnav_layouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_cpnav_navs`
--

LOCK TABLES `craft_cpnav_navs` WRITE;
/*!40000 ALTER TABLE `craft_cpnav_navs` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_cpnav_navs` VALUES (1,1,'dashboard','Kontrollpanel','Kontrollpanel',1,0,'dashboard','dashboard','gauge',NULL,0,0,'2015-10-25 12:33:16','2016-12-13 10:27:59','8389e86d-0c7f-4ab2-ae0e-dbfc180a967b'),(3,1,'assets','Filer','Filer',1,2,'assets','assets','assets',NULL,0,0,'2015-10-25 12:33:16','2016-12-13 10:28:01','e81b6a91-78f4-4302-9c73-99f416a526a0'),(5,1,'settings','Innstillinger','Innstillinger',1,4,'settings','settings','settings',NULL,0,0,'2016-01-19 15:33:51','2016-12-13 10:28:08','6fd29f8c-59cd-4003-835d-14a411012823'),(15,1,'seomatic','SEOmatic','SEOmatic',1,4,'seomatic','seomatic','iconSvg-seomatic',NULL,0,0,'2016-06-14 12:18:20','2016-12-13 10:28:10','f22a3452-e1b2-4c14-86b5-7de93e35175f'),(16,1,'entries','Artikler','Artikler',1,1,'entries','entries','section',NULL,0,0,'2017-03-29 14:01:03','2017-03-29 14:01:03','6c58d48c-9756-44fa-9d0d-3e3a6c91e2e0'),(17,1,'amnav','a&m nav','a&m nav',1,3,'amnav','amnav','iconSvg-amnav',NULL,0,0,'2017-03-29 14:03:20','2017-03-29 14:03:20','f10fa786-8add-4bee-9128-d0cf67f036f4');
/*!40000 ALTER TABLE `craft_cpnav_navs` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_deprecationerrors`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fingerprint` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `line` smallint(6) unsigned NOT NULL,
  `class` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `method` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `template` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `templateLine` smallint(6) unsigned DEFAULT NULL,
  `message` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `traces` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_deprecationerrors`
--

LOCK TABLES `craft_deprecationerrors` WRITE;
/*!40000 ALTER TABLE `craft_deprecationerrors` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_deprecationerrors` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_elementindexsettings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_elementindexsettings`
--

LOCK TABLES `craft_elementindexsettings` WRITE;
/*!40000 ALTER TABLE `craft_elementindexsettings` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_elementindexsettings` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_elements`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `archived` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_elements_type_idx` (`type`),
  KEY `craft_elements_enabled_idx` (`enabled`),
  KEY `craft_elements_archived_dateCreated_idx` (`archived`,`dateCreated`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_elements`
--

LOCK TABLES `craft_elements` WRITE;
/*!40000 ALTER TABLE `craft_elements` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_elements` VALUES (1,'User',1,0,'2014-10-08 10:49:48','2017-04-03 14:50:05','ffb29a05-dcce-4b95-85c8-cba0b3353fca'),(2,'Entry',1,0,'2017-03-29 14:00:56','2017-04-03 13:23:00','7a31f02a-3e10-46c8-85fc-7a6894159cbc'),(3,'Entry',1,0,'2017-03-29 14:01:55','2017-04-05 21:08:43','18050050-b3c8-42e7-8037-5eeb95fdcd60'),(4,'Entry',1,0,'2017-03-29 14:02:42','2017-04-03 14:56:59','5ef5b2d3-a013-4ac5-8cc6-896a9fcd922d'),(5,'Entry',1,0,'2017-03-29 14:03:05','2017-03-29 14:03:05','5efa6dc9-8303-4c75-b372-0d5b6fdadf2d'),(6,'Asset',1,0,'2017-03-30 13:10:45','2017-03-30 13:10:45','35c1be58-519c-45aa-82a6-98bdcd44a13b'),(7,'Asset',1,0,'2017-03-30 13:10:46','2017-03-30 13:10:46','60ce9bb6-1114-4d2e-9c26-e23d846a6814'),(8,'Asset',1,0,'2017-03-30 13:10:46','2017-03-30 13:10:46','e5a5d7d6-2e3c-4419-8914-c3da30211819'),(9,'Asset',1,0,'2017-03-30 13:10:47','2017-03-30 13:10:47','25299eb4-aab1-4edc-9c82-1a7b470350d4'),(10,'Neo_Block',1,0,'2017-03-30 13:38:56','2017-04-05 21:08:43','749f6e84-a94f-43d6-afef-fa77de682a99'),(11,'Neo_Block',1,0,'2017-03-30 13:38:56','2017-04-05 21:08:43','f4405e68-e763-4a98-bdef-113b2ed06bdf'),(12,'Neo_Block',1,0,'2017-03-30 13:38:56','2017-04-05 21:08:43','cc323daa-c607-4296-9957-ca0d96133869'),(13,'Neo_Block',1,0,'2017-03-30 13:38:56','2017-04-05 21:08:43','5f8f5dc7-f7d7-4c1e-946b-a86da6cda3b4'),(14,'Neo_Block',1,0,'2017-03-30 13:46:52','2017-04-05 21:08:43','766e96f9-4ac9-4518-b762-bc4c2c44ca6a'),(15,'Neo_Block',1,0,'2017-03-30 14:40:03','2017-04-05 21:08:43','24968698-a7ed-4888-89d6-d1f833fc6fbf'),(16,'Neo_Block',1,0,'2017-03-30 14:40:03','2017-04-05 21:08:43','82179dba-659e-4a7f-a7b0-db227a5e8782'),(17,'SuperTable_Block',1,0,'2017-04-03 14:37:01','2017-04-03 14:56:59','649812a1-24c1-45e1-9411-819b643da6fd'),(18,'SuperTable_Block',1,0,'2017-04-03 14:37:01','2017-04-03 14:56:59','dd7e6335-8139-454b-bfaf-6ad9ff42748e'),(19,'SuperTable_Block',1,0,'2017-04-03 14:37:01','2017-04-03 14:56:59','267a3785-5d4a-4e69-9607-0322c59fff06'),(20,'SuperTable_Block',1,0,'2017-04-03 14:37:01','2017-04-03 14:56:59','f155d160-2de4-4d91-906b-256fc5dcb404');
/*!40000 ALTER TABLE `craft_elements` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_elements_i18n`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_elements_i18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `slug` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `uri` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_elements_i18n_elementId_locale_unq_idx` (`elementId`,`locale`),
  UNIQUE KEY `craft_elements_i18n_uri_locale_unq_idx` (`uri`,`locale`),
  KEY `craft_elements_i18n_slug_locale_idx` (`slug`,`locale`),
  KEY `craft_elements_i18n_enabled_idx` (`enabled`),
  KEY `craft_elements_i18n_locale_fk` (`locale`),
  CONSTRAINT `craft_elements_i18n_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_elements_i18n_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_elements_i18n`
--

LOCK TABLES `craft_elements_i18n` WRITE;
/*!40000 ALTER TABLE `craft_elements_i18n` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_elements_i18n` VALUES (1,1,'nb_no','',NULL,1,'2014-10-08 10:49:48','2017-04-03 14:50:05','43ed65e2-12cd-4f2c-bf52-00955b97ea18'),(2,2,'nb_no','forside','__home__',1,'2017-03-29 14:00:56','2017-04-03 13:23:00','8b15759a-0f62-48b3-8317-73ddae2d0e70'),(3,3,'nb_no','historien','historien',1,'2017-03-29 14:01:55','2017-04-05 21:08:43','f90ae4a1-335d-4632-9071-f819574d2ca3'),(4,4,'nb_no','publisert','publisert',1,'2017-03-29 14:02:42','2017-04-03 14:56:59','580871aa-9adc-44b1-bf05-403ce30af8c6'),(5,5,'nb_no','journalistene','journalistene',1,'2017-03-29 14:03:05','2017-03-29 14:03:05','3d9652ff-bd16-46ea-93c9-261217f2d669'),(6,6,'nb_no','drapsmannen-15l',NULL,1,'2017-03-30 13:10:45','2017-03-30 13:10:45','2f4dd9c2-b061-4eab-91b2-a5e220299c1f'),(7,7,'nb_no','drapsmannen-16',NULL,1,'2017-03-30 13:10:46','2017-03-30 13:10:46','938eeb78-54e1-44b3-9b0a-a0bf42949ee5'),(8,8,'nb_no','nidarvoll-01',NULL,1,'2017-03-30 13:10:46','2017-03-30 13:10:46','388bcd97-3846-48af-a97e-f1e7e6a83d55'),(9,9,'nb_no','stavne-sletta-03',NULL,1,'2017-03-30 13:10:47','2017-03-30 13:10:47','8be82e7d-9346-4ffd-b486-7907ad787965'),(10,10,'nb_no','',NULL,1,'2017-03-30 13:38:56','2017-04-05 21:08:43','ee57cc57-fc02-48f2-89be-5c996f4609fd'),(11,11,'nb_no','',NULL,1,'2017-03-30 13:38:56','2017-04-05 21:08:43','a7c4cab1-9675-42b9-be11-5ae0c09e98c1'),(12,12,'nb_no','',NULL,1,'2017-03-30 13:38:56','2017-04-05 21:08:43','126993c1-ef1d-42ed-a52e-a6a5b0c80681'),(13,13,'nb_no','',NULL,1,'2017-03-30 13:38:56','2017-04-05 21:08:43','4a900796-306b-4eeb-8824-addc5b7b3cde'),(14,14,'nb_no','',NULL,1,'2017-03-30 13:46:52','2017-04-05 21:08:43','45e3d062-3ac7-4a15-8b91-a875d96fb0b4'),(15,15,'nb_no','',NULL,1,'2017-03-30 14:40:03','2017-04-05 21:08:43','36e07b53-ec9e-4bb4-9cd2-dce7ec30c687'),(16,16,'nb_no','',NULL,1,'2017-03-30 14:40:03','2017-04-05 21:08:43','63c1d411-a26a-4a7f-9334-e256390348ce'),(17,17,'nb_no','',NULL,1,'2017-04-03 14:37:01','2017-04-03 14:56:59','9a689045-ab2c-4687-b9da-71110b3cf72b'),(18,18,'nb_no','',NULL,1,'2017-04-03 14:37:01','2017-04-03 14:56:59','c5e78e74-e3e4-4f4d-b452-0893b353db18'),(19,19,'nb_no','',NULL,1,'2017-04-03 14:37:01','2017-04-03 14:56:59','25ba275a-8d8f-4f77-a970-141723bff37b'),(20,20,'nb_no','',NULL,1,'2017-04-03 14:37:01','2017-04-03 14:56:59','7e4a1b16-904b-407a-9fd8-9a4d9cf62024');
/*!40000 ALTER TABLE `craft_elements_i18n` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_emailmessages`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_emailmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` char(150) COLLATE utf8_unicode_ci NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `subject` varchar(1000) COLLATE utf8_unicode_ci NOT NULL,
  `body` text COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_emailmessages_key_locale_unq_idx` (`key`,`locale`),
  KEY `craft_emailmessages_locale_fk` (`locale`),
  CONSTRAINT `craft_emailmessages_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_emailmessages`
--

LOCK TABLES `craft_emailmessages` WRITE;
/*!40000 ALTER TABLE `craft_emailmessages` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_emailmessages` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_entries`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `typeId` int(11) DEFAULT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entries_sectionId_idx` (`sectionId`),
  KEY `craft_entries_typeId_idx` (`typeId`),
  KEY `craft_entries_postDate_idx` (`postDate`),
  KEY `craft_entries_expiryDate_idx` (`expiryDate`),
  KEY `craft_entries_authorId_fk` (`authorId`),
  CONSTRAINT `craft_entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entries`
--

LOCK TABLES `craft_entries` WRITE;
/*!40000 ALTER TABLE `craft_entries` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_entries` VALUES (2,1,1,NULL,'2017-03-29 14:20:29',NULL,'2017-03-29 14:00:56','2017-04-03 13:23:00','7eca968d-5ba7-457f-828c-2a81e8aa97a7'),(3,2,NULL,NULL,'2017-03-29 14:01:55',NULL,'2017-03-29 14:01:55','2017-04-05 21:08:43','1b2115ed-ffde-45fa-92f4-3ef361a12fb4'),(4,3,NULL,NULL,'2017-03-29 14:02:42',NULL,'2017-03-29 14:02:42','2017-04-03 14:56:59','e2cd5780-1695-4444-a77f-71bd09597001'),(5,4,NULL,NULL,'2017-03-29 14:03:05',NULL,'2017-03-29 14:03:05','2017-03-29 14:03:05','74b12e95-d2e6-4266-a70f-35f9281cc93a');
/*!40000 ALTER TABLE `craft_entries` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_entrydrafts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `notes` tinytext COLLATE utf8_unicode_ci,
  `data` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entrydrafts_entryId_locale_idx` (`entryId`,`locale`),
  KEY `craft_entrydrafts_sectionId_fk` (`sectionId`),
  KEY `craft_entrydrafts_creatorId_fk` (`creatorId`),
  KEY `craft_entrydrafts_locale_fk` (`locale`),
  CONSTRAINT `craft_entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entrydrafts_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entrydrafts`
--

LOCK TABLES `craft_entrydrafts` WRITE;
/*!40000 ALTER TABLE `craft_entrydrafts` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_entrydrafts` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_entrytypes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `hasTitleField` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'Title',
  `titleFormat` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `craft_entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `craft_entrytypes_sectionId_fk` (`sectionId`),
  KEY `craft_entrytypes_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entrytypes`
--

LOCK TABLES `craft_entrytypes` WRITE;
/*!40000 ALTER TABLE `craft_entrytypes` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_entrytypes` VALUES (1,1,42,'Forside','forside',0,NULL,'{section.name|raw}',1,'2017-03-29 14:00:56','2017-03-29 14:07:53','bd109a8e-0ef6-4e67-8618-db89b8b0190a'),(2,2,47,'Historien','historien',0,NULL,'{section.name|raw}',1,'2017-03-29 14:01:55','2017-03-30 13:37:38','c4399dae-69cc-4e71-8e27-cdc5a32060bc'),(3,3,58,'Publisert','publisert',0,NULL,'{section.name|raw}',1,'2017-03-29 14:02:42','2017-04-03 14:33:33','722c65c5-6e35-43ac-ac7a-1a38cbe29662'),(4,4,40,'Journalistene','journalistene',0,NULL,'{section.name|raw}',1,'2017-03-29 14:03:05','2017-03-29 14:03:05','0fdc5e5e-29be-4e85-be6d-dd690e60e785');
/*!40000 ALTER TABLE `craft_entrytypes` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_entryversions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` tinytext COLLATE utf8_unicode_ci,
  `data` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_entryversions_entryId_locale_idx` (`entryId`,`locale`),
  KEY `craft_entryversions_sectionId_fk` (`sectionId`),
  KEY `craft_entryversions_creatorId_fk` (`creatorId`),
  KEY `craft_entryversions_locale_fk` (`locale`),
  CONSTRAINT `craft_entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `craft_users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `craft_entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_entryversions_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_entryversions`
--

LOCK TABLES `craft_entryversions` WRITE;
/*!40000 ALTER TABLE `craft_entryversions` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_entryversions` VALUES (1,2,1,1,'nb_no',1,NULL,'{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Forside\",\"slug\":\"forside\",\"postDate\":1490796056,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":[]}','2017-03-29 14:00:56','2017-03-29 14:00:56','481bb341-ac5a-4b1d-b9d5-1f0b3ac8400f'),(2,3,2,1,'nb_no',1,NULL,'{\"typeId\":\"2\",\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":[]}','2017-03-29 14:01:55','2017-03-29 14:01:55','fbdb61cf-a5ca-4cc7-ac7b-77d94ce77864'),(3,4,3,1,'nb_no',1,NULL,'{\"typeId\":\"3\",\"authorId\":null,\"title\":\"Publisert\",\"slug\":\"publisert\",\"postDate\":1490796162,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":[]}','2017-03-29 14:02:42','2017-03-29 14:02:42','2cc4f7c6-f42a-4970-9142-73c3ae09e532'),(4,5,4,1,'nb_no',1,NULL,'{\"typeId\":\"4\",\"authorId\":null,\"title\":\"Journalistene\",\"slug\":\"journalistene\",\"postDate\":1490796185,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":[]}','2017-03-29 14:03:05','2017-03-29 14:03:05','418e269e-e0b1-4a6a-b8e3-3d5329d156c2'),(5,3,2,1,'nb_no',2,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"22\":\"<p><b>Historien bak tilst\\u00e5elsen<\\/b><\\/p><p><img src=\\\"http:\\/\\/tilstaelsen.local\\/dynamic\\/upload\\/bilder\\/Nidarvoll_01.jpg#asset:8\\\">11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i &nbsp;i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<br><\\/p>\"}}','2017-03-30 13:15:08','2017-03-30 13:15:08','fa2da8bd-701b-4351-a93e-9d77c09baca1'),(6,3,2,1,'nb_no',3,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"new0\":{\"modified\":\"1\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":[\"8\"],\"posisjonTekst\":\"right\"}},\"new1\":{\"modified\":\"1\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonTekst\":\"left\"}},\"new2\":{\"modified\":\"1\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonTekst\":\"left\"}},\"new3\":{\"modified\":\"1\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonTekst\":\"left\"}}}}}','2017-03-30 13:38:56','2017-03-30 13:38:56','462f0b5b-0281-453a-9642-d9f65335e630'),(7,3,2,1,'nb_no',4,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"10\":{\"modified\":\"0\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":[\"8\"],\"posisjonTekst\":\"right\"}},\"11\":{\"modified\":\"0\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonTekst\":\"left\"}},\"12\":{\"modified\":\"0\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonTekst\":\"left\"}},\"13\":{\"modified\":\"1\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonTekst\":\"full\"}}}}}','2017-03-30 13:39:52','2017-03-30 13:39:52','f3950e6a-3a7f-4809-9d94-e593a3f2adce'),(8,3,2,1,'nb_no',5,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"10\":{\"modified\":\"1\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":[\"8\"],\"posisjonTekst\":\"right\"}},\"11\":{\"modified\":\"1\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonTekst\":\"left\"}},\"12\":{\"modified\":\"1\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonTekst\":\"left\"}},\"13\":{\"modified\":\"0\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonTekst\":\"full\"}}}}}','2017-03-30 13:41:26','2017-03-30 13:41:26','5614e839-7997-4ff4-b7ed-3b5c48afbeb7'),(9,3,2,1,'nb_no',6,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"new0\":{\"modified\":\"1\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<h2>Historien bak tilst\\u00e5elsen<\\/h2>\",\"bilde\":\"\",\"posisjonTekst\":\"left\"}},\"10\":{\"modified\":\"0\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":[\"8\"],\"posisjonTekst\":\"right\"}},\"11\":{\"modified\":\"0\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonTekst\":\"left\"}},\"12\":{\"modified\":\"0\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonTekst\":\"left\"}},\"13\":{\"modified\":\"0\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonTekst\":\"full\"}}}}}','2017-03-30 13:46:52','2017-03-30 13:46:52','8108e549-18f2-4830-85d6-2459c5aeafec'),(10,3,2,1,'nb_no',7,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"14\":{\"modified\":\"0\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<h2>Historien bak tilst\\u00e5elsen<\\/h2>\",\"bilde\":\"\",\"posisjonTekst\":\"left\"}},\"10\":{\"modified\":\"0\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":[\"8\"],\"posisjonTekst\":\"right\"}},\"11\":{\"modified\":\"0\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonTekst\":\"left\"}},\"12\":{\"modified\":\"0\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonTekst\":\"left\"}},\"13\":{\"modified\":\"0\",\"type\":\"bildeOgbilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonTekst\":\"full\"}}}}}','2017-03-30 13:47:38','2017-03-30 13:47:38','d0ac93ea-335c-4117-9aa5-0b5d7fa46775'),(11,3,2,1,'nb_no',8,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"14\":{\"modified\":\"0\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<h2>Historien bak tilst\\u00e5elsen<\\/h2>\",\"bilde\":\"\",\"posisjonTekst\":\"left\"}},\"10\":{\"modified\":\"0\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":[\"8\"],\"posisjonTekst\":\"right\"}},\"11\":{\"modified\":\"0\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonTekst\":\"left\"}},\"12\":{\"modified\":\"0\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonTekst\":\"left\"}},\"13\":{\"modified\":\"0\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonTekst\":\"full\"}}}}}','2017-03-30 13:49:12','2017-03-30 13:49:12','440e8b50-e4db-48fb-a827-57bdd7c2482b'),(12,3,2,1,'nb_no',9,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"14\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<h2>Historien bak tilst\\u00e5elsen<\\/h2>\",\"bilde\":\"\",\"posisjonTekst\":\"left\"}},\"10\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":[\"8\"],\"posisjonTekst\":\"right\"}},\"11\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonTekst\":\"left\"}},\"12\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonTekst\":\"left\"}},\"13\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonTekst\":\"full\"}}}}}','2017-03-30 13:56:59','2017-03-30 13:56:59','d2c493de-c176-4a4a-901c-c1020c0c2d86'),(13,3,2,1,'nb_no',10,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"14\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<h2>Historien bak tilst\\u00e5elsen<\\/h2>\",\"bilde\":\"\",\"posisjonBilde\":\"left\"}},\"10\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":[\"8\"],\"posisjonBilde\":\"left\"}},\"11\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonBilde\":\"left\"}},\"12\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonBilde\":\"left\"}},\"13\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonBilde\":\"full\"}}}}}','2017-03-30 14:12:38','2017-03-30 14:12:38','59e37f50-ed34-4f71-8b80-47ed0f3c9a5e'),(14,3,2,1,'nb_no',11,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"14\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<h2>Historien bak tilst\\u00e5elsen<\\/h2>\",\"bilde\":\"\",\"posisjonBilde\":\"left\"}},\"10\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":[\"8\"],\"posisjonBilde\":\"right\"}},\"11\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonBilde\":\"left\"}},\"12\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonBilde\":\"left\"}},\"13\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonBilde\":\"full\"}}}}}','2017-03-30 14:16:59','2017-03-30 14:16:59','b95c9ffc-46db-4d12-89f9-e18d06977684'),(15,3,2,1,'nb_no',12,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"14\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<h2>Historien bak tilst\\u00e5elsen<\\/h2>\",\"bilde\":\"\",\"posisjonBilde\":\"left\"}},\"10\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":\"\",\"posisjonBilde\":\"right\"}},\"11\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonBilde\":\"left\"}},\"12\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonBilde\":\"left\"}},\"13\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonBilde\":\"full\"}}}}}','2017-03-30 14:18:10','2017-03-30 14:18:10','c749b50a-c7b5-4f0e-b897-84d5dad7e010'),(16,3,2,1,'nb_no',13,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"14\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<h2>Historien bak tilst\\u00e5elsen<\\/h2>\",\"bilde\":\"\",\"posisjonBilde\":\"left\"}},\"10\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":[\"8\"],\"posisjonBilde\":\"right\"}},\"11\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonBilde\":\"left\"}},\"12\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonBilde\":\"left\"}},\"13\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonBilde\":\"full\"}}}}}','2017-03-30 14:18:24','2017-03-30 14:18:24','cd1390a7-df47-4946-955d-2fbb0a2c46cc'),(17,3,2,1,'nb_no',14,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"14\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<h3>Historien bak tilst\\u00e5elsen<\\/h3>\",\"bilde\":\"\",\"posisjonBilde\":\"left\"}},\"10\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":[\"8\"],\"posisjonBilde\":\"right\"}},\"11\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonBilde\":\"left\"}},\"12\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonBilde\":\"left\"}},\"13\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonBilde\":\"full\"}}}}}','2017-03-30 14:37:53','2017-03-30 14:37:53','8977b165-99b8-4c3a-a75c-33350be4c85c'),(18,3,2,1,'nb_no',15,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"14\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<h3>Historien bak tilst\\u00e5elsen<\\/h3>\",\"bilde\":\"\",\"posisjonBilde\":\"left\"}},\"10\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":[\"8\"],\"posisjonBilde\":\"left\"}},\"11\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonBilde\":\"left\"}},\"12\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonBilde\":\"right\"}},\"13\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonBilde\":\"full\"}}}}}','2017-03-30 14:39:20','2017-03-30 14:39:20','9948c26f-6ebe-4e79-a110-b772076b5fb1'),(19,3,2,1,'nb_no',16,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"14\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<h3>Historien bak tilst\\u00e5elsen<\\/h3>\",\"bilde\":\"\",\"posisjonBilde\":\"left\"}},\"10\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":[\"8\"],\"posisjonBilde\":\"left\"}},\"11\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonBilde\":\"left\"}},\"12\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonBilde\":\"right\"}},\"13\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonBilde\":\"full\"}},\"new0\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":\"\",\"posisjonBilde\":\"left\"}},\"new1\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"9\"],\"posisjonBilde\":\"left\"}}}}}','2017-03-30 14:40:03','2017-03-30 14:40:03','3f04e5bb-0d48-4c4b-95ef-e34e1a2914a9'),(20,3,2,1,'nb_no',17,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"14\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<h3>Historien bak tilst\\u00e5elsen<\\/h3>\",\"bilde\":\"\",\"posisjonBilde\":\"left\"}},\"10\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":[\"8\"],\"posisjonBilde\":\"left\"}},\"11\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonBilde\":\"left\"}},\"12\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonBilde\":\"right\"}},\"13\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonBilde\":\"full\"}},\"15\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":\"\",\"posisjonBilde\":\"left\"}},\"16\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"9\"],\"posisjonBilde\":\"full\"}}}}}','2017-03-30 14:47:08','2017-03-30 14:47:08','7b4f4eaf-9b02-438f-a85f-6f8cf42d1bc7'),(21,2,1,1,'nb_no',2,'','{\"typeId\":\"1\",\"authorId\":null,\"title\":\"Forside\",\"slug\":\"forside\",\"postDate\":1490797229,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"23\":[\"6\"],\"22\":\"<h1>Tilst\\u00e5elsen<\\/h1><p>Like f\\u00f8r jul i 2005 ble det gjennom media kjent at en person i Tr\\u00f8ndelag, Tor Heps\\u00f8, kort tid f\\u00f8r han avgikk ved d\\u00f8den 20. desember 2005, skulle ha erkjent \\u00e5 st\\u00e5 bak drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad. De samme drapene d\\u00f8vstumme Fritz Moen hadde sonet 18 \\u00e5r i fengsel for.<br><\\/p>\"}}','2017-04-03 13:23:00','2017-04-03 13:23:00','aba48d66-2681-492c-8032-179007fe770f'),(22,4,3,1,'nb_no',2,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Publisert\",\"slug\":\"publisert\",\"postDate\":1490796162,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"27\":{\"new1\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 1\",\"publisert\":\"23.03.2017\",\"lenke\":\"www.sol.no\",\"bilde\":[\"6\"]}},\"new2\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 2\",\"publisert\":\"14.04.2017\",\"lenke\":\"www.vg.no\",\"bilde\":[\"7\"]}},\"new3\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 3\",\"publisert\":\"15.05.2017\",\"lenke\":\"www.db.no\",\"bilde\":[\"8\"]}},\"new4\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 4\",\"publisert\":\"08.12.2018\",\"lenke\":\"www.aftenposten.no\",\"bilde\":[\"9\"]}}}}}','2017-04-03 14:37:01','2017-04-03 14:37:01','6494b932-4547-4e2d-aba1-9193ad8c6b0b'),(23,4,3,1,'nb_no',3,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Publisert\",\"slug\":\"publisert\",\"postDate\":1490796162,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"27\":{\"17\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 1\",\"publisert\":\"23.03.2017\",\"lenke\":\"<p><a href=\\\"http:\\/\\/www.sol.no\\\" target=\\\"_blank\\\">www.sol.no<\\/a><\\/p>\",\"bilde\":[\"6\"]}},\"18\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 2\",\"publisert\":\"14.04.2017\",\"lenke\":\"<p><a href=\\\"http:\\/\\/www.vg.no\\\" target=\\\"_blank\\\">www.vg.no<\\/a><\\/p>\",\"bilde\":[\"7\"]}},\"19\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 3\",\"publisert\":\"15.05.2017\",\"lenke\":\"<p><a href=\\\"http:\\/\\/www.db.no\\\" target=\\\"_blank\\\">www.db.no<\\/a><\\/p>\",\"bilde\":[\"8\"]}},\"20\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 4\",\"publisert\":\"08.12.2018\",\"lenke\":\"<p><a href=\\\"http:\\/\\/www.aftenposten.no\\\" target=\\\"_blank\\\">www.aftenposten.no<\\/a><\\/p>\",\"bilde\":[\"9\"]}}}}}','2017-04-03 14:51:03','2017-04-03 14:51:03','cf85e50c-e1e5-42c8-8b76-a2cfa4c787c8'),(24,4,3,1,'nb_no',4,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Publisert\",\"slug\":\"publisert\",\"postDate\":1490796162,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"27\":{\"17\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 1\",\"publisert\":\"23.03.2017\",\"lenke\":\"www.sol.no\",\"bilde\":[\"6\"]}},\"18\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 2\",\"publisert\":\"14.04.2017\",\"lenke\":\"www.sol.no\",\"bilde\":[\"7\"]}},\"19\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 3\",\"publisert\":\"15.05.2017\",\"lenke\":\"www.sol.no\",\"bilde\":[\"8\"]}},\"20\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 4\",\"publisert\":\"08.12.2018\",\"lenke\":\"www.sol.no\",\"bilde\":[\"9\"]}}}}}','2017-04-03 14:54:37','2017-04-03 14:54:37','88fbd4bc-6fdc-4769-a68d-6e256e19d17d'),(25,4,3,1,'nb_no',5,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Publisert\",\"slug\":\"publisert\",\"postDate\":1490796162,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"27\":{\"17\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 1\",\"publisert\":\"23.03.2017\",\"lenke\":\"http:\\/\\/www.sol.no\",\"bilde\":[\"6\"]}},\"18\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 2\",\"publisert\":\"14.04.2017\",\"lenke\":\"http:\\/\\/www.sol.no\",\"bilde\":[\"7\"]}},\"19\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 3\",\"publisert\":\"15.05.2017\",\"lenke\":\"http:\\/\\/www.sol.no\",\"bilde\":[\"8\"]}},\"20\":{\"type\":\"1\",\"fields\":{\"tittel\":\"Kapittel 4\",\"publisert\":\"08.12.2018\",\"lenke\":\"http:\\/\\/www.sol.no\",\"bilde\":[\"9\"]}}}}}','2017-04-03 14:56:59','2017-04-03 14:56:59','695c2dda-49f7-4d3d-a8a5-cfc97a6d9fd4'),(26,3,2,1,'nb_no',18,'','{\"typeId\":null,\"authorId\":null,\"title\":\"Historien\",\"slug\":\"historien\",\"postDate\":1490796115,\"expiryDate\":null,\"enabled\":1,\"parentId\":null,\"fields\":{\"25\":{\"14\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<h3>Historien bak tilst\\u00e5elsen<\\/h3>\",\"bilde\":\"\",\"posisjonBilde\":\"left\"}},\"10\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>11.September 1976 ble Sigrid Heggheim (20) fra J\\u00f8lster funnet drept p\\u00e5 et jorde p\\u00e5 Nidarvoll i Trondheim. Sigrid var ny i i byen og ble sist sett p\\u00e5 Studentersamfundet kvelden 4. september.<\\/p>\",\"bilde\":[\"8\"],\"posisjonBilde\":\"left\"}},\"11\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>06.Oktober 1977 ble Torunn Finstad (20) fra Kongsberg funnet drept ved Stavne bru i Trondheim. Likheten til drapet p\\u00e5 Sigrid Heggheim elleve m\\u00e5neder tidligere var s\\u00e5 mange at politiet mente at de m\\u00e5tte v\\u00e6re samme gjerningsmann.<\\/p>\",\"bilde\":[\"9\"],\"posisjonBilde\":\"left\"}},\"12\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":[\"7\"],\"posisjonBilde\":\"right\"}},\"13\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"\",\"rikTekst\":\"\",\"bilde\":[\"6\"],\"posisjonBilde\":\"full\"}},\"15\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>Tor Heps\\u00f8 var 38 \\u00e5r i 1976. Han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60-tallet. I 1973 begynte han \\u00e5 jobbe p\\u00e5 oljeplattformen Nordskald. Der fikk han etterhvert stilling som kontrollromsoperat\\u00f8r og hadde ansvar for stabiliteten p\\u00e5 plattformen. Det var her han jobbet da drapene p\\u00e5 de unge studentene Sigrid og Torunn fant sted. Kripos avdekket at Heps\\u00f8 hadde friturnus da begge drapene ble beg\\u00e5tt. I konklusjonen som Kriposetterforsker Asbj\\u00f8rn Hansen skrev etter \\u00e5 ha unders\\u00f8kt om Heps\\u00f8s tilst\\u00e5else kunne v\\u00e6re sann st\\u00e5r det: Ut fra den etterforskning vi objektivet har gjennomf\\u00f8rt, kan vi ikke bevise at Tor Heps\\u00f8 har beg\\u00e5tt drapene p\\u00e5 Sigrid Heggheim og Torunn Finstad i henholdsvis 1976 og 1977, slik han har tilst\\u00e5tt. Det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder p\\u00e5 det motsatte- at han ikke kan ha drept dem.<\\/p>\",\"bilde\":\"\",\"posisjonBilde\":\"left\"}},\"16\":{\"modified\":\"1\",\"type\":\"tekstEllerBilde\",\"enabled\":\"1\",\"collapsed\":\"0\",\"level\":\"0\",\"fields\":{\"tekst\":\"1\",\"rikTekst\":\"<p>sdfgsdfgsdfgsdfg<\\/p>\",\"bilde\":[\"9\"],\"posisjonBilde\":\"full\"}}}}}','2017-04-05 21:08:43','2017-04-05 21:08:43','c33fdbb0-a7e2-4bc1-b9fa-608c13a5a761');
/*!40000 ALTER TABLE `craft_entryversions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_fieldgroups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldgroups`
--

LOCK TABLES `craft_fieldgroups` WRITE;
/*!40000 ALTER TABLE `craft_fieldgroups` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_fieldgroups` VALUES (1,'Standard','2014-10-08 10:49:50','2014-10-08 10:49:50','420d3eaa-0708-4cce-8c20-93409caf3560'),(3,'SEO','2015-10-23 14:49:57','2015-10-23 14:49:57','fa2e2850-530c-4e24-9889-99212610e4dc'),(4,'Tekstblokker','2017-03-30 13:30:15','2017-03-30 13:30:15','7bfc6ff4-3195-4a19-8a37-f23fb06eaa8d');
/*!40000 ALTER TABLE `craft_fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_fieldlayoutfields`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `craft_fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayoutfields_tabId_fk` (`tabId`),
  KEY `craft_fieldlayoutfields_fieldId_fk` (`fieldId`),
  CONSTRAINT `craft_fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `craft_fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=125 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldlayoutfields`
--

LOCK TABLES `craft_fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayoutfields` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_fieldlayoutfields` VALUES (75,35,26,21,0,1,'2016-06-08 08:27:39','2016-06-08 08:27:39','2688b460-dae3-4aaa-b276-0ae02239e680'),(77,35,26,18,0,3,'2016-06-08 08:27:39','2016-06-08 08:27:39','5ee3c7a7-0841-4434-8b2e-3053498fb03b'),(80,42,28,22,0,1,'2017-03-29 14:07:53','2017-03-29 14:07:53','044295dd-e7b2-41e2-a200-d0ac823b63fd'),(81,42,28,23,0,2,'2017-03-29 14:07:53','2017-03-29 14:07:53','b55fc049-a1a7-4c93-8c9b-35a3b28c0962'),(88,47,33,25,0,1,'2017-03-30 13:37:38','2017-03-30 13:37:38','7901ead9-2228-42a6-a596-b1e1de35fc95'),(101,54,40,26,0,1,'2017-03-30 13:48:54','2017-03-30 13:48:54','e0eca5a6-cd83-464b-8f1c-9290cdf6152e'),(102,54,40,22,0,2,'2017-03-30 13:48:54','2017-03-30 13:48:54','4ba5bb77-c1a3-4450-980d-087af57b66e0'),(103,54,40,23,0,3,'2017-03-30 13:48:54','2017-03-30 13:48:54','ff211e25-e7ae-412d-a28b-cfa5e2b93508'),(104,54,40,24,0,4,'2017-03-30 13:48:54','2017-03-30 13:48:54','343e57c0-0e92-468e-889c-fe59ef8306cf'),(105,55,41,22,0,1,'2017-03-30 13:48:54','2017-03-30 13:48:54','136b524b-687e-4a1c-9911-bf83d63aedf5'),(106,56,42,22,0,1,'2017-03-30 13:48:54','2017-03-30 13:48:54','5761863a-e55a-482e-9552-4b8164b5c07b'),(108,58,44,27,0,1,'2017-04-03 14:33:33','2017-04-03 14:33:33','c833de40-de7b-4775-a92c-c97f36138bb6'),(121,62,48,28,0,1,'2017-04-03 14:56:05','2017-04-03 14:56:05','fa8fe06e-1719-424d-b918-96ba5a8e4459'),(122,62,48,29,0,2,'2017-04-03 14:56:05','2017-04-03 14:56:05','f693fb5a-69ab-41ee-b51b-98ee7be2ca1e'),(123,62,48,30,0,3,'2017-04-03 14:56:05','2017-04-03 14:56:05','2ff6d1d8-915f-4313-b104-03372a052b95'),(124,62,48,31,0,4,'2017-04-03 14:56:05','2017-04-03 14:56:05','03abf931-7342-42cd-8985-5a3510dc8e45');
/*!40000 ALTER TABLE `craft_fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_fieldlayouts`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB AUTO_INCREMENT=63 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldlayouts`
--

LOCK TABLES `craft_fieldlayouts` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouts` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_fieldlayouts` VALUES (1,'Tag','2014-10-08 10:49:50','2014-10-08 10:49:50','735aea8d-1467-42fe-a635-fe07456aef93'),(3,'Entry','2014-10-08 10:49:51','2014-10-08 10:49:51','34c943ee-38b2-46f1-977d-5a69371e7b36'),(5,'Entry','2014-10-08 10:49:51','2014-10-08 10:49:51','abf58a12-09f1-4aa1-a709-7f4b5c553eab'),(35,'Asset','2016-06-08 08:27:39','2016-06-08 08:27:39','2f62a4dc-1f0f-431b-845c-ccffcb78f627'),(36,'Asset','2016-09-14 09:29:21','2016-09-14 09:29:21','98cb2b92-aed8-4d5a-bbb7-828546174317'),(40,'Entry','2017-03-29 14:03:05','2017-03-29 14:03:05','f5dbcb1b-7a4d-460d-86b5-85d50b61f9fb'),(42,'Entry','2017-03-29 14:07:53','2017-03-29 14:07:53','929e14b0-4a3a-49ec-8ee3-917bae0de8fd'),(47,'Entry','2017-03-30 13:37:38','2017-03-30 13:37:38','1b8fb7c9-d683-49df-be5a-06d8cd3b8118'),(54,'Neo_Block','2017-03-30 13:48:54','2017-03-30 13:48:54','ac3d8588-673d-4e62-8fe7-89ea3b314ab4'),(55,'Neo_Block','2017-03-30 13:48:54','2017-03-30 13:48:54','59214fbc-a103-4273-b44e-1b82b7393e61'),(56,'Neo_Block','2017-03-30 13:48:54','2017-03-30 13:48:54','b3a914cb-a5c2-49a9-8907-52957be8f2eb'),(58,'Entry','2017-04-03 14:33:33','2017-04-03 14:33:33','5decdd0f-aa26-46eb-8973-946bf1b0d4e1'),(62,'SuperTable_Block','2017-04-03 14:56:05','2017-04-03 14:56:05','a9a66797-9b0a-446e-a0bc-2f7eb2208fbf');
/*!40000 ALTER TABLE `craft_fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_fieldlayouttabs`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `craft_fieldlayouttabs_layoutId_fk` (`layoutId`),
  CONSTRAINT `craft_fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=49 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fieldlayouttabs`
--

LOCK TABLES `craft_fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `craft_fieldlayouttabs` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_fieldlayouttabs` VALUES (1,3,'Innhold',1,'2014-10-08 10:49:51','2014-10-08 10:49:51','d35bab09-a914-4602-91df-0a3c3baa2cfc'),(2,5,'Innhold',1,'2014-10-08 10:49:51','2014-10-08 10:49:51','c39b036d-dd74-43ad-b5f0-cc0dfbd18b00'),(4,1,'Content',1,'2014-12-12 08:34:38','2014-12-12 08:34:38','075c4aae-210e-47b1-b49d-741e200c9155'),(26,35,'Innhold',1,'2016-06-08 08:27:39','2016-06-08 08:27:39','ecb34c16-5ecd-4248-858f-4abe8652da43'),(28,42,'Forside',1,'2017-03-29 14:07:53','2017-03-29 14:07:53','339670d5-a64c-464f-b53d-9901a698a96e'),(33,47,'Historien',1,'2017-03-30 13:37:38','2017-03-30 13:37:38','f355a757-b398-4b41-8a57-e20980822adb'),(40,54,'Tekst og bilde',1,'2017-03-30 13:48:54','2017-03-30 13:48:54','0fa23eea-d2f2-474c-ad7e-e1a23e715577'),(41,55,'Video',1,'2017-03-30 13:48:54','2017-03-30 13:48:54','248cd688-0d7f-4b72-99c0-be5468c19d74'),(42,56,'Lyd',1,'2017-03-30 13:48:54','2017-03-30 13:48:54','39ebe1be-9d7b-4679-811c-21a58cd1ad33'),(44,58,'Publisert',1,'2017-04-03 14:33:33','2017-04-03 14:33:33','7f211a25-112b-44a6-b0de-731367069c01'),(48,62,'Content',1,'2017-04-03 14:56:05','2017-04-03 14:56:05','132d5c5d-de49-4209-bf0c-8685801ffe8b');
/*!40000 ALTER TABLE `craft_fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_fields`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(58) COLLATE utf8_unicode_ci NOT NULL,
  `context` varchar(255) COLLATE utf8_unicode_ci NOT NULL DEFAULT 'global',
  `instructions` text COLLATE utf8_unicode_ci,
  `translatable` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `craft_fields_context_idx` (`context`),
  KEY `craft_fields_groupId_fk` (`groupId`),
  CONSTRAINT `craft_fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_fields`
--

LOCK TABLES `craft_fields` WRITE;
/*!40000 ALTER TABLE `craft_fields` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_fields` VALUES (18,1,'Fokuspunkt','fokuspunkt','global','',0,'FocalPointField_FocalPoint','{\"defaultFocalPoint\":\"\"}','2016-01-19 15:58:29','2016-01-19 15:58:29','74a3919e-0f9f-4f9d-bc71-7e0335ce7f1d'),(21,1,'Alternativ tekst','alt','global','',0,'PlainText','{\"placeholder\":\"\",\"maxLength\":\"\",\"multiline\":\"\",\"initialRows\":\"4\"}','2016-02-15 11:49:15','2016-02-15 11:49:15','7592614d-9607-4aa9-9f4b-cd073d7a7de5'),(22,1,'Rik tekst','rikTekst','global','',0,'RichText','{\"configFile\":\"\",\"availableAssetSources\":\"*\",\"availableTransforms\":\"*\",\"cleanupHtml\":\"1\",\"purifyHtml\":\"1\",\"columnType\":\"text\"}','2017-03-29 14:05:48','2017-03-29 14:05:48','4ddc8de5-9e93-4ecf-a4a3-1ac45c309c6c'),(23,1,'Bilde','bilde','global','',0,'Assets','{\"useSingleFolder\":\"\",\"sources\":\"*\",\"defaultUploadLocationSource\":\"1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"limit\":\"1\",\"viewMode\":\"list\",\"selectionLabel\":\"\"}','2017-03-29 14:06:20','2017-03-29 14:06:20','40c47f99-ab14-484e-ade7-f2d63bd2823c'),(24,4,'Posisjon','posisjonBilde','global','',0,'PositionSelect','{\"options\":[\"left\",\"right\",\"full\"]}','2017-03-30 13:34:46','2017-03-30 14:05:57','b5469196-196d-4278-9d81-eb7143863f0e'),(25,4,'Tekstblokk','tekstblokkNeo','global','',0,'Neo','{\"maxBlocks\":null}','2017-03-30 13:36:59','2017-03-30 13:48:54','42be06d8-2442-462e-b748-e03f4a0ad3cc'),(26,4,'Tekst?','tekst','global','',0,'Lightswitch','{\"default\":\"\"}','2017-03-30 13:40:36','2017-03-30 13:40:36','a0ed310d-9acf-43ba-a7db-9cc69e145189'),(27,1,'Publisert','publisert','global','',0,'SuperTable','{\"columns\":{\"28\":{\"width\":\"\"},\"29\":{\"width\":\"\"},\"30\":{\"width\":\"\"},\"31\":{\"width\":\"\"}},\"fieldLayout\":\"table\",\"staticField\":null,\"selectionLabel\":\"Legg til flere artikler\",\"maxRows\":null,\"minRows\":null}','2017-04-03 14:33:12','2017-04-03 14:56:05','8c2e6229-69aa-400c-a354-d80b324b3b85'),(28,NULL,'Tittel','tittel','superTableBlockType:1','',0,'PlainText','{\"placeholder\":\"\",\"maxLength\":\"\",\"multiline\":\"\",\"initialRows\":\"4\"}','2017-04-03 14:33:13','2017-04-03 14:56:05','3e4c0e00-8b30-43f7-9880-a8a9725a8f2d'),(29,NULL,'Publisert','publisert','superTableBlockType:1','',0,'PlainText','{\"placeholder\":\"\",\"maxLength\":\"\",\"multiline\":\"\",\"initialRows\":\"4\"}','2017-04-03 14:35:36','2017-04-03 14:56:05','ac4756fa-1dc1-47a2-a516-4878bdca042f'),(30,NULL,'Lenke','lenke','superTableBlockType:1','',0,'SproutFields_Link','{\"placeholder\":\"\",\"customPatternToggle\":\"\",\"customPattern\":\"\",\"customPatternErrorMessage\":\"\"}','2017-04-03 14:35:36','2017-04-03 14:56:05','7e78dd82-3519-4e6d-8e2b-9e3d9980cebe'),(31,NULL,'Bilde','bilde','superTableBlockType:1','',0,'Assets','{\"useSingleFolder\":\"\",\"sources\":\"*\",\"defaultUploadLocationSource\":\"1\",\"defaultUploadLocationSubpath\":\"\",\"singleUploadLocationSource\":\"1\",\"singleUploadLocationSubpath\":\"\",\"restrictFiles\":\"\",\"limit\":\"1\",\"viewMode\":\"list\",\"selectionLabel\":\"\"}','2017-04-03 14:35:36','2017-04-03 14:56:05','17312bbe-333e-4b48-b8c0-47bdcc90ca11');
/*!40000 ALTER TABLE `craft_fields` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_globalsets`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_globalsets` (
  `id` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fieldLayoutId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `craft_globalsets_handle_unq_idx` (`handle`),
  KEY `craft_globalsets_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_globalsets`
--

LOCK TABLES `craft_globalsets` WRITE;
/*!40000 ALTER TABLE `craft_globalsets` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_globalsets` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_info`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) COLLATE utf8_unicode_ci NOT NULL,
  `schemaVersion` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `edition` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `siteName` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `siteUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `timezone` varchar(30) COLLATE utf8_unicode_ci DEFAULT NULL,
  `on` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `maintenance` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_info`
--

LOCK TABLES `craft_info` WRITE;
/*!40000 ALTER TABLE `craft_info` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_info` VALUES (1,'2.6.2968','2.6.9',0,'Tilståelsen','{siteUrl}','Europe/Oslo',0,0,'2014-10-08 10:49:45','2017-04-03 11:29:05','ce6e6378-3719-45f4-88b1-640f0e5e22c4');
/*!40000 ALTER TABLE `craft_info` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_locales`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_locales` (
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`locale`),
  KEY `craft_locales_sortOrder_idx` (`sortOrder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_locales`
--

LOCK TABLES `craft_locales` WRITE;
/*!40000 ALTER TABLE `craft_locales` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_locales` VALUES ('nb_no',1,'2014-10-08 10:49:46','2014-10-08 10:49:46','60083433-3d9f-4116-8d2d-1c91c6e178bc');
/*!40000 ALTER TABLE `craft_locales` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_matrixblocks`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `ownerLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_matrixblocks_ownerId_idx` (`ownerId`),
  KEY `craft_matrixblocks_fieldId_idx` (`fieldId`),
  KEY `craft_matrixblocks_typeId_idx` (`typeId`),
  KEY `craft_matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `craft_matrixblocks_ownerLocale_fk` (`ownerLocale`),
  CONSTRAINT `craft_matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocks_ownerLocale_fk` FOREIGN KEY (`ownerLocale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_matrixblocks`
--

LOCK TABLES `craft_matrixblocks` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocks` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_matrixblocks` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_matrixblocktypes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `craft_matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `craft_matrixblocktypes_fieldId_fk` (`fieldId`),
  KEY `craft_matrixblocktypes_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_matrixblocktypes`
--

LOCK TABLES `craft_matrixblocktypes` WRITE;
/*!40000 ALTER TABLE `craft_matrixblocktypes` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_matrixblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_migrations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `version` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_migrations_version_unq_idx` (`version`),
  KEY `craft_migrations_pluginId_fk` (`pluginId`),
  CONSTRAINT `craft_migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `craft_plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=95 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_migrations`
--

LOCK TABLES `craft_migrations` WRITE;
/*!40000 ALTER TABLE `craft_migrations` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_migrations` VALUES (1,NULL,'m000000_000000_base','2014-10-08 10:49:46','2014-10-08 10:49:46','2014-10-08 10:49:46','42d71bf0-6913-4eaa-9e38-d36bea1be5a8'),(2,NULL,'m140730_000001_add_filename_and_format_to_transformindex','2014-10-08 10:49:46','2014-10-08 10:49:46','2014-10-08 10:49:46','b3815782-326e-42bd-aab2-b7df98a331cc'),(3,NULL,'m140815_000001_add_format_to_transforms','2014-10-08 10:49:46','2014-10-08 10:49:46','2014-10-08 10:49:46','d16c46c4-1e70-4db1-a35b-369052650590'),(4,NULL,'m140822_000001_allow_more_than_128_items_per_field','2014-10-08 10:49:46','2014-10-08 10:49:46','2014-10-08 10:49:46','cfc81698-5ad6-4774-b348-8b83b7cb8f1e'),(5,NULL,'m140829_000001_single_title_formats','2014-10-08 10:49:46','2014-10-08 10:49:46','2014-10-08 10:49:46','198b1671-c688-4a74-9897-0211fddd2566'),(6,NULL,'m140831_000001_extended_cache_keys','2014-10-08 10:49:46','2014-10-08 10:49:46','2014-10-08 10:49:46','2d510d43-bb61-470e-a8ab-55672d6738ab'),(7,NULL,'m140922_000001_delete_orphaned_matrix_blocks','2014-10-08 10:49:46','2014-10-08 10:49:46','2014-10-08 10:49:46','399632eb-8668-43a1-a28d-2e933310cb4f'),(9,NULL,'m141008_000001_elements_index_tune','2014-12-12 08:34:38','2014-12-12 08:34:38','2014-12-12 08:34:38','1c96e5aa-cb60-4c43-bd6a-c0bd38773675'),(10,NULL,'m141009_000001_assets_source_handle','2014-12-12 08:34:38','2014-12-12 08:34:38','2014-12-12 08:34:38','ee995679-dce6-4bb5-814a-ef4eb48d9e5c'),(11,NULL,'m141024_000001_field_layout_tabs','2014-12-12 08:34:39','2014-12-12 08:34:39','2014-12-12 08:34:39','22887b9a-b1dc-456a-b5e3-14b8f6724926'),(12,NULL,'m141030_000001_drop_structure_move_permission','2014-12-12 08:34:39','2014-12-12 08:34:39','2014-12-12 08:34:39','10e7e46a-612f-43a8-b243-170934f67e38'),(13,NULL,'m141103_000001_tag_titles','2014-12-12 08:34:39','2014-12-12 08:34:39','2014-12-12 08:34:39','0ddd1195-7ac4-4f43-a185-e2a45012e324'),(14,NULL,'m141109_000001_user_status_shuffle','2014-12-12 08:34:40','2014-12-12 08:34:40','2014-12-12 08:34:40','8f737b06-2ba4-42bf-81d4-e06786ff9fa6'),(15,NULL,'m141126_000001_user_week_start_day','2014-12-12 08:34:40','2014-12-12 08:34:40','2014-12-12 08:34:40','f08d4d0a-045b-422f-b5ce-6a5976363598'),(16,NULL,'m150210_000001_adjust_user_photo_size','2015-03-11 17:02:58','2015-03-11 17:02:58','2015-03-11 17:02:58','1f89c6e6-0589-4f44-bbe3-046d140361f8'),(17,9,'m150901_144609_superTable_fixForContentTables','2015-10-23 15:33:35','2015-10-23 15:33:35','2015-10-23 15:33:35','f418c3f0-ce4e-4294-a5a9-7c359e000d76'),(18,16,'m150314_144609_cpNav_addUrlSupport','2015-10-25 12:33:15','2015-10-25 12:33:15','2015-10-25 12:33:15','711d1275-f8ec-497d-905c-5a010ada3f80'),(19,16,'m150314_144610_cpNav_addPrevUrlSupport','2015-10-25 12:33:15','2015-10-25 12:33:15','2015-10-25 12:33:15','dd743bff-ee3a-4484-b928-424ae65f72b2'),(20,16,'m150314_144611_cpNav_addManualNavItemSupport','2015-10-25 12:33:15','2015-10-25 12:33:15','2015-10-25 12:33:15','0df3e894-a476-47bf-a556-d28d6d7ba9e2'),(21,16,'m150314_144615_cpNav_layouts','2015-10-25 12:33:15','2015-10-25 12:33:15','2015-10-25 12:33:15','0a95d82b-dad0-464b-bdf1-4508dbe91a79'),(22,16,'m150321_144616_cpNav_newWindow','2015-10-25 12:33:15','2015-10-25 12:33:15','2015-10-25 12:33:15','a3f045bb-f280-43e6-845f-bbb4d1f812de'),(23,NULL,'m141030_000000_plugin_schema_versions','2016-01-19 15:32:54','2016-01-19 15:32:54','2016-01-19 15:32:54','08881d26-493b-496a-85c8-b6f4f73fa125'),(24,NULL,'m150724_000001_adjust_quality_settings','2016-01-19 15:32:54','2016-01-19 15:32:54','2016-01-19 15:32:54','0825fb2d-f665-41d5-90b2-11fff25d652a'),(25,NULL,'m150827_000000_element_index_settings','2016-01-19 15:32:55','2016-01-19 15:32:55','2016-01-19 15:32:55','e90f1ddc-643a-41ef-9d4f-0f3a5779a9fa'),(26,NULL,'m150918_000001_add_colspan_to_widgets','2016-01-19 15:32:55','2016-01-19 15:32:55','2016-01-19 15:32:55','5dcb9740-8fcf-4d63-a9de-4cdb8126836c'),(27,NULL,'m151007_000000_clear_asset_caches','2016-01-19 15:32:55','2016-01-19 15:32:55','2016-01-19 15:32:55','34c7e193-5c82-4958-b580-fa42f2f55620'),(28,NULL,'m151109_000000_text_url_formats','2016-01-19 15:32:55','2016-01-19 15:32:55','2016-01-19 15:32:55','203cfac4-935d-4813-bc6e-d1dd04bdf4e3'),(29,NULL,'m151110_000000_move_logo','2016-01-19 15:32:55','2016-01-19 15:32:55','2016-01-19 15:32:55','67fb9d27-93eb-4c66-a97f-80a41c8ef549'),(30,NULL,'m151117_000000_adjust_image_widthheight','2016-01-19 15:32:56','2016-01-19 15:32:56','2016-01-19 15:32:56','fa12e892-dffa-461a-8f61-7961713a0a90'),(31,NULL,'m151127_000000_clear_license_key_status','2016-01-19 15:32:56','2016-01-19 15:32:56','2016-01-19 15:32:56','401e83a8-8c79-4ddf-8e8c-2d8a6c66a49f'),(32,NULL,'m151127_000000_plugin_license_keys','2016-01-19 15:32:56','2016-01-19 15:32:56','2016-01-19 15:32:56','e1e28880-9184-4ab2-85d4-b7fc8b0867ee'),(33,NULL,'m151130_000000_update_pt_widget_feeds','2016-01-19 15:32:56','2016-01-19 15:32:56','2016-01-19 15:32:56','f84150f9-96c1-4c46-9a3d-37371593ea04'),(38,16,'m151126_144611_cpNav_addIconSupport','2016-01-19 15:49:53','2016-01-19 15:49:53','2016-01-19 15:49:53','c7915192-1955-4aed-9c46-72ffbfd98da8'),(39,16,'m151224_144611_cpNav_populateIcons','2016-01-19 15:49:53','2016-01-19 15:49:53','2016-01-19 15:49:53','b0c0de49-5d02-4b05-acf0-6326e9630a9e'),(40,25,'m151225_000000_seomatic_addHumansField','2016-01-19 16:04:43','2016-01-19 16:04:43','2016-01-19 16:04:43','be0031cc-a464-4f76-a2ca-9526c57266dd'),(41,25,'m151226_000000_seomatic_addTwitterFacebookFields','2016-01-19 16:04:43','2016-01-19 16:04:43','2016-01-19 16:04:43','8c60976c-cfb9-4e93-b561-191168cd942f'),(42,25,'m160101_000000_seomatic_addRobotsFields','2016-01-19 16:04:43','2016-01-19 16:04:43','2016-01-19 16:04:43','08150c39-519a-4222-8dfd-83db954844c5'),(43,25,'m160111_000000_seomatic_addTitleFields','2016-01-19 16:04:43','2016-01-19 16:04:43','2016-01-19 16:04:43','6c7d54bc-41f9-48a5-b739-00f2912505c7'),(48,20,'m160117_000000_reasons_addFieldLayoutIdColumn','2016-01-19 16:53:54','2016-01-19 16:53:54','2016-01-19 16:53:54','34724ab7-fe52-41f9-87ca-ee6b4435ea79'),(49,25,'m160122_000000_seomatic_addTypeFields','2016-02-08 09:46:07','2016-02-08 09:46:07','2016-02-08 09:46:07','8ce216a7-1575-4979-80bc-890db5a21f23'),(50,25,'m160123_000000_seomatic_addOpeningHours','2016-02-08 09:46:07','2016-02-08 09:46:07','2016-02-08 09:46:07','2006f848-5e1b-4b74-b4ed-32bfc0dd74a6'),(51,25,'m160202_000000_seomatic_addSocialHandles','2016-02-08 09:46:08','2016-02-08 09:46:08','2016-02-08 09:46:08','7e72ff9e-a95f-44d4-a0b5-0ea3ed55fe03'),(52,25,'m160204_000000_seomatic_addGoogleAnalytics','2016-02-08 09:46:08','2016-02-08 09:46:08','2016-02-08 09:46:08','c8d5c4d7-2519-47d4-8195-666cb2bd7a4c'),(53,25,'m160205_000000_seomatic_addResturantMenu','2016-02-08 09:46:09','2016-02-08 09:46:09','2016-02-08 09:46:09','f6600475-3680-47b4-93e5-827112386ab8'),(54,25,'m160206_000000_seomatic_addGoogleAnalyticsPlugins','2016-02-08 09:46:09','2016-02-08 09:46:09','2016-02-08 09:46:09','5012d302-c706-485c-bfc2-6f1005340cfa'),(55,25,'m160206_000000_seomatic_addGoogleAnalyticsSendPageView','2016-02-08 09:46:10','2016-02-08 09:46:10','2016-02-08 09:46:10','970c984b-836e-448f-9d92-b730e71ced36'),(56,25,'m160209_000000_seomatic_alterDescriptionsColumns','2016-02-15 11:47:46','2016-02-15 11:47:46','2016-02-15 11:47:46','8392a067-d5be-4ba2-b2a7-77e5da743115'),(57,25,'m160209_000001_seomatic_addRobotsTxt','2016-02-15 11:47:46','2016-02-15 11:47:46','2016-02-15 11:47:46','07257513-deb5-4878-a0d1-ef6ddc7f9535'),(58,NULL,'m160223_000000_sortorder_to_smallint','2016-02-26 12:40:37','2016-02-26 12:40:37','2016-02-26 12:40:37','9588b6e5-da78-40eb-b112-b1618688367a'),(59,25,'m160227_000000_seomatic_addFacebookAppId','2016-03-01 13:46:56','2016-03-01 13:46:56','2016-03-01 13:46:56','c15345dd-a775-4498-85f3-6b5c200bbb35'),(60,NULL,'m160114_000000_asset_sources_public_url_default_true','2016-03-14 09:38:38','2016-03-14 09:38:38','2016-03-14 09:38:38','76131bfa-aac9-4838-b024-06b06f161299'),(61,NULL,'m160229_000000_set_default_entry_statuses','2016-03-14 09:38:38','2016-03-14 09:38:38','2016-03-14 09:38:38','5a0baa99-1351-4f14-833f-c6e36fcad40c'),(62,NULL,'m160304_000000_client_permissions','2016-03-14 09:38:38','2016-03-14 09:38:38','2016-03-14 09:38:38','eba0ff49-3221-4919-9e73-7a74770b311f'),(63,NULL,'m160322_000000_asset_filesize','2016-04-11 13:35:59','2016-04-11 13:35:59','2016-04-11 13:35:59','234ddd8b-d410-40eb-96c6-7f334a512904'),(64,25,'m160416_000000_seomatic_addContactPoints','2016-04-20 17:24:14','2016-04-20 17:24:14','2016-04-20 17:24:14','d99fdc19-6841-41f9-870a-bf17b73cbd40'),(65,NULL,'m160503_000000_orphaned_fieldlayouts','2016-05-06 13:23:51','2016-05-06 13:23:51','2016-05-06 13:23:51','a75d0f00-3535-4273-abc6-54175df947bc'),(66,25,'m160509_000000_seomatic_addSiteLinksBing','2016-05-12 07:40:04','2016-05-12 07:40:04','2016-05-12 07:40:04','ce57b098-b788-4311-8e26-d3eece0a73b9'),(67,NULL,'m160510_000000_tasksettings','2016-05-20 08:59:14','2016-05-20 08:59:14','2016-05-20 08:59:14','eda5bc4f-1d2d-47f4-b0d3-cbb0cd48cdc4'),(71,16,'m160625_000000_cpNav_addCustomIconSupport','2016-08-01 10:06:58','2016-08-01 10:06:58','2016-08-01 10:06:58','4b067cb3-8b53-49de-8404-adbc98cd52f3'),(72,25,'m160707_000000_seomatic_addGoogleTagManager','2016-08-01 10:10:43','2016-08-01 10:10:43','2016-08-01 10:10:43','a79ca235-293d-490d-8ec7-0cb96d6a889f'),(73,25,'m160715_000000_seomatic_addSeoImageTransforms','2016-08-01 10:10:49','2016-08-01 10:10:49','2016-08-01 10:10:49','b6ff90c1-bcae-4c9a-acd5-9cbee968a208'),(74,25,'m160723_000000_seomatic_addSeoMainEntityOfPage','2016-08-01 10:10:49','2016-08-01 10:10:49','2016-08-01 10:10:49','a0f19231-24bd-4ee4-9843-c5d39c948634'),(75,25,'m160724_000000_seomatic_addSeoMainEntityCategory','2016-08-01 10:10:49','2016-08-01 10:10:49','2016-08-01 10:10:49','dab084ae-a963-49ba-920d-95e1e8e0c5b0'),(76,25,'m160811_000000_seomatic_addVimeo','2016-08-17 11:56:29','2016-08-17 11:56:29','2016-08-17 11:56:29','a58e7d90-90d1-4eb3-92f1-aaf8bc1a5ebc'),(77,NULL,'m160829_000000_pending_user_content_cleanup','2016-09-14 09:10:17','2016-09-14 09:10:17','2016-09-14 09:10:17','cabb6533-df2b-4b90-a500-3499ec1ac4dd'),(78,NULL,'m160830_000000_asset_index_uri_increase','2016-09-14 09:10:18','2016-09-14 09:10:18','2016-09-14 09:10:18','e956d954-22b8-45bc-a593-572c6a9ceb60'),(79,25,'m160904_000000_seomatic_addTwitterFacebookImages','2016-09-14 09:10:24','2016-09-14 09:10:24','2016-09-14 09:10:24','da78c383-fa7f-467e-afa2-a8c8985febf5'),(80,NULL,'m160919_000000_usergroup_handle_title_unique','2016-09-30 07:43:49','2016-09-30 07:43:49','2016-09-30 07:43:49','50ef647c-8d70-466a-bac7-11f587f8ecd3'),(81,NULL,'m161108_000000_new_version_format','2016-12-01 09:12:23','2016-12-01 09:12:23','2016-12-01 09:12:23','658a40d1-35f7-4855-baf0-576cb8a3f434'),(82,NULL,'m161109_000000_index_shuffle','2016-12-01 09:12:23','2016-12-01 09:12:23','2016-12-01 09:12:23','2db6a1e5-fe4b-417f-bc65-a7ebb934d59d'),(83,25,'m161220_000000_seomatic_addPriceRange','2017-01-12 08:45:43','2017-01-12 08:45:43','2017-01-12 08:45:43','e5a38355-ac8e-469a-95a2-2ca518807af9'),(84,44,'m150212_145000_AmNav_renamePagesToNodes','2017-03-29 14:03:19','2017-03-29 14:03:19','2017-03-29 14:03:19','cbbecf4f-be2d-4671-a54b-7f572cd07c30'),(85,44,'m150217_112800_AmNav_expandPageData','2017-03-29 14:03:19','2017-03-29 14:03:19','2017-03-29 14:03:19','091063bb-23a8-47eb-9489-0df4a37478fe'),(86,44,'m150403_093000_AmNav_nodesWithElements','2017-03-29 14:03:19','2017-03-29 14:03:19','2017-03-29 14:03:19','558bae4e-79f8-4c7f-ac27-fb281459bab9'),(87,44,'m150512_105600_AmNav_addOptionalClass','2017-03-29 14:03:19','2017-03-29 14:03:19','2017-03-29 14:03:19','3f994810-7193-46e0-b7a5-559f714ed401'),(88,45,'m160428_202308_Neo_UpdateBlockLevels','2017-03-30 13:32:42','2017-03-30 13:32:42','2017-03-30 13:32:42','b1b69df1-0674-43e7-8c7c-2df519efbc1c'),(89,45,'m160515_005002_Neo_UpdateBlockStructure','2017-03-30 13:32:42','2017-03-30 13:32:42','2017-03-30 13:32:42','800ad1d3-faea-4504-b38f-f7dad3d8e6b4'),(90,45,'m160605_191540_Neo_UpdateBlockStructureLocales','2017-03-30 13:32:42','2017-03-30 13:32:42','2017-03-30 13:32:42','d4135181-8a66-4242-abed-a7fc0f6b2046'),(91,45,'m161029_230849_Neo_AddMaxChildBlocksSetting','2017-03-30 13:32:42','2017-03-30 13:32:42','2017-03-30 13:32:42','28432ece-5df0-43a4-9bb5-2cc31829952c'),(92,25,'m170212_000000_seomatic_addGoogleAnalyticsAnonymizeIp','2017-03-30 13:55:50','2017-03-30 13:55:50','2017-03-30 13:55:50','5efcdb0f-9046-4829-b6ef-c238ab61539b'),(93,25,'m170212_000000_seomatic_addWikipedia','2017-03-30 13:55:51','2017-03-30 13:55:51','2017-03-30 13:55:51','4f7d2d23-f5c1-4e5f-803c-72f972d8f656'),(94,46,'m151115_000000_sproutFields_addNotesStyles','2017-04-03 14:55:41','2017-04-03 14:55:41','2017-04-03 14:55:41','18f3b9cf-e05c-4a7f-a415-7277ea69b0ea');
/*!40000 ALTER TABLE `craft_migrations` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_neoblocks`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_neoblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) DEFAULT NULL,
  `collapsed` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `ownerLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_neoblocks_ownerId_idx` (`ownerId`),
  KEY `craft_neoblocks_fieldId_idx` (`fieldId`),
  KEY `craft_neoblocks_typeId_idx` (`typeId`),
  KEY `craft_neoblocks_collapsed_idx` (`collapsed`),
  KEY `craft_neoblocks_ownerLocale_fk` (`ownerLocale`),
  CONSTRAINT `craft_neoblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_neoblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_neoblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_neoblocks_ownerLocale_fk` FOREIGN KEY (`ownerLocale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_neoblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_neoblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_neoblocks`
--

LOCK TABLES `craft_neoblocks` WRITE;
/*!40000 ALTER TABLE `craft_neoblocks` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_neoblocks` VALUES (10,3,25,1,0,NULL,'2017-03-30 13:38:56','2017-04-05 21:08:43','d722c261-a7cb-427f-b536-52de686f8618'),(11,3,25,1,0,NULL,'2017-03-30 13:38:56','2017-04-05 21:08:43','de85f580-f0d8-4c05-87e7-63a43ab0bf10'),(12,3,25,1,0,NULL,'2017-03-30 13:38:56','2017-04-05 21:08:43','f5b333ff-a392-41f1-8aa6-947147c73777'),(13,3,25,1,0,NULL,'2017-03-30 13:38:56','2017-04-05 21:08:43','c0959926-82d7-42ed-af51-cfda233908d1'),(14,3,25,1,0,NULL,'2017-03-30 13:46:52','2017-04-05 21:08:43','1a7c646f-7c30-4759-a200-48fc5d283213'),(15,3,25,1,0,NULL,'2017-03-30 14:40:03','2017-04-05 21:08:43','de51a374-27e1-4137-9bdc-9da5d8422c6a'),(16,3,25,1,0,NULL,'2017-03-30 14:40:03','2017-04-05 21:08:43','03a98f60-ac7a-4415-8791-7920890446bf');
/*!40000 ALTER TABLE `craft_neoblocks` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_neoblockstructures`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_neoblockstructures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `ownerLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_neoblockstructures_structureId_idx` (`structureId`),
  KEY `craft_neoblockstructures_ownerId_idx` (`ownerId`),
  KEY `craft_neoblockstructures_fieldId_idx` (`fieldId`),
  KEY `craft_neoblockstructures_ownerLocale_fk` (`ownerLocale`),
  CONSTRAINT `craft_neoblockstructures_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_neoblockstructures_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_neoblockstructures_ownerLocale_fk` FOREIGN KEY (`ownerLocale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_neoblockstructures_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_neoblockstructures`
--

LOCK TABLES `craft_neoblockstructures` WRITE;
/*!40000 ALTER TABLE `craft_neoblockstructures` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_neoblockstructures` VALUES (16,16,3,25,NULL,'2017-04-05 21:08:43','2017-04-05 21:08:43','e4c7676a-a8c3-4f3d-a037-57276ae4d5be');
/*!40000 ALTER TABLE `craft_neoblockstructures` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_neoblocktypes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_neoblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `maxBlocks` int(11) DEFAULT '0',
  `maxChildBlocks` int(11) DEFAULT '0',
  `childBlocks` text COLLATE utf8_unicode_ci,
  `topLevel` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_neoblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `craft_neoblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `craft_neoblocktypes_fieldId_fk` (`fieldId`),
  KEY `craft_neoblocktypes_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_neoblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_neoblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_neoblocktypes`
--

LOCK TABLES `craft_neoblocktypes` WRITE;
/*!40000 ALTER TABLE `craft_neoblocktypes` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_neoblocktypes` VALUES (1,25,54,'Tekst eller bilde','tekstEllerBilde',NULL,NULL,'',1,2,'2017-03-30 13:36:59','2017-03-30 13:48:54','b8a88a59-56a6-4981-aa5f-edb212b6e909'),(2,25,55,'Video','video',NULL,NULL,'',1,4,'2017-03-30 13:36:59','2017-03-30 13:48:54','aef9fd88-5555-44ab-b7d8-10983c463657'),(3,25,56,'Lyd','lyd',NULL,NULL,'',1,6,'2017-03-30 13:36:59','2017-03-30 13:48:54','fa2aa740-5e8c-47d9-979e-2d8e161f3fb9');
/*!40000 ALTER TABLE `craft_neoblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_neogroups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_neogroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_neogroups_fieldId_fk` (`fieldId`),
  CONSTRAINT `craft_neogroups_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_neogroups`
--

LOCK TABLES `craft_neogroups` WRITE;
/*!40000 ALTER TABLE `craft_neogroups` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_neogroups` VALUES (10,25,'Tekst eller bilde',1,'2017-03-30 13:48:54','2017-03-30 13:48:54','6cd21d99-6ae2-4ac9-a057-a6b8205c4817'),(11,25,'Video',3,'2017-03-30 13:48:54','2017-03-30 13:48:54','d5c856ae-3a82-4ff2-8450-1ceb2c876f20'),(12,25,'Lyd',5,'2017-03-30 13:48:54','2017-03-30 13:48:54','6b297786-c63f-42b1-b0f7-3e24fa33ecd7');
/*!40000 ALTER TABLE `craft_neogroups` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_plugins`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `class` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `version` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `schemaVersion` varchar(15) COLLATE utf8_unicode_ci DEFAULT NULL,
  `licenseKey` char(24) COLLATE utf8_unicode_ci DEFAULT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','unknown') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'unknown',
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `settings` text COLLATE utf8_unicode_ci,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_plugins`
--

LOCK TABLES `craft_plugins` WRITE;
/*!40000 ALTER TABLE `craft_plugins` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_plugins` VALUES (1,'Directory','1.0.12',NULL,NULL,'unknown',1,NULL,'2014-10-08 10:52:21','2014-10-08 10:52:21','2014-10-08 10:52:21','aba3661c-99d2-4d34-9788-30e05197134f'),(3,'ObsoleteRedirect','0.1.0',NULL,NULL,'unknown',1,NULL,'2015-05-14 10:49:46','2015-05-14 10:49:46','2017-04-05 21:08:21','94eaed70-d03e-430c-be1f-18f0a30612d4'),(5,'AssetRev','3.0.0',NULL,NULL,'unknown',1,'{\"manifestPath\":\"..\\/cachebust.json\"}','2015-06-16 14:53:46','2015-06-16 14:53:46','2017-04-05 21:08:21','5c6c2959-e9ef-49b3-b92b-8529b4157f0d'),(6,'Guano','0.2',NULL,NULL,'unknown',1,NULL,'2015-10-08 11:08:49','2015-10-08 11:08:49','2017-04-05 21:08:21','feba2548-9685-4cfb-ad7a-d1e4776bb9cc'),(8,'ImageResizer','1.0.0','1.0.0',NULL,'unknown',1,'{\"enabled\":\"1\",\"imageWidth\":\"2048\",\"imageHeight\":\"2048\",\"imageQuality\":\"100\",\"assetSources\":\"*\"}','2015-10-23 10:00:34','2015-10-23 10:00:34','2017-04-05 21:08:21','4c10ef35-fcc0-4f06-9d43-c6d14622a053'),(9,'SuperTable','1.0.4','1.0.0',NULL,'unknown',1,NULL,'2015-10-23 15:33:34','2015-10-23 15:33:34','2017-04-05 21:08:21','f99b9499-b2b3-4189-9f1d-c4554def3374'),(11,'EntryTitleEditable','1.0',NULL,NULL,'unknown',1,NULL,'2015-10-23 16:17:02','2015-10-23 16:17:02','2016-01-19 15:50:10','07dc8a59-da92-47cc-9f30-759d07e05ac3'),(12,'LabelEnvironment','0.1.0',NULL,NULL,'unknown',1,'{\"colorMappings\":{\"development\":\"#000000\",\"staging\":\"#0000ff\",\"preview\":\"#ff0000\",\"production\":\"#16c68e\"},\"prefix\":\"\",\"suffix\":\"\"}','2015-10-25 11:35:32','2015-10-25 11:35:32','2017-04-05 21:08:21','7b4fe278-6804-4f70-b0bf-e61c7fdf6d2c'),(16,'CpNav','1.7.6','1.1.0',NULL,'unknown',1,'{\"showQuickAddMenu\":\"\"}','2015-10-25 12:33:15','2015-10-25 12:33:15','2017-04-05 21:08:21','0b042902-349c-41ef-98d8-bb2a31b445cd'),(17,'Imager','1.5.0','1.0.0',NULL,'unknown',1,NULL,'2015-10-30 15:57:14','2015-10-30 15:57:14','2017-04-05 21:08:21','b0c87aa0-53d6-4420-a297-2211da547370'),(19,'CpFieldLinks','1.2.2','1.0',NULL,'unknown',1,NULL,'2015-11-13 09:56:41','2015-11-13 09:56:41','2017-04-05 21:08:21','d5fd8f41-473d-42e9-9145-bf64eea6d7f3'),(20,'Reasons','1.0.8','1.1',NULL,'unknown',1,NULL,'2015-11-13 10:49:20','2015-11-13 10:49:20','2017-04-05 21:08:21','208a9b9d-dc2c-48a3-92f5-7e6da66d905a'),(22,'QuickField','0.3.4','1.0.0',NULL,'unknown',1,NULL,'2015-12-08 09:34:10','2015-12-08 09:34:10','2017-04-05 21:08:21','e8aac0ec-e200-4781-aacb-465aa765abb4'),(24,'FocalPointField','1.0.2',NULL,NULL,'unknown',1,NULL,'2016-01-19 15:57:13','2016-01-19 15:57:13','2017-04-05 21:08:21','623245d2-1fe2-4cbb-b4d6-405c5667e449'),(25,'Seomatic','1.1.45','1.1.25',NULL,'unknown',1,NULL,'2016-01-19 16:04:43','2016-01-19 16:04:43','2017-04-05 21:08:21','8f159c1e-3a2a-4b08-adc7-1cac6fb79747'),(26,'Sitemap','v1.0.0-alpha.4',NULL,NULL,'unknown',1,NULL,'2016-01-19 16:13:28','2016-01-19 16:13:28','2017-04-05 21:08:21','273cbb5c-e494-4e7b-aabd-464c3e5fb078'),(29,'Relabel','0.1.3','1.0.0',NULL,'unknown',1,NULL,'2016-01-19 16:57:21','2016-01-19 16:57:21','2017-04-05 21:08:21','5294ce3b-08d7-4bd3-8e2f-6ff84c6cb5ca'),(35,'Inlin','1.1',NULL,NULL,'unknown',1,NULL,'2016-04-12 14:46:20','2016-04-12 14:46:20','2017-04-05 21:08:21','dc6d6c60-82fe-4d66-bf61-d6c6fad7a3d8'),(41,'SidebarEnhancer','1.0.5','1.0.0',NULL,'unknown',1,NULL,'2016-08-23 15:05:37','2016-08-23 15:05:37','2017-04-05 21:08:21','727e244d-3684-49e7-b6c9-175cd8bc7de3'),(43,'Minify','1.1.2','1.0.0',NULL,'unknown',1,NULL,'2016-09-14 09:50:49','2016-09-14 09:50:49','2017-04-05 21:08:21','43ad78cb-1618-4d15-b6d9-92ca5769fbfc'),(44,'AmNav','1.7.4','1.7.4',NULL,'unknown',1,NULL,'2017-03-29 14:03:19','2017-03-29 14:03:19','2017-04-05 21:08:21','8457e4c2-eeb4-4065-99dc-0662002b2b98'),(45,'Neo','1.4.1','1.4.1',NULL,'unknown',1,NULL,'2017-03-30 13:32:42','2017-03-30 13:32:42','2017-04-05 21:08:21','789c6c19-8d78-4763-b1bf-d6f7f3131add'),(46,'SproutFields','2.1.0','2.0.3',NULL,'unknown',1,'{\"infoPrimaryDocumentation\":\".field[id$=fields-{{ name }}-field] {\\r\\n  background-color: #d9edf7;\\r\\n  padding: 10px;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] label {\\r\\n  color: #000;\\r\\n  cursor: pointer;\\r\\n  display: block;\\r\\n  font-size: 1em;\\r\\n  font-weight: bold;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] .input {\\r\\n  border-top: 1px solid #bbd2dd;\\r\\n  padding-top:.5em;\\r\\n  margin-top: .5em;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h1,\\r\\n.field[id$=fields-{{ name }}-field] h2,\\r\\n.field[id$=fields-{{ name }}-field] h3 {\\r\\n  color: #29323d;\\r\\n  font-size: 1em;\\r\\n  font-weight: bold;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h1,\\r\\n.field[id$=fields-{{ name }}-field] h2 {\\r\\n  border-bottom: 1px solid #c8dae2;\\r\\n  font-weight: bold;\\r\\n  padding: 0 0 .5em;\\r\\n  margin: .5em 0;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h1 {\\r\\n  text-transform: uppercase;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h3 {\\r\\n  color: #444;\\r\\n  margin-bottom: .2em;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h3 + p {\\r\\n  margin-top: 0;\\r\\n  padding-top: 0;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] p {\\r\\n  color: #232323;\\r\\n  font-size: 1em;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] ul {\\r\\n  color: #232323;\\r\\n  list-style-type: disc;\\r\\n  margin: 0 0 1em 3em;\\r\\n}\",\"infoSecondaryDocumentation\":\".field[id$=fields-{{ name }}-field] {\\r\\n  background-color: #eee;\\r\\n  padding: 10px;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] label {\\r\\n  color: #000;\\r\\n  cursor: pointer;\\r\\n  display: block;\\r\\n  font-size: 1em;\\r\\n  font-weight: bold;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] .input {\\r\\n  border-top: 1px solid #c6c6c6;\\r\\n  padding-top:.5em;\\r\\n  margin-top: .5em;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h1,\\r\\n.field[id$=fields-{{ name }}-field] h2,\\r\\n.field[id$=fields-{{ name }}-field] h3 {\\r\\n  color: #29323d;\\r\\n  font-size: 1em;\\r\\n  font-weight: bold;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h1,\\r\\n.field[id$=fields-{{ name }}-field] h2 {\\r\\n  border-bottom: 1px solid #dddddd;\\r\\n  font-weight: bold;\\r\\n  padding: 0 0 .5em;\\r\\n  margin: .5em 0;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h1 {\\r\\n  text-transform: uppercase;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h3 {\\r\\n  color: #444;\\r\\n  margin-bottom: .2em;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h3 + p {\\r\\n  margin-top: 0;\\r\\n  padding-top: 0;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] p {\\r\\n  color: #232323;\\r\\n  font-size: 1em;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] ul {\\r\\n  color: #232323;\\r\\n  list-style-type: disc;\\r\\n  margin: 0 0 1em 3em;\\r\\n}\",\"warningDocumentation\":\".field[id$=fields-{{ name }}-field] {\\r\\n  background-color: #fcf8e3;\\r\\n  padding: 10px;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] label {\\r\\n  color: #000;\\r\\n  cursor: pointer;\\r\\n  display: block;\\r\\n  font-size: 1em;\\r\\n  font-weight: bold;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] .input {\\r\\n  border-top: 1px solid #e4d1b0;\\r\\n  padding-top:.5em;\\r\\n  margin-top: .5em;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h1,\\r\\n.field[id$=fields-{{ name }}-field] h2,\\r\\n.field[id$=fields-{{ name }}-field] h3 {\\r\\n  color: #29323d;\\r\\n  font-size: 1em;\\r\\n  font-weight: bold;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h1,\\r\\n.field[id$=fields-{{ name }}-field] h2 {\\r\\n  border-bottom: 1px solid #f7e9d1;\\r\\n  font-weight: bold;\\r\\n  padding: 0 0 .5em;\\r\\n  margin: .5em 0;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h1 {\\r\\n  text-transform: uppercase;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h3 {\\r\\n  color: #444;\\r\\n  margin-bottom: .2em;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h3 + p {\\r\\n  margin-top: 0;\\r\\n  padding-top: 0;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] p {\\r\\n  color: #232323;\\r\\n  font-size: 1em;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] ul {\\r\\n  color: #232323;\\r\\n  list-style-type: disc;\\r\\n  margin: 0 0 1em 3em;\\r\\n}\",\"dangerDocumentation\":\".field[id$=fields-{{ name }}-field] {\\r\\n  background-color: #ffe1e1;\\r\\n  padding: 10px;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] label {\\r\\n  color: #000;\\r\\n  cursor: pointer;\\r\\n  display: block;\\r\\n  font-size: 1em;\\r\\n  font-weight: bold;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] .input {\\r\\n  border-top: 1px solid #ddb9b9;\\r\\n  padding-top:.5em;\\r\\n  margin-top: .5em;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h1,\\r\\n.field[id$=fields-{{ name }}-field] h2,\\r\\n.field[id$=fields-{{ name }}-field] h3 {\\r\\n  color: #29323d;\\r\\n  font-size: 1em;\\r\\n  font-weight: bold;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h1,\\r\\n.field[id$=fields-{{ name }}-field] h2 {\\r\\n  border-bottom: 1px solid #f3cccc;\\r\\n  font-weight: bold;\\r\\n  padding: 0 0 .5em;\\r\\n  margin: .5em 0;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h1 {\\r\\n  text-transform: uppercase;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h3 {\\r\\n  color: #444;\\r\\n  margin-bottom: .2em;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h3 + p {\\r\\n  margin-top: 0;\\r\\n  padding-top: 0;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] p {\\r\\n  color: #232323;\\r\\n  font-size: 1em;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] ul {\\r\\n  color: #232323;\\r\\n  list-style-type: disc;\\r\\n  margin: 0 0 1em 3em;\\r\\n}\",\"highlightDocumentation\":\".field[id$=fields-{{ name }}-field] {\\r\\n  background-color: #dbf7d9;\\r\\n  padding: 10px;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] label {\\r\\n  color: #000;\\r\\n  cursor: pointer;\\r\\n  display: block;\\r\\n  font-size: 1em;\\r\\n  font-weight: bold;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] .input {\\r\\n  border-top: 1px solid #b6c8b5;\\r\\n  padding-top:.5em;\\r\\n  margin-top: .5em;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h1,\\r\\n.field[id$=fields-{{ name }}-field] h2,\\r\\n.field[id$=fields-{{ name }}-field] h3 {\\r\\n  color: #29323d;\\r\\n  font-size: 1em;\\r\\n  font-weight: bold;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h1,\\r\\n.field[id$=fields-{{ name }}-field] h2 {\\r\\n  border-bottom: 1px solid #c5e1c3;\\r\\n  font-weight: bold;\\r\\n  padding: 0 0 .5em;\\r\\n  margin: .5em 0;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h1 {\\r\\n  text-transform: uppercase;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h3 {\\r\\n  color: #444;\\r\\n  margin-bottom: .2em;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] h3 + p {\\r\\n  margin-top: 0;\\r\\n  padding-top: 0;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] p {\\r\\n  color: #232323;\\r\\n  font-size: 1em;\\r\\n}\\r\\n.field[id$=fields-{{ name }}-field] ul {\\r\\n  color: #232323;\\r\\n  list-style-type: disc;\\r\\n  margin: 0 0 1em 3em;\\r\\n}\"}','2017-04-03 14:55:41','2017-04-03 14:55:41','2017-04-05 21:08:21','14ab3809-7392-4ae4-8f29-aabb59ebefef');
/*!40000 ALTER TABLE `craft_plugins` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_rackspaceaccess`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_rackspaceaccess` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `connectionKey` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `storageUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `cdnUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_rackspaceaccess_connectionKey_unq_idx` (`connectionKey`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_rackspaceaccess`
--

LOCK TABLES `craft_rackspaceaccess` WRITE;
/*!40000 ALTER TABLE `craft_rackspaceaccess` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_rackspaceaccess` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_reasons`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_reasons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `conditionals` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_reasons_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_reasons_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_reasons`
--

LOCK TABLES `craft_reasons` WRITE;
/*!40000 ALTER TABLE `craft_reasons` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_reasons` VALUES (4,54,'{\"22\":[[{\"fieldId\":26,\"compare\":\"==\",\"value\":\"true\"}]],\"24\":[[{\"fieldId\":23,\"compare\":\"==\",\"value\":\"notnull\"}]]}','2017-03-30 13:48:54','2017-03-30 13:48:54','cc0b7616-0d05-414e-8756-ae42bcfd4ae6');
/*!40000 ALTER TABLE `craft_reasons` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_relabel`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_relabel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) DEFAULT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `instructions` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_relabel_fieldId_fk` (`fieldId`),
  KEY `craft_relabel_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_relabel_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relabel_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_relabel`
--

LOCK TABLES `craft_relabel` WRITE;
/*!40000 ALTER TABLE `craft_relabel` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_relabel` VALUES (1,23,42,'Stort bilde',NULL,'2017-03-29 14:07:53','2017-03-29 14:07:53','d2b32354-39ab-48fa-9437-e80a5af4720e'),(5,24,54,'Bildeposisjon',NULL,'2017-03-30 13:48:54','2017-03-30 13:48:54','eb22312c-5c64-4201-a977-4dbc48e8d643');
/*!40000 ALTER TABLE `craft_relabel` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_relations`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_relations_fieldId_sourceId_sourceLocale_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceLocale`,`targetId`),
  KEY `craft_relations_sourceId_fk` (`sourceId`),
  KEY `craft_relations_sourceLocale_fk` (`sourceLocale`),
  KEY `craft_relations_targetId_fk` (`targetId`),
  CONSTRAINT `craft_relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_relations_sourceLocale_fk` FOREIGN KEY (`sourceLocale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=68 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_relations`
--

LOCK TABLES `craft_relations` WRITE;
/*!40000 ALTER TABLE `craft_relations` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_relations` VALUES (46,23,2,NULL,6,1,'2017-04-03 13:23:00','2017-04-03 13:23:00','484fffe2-e368-4e8f-94a0-e669212e6e7b'),(59,31,17,NULL,6,1,'2017-04-03 14:56:59','2017-04-03 14:56:59','8f15b923-b0ba-405c-9e25-d5439dc2f7c2'),(60,31,18,NULL,7,1,'2017-04-03 14:56:59','2017-04-03 14:56:59','371bcdd1-3e75-44fa-8f98-22966b2e0191'),(61,31,19,NULL,8,1,'2017-04-03 14:56:59','2017-04-03 14:56:59','79d67ca4-cf6f-40dc-aca4-5ee30d79ddfa'),(62,31,20,NULL,9,1,'2017-04-03 14:56:59','2017-04-03 14:56:59','4c3d5350-c522-44d8-b5ab-ab9002eb3766'),(63,23,10,NULL,8,1,'2017-04-05 21:08:43','2017-04-05 21:08:43','5c1d2f36-e716-4ffa-a77a-cd2770d53a78'),(64,23,11,NULL,9,1,'2017-04-05 21:08:43','2017-04-05 21:08:43','ee101c82-b45f-4172-a08b-1e65a2f9f14b'),(65,23,12,NULL,7,1,'2017-04-05 21:08:43','2017-04-05 21:08:43','e317428d-8f96-4c76-b6af-db7550f8ce4e'),(66,23,13,NULL,6,1,'2017-04-05 21:08:43','2017-04-05 21:08:43','cbe19e96-50dd-4d16-a5d6-3a94412bc026'),(67,23,16,NULL,9,1,'2017-04-05 21:08:43','2017-04-05 21:08:43','44fe97d9-8807-41e6-827d-da05ed2b0bc1');
/*!40000 ALTER TABLE `craft_relations` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_routes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `locale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `urlParts` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `urlPattern` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `template` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_routes_urlPattern_unq_idx` (`urlPattern`),
  KEY `craft_routes_locale_idx` (`locale`),
  CONSTRAINT `craft_routes_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_routes`
--

LOCK TABLES `craft_routes` WRITE;
/*!40000 ALTER TABLE `craft_routes` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_routes` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_searchindex`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `fieldId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `keywords` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`locale`),
  FULLTEXT KEY `craft_searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_searchindex`
--

LOCK TABLES `craft_searchindex` WRITE;
/*!40000 ALTER TABLE `craft_searchindex` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_searchindex` VALUES (1,'username',0,'nb_no',' admin '),(1,'firstname',0,'nb_no',''),(1,'lastname',0,'nb_no',''),(1,'fullname',0,'nb_no',''),(1,'email',0,'nb_no',' dev lenaknutli com '),(1,'slug',0,'nb_no',''),(2,'slug',0,'nb_no',' forside '),(2,'title',0,'nb_no',' forside '),(3,'slug',0,'nb_no',' historien '),(3,'title',0,'nb_no',' historien '),(4,'slug',0,'nb_no',' publisert '),(4,'title',0,'nb_no',' publisert '),(5,'slug',0,'nb_no',' journalistene '),(5,'title',0,'nb_no',' journalistene '),(2,'field',22,'nb_no',' tilstaelsenlike for jul i 2005 ble det gjennom media kjent at en person i trondelag tor hepso kort tid for han avgikk ved doden 20 desember 2005 skulle ha erkjent a sta bak drapene pa sigrid heggheim og torunn finstad de samme drapene dovstumme fritz moen hadde sonet 18 ar i fengsel for '),(2,'field',23,'nb_no',' drapsmannen 15l '),(6,'field',21,'nb_no',''),(6,'field',18,'nb_no',''),(6,'filename',0,'nb_no',' drapsmannen_15l jpg '),(6,'extension',0,'nb_no',' jpg '),(6,'kind',0,'nb_no',' image '),(6,'slug',0,'nb_no',' drapsmannen 15l '),(6,'title',0,'nb_no',' drapsmannen 15l '),(7,'field',21,'nb_no',''),(7,'field',18,'nb_no',''),(7,'filename',0,'nb_no',' drapsmannen_16 jpg '),(7,'extension',0,'nb_no',' jpg '),(7,'kind',0,'nb_no',' image '),(7,'slug',0,'nb_no',' drapsmannen 16 '),(7,'title',0,'nb_no',' drapsmannen 16 '),(8,'field',21,'nb_no',''),(8,'field',18,'nb_no',''),(8,'filename',0,'nb_no',' nidarvoll_01 jpg '),(8,'extension',0,'nb_no',' jpg '),(8,'kind',0,'nb_no',' image '),(8,'slug',0,'nb_no',' nidarvoll 01 '),(8,'title',0,'nb_no',' nidarvoll 01 '),(9,'field',21,'nb_no',''),(9,'field',18,'nb_no',''),(9,'filename',0,'nb_no',' stavne_sletta_03 jpg '),(9,'extension',0,'nb_no',' jpg '),(9,'kind',0,'nb_no',' image '),(9,'slug',0,'nb_no',' stavne sletta 03 '),(9,'title',0,'nb_no',' stavne sletta 03 '),(3,'field',22,'nb_no',' historien bak tilstaelsen11 september 1976 ble sigrid heggheim 20 fra jolster funnet drept pa et jorde pa nidarvoll i trondheim sigrid var ny i i byen og ble sist sett pa studentersamfundet kvelden 4 september '),(3,'field',25,'nb_no',''),(10,'field',22,'nb_no',' 11 september 1976 ble sigrid heggheim 20 fra jolster funnet drept pa et jorde pa nidarvoll i trondheim sigrid var ny i i byen og ble sist sett pa studentersamfundet kvelden 4 september '),(10,'field',23,'nb_no',' nidarvoll 01 '),(10,'field',24,'nb_no',' left '),(10,'slug',0,'nb_no',''),(11,'field',22,'nb_no',' 06 oktober 1977 ble torunn finstad 20 fra kongsberg funnet drept ved stavne bru i trondheim likheten til drapet pa sigrid heggheim elleve maneder tidligere var sa mange at politiet mente at de matte vaere samme gjerningsmann '),(11,'field',23,'nb_no',' stavne sletta 03 '),(11,'field',24,'nb_no',' left '),(11,'slug',0,'nb_no',''),(12,'field',22,'nb_no',' tor hepso var 38 ar i 1976 han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60 tallet i 1973 begynte han a jobbe pa oljeplattformen nordskald der fikk han etterhvert stilling som kontrollromsoperator og hadde ansvar for stabiliteten pa plattformen det var her han jobbet da drapene pa de unge studentene sigrid og torunn fant sted kripos avdekket at hepso hadde friturnus da begge drapene ble begatt i konklusjonen som kriposetterforsker asbjorn hansen skrev etter a ha undersokt om hepsos tilstaelse kunne vaere sann star det ut fra den etterforskning vi objektivet har gjennomfort kan vi ikke bevise at tor hepso har begatt drapene pa sigrid heggheim og torunn finstad i henholdsvis 1976 og 1977 slik han har tilstatt det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder pa det motsatte at han ikke kan ha drept dem '),(12,'field',23,'nb_no',' drapsmannen 16 '),(12,'field',24,'nb_no',' right '),(12,'slug',0,'nb_no',''),(13,'field',22,'nb_no',''),(13,'field',23,'nb_no',' drapsmannen 15l '),(13,'field',24,'nb_no',' full '),(13,'slug',0,'nb_no',''),(10,'field',26,'nb_no',' 1 '),(11,'field',26,'nb_no',' 1 '),(12,'field',26,'nb_no',' 1 '),(14,'field',26,'nb_no',' 1 '),(14,'field',22,'nb_no',' historien bak tilstaelsen '),(14,'field',23,'nb_no',''),(14,'field',24,'nb_no',' left '),(14,'slug',0,'nb_no',''),(13,'field',26,'nb_no',' 0 '),(15,'field',26,'nb_no',' 1 '),(15,'field',22,'nb_no',' tor hepso var 38 ar i 1976 han var utdannet styrmann og hadde jobbet i utenriksfart fra slutten av 60 tallet i 1973 begynte han a jobbe pa oljeplattformen nordskald der fikk han etterhvert stilling som kontrollromsoperator og hadde ansvar for stabiliteten pa plattformen det var her han jobbet da drapene pa de unge studentene sigrid og torunn fant sted kripos avdekket at hepso hadde friturnus da begge drapene ble begatt i konklusjonen som kriposetterforsker asbjorn hansen skrev etter a ha undersokt om hepsos tilstaelse kunne vaere sann star det ut fra den etterforskning vi objektivet har gjennomfort kan vi ikke bevise at tor hepso har begatt drapene pa sigrid heggheim og torunn finstad i henholdsvis 1976 og 1977 slik han har tilstatt det vi med sikkerhet kan si er at vi ikke har funnet noe som tyder pa det motsatte at han ikke kan ha drept dem '),(15,'field',23,'nb_no',''),(15,'field',24,'nb_no',' left '),(15,'slug',0,'nb_no',''),(16,'field',26,'nb_no',' 1 '),(16,'field',22,'nb_no',' sdfgsdfgsdfgsdfg '),(16,'field',23,'nb_no',' stavne sletta 03 '),(16,'field',24,'nb_no',' full '),(16,'slug',0,'nb_no',''),(4,'field',27,'nb_no',' drapsmannen 15l http www sol no 23 03 2017 kapittel 1 drapsmannen 16 http www sol no 14 04 2017 kapittel 2 nidarvoll 01 http www sol no 15 05 2017 kapittel 3 stavne sletta 03 http www sol no 08 12 2018 kapittel 4 '),(17,'field',28,'nb_no',' kapittel 1 '),(17,'field',29,'nb_no',' 23 03 2017 '),(17,'field',30,'nb_no',' http www sol no '),(17,'field',31,'nb_no',' drapsmannen 15l '),(17,'slug',0,'nb_no',''),(18,'field',28,'nb_no',' kapittel 2 '),(18,'field',29,'nb_no',' 14 04 2017 '),(18,'field',30,'nb_no',' http www sol no '),(18,'field',31,'nb_no',' drapsmannen 16 '),(18,'slug',0,'nb_no',''),(19,'field',28,'nb_no',' kapittel 3 '),(19,'field',29,'nb_no',' 15 05 2017 '),(19,'field',30,'nb_no',' http www sol no '),(19,'field',31,'nb_no',' nidarvoll 01 '),(19,'slug',0,'nb_no',''),(20,'field',28,'nb_no',' kapittel 4 '),(20,'field',29,'nb_no',' 08 12 2018 '),(20,'field',30,'nb_no',' http www sol no '),(20,'field',31,'nb_no',' stavne sletta 03 '),(20,'slug',0,'nb_no','');
/*!40000 ALTER TABLE `craft_searchindex` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_sections`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `type` enum('single','channel','structure') COLLATE utf8_unicode_ci NOT NULL DEFAULT 'channel',
  `hasUrls` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `template` varchar(500) COLLATE utf8_unicode_ci DEFAULT NULL,
  `enableVersioning` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_sections_name_unq_idx` (`name`),
  UNIQUE KEY `craft_sections_handle_unq_idx` (`handle`),
  KEY `craft_sections_structureId_fk` (`structureId`),
  CONSTRAINT `craft_sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_sections`
--

LOCK TABLES `craft_sections` WRITE;
/*!40000 ALTER TABLE `craft_sections` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_sections` VALUES (1,NULL,'Forside','forside','single',1,'index',1,'2017-03-29 14:00:56','2017-03-29 14:20:29','29db14dd-1472-4a46-8244-422d524f3559'),(2,NULL,'Historien','historien','single',1,'historien',1,'2017-03-29 14:01:55','2017-03-29 14:01:55','1da68962-b795-4023-b9ba-f812c315bde2'),(3,NULL,'Publisert','publisert','single',1,'publisert',1,'2017-03-29 14:02:42','2017-03-29 14:02:42','47dd1674-c004-4d21-a426-c2a4dc7cb91d'),(4,NULL,'Journalistene','journalistene','single',1,'journalistene',1,'2017-03-29 14:03:05','2017-03-29 14:03:05','2e748a69-26cd-4690-9435-97af55630491');
/*!40000 ALTER TABLE `craft_sections` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_sections_i18n`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sections_i18n` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `enabledByDefault` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `urlFormat` text COLLATE utf8_unicode_ci,
  `nestedUrlFormat` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_sections_i18n_sectionId_locale_unq_idx` (`sectionId`,`locale`),
  KEY `craft_sections_i18n_locale_fk` (`locale`),
  CONSTRAINT `craft_sections_i18n_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_sections_i18n_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `craft_sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_sections_i18n`
--

LOCK TABLES `craft_sections_i18n` WRITE;
/*!40000 ALTER TABLE `craft_sections_i18n` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_sections_i18n` VALUES (1,1,'nb_no',1,'__home__',NULL,'2017-03-29 14:00:56','2017-03-29 14:02:09','3589e965-4a42-4d94-82c9-6b074fe59d99'),(2,2,'nb_no',1,'historien',NULL,'2017-03-29 14:01:55','2017-03-29 14:01:55','ff97707d-bfba-4e74-a894-0d23b5921b64'),(3,3,'nb_no',1,'publisert',NULL,'2017-03-29 14:02:42','2017-03-29 14:02:42','15bdc4d7-1c0b-4e9b-8522-4b4b53657c7d'),(4,4,'nb_no',1,'journalistene',NULL,'2017-03-29 14:03:05','2017-03-29 14:03:05','19f4b3f6-c26e-4aa5-8d7b-02f9b65704b8');
/*!40000 ALTER TABLE `craft_sections_i18n` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_seomatic_meta`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_seomatic_meta` (
  `id` int(11) NOT NULL,
  `seoImageId` int(11) DEFAULT NULL,
  `seoFacebookImageId` int(11) DEFAULT NULL,
  `seoTwitterImageId` int(11) DEFAULT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'nb_no',
  `elementId` int(10) DEFAULT '0',
  `metaType` enum('default','template') COLLATE utf8_unicode_ci DEFAULT 'template',
  `metaPath` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `seoMainEntityCategory` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `seoMainEntityOfPage` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `seoTitle` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `seoDescription` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `seoKeywords` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `seoTwitterImageTransform` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `seoFacebookImageTransform` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `seoImageTransform` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `twitterCardType` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'summary',
  `openGraphType` varchar(255) COLLATE utf8_unicode_ci DEFAULT 'website',
  `robots` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_seomatic_meta_seoImageId_fk` (`seoImageId`),
  CONSTRAINT `craft_seomatic_meta_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_seomatic_meta_seoImageId_fk` FOREIGN KEY (`seoImageId`) REFERENCES `craft_assetfiles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_seomatic_meta`
--

LOCK TABLES `craft_seomatic_meta` WRITE;
/*!40000 ALTER TABLE `craft_seomatic_meta` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_seomatic_meta` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_seomatic_settings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_seomatic_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteSeoImageId` int(11) DEFAULT NULL,
  `siteSeoFacebookImageId` int(11) DEFAULT NULL,
  `siteSeoTwitterImageId` int(11) DEFAULT NULL,
  `genericOwnerImageId` int(11) DEFAULT NULL,
  `genericCreatorImageId` int(11) DEFAULT NULL,
  `locale` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `siteSeoName` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `siteSeoTitle` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `siteSeoTitleSeparator` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `siteSeoTitlePlacement` enum('before','after','none') COLLATE utf8_unicode_ci DEFAULT 'after',
  `siteSeoDescription` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `siteSeoKeywords` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `siteSeoTwitterImageTransform` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `siteSeoFacebookImageTransform` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `siteSeoImageTransform` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `siteTwitterCardType` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `siteOpenGraphType` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `siteRobots` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `siteRobotsTxt` text COLLATE utf8_unicode_ci NOT NULL,
  `siteLinksQueryInput` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `siteLinksSearchTargets` text COLLATE utf8_unicode_ci NOT NULL,
  `googleSiteVerification` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `bingSiteVerification` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `googleAnalyticsAdvertising` tinyint(1) NOT NULL,
  `googleAnalyticsLinker` tinyint(1) NOT NULL,
  `googleAnalyticsAnonymizeIp` tinyint(1) NOT NULL,
  `googleAnalyticsLinkAttribution` tinyint(1) NOT NULL,
  `googleAnalyticsEEcommerce` tinyint(1) NOT NULL,
  `googleAnalyticsEcommerce` tinyint(1) NOT NULL,
  `googleAnalyticsUID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `googleTagManagerID` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `googleAnalyticsSendPageview` tinyint(1) NOT NULL,
  `siteOwnerType` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `siteOwnerSpecificType` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `siteOwnerSubType` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `genericOwnerName` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerAlternateName` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerDescription` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `genericOwnerUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerTelephone` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerEmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerStreetAddress` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerAddressLocality` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerAddressRegion` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerPostalCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerAddressCountry` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerGeoLatitude` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericOwnerGeoLongitude` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationOwnerDuns` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationOwnerFounder` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationOwnerFoundingDate` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationOwnerFoundingLocation` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationOwnerContactPoints` text COLLATE utf8_unicode_ci NOT NULL,
  `localBusinessPriceRange` varchar(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `localBusinessOwnerOpeningHours` text COLLATE utf8_unicode_ci NOT NULL,
  `corporationOwnerTickerSymbol` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `restaurantOwnerServesCuisine` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `restaurantOwnerReservationsUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `restaurantOwnerMenuUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `personOwnerGender` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `personOwnerBirthPlace` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `twitterHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebookHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebookProfileId` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `facebookAppId` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `linkedInHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `googlePlusHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `youtubeHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `youtubeChannelHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `instagramHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `pinterestHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `githubHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `vimeoHandle` varchar(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `wikipediaUrl` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `siteCreatorType` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `siteCreatorSpecificType` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `siteCreatorSubType` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `genericCreatorName` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorAlternateName` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorDescription` varchar(1024) COLLATE utf8_unicode_ci DEFAULT NULL,
  `genericCreatorUrl` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorTelephone` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorEmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorStreetAddress` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorAddressLocality` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorAddressRegion` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorPostalCode` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorAddressCountry` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorGeoLatitude` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorGeoLongitude` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationCreatorDuns` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationCreatorFounder` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationCreatorFoundingDate` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationCreatorFoundingLocation` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `organizationCreatorContactPoints` text COLLATE utf8_unicode_ci NOT NULL,
  `localBusinessCreatorOpeningHours` text COLLATE utf8_unicode_ci NOT NULL,
  `corporationCreatorTickerSymbol` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `restaurantCreatorServesCuisine` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `restaurantCreatorReservationsUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `restaurantCreatorMenuUrl` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `personCreatorGender` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `personCreatorBirthPlace` varchar(255) COLLATE utf8_unicode_ci DEFAULT '',
  `genericCreatorHumansTxt` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_seomatic_settings_siteSeoImageId_fk` (`siteSeoImageId`),
  KEY `craft_seomatic_settings_genericOwnerImageId_fk` (`genericOwnerImageId`),
  KEY `craft_seomatic_settings_genericCreatorImageId_fk` (`genericCreatorImageId`),
  CONSTRAINT `craft_seomatic_settings_genericCreatorImageId_fk` FOREIGN KEY (`genericCreatorImageId`) REFERENCES `craft_assetfiles` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_seomatic_settings_genericOwnerImageId_fk` FOREIGN KEY (`genericOwnerImageId`) REFERENCES `craft_assetfiles` (`id`) ON DELETE SET NULL,
  CONSTRAINT `craft_seomatic_settings_siteSeoImageId_fk` FOREIGN KEY (`siteSeoImageId`) REFERENCES `craft_assetfiles` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_seomatic_settings`
--

LOCK TABLES `craft_seomatic_settings` WRITE;
/*!40000 ALTER TABLE `craft_seomatic_settings` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_seomatic_settings` VALUES (1,NULL,NULL,NULL,NULL,NULL,'nb_no','Standardcraft','','|','after','This is the default global natural language description of the content on the site pages.','default,global,comma-separated,keywords','','','','summary','website','','# robots.txt for {{ siteUrl }}\r\n\r\nSitemap: {{ siteUrl }}sitemap.xml\r\n\r\n# Don\'t allow web crawlers to index Craft\r\n\r\nUser-agent: *\r\nDisallow: /craft/\r\n','','[]','','',0,0,0,0,0,0,'','',0,'Organization','','Corporation','Standardcraft','','','http://craft.dev/','','','','','','','','','','','','','','[]','','[{\"open\":\"\",\"close\":\"\"},{\"open\":\"\",\"close\":\"\"},{\"open\":\"\",\"close\":\"\"},{\"open\":\"\",\"close\":\"\"},{\"open\":\"\",\"close\":\"\"},{\"open\":\"\",\"close\":\"\"},{\"open\":\"\",\"close\":\"\"}]','','','','','Male','','','','','','','','','','','','','','','LocalBusiness','','','Mustasj','','','http://mustasj.no','+4748313760','post@mustasj.no','Kjøpmannsgata 7','Trondheim','Sør Trøndelag','7014','Norge','63.42890269999999','10.4011382','','','','','[{\"telephone\":\"+4748313760\",\"contactType\":\"customer support\"}]','','','','','','Male','','/* TEAM */\r\n\r\n{% if seomaticCreator.name is defined and seomaticCreator.name %}\r\nCreator: {{ seomaticCreator.name }}\r\n{% endif %}\r\n{% if seomaticCreator.url is defined and seomaticCreator.url %}\r\nURL: {{ seomaticCreator.url }}\r\n{% endif %}\r\n{% if seomaticCreator.description is defined and seomaticCreator.description %}\r\nDescription: {{ seomaticCreator.description }}\r\n{% endif %}\r\n\r\n/* THANKS */\r\n\r\nPixel & Tonic - https://pixelandtonic.com\r\n\r\n/* SITE */\r\n\r\nStandards: HTML5, CSS3\r\nComponents: Craft CMS, Yii, PHP, Javascript, SEOmatic','2016-01-19 16:04:47','2016-06-08 12:37:30','17e178ee-774b-4217-97d0-4548dd640b67');
/*!40000 ALTER TABLE `craft_seomatic_settings` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_sessions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_sessions_uid_idx` (`uid`),
  KEY `craft_sessions_token_idx` (`token`),
  KEY `craft_sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `craft_sessions_userId_fk` (`userId`),
  CONSTRAINT `craft_sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=93 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_sessions`
--

LOCK TABLES `craft_sessions` WRITE;
/*!40000 ALTER TABLE `craft_sessions` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_sessions` VALUES (53,1,'4893bef3c369df586e564b24061bf61b7cc38aa3czozMjoibldQaHBhdzVGMlFtYzdBWmVwVFRLUHhfaG5ZcmZ+MG4iOw==','2016-03-14 09:36:21','2016-03-14 09:36:21','5969dd47-805e-446c-a8f2-1b9864f85784'),(54,1,'36017137ebdc38be935a53fa9f3ede3bd3134846czozMjoiWkVkZWNGOUl4WXp3dG52RUdTbFNKd19vbk5ZRmZyanIiOw==','2016-03-15 14:27:23','2016-03-15 14:27:23','e975b2e2-d4c0-4248-a5df-440f68a0cde1'),(55,1,'82b5a4d5a78de76d120ef24a0121ade326160d14czozMjoiaWhjM05KZnpIX1B6S2NGSjRRbUtHSmw4aVNLVU1oQXEiOw==','2016-03-18 09:50:35','2016-03-18 09:50:35','56089d91-4731-4e3f-b205-eecacf2f0ba6'),(56,1,'35c2fa56be21797c9fdcf9ad36ab1112a0bfaf3bczozMjoiZUE3eFVGV2lfUmREV2NPdlFmUW1UYmNoSVBHemRUVlciOw==','2016-03-23 14:49:15','2016-03-23 14:49:15','d9125f70-1082-472e-98fd-e4be3c4b2be3'),(57,1,'4af3f2d2885e60b54cdcf06f2260fe9b9ed842f5czozMjoifmg1OWE0bjZvdDhoalJxNllWMjloUWdLTHNrcHZQV2wiOw==','2016-04-11 13:26:42','2016-04-11 13:26:42','bad8b6cb-52cb-4468-9980-a412255bd198'),(58,1,'2bebeae4bc62cc32e9438359bba2721227c42fcbczozMjoibmNWQjh1bkhVdUF6d3o3d185MkppNzJsbHBmbHVma1AiOw==','2016-04-12 14:45:38','2016-04-12 14:45:38','0028cafe-b363-4302-803b-96a1217579c2'),(59,1,'93982bf48378d278e89c5181578c1ef1b291b199czozMjoiOGVTRVBwSnJGTTRBWnZmdXpfSlRqRnFpOTJDYU5qUVUiOw==','2016-04-20 17:24:44','2016-04-20 17:24:44','cf15adf5-a2c8-4ed0-bda3-467ab4679182'),(60,1,'08e530b0f90255576b2cfa6dab822e7eeb722b18czozMjoiMUlid1NzVHVTdmtfMlA0SExZdklrQ3BHZGVsaHhrUE8iOw==','2016-04-26 11:07:10','2016-04-26 11:07:10','8953fec6-ce13-46ea-b188-29acf0daebb5'),(61,1,'c467fa26071f9348c29cab0fda4fb4d99e84dad3czozMjoiRjgxeE10SmVKc0IwSnoxajNSZHdzdGZ6QUVoMzZDT1oiOw==','2016-04-27 16:17:45','2016-04-27 16:17:45','f1aa051d-f85f-497e-9ab5-ad9ae6a1f9d3'),(62,1,'180823852cc582bfc4f803ab3e0cd7d796ba1be6czozMjoidXY4VlpWNDA1cXFIaFV3WTBFZmdDZn55VHVqbVJ2dXYiOw==','2016-04-29 15:12:50','2016-04-29 15:12:50','28ec656e-466c-4f19-b0e0-4af8493a2719'),(63,1,'475d52a0118759839fb87e90bbde9e8db443bdb0czozMjoiWkx3ZUo2TkJwTXVrck9hWU5iaXRiZVBRa2lIQ3gxcXkiOw==','2016-05-03 09:06:40','2016-05-03 09:06:40','80db662e-d0a0-41d3-80b4-3be2e629d90e'),(64,1,'02dd0c6652e90e0ea0b75778c3c28df0acd68c1cczozMjoiVFY3a09DXzNzMFFJUnFwRkRDbnEwa1lJckhDTFdnSngiOw==','2016-05-06 13:23:12','2016-05-06 13:23:12','fc38a153-0e41-476a-aa77-70f9c6855c7e'),(65,1,'6175a888ee253077c2d3e32afb232125088fe36dczozMjoiR0pkOEpsWkFNMXU2dlRqZVRUWGtCYWV0VDFzYjBnUzQiOw==','2016-05-09 10:56:50','2016-05-09 10:56:50','09a2e14d-6bd7-4c46-b45d-c52a9d6870d9'),(66,1,'81efffa26cf4259896a52d69b508bdee1d185042czozMjoiaVc0aXViM0NWWmtBN1pGdG5MbmRvVX5LbmlVTFNJUm8iOw==','2016-05-12 07:37:44','2016-05-12 07:37:44','f0471e5f-1389-4955-9056-ecb67a7d0de6'),(67,1,'495b9d0d119e5c1f8a4bb0f4e369cfd02b737939czozMjoiaXo0amZQR2VYQ34wUlFCfk12bTZYY3ltN1llekZrSDIiOw==','2016-05-13 14:52:00','2016-05-13 14:52:00','7a3b86d8-289a-4898-a33d-a066761ebc23'),(68,1,'ad8bbcc960a2a15e3f25b4adc85eb3fce43f0828czozMjoiZTdSeGdMWmdYVUhrVGFBWmo2aGVEU0ZWdGhBa2FnUGIiOw==','2016-05-20 08:58:11','2016-05-20 08:58:11','2cf41f3c-82d3-448c-889e-c5a40ee09f93'),(71,1,'d5a55979383a4f50847655aae1aa4e90e7a05213czozMjoia1NQfjFQT25qUzM2TzJrOTVNZW9Wa1dENU9GYXNmSHkiOw==','2016-05-25 09:56:09','2016-05-25 09:56:09','17a43c6b-fc7f-4e65-9cfd-1aa5d0823b63'),(72,1,'a29e5c409c332e141eaf74bf3dffcccf72b06764czozMjoiaTlkZGhhc3dEQU9rOHZPcGJzSTkwM0dMenFiX2ZVUlUiOw==','2016-06-03 08:20:18','2016-06-03 08:20:18','0345ad3b-b82f-4546-b01a-9df6621e0a3d'),(73,1,'44388df253fdec281d239483bd584da847fd6d5fczozMjoiRl92M1BmSUh4WWNHbHZLM0t+RUhhM3lySFJ5M1FkOEciOw==','2016-06-08 07:59:47','2016-06-08 12:34:48','75a63239-7e89-4af4-9205-3272e11b2499'),(74,1,'e09831dc4e4ac2c7ef0028b5c7c9d7234b0d9af6czozMjoiUHBHUHdZQnpoVGMwT0pMMGo0a1I4STdYeUR4RF83UF8iOw==','2016-06-10 07:36:42','2016-06-10 07:36:42','d0e01652-f6cd-4f1b-b441-cbaf73e8192d'),(75,1,'fa6c243428f428172a04a38fdaca340a188a29eeczozMjoib05wWUxKfmdaelFrT35uWXdzcEZiaTl6QjJuSkVod18iOw==','2016-06-14 07:14:28','2016-06-14 07:14:28','21259194-1de9-43c3-b722-52ef29a58fa3'),(76,1,'be201ca9d7234b1aac7d91ca449418b0b3899692czozMjoiaG42NVN+NUhFT1BjeWFXM2REUkZjUGdkQlRTVTZyZ3oiOw==','2016-08-01 10:07:11','2016-08-01 10:07:11','22bb5781-502a-4c7c-befc-685b653b5ddf'),(77,1,'cf642d761c968d67f6b3e37a695691796d321aa0czozMjoiVHpDQ3BEUk9ldjVqNExNaH50fmVxWVVYY3FYQkJuUm8iOw==','2016-08-01 10:41:26','2016-08-01 10:41:26','260f8739-4f1a-4f82-8fd1-9bb783074a98'),(78,1,'da8391b9922675b8a056bb11d464dc83ab7ae16cczozMjoiYTBNa0VLMk5OV0lzYUtiaFZNT25mRFZ2bkdFR0ExSFciOw==','2016-08-17 11:54:42','2016-08-17 11:54:42','467f3d6e-bc2e-439e-96f4-431f77b6bdca'),(79,1,'69812d4362ba7edb222763dcea11dad4bfe150bfczozMjoiYjh2S2ZqQkdKb3p1RjRFSmRZeFdzQWtIVlJWYjRkR34iOw==','2016-08-23 15:03:32','2016-08-23 15:03:32','03e0cad1-4ad9-478d-b1c5-bf294ec097ad'),(80,1,'c578675eaabe059ae56f4560caa1e1c49a719e62czozMjoiVTZtOHl4MU44cG1BUFlMaXF3dzkwWnd3TGNoVWNNQmMiOw==','2016-09-14 08:33:28','2016-09-14 08:33:28','3c99c03a-c802-41d1-9458-a7f3c07de6aa'),(81,1,'29058073eddc6773a511628f5a45289cd334d36bczozMjoiNnBlVEVMMTE5Z3VUTHNnR1FDalowVm5LTElsM1BDaWciOw==','2016-09-14 13:26:15','2016-09-14 13:26:15','ec72a6f0-e996-4fea-890e-960ee8f60601'),(82,1,'4bb2bbdc8992f03a9982d0b2a5f73bd402baee9dczozMjoiZG5JWmMwNjVffkFZblBqaGU1ZXZST21xUGNRcjdIV3AiOw==','2016-09-30 07:40:08','2016-09-30 07:40:08','77def9cd-6203-433c-aed4-ebcc15125c61'),(83,1,'e25cfc8a3dffc4303e8cc6b14754b9897116bc6aczozMjoiQjR3ZTN+SUxfZUt0czQ0ZjY2VlY0d35fNEpkYTVlODMiOw==','2016-10-13 07:58:15','2016-10-13 07:58:15','422953fa-3878-4d8f-a191-34024da92399'),(84,1,'3cb48e906f4fbfb4323a5d13b1c6b9a93fa36ad0czozMjoiNXExQV9BNGpjWTQxdnRWTFpoUzNIbVhBck5YZnBDRmoiOw==','2016-11-07 18:24:53','2016-11-07 18:24:53','c6cf1893-ad92-458d-8046-2fb33dcc176c'),(85,1,'90c1ca98d4224e3867335eadbbd0ecd978ab7ba1czozMjoieDhOcjZCamdaYkhWV3ZQbVJrN0toNXFfWDU2WmVkS1giOw==','2016-11-14 09:36:36','2016-11-14 09:36:36','cdde5745-f601-4d80-b84c-f2f3fd33f704'),(86,1,'4b1f749761ec6831b461da8955a2a1364f0b4aceczozMjoiaV9YRzhXbzBpamFpR1ZhZTFEVGptaHdsaFlDalYxOWMiOw==','2016-12-01 09:06:33','2016-12-01 09:06:33','5d58b5b8-3bbc-498a-ab29-b1ead1893ef1'),(87,1,'56d7eafd5420368bc2b7b04641f93e006e80b0ffczozMjoiYXpWNWhlTFlQckZnR1Z4bnZ2a1dUNG90NzI2TEw3RGsiOw==','2016-12-07 10:02:42','2016-12-07 10:02:42','e48a1463-4638-4f05-80ff-2c9ae02424f2'),(88,1,'342ef6751dcbebed174bd77219021326cf1f079aczozMjoiTXVRa0VNY2hhTlpnbTBTMTl3MExPM1lwQ3FDcjFISUEiOw==','2016-12-13 09:53:02','2016-12-13 09:53:02','8d800933-9ce7-4723-b6ee-4094a95d721b'),(89,1,'594abb7c2f95bb1f98d13980b38831cf242767b0czozMjoiOWlpcEZXblZmZmZ1OFpBelB2VnBHUzdxRF9neWwzR1QiOw==','2017-01-12 08:44:22','2017-01-12 08:44:22','75e95fc2-7f86-4e88-a8d1-cb8f7ddd02b7'),(90,1,'c1b9b62df6aa0c9b510459583a70c8af49c46108czozMjoieE1KeVJEaE9DOGU5Qk9pYjBLbFpKc21kTVV4MDZfRkIiOw==','2017-01-31 13:52:34','2017-01-31 13:52:34','db24202f-2405-4575-89aa-a0dd77b94599'),(91,1,'6dafa713b237151ada104fe174f3225079e87180czozMjoiclRzRFVGWVMyb0JXZkpxWDJBNWdnc3lhSHhVdVpld1ciOw==','2017-03-29 13:55:06','2017-03-29 13:55:06','8976c354-375e-41f8-8392-7ef724cb4bba'),(92,1,'8c534383d0f0d460b45b72855ba211d5cd347580czozMjoieDNSNUFXZ3RkZ0Q2NTIxVkxIZFp1OWZsOUIxZ0xoNm4iOw==','2017-04-03 11:28:26','2017-04-03 11:28:26','14486347-98d5-4dec-bd4c-53d9611058c4');
/*!40000 ALTER TABLE `craft_sessions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_shunnedmessages`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `craft_shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_shunnedmessages`
--

LOCK TABLES `craft_shunnedmessages` WRITE;
/*!40000 ALTER TABLE `craft_shunnedmessages` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_shunnedmessages` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_structureelements`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `craft_structureelements_root_idx` (`root`),
  KEY `craft_structureelements_lft_idx` (`lft`),
  KEY `craft_structureelements_rgt_idx` (`rgt`),
  KEY `craft_structureelements_level_idx` (`level`),
  KEY `craft_structureelements_elementId_fk` (`elementId`),
  CONSTRAINT `craft_structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `craft_structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=100 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_structureelements`
--

LOCK TABLES `craft_structureelements` WRITE;
/*!40000 ALTER TABLE `craft_structureelements` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_structureelements` VALUES (92,16,NULL,92,1,16,0,'2017-04-05 21:08:43','2017-04-05 21:08:43','eaf0012f-6299-4588-af38-f9903e5e67a7'),(93,16,14,92,2,3,1,'2017-04-05 21:08:43','2017-04-05 21:08:43','5bfaa9d9-7d52-4987-8b87-2006fc596c4c'),(94,16,10,92,4,5,1,'2017-04-05 21:08:43','2017-04-05 21:08:43','a731b24e-332a-43a7-995e-a216305f7638'),(95,16,11,92,6,7,1,'2017-04-05 21:08:43','2017-04-05 21:08:43','5089e7de-2fbb-4d44-a321-496e1257d96c'),(96,16,12,92,8,9,1,'2017-04-05 21:08:43','2017-04-05 21:08:43','acc07cf5-188f-4166-8d93-f1c339c9ba3a'),(97,16,13,92,10,11,1,'2017-04-05 21:08:43','2017-04-05 21:08:43','242331e2-addc-4435-85dd-0c110cd08908'),(98,16,15,92,12,13,1,'2017-04-05 21:08:43','2017-04-05 21:08:43','9071ad90-97e4-4b1b-8364-2b6d7156045d'),(99,16,16,92,14,15,1,'2017-04-05 21:08:43','2017-04-05 21:08:43','628722a9-9c52-426c-9b11-79736ef16419');
/*!40000 ALTER TABLE `craft_structureelements` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_structures`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_structures`
--

LOCK TABLES `craft_structures` WRITE;
/*!40000 ALTER TABLE `craft_structures` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_structures` VALUES (16,NULL,'2017-04-05 21:08:43','2017-04-05 21:08:43','02c9769e-dac5-4a47-81bd-ff171be8d6d9');
/*!40000 ALTER TABLE `craft_structures` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_supertableblocks`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_supertableblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) DEFAULT NULL,
  `sortOrder` tinyint(4) DEFAULT NULL,
  `ownerLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_supertableblocks_ownerId_idx` (`ownerId`),
  KEY `craft_supertableblocks_fieldId_idx` (`fieldId`),
  KEY `craft_supertableblocks_typeId_idx` (`typeId`),
  KEY `craft_supertableblocks_sortOrder_idx` (`sortOrder`),
  KEY `craft_supertableblocks_ownerLocale_fk` (`ownerLocale`),
  CONSTRAINT `craft_supertableblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_supertableblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_supertableblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_supertableblocks_ownerLocale_fk` FOREIGN KEY (`ownerLocale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `craft_supertableblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `craft_supertableblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_supertableblocks`
--

LOCK TABLES `craft_supertableblocks` WRITE;
/*!40000 ALTER TABLE `craft_supertableblocks` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_supertableblocks` VALUES (17,4,27,1,1,NULL,'2017-04-03 14:37:01','2017-04-03 14:56:59','453412af-e87b-4ed7-933c-88f41c4dc87d'),(18,4,27,1,2,NULL,'2017-04-03 14:37:01','2017-04-03 14:56:59','f095e969-1666-4ca4-981e-a1c02b3896ac'),(19,4,27,1,3,NULL,'2017-04-03 14:37:01','2017-04-03 14:56:59','341840ba-8081-437f-a375-9746d5a4a2a0'),(20,4,27,1,4,NULL,'2017-04-03 14:37:01','2017-04-03 14:56:59','749f72be-037f-4970-bc32-14c0272db86b');
/*!40000 ALTER TABLE `craft_supertableblocks` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_supertableblocktypes`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_supertableblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_supertableblocktypes_fieldId_fk` (`fieldId`),
  KEY `craft_supertableblocktypes_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_supertableblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `craft_fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_supertableblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_supertableblocktypes`
--

LOCK TABLES `craft_supertableblocktypes` WRITE;
/*!40000 ALTER TABLE `craft_supertableblocktypes` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_supertableblocktypes` VALUES (1,27,62,'2017-04-03 14:33:13','2017-04-03 14:56:05','d4f92b65-e675-4b30-b9c1-b6ae5ef59726');
/*!40000 ALTER TABLE `craft_supertableblocktypes` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_supertablecontent_publisert`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_supertablecontent_publisert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `field_tittel` text COLLATE utf8_unicode_ci,
  `field_publisert` text COLLATE utf8_unicode_ci,
  `field_lenke` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_supertablecontent_publisert_elementId_locale_unq_idx` (`elementId`,`locale`),
  KEY `craft_supertablecontent_publisert_locale_fk` (`locale`),
  CONSTRAINT `craft_supertablecontent_publisert_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_supertablecontent_publisert_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_supertablecontent_publisert`
--

LOCK TABLES `craft_supertablecontent_publisert` WRITE;
/*!40000 ALTER TABLE `craft_supertablecontent_publisert` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_supertablecontent_publisert` VALUES (1,17,'nb_no','Kapittel 1','23.03.2017','http://www.sol.no','2017-04-03 14:37:01','2017-04-03 14:56:59','31a5a00d-f5c5-4271-ba0c-8ab23640e922'),(2,18,'nb_no','Kapittel 2','14.04.2017','http://www.sol.no','2017-04-03 14:37:01','2017-04-03 14:56:59','2afac3ad-2e7e-4e6a-a58b-060dcd8277b4'),(3,19,'nb_no','Kapittel 3','15.05.2017','http://www.sol.no','2017-04-03 14:37:01','2017-04-03 14:56:59','5a98f33a-733b-4c57-88ff-61f055296be0'),(4,20,'nb_no','Kapittel 4','08.12.2018','http://www.sol.no','2017-04-03 14:37:01','2017-04-03 14:56:59','7a7fa544-31a4-4607-a413-c6131b215b0a');
/*!40000 ALTER TABLE `craft_supertablecontent_publisert` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_supertablecontent_seodiv`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_supertablecontent_seodiv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `field_googleProfile` text COLLATE utf8_unicode_ci,
  `field_googlePage` text COLLATE utf8_unicode_ci,
  `field_twitterSite` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_supertablecontent_seodiv_elementId_locale_unq_idx` (`elementId`,`locale`),
  KEY `craft_supertablecontent_seodiv_locale_fk` (`locale`),
  CONSTRAINT `craft_supertablecontent_seodiv_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_supertablecontent_seodiv_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_supertablecontent_seodiv`
--

LOCK TABLES `craft_supertablecontent_seodiv` WRITE;
/*!40000 ALTER TABLE `craft_supertablecontent_seodiv` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_supertablecontent_seodiv` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_systemsettings`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_systemsettings`
--

LOCK TABLES `craft_systemsettings` WRITE;
/*!40000 ALTER TABLE `craft_systemsettings` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_systemsettings` VALUES (1,'email','{\"protocol\":\"php\",\"emailAddress\":\"dev@mustasj.no\",\"senderName\":\"Standardcraft\"}','2014-10-08 10:49:50','2014-10-08 10:49:50','13f059b8-2b49-44e6-bb6e-28bad17289af');
/*!40000 ALTER TABLE `craft_systemsettings` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_taggroups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `fieldLayoutId` int(10) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `craft_taggroups_handle_unq_idx` (`handle`),
  KEY `craft_taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `craft_taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `craft_fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_taggroups`
--

LOCK TABLES `craft_taggroups` WRITE;
/*!40000 ALTER TABLE `craft_taggroups` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_taggroups` VALUES (1,'Standard','default',1,'2014-10-08 10:49:50','2014-10-08 10:49:50','b798f6f4-4b51-4b2a-a1e8-fe03d7e54640');
/*!40000 ALTER TABLE `craft_taggroups` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_tags`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_tags_groupId_fk` (`groupId`),
  KEY `craft_tags_groupId_idx` (`groupId`),
  CONSTRAINT `craft_tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_tags_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_tags`
--

LOCK TABLES `craft_tags` WRITE;
/*!40000 ALTER TABLE `craft_tags` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_tags` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_tasks`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `currentStep` int(11) unsigned DEFAULT NULL,
  `totalSteps` int(11) unsigned DEFAULT NULL,
  `status` enum('pending','error','running') COLLATE utf8_unicode_ci DEFAULT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `description` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `settings` mediumtext COLLATE utf8_unicode_ci,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_tasks_root_idx` (`root`),
  KEY `craft_tasks_lft_idx` (`lft`),
  KEY `craft_tasks_rgt_idx` (`rgt`),
  KEY `craft_tasks_level_idx` (`level`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_tasks`
--

LOCK TABLES `craft_tasks` WRITE;
/*!40000 ALTER TABLE `craft_tasks` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_tasks` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_templatecachecriteria`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecachecriteria` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `criteria` text COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecachecriteria_cacheId_fk` (`cacheId`),
  KEY `craft_templatecachecriteria_type_idx` (`type`),
  CONSTRAINT `craft_templatecachecriteria_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_templatecachecriteria`
--

LOCK TABLES `craft_templatecachecriteria` WRITE;
/*!40000 ALTER TABLE `craft_templatecachecriteria` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_templatecachecriteria` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_templatecacheelements`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `craft_templatecacheelements_cacheId_fk` (`cacheId`),
  KEY `craft_templatecacheelements_elementId_fk` (`elementId`),
  CONSTRAINT `craft_templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `craft_templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_templatecacheelements`
--

LOCK TABLES `craft_templatecacheelements` WRITE;
/*!40000 ALTER TABLE `craft_templatecacheelements` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_templatecacheelements` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_templatecaches`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheKey` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `locale` char(12) COLLATE utf8_unicode_ci NOT NULL,
  `path` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  KEY `craft_templatecaches_locale_fk` (`locale`),
  KEY `craft_templatecaches_locale_cacheKey_path_expiryDate_idx` (`locale`,`cacheKey`,`path`,`expiryDate`),
  CONSTRAINT `craft_templatecaches_locale_fk` FOREIGN KEY (`locale`) REFERENCES `craft_locales` (`locale`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_templatecaches`
--

LOCK TABLES `craft_templatecaches` WRITE;
/*!40000 ALTER TABLE `craft_templatecaches` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_templatecaches` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_tokens`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) COLLATE utf8_unicode_ci NOT NULL,
  `route` text COLLATE utf8_unicode_ci,
  `usageLimit` tinyint(3) unsigned DEFAULT NULL,
  `usageCount` tinyint(3) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_tokens_token_unq_idx` (`token`),
  KEY `craft_tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_tokens`
--

LOCK TABLES `craft_tokens` WRITE;
/*!40000 ALTER TABLE `craft_tokens` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_tokens` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_usergroups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `handle` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `craft_usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_usergroups`
--

LOCK TABLES `craft_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_usergroups` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_usergroups_users`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `craft_usergroups_users_userId_fk` (`userId`),
  CONSTRAINT `craft_usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_usergroups_users`
--

LOCK TABLES `craft_usergroups_users` WRITE;
/*!40000 ALTER TABLE `craft_usergroups_users` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_usergroups_users` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_userpermissions`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_userpermissions`
--

LOCK TABLES `craft_userpermissions` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_userpermissions` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_userpermissions_usergroups`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `craft_userpermissions_usergroups_groupId_fk` (`groupId`),
  CONSTRAINT `craft_userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `craft_usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_userpermissions_usergroups`
--

LOCK TABLES `craft_userpermissions_usergroups` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_userpermissions_usergroups` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_userpermissions_users`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `craft_userpermissions_users_userId_fk` (`userId`),
  CONSTRAINT `craft_userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `craft_userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_userpermissions_users`
--

LOCK TABLES `craft_userpermissions_users` WRITE;
/*!40000 ALTER TABLE `craft_userpermissions_users` DISABLE KEYS */;
SET autocommit=0;
/*!40000 ALTER TABLE `craft_userpermissions_users` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_users`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `photo` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `firstName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `lastName` varchar(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `password` char(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `preferredLocale` char(12) COLLATE utf8_unicode_ci DEFAULT NULL,
  `weekStartDay` tinyint(4) NOT NULL DEFAULT '0',
  `admin` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `client` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL,
  `suspended` tinyint(1) NOT NULL,
  `pending` tinyint(1) NOT NULL,
  `archived` tinyint(1) NOT NULL,
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIPAddress` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` tinyint(4) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `verificationCode` char(100) COLLATE utf8_unicode_ci DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  `passwordResetRequired` tinyint(1) unsigned NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `craft_users_username_unq_idx` (`username`),
  UNIQUE KEY `craft_users_email_unq_idx` (`email`),
  KEY `craft_users_verificationCode_idx` (`verificationCode`),
  KEY `craft_users_uid_idx` (`uid`),
  KEY `craft_users_preferredLocale_fk` (`preferredLocale`),
  CONSTRAINT `craft_users_id_fk` FOREIGN KEY (`id`) REFERENCES `craft_elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `craft_users_preferredLocale_fk` FOREIGN KEY (`preferredLocale`) REFERENCES `craft_locales` (`locale`) ON DELETE SET NULL ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_users`
--

LOCK TABLES `craft_users` WRITE;
/*!40000 ALTER TABLE `craft_users` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_users` VALUES (1,'Admin',NULL,'','','dev@lenaknutli.com','$2y$13$ArPZhvPPfpGmLY0TFvHkYe28ncdwmaii1krhW.4aUrLTJYIGF0Fhe',NULL,1,1,0,0,0,0,0,'2017-04-03 11:28:26','127.0.0.1',NULL,NULL,'2016-02-15 11:45:20',NULL,NULL,NULL,NULL,0,'2017-04-03 14:50:05','2014-10-08 10:49:48','2017-04-03 14:50:05','1381d236-993f-4cd9-81bf-e97ced9e7789');
/*!40000 ALTER TABLE `craft_users` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

--
-- Table structure for table `craft_widgets`
--

/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `craft_widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(4) unsigned DEFAULT NULL,
  `settings` text COLLATE utf8_unicode_ci,
  `enabled` tinyint(1) unsigned NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) COLLATE utf8_unicode_ci NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `craft_widgets_userId_fk` (`userId`),
  CONSTRAINT `craft_widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `craft_users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `craft_widgets`
--

LOCK TABLES `craft_widgets` WRITE;
/*!40000 ALTER TABLE `craft_widgets` DISABLE KEYS */;
SET autocommit=0;
INSERT INTO `craft_widgets` VALUES (1,1,'QuickPost',1,NULL,'{\"section\":\"2\"}',0,'2014-10-08 10:52:10','2016-01-19 15:34:32','262b9070-0bab-4f6d-b428-4eae106b5cd8'),(2,1,'RecentEntries',2,NULL,NULL,1,'2014-10-08 10:52:10','2014-10-08 10:52:10','a60fa7d3-9e67-413e-87ed-e32498493920'),(3,1,'GetHelp',3,NULL,NULL,1,'2014-10-08 10:52:10','2014-10-08 10:52:10','95bf3c4f-3127-4561-ac45-a6c63fb67036'),(4,1,'Updates',4,NULL,NULL,1,'2014-10-08 10:52:10','2014-10-08 10:52:10','e2d736fe-350e-4db5-b1fc-f8abde34e266'),(5,1,'Feed',5,NULL,'{\"url\":\"https:\\/\\/craftcms.com\\/news.rss\",\"title\":\"Craft News\"}',1,'2014-10-08 10:52:10','2016-01-19 15:32:56','f9d6ff3f-5305-48c7-9f64-734b67436d7b'),(6,1,'Maintenance',6,NULL,'{\"title\":\"Announcements\",\"limit\":\"5\"}',0,'2016-02-24 13:36:15','2016-02-24 13:36:47','a239f863-e7eb-4ccd-95fe-993ac358ae3c'),(7,1,'Maintenance',7,NULL,'{\"title\":\"Announcements\",\"limit\":\"\"}',0,'2016-02-26 13:54:07','2016-02-26 13:54:14','42e2fb09-1170-407a-b733-443fcfdcd7e1');
/*!40000 ALTER TABLE `craft_widgets` ENABLE KEYS */;
UNLOCK TABLES;
COMMIT;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on: Wed, 05 Apr 2017 21:08:49 +0000
