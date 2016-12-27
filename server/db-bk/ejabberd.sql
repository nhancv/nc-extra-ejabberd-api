-- phpMyAdmin SQL Dump
-- version 4.5.2
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 27, 2016 at 07:47 
-- Server version: 10.1.16-MariaDB
-- PHP Version: 7.0.9

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `ejabberd`
--

-- --------------------------------------------------------

--
-- Table structure for table `archive`
--

CREATE TABLE `archive` (
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `timestamp` bigint(20) UNSIGNED NOT NULL,
  `peer` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bare_peer` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `xml` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `txt` text COLLATE utf8mb4_unicode_ci,
  `id` bigint(20) UNSIGNED NOT NULL,
  `kind` varchar(10) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `nick` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `archive`
--

INSERT INTO `archive` (`username`, `timestamp`, `peer`, `bare_peer`, `xml`, `txt`, `id`, `kind`, `nick`, `created_at`) VALUES
('test', 1482821209767766, 'admin@local.beesightsoft.com', 'admin@local.beesightsoft.com', '<message xml:lang=''en'' to=''admin@local.beesightsoft.com'' from=''test@local.beesightsoft.com/Android'' type=''chat'' id=''fC9fl-17'' xmlns=''jabber:client''><request xmlns=''urn:xmpp:receipts''/><active xmlns=''http://jabber.org/protocol/chatstates''/><body>test</body><thread>ee305152-0422-4895-8210-ff4d595b429f</thread></message>', 'test', 166, 'chat', '', '2016-12-27 06:46:49'),
('admin', 1482821209806986, 'test@local.beesightsoft.com/Android', 'test@local.beesightsoft.com', '<message xml:lang=''en'' to=''admin@local.beesightsoft.com'' from=''test@local.beesightsoft.com/Android'' type=''chat'' id=''fC9fl-17'' xmlns=''jabber:client''><request xmlns=''urn:xmpp:receipts''/><active xmlns=''http://jabber.org/protocol/chatstates''/><body>test</body><thread>ee305152-0422-4895-8210-ff4d595b429f</thread></message>', 'test', 167, 'chat', '', '2016-12-27 06:46:49'),
('admin', 1482821218100427, 'test@local.beesightsoft.com', 'test@local.beesightsoft.com', '<message xml:lang=''en'' to=''test@local.beesightsoft.com'' from=''admin@local.beesightsoft.com/Android'' type=''chat'' id=''xwIM4-28'' xmlns=''jabber:client''><request xmlns=''urn:xmpp:receipts''/><active xmlns=''http://jabber.org/protocol/chatstates''/><body>send to test</body><thread>d38b5f5b-b1b6-4f45-8082-2aeaca301507</thread></message>', 'send to test', 168, 'chat', '', '2016-12-27 06:46:58'),
('test', 1482821218157803, 'admin@local.beesightsoft.com/Android', 'admin@local.beesightsoft.com', '<message xml:lang=''en'' to=''test@local.beesightsoft.com'' from=''admin@local.beesightsoft.com/Android'' type=''chat'' id=''xwIM4-28'' xmlns=''jabber:client''><request xmlns=''urn:xmpp:receipts''/><active xmlns=''http://jabber.org/protocol/chatstates''/><body>send to test</body><thread>d38b5f5b-b1b6-4f45-8082-2aeaca301507</thread></message>', 'send to test', 169, 'chat', '', '2016-12-27 06:46:58');

--
-- Triggers `archive`
--
DELIMITER $$
CREATE TRIGGER `delete_last_message` AFTER DELETE ON `archive` FOR EACH ROW BEGIN
	SET @NEW_PEER = SUBSTRING_INDEX(OLD.peer, '@', 1);
	SET @COUNT = (SELECT COUNT(*) FROM last_message WHERE username = OLD.username AND peer = @NEW_PEER);
    IF @COUNT > 0 THEN
        DELETE FROM `last_message` WHERE (username = OLD.username AND peer = @NEW_PEER);
    END IF;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `update_last_message` BEFORE INSERT ON `archive` FOR EACH ROW BEGIN
	SET @NEW_PEER = SUBSTRING_INDEX(NEW.peer, '@', 1);
	SET @COUNT = (SELECT COUNT(*) FROM last_message WHERE username = NEW.username AND peer = @NEW_PEER);
    IF @COUNT = 0 THEN
        INSERT INTO last_message (username, peer, txt) VALUES (NEW.username, @NEW_PEER, NEW.txt); 
    ELSE
    	UPDATE last_message SET txt = NEW.txt WHERE (username = NEW.username AND peer = @NEW_PEER);
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `archive_prefs`
--

CREATE TABLE `archive_prefs` (
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `def` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `always` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `never` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `caps_features`
--

CREATE TABLE `caps_features` (
  `node` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subnode` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `feature` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `caps_features`
--

INSERT INTO `caps_features` (`node`, `subnode`, `feature`, `created_at`) VALUES
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'http://jabber.org/protocol/bytestreams', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'jabber:iq:privacy', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'urn:xmpp:ping', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'http://jabber.org/protocol/commands', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'jabber:iq:version', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'jabber:iq:last', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'http://jabber.org/protocol/xdata-validate', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'http://jabber.org/protocol/xhtml-im', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'vcard-temp', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'urn:xmpp:receipts', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'urn:xmpp:time', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'http://jabber.org/protocol/xdata-layout', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'http://jabber.org/protocol/muc', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'http://jabber.org/protocol/disco#items', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'http://jabber.org/protocol/disco#info', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'http://jabber.org/protocol/caps', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'NfJ3flI83zSdUDzCEICtbypursw=', 'jabber:x:data', '2016-12-15 04:00:11'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'http://jabber.org/protocol/bytestreams', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'jabber:iq:privacy', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'urn:xmpp:ping', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'http://jabber.org/protocol/commands', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'jabber:iq:version', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'jabber:iq:last', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'http://jabber.org/protocol/xdata-validate', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'http://jabber.org/protocol/xhtml-im', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'vcard-temp', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'http://jabber.org/protocol/chatstates', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'urn:xmpp:receipts', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'urn:xmpp:time', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'http://jabber.org/protocol/xdata-layout', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'http://jabber.org/protocol/muc', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'http://jabber.org/protocol/disco#items', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'http://jabber.org/protocol/disco#info', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'http://jabber.org/protocol/caps', '2016-12-15 09:05:28'),
('http://www.igniterealtime.org/projects/smack', 'zIfK69gJkJ5OCxMILmZOsZ9HBlU=', 'jabber:x:data', '2016-12-15 09:05:28'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/bytestreams', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/si', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/si/profile/file-transfer', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/muc', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/muc#user', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/muc#admin', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/muc#owner', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/muc#roomconfig', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/commands', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/disco#info', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'ipv6', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'jabber:iq:gateway', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'jabber:iq:last', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'jabber:iq:privacy', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'jabber:iq:private', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'jabber:iq:register', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'jabber:iq:version', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'jabber:x:data', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'jabber:x:encrypted', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'msglog', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'sslc2s', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'stringprep', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:ping', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:time', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:ssn', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/mood', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/activity', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/nick', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/rosterx', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:sec-label:0', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:hashes:1', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:hash-function-textual-names:md5', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:hash-function-textual-names:sha-1', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:hash-function-textual-names:sha-256', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:hash-function-textual-names:sha-512', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:message-correct:0', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'jabber:x:conference', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/mood+notify', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/activity+notify', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/tune+notify', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/nick+notify', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/geoloc+notify', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/chatstates', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://jabber.org/protocol/xhtml-im', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'http://www.xmpp.org/extensions/xep-0116.html#ns', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:receipts', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:jingle:1', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:jingle:apps:file-transfer:3', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:jingle:security:xtls:0', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:jingle:transports:s5b:1', '2016-12-20 09:19:13'),
('http://gajim.org', 'wzGVKj7wSkm4/nTeh6OItUzSeYc=', 'urn:xmpp:jingle:transports:ibb:1', '2016-12-20 09:19:13');

-- --------------------------------------------------------

--
-- Table structure for table `irc_custom`
--

CREATE TABLE `irc_custom` (
  `jid` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `host` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `last`
--

CREATE TABLE `last` (
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `seconds` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `state` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `last`
--

INSERT INTO `last` (`username`, `seconds`, `state`) VALUES
('admin', '1482758739', ''),
('test', '1482758739', ''),
('test1', '1482744386', ''),
('test2', '1481887023', 'Registered but didn''t login');

-- --------------------------------------------------------

--
-- Table structure for table `last_message`
--

CREATE TABLE `last_message` (
  `username` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `peer` varchar(191) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `txt` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `last_message`
--

INSERT INTO `last_message` (`username`, `peer`, `txt`, `create_time`, `update_time`) VALUES
('admin', 'test', 'send to test', '2016-12-27 13:46:49', '2016-12-27 13:46:58'),
('test', 'admin', 'send to test', '2016-12-27 13:46:49', '2016-12-27 13:46:58');

-- --------------------------------------------------------

--
-- Table structure for table `motd`
--

CREATE TABLE `motd` (
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `xml` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `muc_registered`
--

CREATE TABLE `muc_registered` (
  `jid` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `host` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `nick` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `muc_room`
--

CREATE TABLE `muc_room` (
  `name` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `host` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `opts` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `muc_room`
--

INSERT INTO `muc_room` (`name`, `host`, `opts`, `created_at`) VALUES
('ca7b044b-84ac-4765-80c1-ae89ebb64d4e', 'conference.local.beesightsoft.com', '[{title,<<"Test group chat">>},\n {description,<<"Test group description">>},\n {allow_change_subj,true},\n {allow_query_users,true},\n {allow_private_messages,true},\n {allow_private_messages_from_visitors,anyone},\n {allow_visitor_status,true},\n {allow_visitor_nickchange,true},\n {public,true},\n {public_list,true},\n {persistent,true},\n {moderated,true},\n {members_by_default,true},\n {members_only,false},\n {allow_user_invites,false},\n {password_protected,false},\n {captcha_protected,false},\n {password,<<>>},\n {anonymous,true},\n {logging,false},\n {max_users,100},\n {allow_voice_requests,true},\n {allow_subscription,false},\n {mam,true},\n {presence_broadcast,[moderator,participant,visitor]},\n {voice_request_min_interval,1800},\n {vcard,<<>>},\n {captcha_whitelist,[]},\n {affiliations,[{{<<"admin">>,<<"local.beesightsoft.com">>,<<>>},\n                 {owner,<<>>}}]},\n {subject,<<>>},\n {subject_author,<<>>},\n {subscribers,[]}]', '2016-12-26 09:46:03');

-- --------------------------------------------------------

--
-- Table structure for table `oauth_token`
--

CREATE TABLE `oauth_token` (
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jid` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `scope` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `privacy_default_list`
--

CREATE TABLE `privacy_default_list` (
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `privacy_list`
--

CREATE TABLE `privacy_list` (
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `id` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `privacy_list_data`
--

CREATE TABLE `privacy_list_data` (
  `id` bigint(20) DEFAULT NULL,
  `t` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `value` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `action` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ord` decimal(10,0) NOT NULL,
  `match_all` tinyint(1) NOT NULL,
  `match_iq` tinyint(1) NOT NULL,
  `match_message` tinyint(1) NOT NULL,
  `match_presence_in` tinyint(1) NOT NULL,
  `match_presence_out` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `private_storage`
--

CREATE TABLE `private_storage` (
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `namespace` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pubsub_item`
--

CREATE TABLE `pubsub_item` (
  `nodeid` bigint(20) DEFAULT NULL,
  `itemid` text COLLATE utf8mb4_unicode_ci,
  `publisher` text COLLATE utf8mb4_unicode_ci,
  `creation` text COLLATE utf8mb4_unicode_ci,
  `modification` text COLLATE utf8mb4_unicode_ci,
  `payload` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pubsub_node`
--

CREATE TABLE `pubsub_node` (
  `host` text COLLATE utf8mb4_unicode_ci,
  `node` text COLLATE utf8mb4_unicode_ci,
  `parent` text COLLATE utf8mb4_unicode_ci,
  `type` text COLLATE utf8mb4_unicode_ci,
  `nodeid` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pubsub_node_option`
--

CREATE TABLE `pubsub_node_option` (
  `nodeid` bigint(20) DEFAULT NULL,
  `name` text COLLATE utf8mb4_unicode_ci,
  `val` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pubsub_node_owner`
--

CREATE TABLE `pubsub_node_owner` (
  `nodeid` bigint(20) DEFAULT NULL,
  `owner` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pubsub_state`
--

CREATE TABLE `pubsub_state` (
  `nodeid` bigint(20) DEFAULT NULL,
  `jid` text COLLATE utf8mb4_unicode_ci,
  `affiliation` char(1) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subscriptions` text COLLATE utf8mb4_unicode_ci,
  `stateid` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `pubsub_subscription_opt`
--

CREATE TABLE `pubsub_subscription_opt` (
  `subid` text COLLATE utf8mb4_unicode_ci,
  `opt_name` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `opt_value` text COLLATE utf8mb4_unicode_ci
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rostergroups`
--

CREATE TABLE `rostergroups` (
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `grp` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `rosterusers`
--

CREATE TABLE `rosterusers` (
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `jid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nick` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `subscription` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ask` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `askmessage` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `server` char(1) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subscribe` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `type` text COLLATE utf8mb4_unicode_ci,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `rosterusers`
--

INSERT INTO `rosterusers` (`username`, `jid`, `nick`, `subscription`, `ask`, `askmessage`, `server`, `subscribe`, `type`, `created_at`) VALUES
('test', 'admin@local.beesightsoft.com', '', 'B', 'N', '', 'N', '', 'item', '2016-12-15 04:01:19'),
('admin', 'test@local.beesightsoft.com', '', 'B', 'N', '', 'N', '', 'item', '2016-12-15 04:01:19'),
('test1', 'admin@local.beesightsoft.com', '', 'B', 'N', '', 'N', '', 'item', '2016-12-26 09:15:22'),
('admin', 'test1@local.beesightsoft.com', '', 'B', 'N', '', 'N', '', 'item', '2016-12-26 09:15:22'),
('test1', 'test@local.beesightsoft.com', '', 'B', 'N', '', 'N', '', 'item', '2016-12-26 09:20:58'),
('test', 'test1@local.beesightsoft.com', '', 'B', 'N', '', 'N', '', 'item', '2016-12-26 09:20:58');

-- --------------------------------------------------------

--
-- Table structure for table `roster_version`
--

CREATE TABLE `roster_version` (
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `version` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sm`
--

CREATE TABLE `sm` (
  `usec` bigint(20) NOT NULL,
  `pid` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `node` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `resource` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `priority` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `info` text COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `spool`
--

CREATE TABLE `spool` (
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `xml` blob NOT NULL,
  `seq` bigint(20) UNSIGNED NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sr_group`
--

CREATE TABLE `sr_group` (
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `opts` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sr_user`
--

CREATE TABLE `sr_user` (
  `jid` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `grp` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `serverkey` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `salt` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '',
  `iterationcount` int(11) NOT NULL DEFAULT '0',
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `password`, `serverkey`, `salt`, `iterationcount`, `created_at`) VALUES
('admin', '123321', '', '', 0, '2016-12-15 02:56:48'),
('test', '123321', '', '', 0, '2016-12-15 02:57:23'),
('test1', '123321', '', '', 0, '2016-12-15 03:08:15'),
('test2', '123321', '', '', 0, '2016-12-16 11:17:03');

-- --------------------------------------------------------

--
-- Table structure for table `vcard`
--

CREATE TABLE `vcard` (
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `vcard` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vcard_search`
--

CREATE TABLE `vcard_search` (
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lusername` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fn` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lfn` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `family` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lfamily` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `given` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lgiven` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `middle` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lmiddle` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nickname` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lnickname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `bday` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lbday` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ctry` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lctry` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `locality` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `llocality` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lemail` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `orgname` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lorgname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `orgunit` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `lorgunit` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vcard_xupdate`
--

CREATE TABLE `vcard_xupdate` (
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hash` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `archive`
--
ALTER TABLE `archive`
  ADD UNIQUE KEY `id` (`id`),
  ADD KEY `i_username` (`username`) USING BTREE,
  ADD KEY `i_timestamp` (`timestamp`) USING BTREE,
  ADD KEY `i_peer` (`peer`) USING BTREE,
  ADD KEY `i_bare_peer` (`bare_peer`) USING BTREE;
ALTER TABLE `archive` ADD FULLTEXT KEY `i_text` (`txt`);

--
-- Indexes for table `archive_prefs`
--
ALTER TABLE `archive_prefs`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `caps_features`
--
ALTER TABLE `caps_features`
  ADD KEY `i_caps_features_node_subnode` (`node`(75),`subnode`(75));

--
-- Indexes for table `irc_custom`
--
ALTER TABLE `irc_custom`
  ADD UNIQUE KEY `i_irc_custom_jid_host` (`jid`(75),`host`(75)) USING BTREE;

--
-- Indexes for table `last`
--
ALTER TABLE `last`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `last_message`
--
ALTER TABLE `last_message`
  ADD PRIMARY KEY (`username`,`peer`);

--
-- Indexes for table `motd`
--
ALTER TABLE `motd`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `muc_registered`
--
ALTER TABLE `muc_registered`
  ADD UNIQUE KEY `i_muc_registered_jid_host` (`jid`(75),`host`(75)) USING BTREE,
  ADD KEY `i_muc_registered_nick` (`nick`(75)) USING BTREE;

--
-- Indexes for table `muc_room`
--
ALTER TABLE `muc_room`
  ADD UNIQUE KEY `i_muc_room_name_host` (`name`(75),`host`(75)) USING BTREE;

--
-- Indexes for table `oauth_token`
--
ALTER TABLE `oauth_token`
  ADD PRIMARY KEY (`token`);

--
-- Indexes for table `privacy_default_list`
--
ALTER TABLE `privacy_default_list`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `privacy_list`
--
ALTER TABLE `privacy_list`
  ADD UNIQUE KEY `id` (`id`),
  ADD UNIQUE KEY `i_privacy_list_username_name` (`username`(75),`name`(75)) USING BTREE,
  ADD KEY `i_privacy_list_username` (`username`) USING BTREE;

--
-- Indexes for table `privacy_list_data`
--
ALTER TABLE `privacy_list_data`
  ADD KEY `i_privacy_list_data_id` (`id`);

--
-- Indexes for table `private_storage`
--
ALTER TABLE `private_storage`
  ADD UNIQUE KEY `i_private_storage_username_namespace` (`username`(75),`namespace`(75)) USING BTREE,
  ADD KEY `i_private_storage_username` (`username`) USING BTREE;

--
-- Indexes for table `pubsub_item`
--
ALTER TABLE `pubsub_item`
  ADD UNIQUE KEY `i_pubsub_item_tuple` (`nodeid`,`itemid`(36)),
  ADD KEY `i_pubsub_item_itemid` (`itemid`(36));

--
-- Indexes for table `pubsub_node`
--
ALTER TABLE `pubsub_node`
  ADD PRIMARY KEY (`nodeid`),
  ADD UNIQUE KEY `i_pubsub_node_tuple` (`host`(20),`node`(120)),
  ADD KEY `i_pubsub_node_parent` (`parent`(120));

--
-- Indexes for table `pubsub_node_option`
--
ALTER TABLE `pubsub_node_option`
  ADD KEY `i_pubsub_node_option_nodeid` (`nodeid`);

--
-- Indexes for table `pubsub_node_owner`
--
ALTER TABLE `pubsub_node_owner`
  ADD KEY `i_pubsub_node_owner_nodeid` (`nodeid`);

--
-- Indexes for table `pubsub_state`
--
ALTER TABLE `pubsub_state`
  ADD PRIMARY KEY (`stateid`),
  ADD UNIQUE KEY `i_pubsub_state_tuple` (`nodeid`,`jid`(60)),
  ADD KEY `i_pubsub_state_jid` (`jid`(60));

--
-- Indexes for table `pubsub_subscription_opt`
--
ALTER TABLE `pubsub_subscription_opt`
  ADD UNIQUE KEY `i_pubsub_subscription_opt` (`subid`(32),`opt_name`);

--
-- Indexes for table `rostergroups`
--
ALTER TABLE `rostergroups`
  ADD KEY `pk_rosterg_user_jid` (`username`(75),`jid`(75));

--
-- Indexes for table `rosterusers`
--
ALTER TABLE `rosterusers`
  ADD UNIQUE KEY `i_rosteru_user_jid` (`username`(75),`jid`(75)),
  ADD KEY `i_rosteru_username` (`username`),
  ADD KEY `i_rosteru_jid` (`jid`);

--
-- Indexes for table `roster_version`
--
ALTER TABLE `roster_version`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `sm`
--
ALTER TABLE `sm`
  ADD UNIQUE KEY `i_sid` (`usec`,`pid`(75)),
  ADD KEY `i_node` (`node`(75)),
  ADD KEY `i_username` (`username`);

--
-- Indexes for table `spool`
--
ALTER TABLE `spool`
  ADD UNIQUE KEY `seq` (`seq`),
  ADD KEY `i_despool` (`username`) USING BTREE,
  ADD KEY `i_spool_created_at` (`created_at`) USING BTREE;

--
-- Indexes for table `sr_user`
--
ALTER TABLE `sr_user`
  ADD UNIQUE KEY `i_sr_user_jid_group` (`jid`(75),`grp`(75)),
  ADD KEY `i_sr_user_jid` (`jid`),
  ADD KEY `i_sr_user_grp` (`grp`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `vcard`
--
ALTER TABLE `vcard`
  ADD PRIMARY KEY (`username`);

--
-- Indexes for table `vcard_search`
--
ALTER TABLE `vcard_search`
  ADD PRIMARY KEY (`lusername`),
  ADD KEY `i_vcard_search_lfn` (`lfn`),
  ADD KEY `i_vcard_search_lfamily` (`lfamily`),
  ADD KEY `i_vcard_search_lgiven` (`lgiven`),
  ADD KEY `i_vcard_search_lmiddle` (`lmiddle`),
  ADD KEY `i_vcard_search_lnickname` (`lnickname`),
  ADD KEY `i_vcard_search_lbday` (`lbday`),
  ADD KEY `i_vcard_search_lctry` (`lctry`),
  ADD KEY `i_vcard_search_llocality` (`llocality`),
  ADD KEY `i_vcard_search_lemail` (`lemail`),
  ADD KEY `i_vcard_search_lorgname` (`lorgname`),
  ADD KEY `i_vcard_search_lorgunit` (`lorgunit`);

--
-- Indexes for table `vcard_xupdate`
--
ALTER TABLE `vcard_xupdate`
  ADD PRIMARY KEY (`username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `archive`
--
ALTER TABLE `archive`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=170;
--
-- AUTO_INCREMENT for table `privacy_list`
--
ALTER TABLE `privacy_list`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `pubsub_node`
--
ALTER TABLE `pubsub_node`
  MODIFY `nodeid` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `pubsub_state`
--
ALTER TABLE `pubsub_state`
  MODIFY `stateid` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `spool`
--
ALTER TABLE `spool`
  MODIFY `seq` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `pubsub_item`
--
ALTER TABLE `pubsub_item`
  ADD CONSTRAINT `pubsub_item_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE;

--
-- Constraints for table `pubsub_node_option`
--
ALTER TABLE `pubsub_node_option`
  ADD CONSTRAINT `pubsub_node_option_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE;

--
-- Constraints for table `pubsub_node_owner`
--
ALTER TABLE `pubsub_node_owner`
  ADD CONSTRAINT `pubsub_node_owner_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE;

--
-- Constraints for table `pubsub_state`
--
ALTER TABLE `pubsub_state`
  ADD CONSTRAINT `pubsub_state_ibfk_1` FOREIGN KEY (`nodeid`) REFERENCES `pubsub_node` (`nodeid`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
