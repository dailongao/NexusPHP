-- phpMyAdmin SQL Dump
-- version 3.1.2deb1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 22, 2009 at 11:21 PM
-- Server version: 5.0.75
-- PHP Version: 5.2.6-3ubuntu4.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `nhdbackup`
--

-- --------------------------------------------------------

--
-- Table structure for table `addedrequests`
--

CREATE TABLE IF NOT EXISTS `addedrequests` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `requestid` int(10) unsigned NOT NULL default '0',
  `userid` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `pollid` (`id`),
  KEY `userid` (`userid`),
  KEY `requestid_userid` (`requestid`,`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `addedrequests`
--


-- --------------------------------------------------------

--
-- Table structure for table `adminpanel`
--

CREATE TABLE IF NOT EXISTS `adminpanel` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `url` varchar(50) default NULL,
  `info` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2014 ;

--
-- Dumping data for table `adminpanel`
--

INSERT INTO `adminpanel` (`id`, `name`, `url`, `info`) VALUES
(2000, 'Add user', 'adduser.php', 'Create new user account'),
(2001, 'List Unconfirmed Users', 'unco.php', 'View unconfirmed accounts'),
(2002, 'Reset Users Password', 'reset.php', 'Rest lost Passwords'),
(2003, 'Mass PM', 'staffmess.php', 'Send PM to all users'),
(2005, 'List Unconnectable Users', 'notconnectable.php', 'View All Unconnectable Users'),
(2006, 'Poll overview', 'polloverview.php', 'View poll votes'),
(2007, 'Warned users', 'warned.php', 'See all warned users on tracker'),
(2008, 'Pending Users Confirmation', 'pusers.php', 'Here you can confirm unconfirmed accounts'),
(2010, 'FreeLeech', 'freeleech.php', 'Set ALL Torrents At Special State.'),
(2011, 'FAQ Management', 'faqmanage.php', 'Edit/Add/Delete FAQ Page'),
(2012, 'Rules Management', 'modrules.php', 'Edit/Add/Delete RULES Page'),
(2013, 'Add Bonus Points', 'amountbonus.php', 'Add Bonus Points to one or All Users.');

-- --------------------------------------------------------

--
-- Table structure for table `agent_allowed_exception`
--

CREATE TABLE IF NOT EXISTS `agent_allowed_exception` (
  `family_id` int(3) NOT NULL auto_increment,
  `name` varchar(100) NOT NULL,
  `peer_id` varchar(20) NOT NULL,
  `agent` varchar(60) NOT NULL,
  `comment` varchar(200) NOT NULL,
  PRIMARY KEY  (`family_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2004 ;

--
-- Dumping data for table `agent_allowed_exception`
--

INSERT INTO `agent_allowed_exception` (`family_id`, `name`, `peer_id`, `agent`, `comment`) VALUES
(2003, 'uTorrent 1.80B (Build 6838)', '-UT180B-', 'uTorrent/180B(6838)', 'buggy build that always seeding bad request');

-- --------------------------------------------------------

--
-- Table structure for table `agent_allowed_family`
--

CREATE TABLE IF NOT EXISTS `agent_allowed_family` (
  `id` int(3) NOT NULL auto_increment,
  `family` varchar(50) NOT NULL,
  `start_name` varchar(100) NOT NULL,
  `peer_id_pattern` varchar(200) NOT NULL,
  `peer_id_match_num` int(5) unsigned NOT NULL,
  `peer_id_matchtype` enum('dec','hex') NOT NULL default 'dec',
  `peer_id_start` varchar(20) NOT NULL,
  `agent_pattern` varchar(200) NOT NULL,
  `agent_match_num` int(5) unsigned NOT NULL,
  `agent_matchtype` enum('dec','hex') NOT NULL default 'dec',
  `agent_start` varchar(100) NOT NULL,
  `exception` enum('yes','no') NOT NULL default 'no',
  `allowhttps` enum('yes','no') NOT NULL default 'no',
  `comment` varchar(200) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9004 ;

--
-- Dumping data for table `agent_allowed_family`
--

INSERT INTO `agent_allowed_family` (`id`, `family`, `start_name`, `peer_id_pattern`, `peer_id_match_num`, `peer_id_matchtype`, `peer_id_start`, `agent_pattern`, `agent_match_num`, `agent_matchtype`, `agent_start`, `exception`, `allowhttps`, `comment`) VALUES
(1001, 'Azureus 2.5.0.4', 'Azureus 2.5.0.4', '/^-AZ2504-/', 0, 'dec', '-AZ2504-', '/^Azureus 2.5.0.4/', 0, 'dec', 'Azureus 2.5.0.4', 'no', 'no', ''),
(2001, 'uTorrent 1.6.1', 'uTorrent 1.6.1', '/^-UT1610-/', 0, 'dec', '-UT1610-', '/^uTorrent\\/1610/', 0, 'dec', 'uTorrent/1610', 'no', 'no', ''),
(2003, 'uTorrent 1.8xB', 'uTorrent 1.80 Beta (build 9137)', '/^-UT18([0-9])B-/', 1, 'dec', '-UT180B-', '/^uTorrent\\/18([0-9])B\\(([1-9][0-9]*)\\)/', 2, 'dec', 'uTorrent/180B(9137)', 'no', 'no', ''),
(3001, 'Bittorrent 6.x', 'Bittorrent 6.0.1', '/^M6-([0-9])-([0-9])--/', 2, 'dec', 'M6-0-1--', '/^BitTorrent\\/6([0-9])([0-9])([0-9])/', 3, 'dec', 'BitTorrent/6010', 'no', 'no', ''),
(4001, 'Deluge 0.x', 'Deluge 0.5.8.9', '/^-DE0([0-9])([0-9])([0-9])-/', 3, 'dec', '-DE0589-', '/^Deluge 0\\.([0-9])\\.([0-9])\\.([0-9])/', 3, 'dec', 'Deluge 0.5.8.9', 'no', 'no', ''),
(5001, 'Transmission1.x', 'Transmission 1.06 (build 5136)', '/^-TR1([0-9])([0-9])([0-9])-/', 3, 'dec', '-TR1060-', '/^Transmission\\/1\\.([0-9])([0-9]) \\(([1-9][0-9]*)\\)/', 3, 'dec', 'Transmission/1.06 (5136)', 'no', 'no', ''),
(6001, 'RTorrent 0.x(with libtorrent 0.x)', 'rTorrent 0.8.0 (with libtorrent 0.12.0)', '/^-lt([0-9A-E])([0-9A-E])([0-9A-E])([0-9A-E])-/', 4, 'hex', '-lt0C00-', '/^rtorrent\\/0\\.([0-9])\\.([0-9])\\/0\\.([1-9][0-9]*)\\.(0|[1-9][0-9]*)/', 4, 'dec', 'rtorrent/0.8.0/0.12.0', 'no', 'no', ''),
(7001, 'Rufus 0.x', 'Rufus 0.6.9', '', 0, 'dec', '', '/^Rufus\\/0\\.([0-9])\\.([0-9])/', 2, 'dec', 'Rufus/0.6.9', 'no', 'no', ''),
(1002, 'Azureus 3.x', 'Azureus 3.0.5.0', '/^-AZ3([0-9])([0-9])([0-9])-/', 3, 'dec', '-AZ3050-', '/^Azureus 3\\.([0-9])\\.([0-9])\\.([0-9])/', 3, 'dec', 'Azureus 3.0.5.0', 'no', 'no', ''),
(2002, 'uTorrent 1.7.x', 'uTorrent 1.7.5', '/^-UT17([0-9])([0-9])-/', 2, 'dec', '-UT1750-', '/^uTorrent\\/17([0-9])([0-9])/', 2, 'dec', 'uTorrent/1750', 'no', 'no', ''),
(8001, 'BitRocket 0.x', 'BitRocket 0.3.3(32)', '/^-BR0([0-9])([1-9][0-9]*)-/', 2, 'dec', '-BR0332-', '/^BitRocket\\/0\\.([0-9])\\.([0-9])\\(([1-9][0-9]*)\\) libtorrent\\/0\\.([1-9][0-9]*)\\.(0|[1-9][0-9]*)\\.(0|[1-9][0-9]*)/', 6, 'dec', 'BitRocket/0.3.3(32) libtorrent/0.13.0.0', 'no', 'no', ''),
(9001, 'MLDonkey 2.9.x', 'MLDonkey 2.9.2', '/^-ML2\\.9\\.([0-9])-/', 1, 'dec', '-ML2.9.2-', '/^MLDonkey\\/2\\.9\\.([0-9])/', 1, 'dec', 'MLDonkey/2.9.2', 'no', 'no', ''),
(2004, 'uTorrent 1.8.x', 'uTorrent 1.8.0', '/^-UT18([0-9])([0-9])-/', 2, 'dec', '-UT1800-', '/^uTorrent\\/18([0-9])([0-9])/', 2, 'dec', 'uTorrent/1800', 'no', 'no', ''),
(1003, 'Azureus 4.x', 'Vuze 4.0.0.2', '/^-AZ4([0-9])([0-9])([0-9])-/', 3, 'dec', '-AZ4002-', '/^Azureus 4\\.([0-9])\\.([0-9])\\.([0-9])/', 3, 'dec', 'Azureus 4.0.0.2', 'no', 'no', ''),
(9002, 'SymTorrent', '', '', 0, 'dec', '', '/^SymTorrent/', 0, 'dec', 'SymTorrent', 'no', 'no', ''),
(9003, 'Enhanced-CTorrent', 'Enhanced-CTorrent/dnh3.3.2', '/^-CD([0-9])([0-9])([0-9])([0-9])-/', 4, 'dec', '-CD0303-', '/^Enhanced-CTorrent\\/dnh([0-9])\\.([0-9])\\.([0-9])/', 3, 'dec', 'Enhanced-CTorrent/dnh3.3.2', 'no', 'no', ''),
(4002, 'Deluge 1.x', 'Deluge 1.1.6', '/^-DE1([0-9])([0-9])([0-9])-/', 3, 'dec', '-DE1160-', '/^Deluge 1\\.([0-9])\\.([0-9])/', 2, 'dec', 'Deluge 1.1.6', 'no', 'no', '');

-- --------------------------------------------------------

--
-- Table structure for table `allowedemails`
--

CREATE TABLE IF NOT EXISTS `allowedemails` (
  `id` int(10) NOT NULL auto_increment,
  `value` mediumtext NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `allowedemails`
--

INSERT INTO `allowedemails` (`id`, `value`) VALUES
(1, '@st.zju.edu.cn @gstu.zju.edu.cn @fa.zju.edu.cn @email.zucc.edu.cn @zuaa.zju.edu.cn');

-- --------------------------------------------------------

--
-- Table structure for table `audiocodecs`
--

CREATE TABLE IF NOT EXISTS `audiocodecs` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(30) character set utf8 NOT NULL,
  `image` varchar(30) character set utf8 NOT NULL,
  `sort_index` int(10) unsigned NOT NULL default '0',
  `team_desc` varchar(30) character set utf8 NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=10 ;

--
-- Dumping data for table `audiocodecs`
--

INSERT INTO `audiocodecs` (`id`, `name`, `image`, `sort_index`, `team_desc`) VALUES
(1, 'FLAC', '', 0, ''),
(2, 'APE', '', 0, ''),
(3, 'DTS', '', 0, ''),
(4, 'MP3', '', 0, ''),
(5, 'Vorbis', '', 0, ''),
(6, 'AAC', '', 0, ''),
(7, 'Other', '', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `avps`
--

CREATE TABLE IF NOT EXISTS `avps` (
  `arg` varchar(20) NOT NULL default '',
  `value_s` text NOT NULL,
  `value_i` int(11) NOT NULL default '0',
  `value_u` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`arg`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `avps`
--

INSERT INTO `avps` (`arg`, `value_s`, `value_i`, `value_u`) VALUES
('lastcleantime', '', 0, 1245653948),
('last24', '', 947, 1211708476),
('lastcleantime2', '', 0, 1240736917),
('lastcleantime3', '', 0, 1240739049),
('lastcleantime4', '', 0, 1240745618),
('lastcleantime5', '', 0, 1240832394);

-- --------------------------------------------------------

--
-- Table structure for table `bannedemails`
--

CREATE TABLE IF NOT EXISTS `bannedemails` (
  `id` int(10) NOT NULL auto_increment,
  `value` mediumtext NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `bannedemails`
--

INSERT INTO `bannedemails` (`id`, `value`) VALUES
(1, '@test.com');

-- --------------------------------------------------------

--
-- Table structure for table `bans`
--

CREATE TABLE IF NOT EXISTS `bans` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `addedby` int(10) unsigned NOT NULL default '0',
  `comment` varchar(255) NOT NULL default '',
  `first` bigint(11) default NULL,
  `last` bigint(11) default NULL,
  PRIMARY KEY  (`id`),
  KEY `first_last` (`first`,`last`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `bans`
--


-- --------------------------------------------------------

--
-- Table structure for table `bitbucket`
--

CREATE TABLE IF NOT EXISTS `bitbucket` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `owner` int(10) default NULL,
  `name` text,
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `public` enum('0','1') NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `bitbucket`
--


-- --------------------------------------------------------

--
-- Table structure for table `blocks`
--

CREATE TABLE IF NOT EXISTS `blocks` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` int(10) unsigned NOT NULL default '0',
  `blockid` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `userfriend` (`userid`,`blockid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `blocks`
--


-- --------------------------------------------------------

--
-- Table structure for table `bonus`
--

CREATE TABLE IF NOT EXISTS `bonus` (
  `id` int(5) NOT NULL auto_increment,
  `bonusname` varchar(50) NOT NULL,
  `art` varchar(10) NOT NULL default 'traffic',
  `menge` bigint(20) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `bonus`
--

INSERT INTO `bonus` (`id`, `bonusname`, `art`, `menge`) VALUES
(1, '1.0GB Uploaded', 'traffic', 1073741824),
(2, '5.0GB Uploaded', 'traffic', 5368709120),
(3, '10.0 GB Uploaded', 'traffic', 10737418240),
(4, '1 Invite', 'invite', 1),
(5, 'Custom Title!', 'title', 1),
(6, 'VIP Status', 'class', 1),
(7, 'Give A Karma Gift', 'gift_1', 1073741824);

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

CREATE TABLE IF NOT EXISTS `bookmarks` (
  `id` int(10) NOT NULL auto_increment,
  `torrentid` int(10) NOT NULL default '0',
  `userid` int(10) NOT NULL default '0',
  `share` enum('yes','no') NOT NULL default 'no',
  PRIMARY KEY  (`id`),
  KEY `finished` (`torrentid`),
  KEY `torrentid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `bookmarks`
--


-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `mode` enum('nhd','atbrowse','atspecial','chd','hdsmusic','ali213','ncepu') NOT NULL default 'nhd',
  `name` varchar(30) NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_index` int(10) unsigned NOT NULL default '0',
  `cat_desc` varchar(30) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=725 ;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`id`, `mode`, `name`, `image`, `sort_index`, `cat_desc`) VALUES
(401, 'chd', 'Movies', 'movies.png', 0, ''),
(402, 'chd', 'TV Series', 'tvseries.png', 3, ''),
(403, 'chd', 'TV Shows', 'tvshows.png', 4, ''),
(404, 'chd', 'Documentaries', 'doc.png', 1, ''),
(405, 'chd', 'Animations', 'anime.png', 2, ''),
(406, 'chd', 'Music Videos', 'mv.png', 5, ''),
(407, 'chd', 'Sports', 'sports.png', 6, ''),
(408, 'chd', 'HQ Audio', 'hqaudio.png', 8, ''),
(409, 'chd', 'Misc', 'misc.png', 7, '');

-- --------------------------------------------------------

--
-- Table structure for table `caticons`
--

CREATE TABLE IF NOT EXISTS `caticons` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(64) NOT NULL,
  `folder` varchar(100) NOT NULL,
  `multilang` enum('yes','no') NOT NULL default 'no',
  `secondicon` enum('yes','no') NOT NULL default 'no',
  `designer` varchar(50) default NULL,
  `comment` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

--
-- Dumping data for table `caticons`
--

INSERT INTO `caticons` (`id`, `name`, `folder`, `multilang`, `secondicon`, `designer`, `comment`) VALUES
(1, 'SceneTorrents mod', 'scenetorrents/', 'yes', 'no', 'Nexus Project', 'Modified from SceneTorrents');

-- --------------------------------------------------------

--
-- Table structure for table `cheaters`
--

CREATE TABLE IF NOT EXISTS `cheaters` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `added` datetime default NULL,
  `userid` int(10) unsigned NOT NULL,
  `torrentid` int(10) unsigned NOT NULL,
  `uploaded` bigint(20) unsigned NOT NULL default '0',
  `downloaded` bigint(20) unsigned NOT NULL default '0',
  `anctime` int(10) NOT NULL,
  `seeders` int(10) unsigned NOT NULL,
  `leechers` int(10) unsigned NOT NULL,
  `hit` int(10) default '1',
  `dealtby` int(10) unsigned NOT NULL default '0',
  `dealtwith` tinyint(1) NOT NULL default '0',
  `comment` varchar(100) character set utf8 default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `cheaters`
--


-- --------------------------------------------------------

--
-- Table structure for table `chronicle`
--

CREATE TABLE IF NOT EXISTS `chronicle` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` int(11) NOT NULL default '0',
  `added` datetime default NULL,
  `txt` text,
  PRIMARY KEY  (`id`),
  KEY `added` (`added`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `chronicle`
--


-- --------------------------------------------------------

--
-- Table structure for table `clientselect`
--

CREATE TABLE IF NOT EXISTS `clientselect` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(80) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=359 ;

--
-- Dumping data for table `clientselect`
--

INSERT INTO `clientselect` (`id`, `name`) VALUES
(1, 'ABC'),
(2, 'Azureus'),
(3, 'BitAnarch'),
(4, 'BitComet'),
(5, 'BitSpirit'),
(6, 'BitTorrent'),
(7, 'BitTorrent++'),
(8, 'BitTornado'),
(9, 'BTQueue'),
(10, 'Burst'),
(11, 'CTorrent'),
(12, 'G3 Torrent'),
(13, 'Nova Torrent'),
(14, 'PTC Bittorrent'),
(15, 'Shadows Experimental'),
(16, 'Shareaza'),
(17, 'Torrentstorm'),
(18, 'TorrenTopia'),
(19, 'TurbotBT'),
(20, 'UPnP BT Client'),
(21, 'BitTorrent/3.4.2'),
(22, 'uTorrent/1300'),
(23, 'uTorrent/1600'),
(24, 'Azureus 2.5.0.0;Windows XP;Java 1.5.0_06'),
(25, 'uTorrent/1750'),
(26, 'ktorrent/2.2.4'),
(27, 'uTorrent/180B(6415)'),
(28, 'uTorrent/180B(6171)'),
(29, 'uTorrent/1700'),
(30, 'uTorrent/1710'),
(31, 'uTorrent/180B(7041)'),
(32, 'BitTorrent/6000'),
(33, 'uTorrent/1720'),
(34, 'BitTorrent/4.1.2'),
(35, 'uTorrent/1610'),
(36, 'Azureus 2.5.0.4;Windows XP;Java 1.6.0_03'),
(37, 'Deluge 0.5.4.1'),
(38, 'Azureus 2.5.0.4;Linux;Java 1.7.0'),
(39, 'ktorrent/2.0.3'),
(40, 'Azureus 3.0.4.0;Mac OS X;Java 1.5.0_13'),
(41, 'uTorrent/151B(456)'),
(42, 'uTorrent/170B(2740)'),
(43, 'uTorrent/1500'),
(44, 'uTorrent/160B(467)'),
(45, 'Azureus 3.0.4.2;Windows Vista;Java 1.6.0_02'),
(46, 'Deluge 0.5.7.1'),
(47, 'Transmission/0.96 (4124)'),
(48, 'Azureus 2.5.0.4;Linux;Java 1.6.0_03'),
(49, 'Azureus 2.5.0.5;Linux;Java 1.6.0_03'),
(50, 'uTorrent/180B(6723)'),
(51, 'uTorrent/170B(2585)'),
(52, 'uTorrent/180B(6838)'),
(53, 'Azureus 2.5.0.0;Linux;Java 1.4.2'),
(54, 'Azureus 3.0.4.0;Windows XP;Java 1.5.0_05'),
(55, 'Azureus 3.0.3.4;Linux;Java 1.5.0_13'),
(56, 'Azureus 3.0.1.6;Linux;Java 1.6.0_03'),
(57, 'qqdownload/1.7.153.0'),
(58, 'Transmission/0.91 (3628)'),
(59, 'Azureus 2.5.0.4;Windows Vista;Java 1.6.0_03'),
(60, 'Transmission/0.96 (4122)'),
(61, 'uTorrent/180B(7364)'),
(62, 'BitTorrent/4.2.0'),
(63, 'Transmission/0.82 (3009)'),
(64, 'Azureus 3.0.4.2;Linux;Java 1.7.0'),
(65, 'AzureusBitTyrant 2.5.0.0BitTyrant;Mac OS X;Java 1.5.0_13'),
(66, 'Azureus 3.0.4.2;Mac OS X;Java 1.5.0_07'),
(67, 'Deluge 0.5.7.95'),
(68, 'uTorrent/180B(7237)'),
(69, 'uTorrent/170B(2151)'),
(70, 'Azureus 3.0.4.2;Windows Vista;Java 1.6.0_03'),
(71, 'Azureus 3.0.4.2;Windows XP;Java 1.6.0_02'),
(72, 'Azureus 3.0.4.2;Windows XP;Java 1.5.0'),
(73, 'uTorrent/180B(7398)'),
(74, 'qqdownload/1.7.154.0'),
(75, 'uTorrent/1740'),
(76, ''),
(77, 'uTorrent/180B(7435)'),
(78, 'qqdownload/1.2.83.0'),
(79, 'uTorrent/170B(2951)'),
(80, 'Azureus 3.0.4.2;Mac OS X;Java 1.5.0_13'),
(81, 'uTorrent/180B(7491)'),
(82, 'uTorrent/180B(7593)'),
(83, 'Azureus 3.0.4.2;Windows XP;Java 1.6.0'),
(84, 'Azureus 3.0.4.2;Windows XP;Java 1.6.0_03'),
(85, 'Azureus 3.0.4.2;Windows XP;Java 1.6.0_01'),
(86, 'Azureus 2.5.0.4;Windows XP;Java 1.5.0_06'),
(87, 'uTorrent/180B(7795)'),
(88, 'Azureus 3.0.4.2;Windows Vista;Java 1.6.0-oem'),
(89, 'uTorrent/1760'),
(90, 'uTorrent/1760'),
(91, 'uTorrent/170B(2248)'),
(92, 'Azureus 3.0.4.2;Windows 2003;Java 1.6.0_02'),
(93, 'uTorrent/180B(7895)'),
(94, 'Azureus 3.0.4.2;Windows XP;Java 1.6.0-rc'),
(95, 'uTorrent/180B(7834)'),
(96, 'rtorrent/0.7.8/0.11.8'),
(97, 'Azureus 2.5.0.4;Windows XP;Java 1.6.0_02'),
(98, 'uTorrent/1770'),
(99, 'qqdownload/1.7.164.0'),
(100, 'Transmission/1.04 (4888)'),
(101, 'Deluge 0.5.8.3'),
(102, 'uTorrent/180B(8205)'),
(103, 'qqdownload/1.6.143.0'),
(104, 'Transmission/1.05 (4991)'),
(105, 'uTorrent/180B(6102)'),
(106, 'Azureus 3.0.4.2;Windows Vista;Java 1.6.0'),
(107, 'BitTorrent/6020'),
(108, 'Azureus 3.0.4.2;Windows 2003;Java 1.6.0_03'),
(109, 'Azureus 3.0.4.2;Windows XP;Java 1.5.0_06'),
(110, 'ktorrent/2.2.5'),
(111, 'uTorrent/180B(7022)'),
(112, 'Azureus 3.0.4.2'),
(113, 'uTorrent/180B(7676)'),
(114, 'uTorrent/180B(8682)'),
(115, 'MLDonkey/2.9.3'),
(116, 'BitTorrent/4.4.1'),
(117, 'uTorrent/170B(1170)'),
(118, 'uTorrent/161B(483)'),
(119, 'FDM 2.x'),
(120, 'Azureus 3.0.4.2;Windows XP;Java 1.5.0_07'),
(121, 'ktorrent/2.2.1'),
(122, 'Transmission/1.06 (5136)'),
(123, 'Deluge 0.5.8.5'),
(124, 'Azureus 3.0.4.2;Windows Vista;Java 1.6.0_05'),
(125, 'Azureus 3.0.5.0;Windows Vista;Java 1.6.0_05'),
(126, 'Azureus 3.0.5.0;Windows XP;Java 1.6.0_03'),
(127, 'Azureus 3.0.5.0;Windows XP;Java 1.6.0_02'),
(128, 'uTorrent/151B(459)'),
(129, 'Transmission/1.05 (4987)'),
(130, 'uTorrent/180B(8872)'),
(131, 'Azureus 3.0.4.2;Windows XP;Java 1.6.0_04'),
(132, 'Azureus 3.0.5.0;Windows Vista;Java 1.6.0_03'),
(133, 'Azureus 2.5.0.4;Windows Vista;Java 1.6.0_05'),
(134, 'Azureus 2.5.0.4;Windows Vista;Java 1.6.0_05'),
(135, 'Azureus 3.0.5.0;Windows Vista;Java 1.6.0_01'),
(136, 'uTorrent/180B(8852)'),
(137, 'uTorrent/180B(8912)'),
(138, 'uTorrent/180B(8188)'),
(139, 'Azureus 3.0.5.0;Windows Vista;Java 1.6.0-oem'),
(140, 'uTorrent/1400'),
(141, 'Azureus 3.0.4.2;Windows XP;Java 1.6.0_05'),
(142, 'Azureus 3.0.5.0;Windows XP;Java 1.6.0_01'),
(143, 'Azureus 3.0.5.0;Mac OS X;Java 1.5.0_13'),
(144, 'uTorrent/180B(9137)'),
(145, 'BitTorrent/6030'),
(146, 'Deluge 0.5.8.6'),
(147, 'Azureus 2.5.0.4;Windows Vista;Java 1.6.0'),
(148, 'Azureus 3.0.5.0;Windows XP;Java 1.5.0'),
(149, 'Azureus 3.0.5.0;Windows XP;Java 1.6.0_05'),
(150, 'uTorrent/180B(8680)'),
(151, 'uTorrent/180B(9272)'),
(152, 'Transmission/1.10 (5422)'),
(153, 'Transmission/1.10 (5422)'),
(154, 'rtorrent/0.6.4/0.10.4'),
(155, 'Transmission/1.11 (5504)'),
(156, 'Azureus 3.0.5.0;Windows XP;Java 1.5.0_06'),
(157, 'Azureus 3.0.5.0;Windows XP;Java 1.5.0_15'),
(158, 'uTorrent/180B(9363)'),
(159, 'uTorrent/180B(9360)'),
(160, 'Azureus 3.0.5.2;Windows Vista;Java 1.6.0_02'),
(161, 'Azureus 3.0.5.2;Windows XP;Java 1.6.0_03'),
(162, 'uTorrent/180B(9578)'),
(163, 'uTorrent/180B(9599)'),
(164, 'uTorrent/180B(9599)'),
(165, 'Azureus 3.0.5.2;Windows XP;Java 1.5.0_15'),
(166, 'Azureus 2.5.0.4;Windows Vista;Java 1.6.0_02'),
(167, 'Azureus 3.0.5.2;Windows XP;Java 1.6.0_02'),
(168, 'Azureus 3.0.5.2;Windows XP;Java 1.6.0'),
(169, 'Azureus 2.5.0.4;Windows XP;Java 1.5.0-rc'),
(170, 'BitTornado/T-0.3.18'),
(171, 'BitTornado/T-0.3.17'),
(172, 'Azureus 3.0.1.6;Linux;Java 1.6.0_05'),
(173, 'uTorrent/180B(9704)'),
(174, 'rtorrent/0.8.0/0.12.0'),
(175, 'qqdownload/1.8.191.0'),
(176, 'Azureus 3.0.4.2;Windows XP;Java 1.6.0_06'),
(177, 'Azureus 3.0.5.2;Windows XP;Java 1.6.0_06'),
(178, 'Azureus 3.0.5.2;Windows XP;Java 1.5.0_06'),
(179, 'Azureus 2.5.0.4;Linux;Java 1.6.0'),
(180, 'Transmission/1.02 (4794)'),
(181, 'Azureus 3.0.5.2;Windows Vista;Java 1.6.0_05'),
(182, 'Azureus 3.0.5.2;Windows Vista;Java 1.6.0_03'),
(183, 'BitTorrent/BitSpirit'),
(184, 'uTorrent/180B(10054)'),
(185, 'uTorrent/180B(10093)'),
(186, 'uTorrent/180B(10085)'),
(187, 'uTorrent/180B(10085)'),
(188, 'uTorrent/180B(10198)'),
(189, 'Transmission/1.20 (5786)'),
(190, 'Deluge 0.5.9.0'),
(191, 'qqdownload/1.8.198.0'),
(192, 'Azureus 2.5.0.4;Linux;Java 1.6.0_06'),
(193, 'uTorrent/180B(10181)'),
(194, 'Rufus/0.6.9'),
(195, 'Rufus/0.7.0'),
(196, 'ktorrent/2.2.6'),
(197, 'uTorrent/180B(10364)'),
(198, 'Azureus 2.5.0.4;Mac OS X;Java 1.5.0_13'),
(199, 'Deluge 0.5.8.9'),
(200, 'Azureus 3.0.4.2;Windows Vista;Java 1.6.0_10-beta'),
(201, 'Azureus 3.0.5.2;Windows Vista;Java 1.6.0_06'),
(202, 'Transmission/1.21 (5890)'),
(203, 'Azureus 2.5.0.4;Windows XP;Java 1.5.0_11'),
(204, 'Azureus 3.0.5.2;Windows XP;Java 1.6.0_05'),
(205, 'Azureus 3.0.5.2;Linux;Java 1.6.0_06'),
(206, 'Azureus 3.0.5.2;Windows XP;Java 1.5.0'),
(207, 'Azureus 3.0.5.2;Windows 2003;Java 1.6.0_03'),
(208, 'Azureus 3.0.5.0;Windows Vista;Java 1.5.0_12'),
(209, 'uTorrent/180B(10416)'),
(210, 'Azureus 3.0.5.0;Windows 2003;Java 1.6.0_03'),
(211, 'uTorrent/180B(10431)'),
(212, 'Azureus 3.0.5.2;Windows XP;Java 1.5.0_07'),
(213, 'Deluge 0.5.9.1'),
(214, 'uTorrent/180B(10415)'),
(215, 'Azureus 2.5.0.4;Windows XP;Java 1.5.0-beta'),
(216, 'Azureus 3.0.5.2;Linux;Java 1.6.0_03'),
(217, 'Azureus 2.5.0.4;Windows XP;Java 1.6.0_06'),
(218, 'BitTorrent/6010'),
(219, 'Azureus 3.0.5.2;Linux;Java 1.6.0'),
(220, 'Azureus 3.0.5.0;Windows XP;Java 1.5.0_14'),
(221, 'Azureus 3.0.5.2;Windows XP;Java 1.5.0_14'),
(222, 'uTorrent/180B(10497)'),
(223, 'Azureus 3.0.5.0;Windows XP;Java 1.6.0'),
(224, 'uTorrent/180B(10504)'),
(225, 'uTorrent/180B(10504)'),
(226, 'Azureus 3.0.5.2;Windows XP;Java 1.6.0_10-ea'),
(227, 'Azureus 2.5.0.4;Windows XP;Java 1.6.0'),
(228, 'uTorrent/180B(10524)'),
(229, 'Azureus 2.5.0.4;Windows XP;Java 1.6.0_05'),
(230, 'Azureus 3.0.5.0;Windows XP;Java 1.5.0_07'),
(231, 'Transmission/1.21 (5898)'),
(232, 'MLDonkey/2.9.5'),
(233, 'Azureus 2.5.0.4;Windows XP;Java 1.6.0_01'),
(234, 'Azureus 3.0.5.2;Windows 2003;Java 1.6.0_06'),
(235, 'Azureus 2.5.0.4;Linux;Java 1.6.0_05'),
(236, 'Azureus 3.0.5.2;Windows 2003;Java 1.6.0_05'),
(237, 'uTorrent/180B(10843)'),
(238, 'Azureus 3.0.5.2;Linux;Java 1.7.0'),
(239, 'uTorrent/180B(10853)'),
(240, 'uTorrent/180B(10853)'),
(241, 'uTorrent/180B(10853)'),
(242, 'Azureus 3.1.0.0;Windows 2003;Java 1.6.0_05'),
(243, 'Azureus 3.1.0.0;Windows 2003;Java 1.6.0_05'),
(244, 'uTorrent/180B(10770)'),
(245, 'Azureus 3.1.0.0;Windows Vista;Java 1.6.0_02'),
(246, 'Azureus 3.1.0.0;Windows Vista;Java 1.6.0_05'),
(247, 'Azureus 3.1.0.0;Windows Vista;Java 1.6.0_05'),
(248, 'Azureus 3.1.0.0;Windows XP;Java 1.6.0_04'),
(249, 'Azureus 3.0.5.0;Linux;Java 1.5.0'),
(250, 'Azureus 3.1.0.0;Windows XP;Java 1.6.0_03'),
(251, 'Azureus 2.5.0.4;Windows XP;Java 1.5.0_14'),
(252, 'Azureus 3.1.0.0;Windows XP;Java 1.6.0'),
(253, 'Azureus 3.0.5.0;Windows 2000;Java 1.6.0_03'),
(254, 'Azureus 3.1.0.0;Windows XP;Java 1.6.0_05'),
(255, 'Transmission/1.22 (6189)'),
(256, 'Azureus 3.0.5.0'),
(257, 'uTorrent/180B(11086)'),
(258, 'Deluge 0.5.9.3'),
(259, 'Deluge 0.5.9.3'),
(260, 'Deluge 0.5.9.3'),
(261, 'Transmission/1.22 (6191)'),
(262, 'Transmission/1.22 (6191)'),
(263, 'Azureus 2.5.0.4;Windows NT (unknown);Java 1.5.0_07'),
(264, 'uTorrent/180B(11140)'),
(265, 'Azureus 3.1.0.0;Windows Vista;Java 1.6.0_06'),
(266, 'Azureus 3.1.1.0;Windows XP;Java 1.6.0_03'),
(267, 'Azureus 3.1.1.0;Windows 2003;Java 1.6.0_05'),
(268, 'uTorrent/1800'),
(269, 'Azureus 2.5.0.4;Windows Vista;Java 1.6.0-oem'),
(270, 'Azureus 3.1.1.0;Windows Vista;Java 1.6.0_02'),
(271, 'Azureus 3.1.0.0;Mac OS X;Java 1.5.0_13'),
(272, 'Azureus 2.5.0.4;Windows XP;Java 1.5.0'),
(273, 'Azureus 3.1.1.0;Windows Vista;Java 1.6.0_05'),
(274, 'Azureus 3.1.1.0;Windows XP;Java 1.5.0_06'),
(275, 'Azureus 3.0.5.2;Windows Vista;Java 1.6.0_07'),
(276, 'Azureus 2.5.0.4;Windows XP;Java 1.6.0_07'),
(277, 'Azureus 3.1.1.0;Windows XP;Java 1.5.0_11'),
(278, 'Azureus 3.0.5.0;Windows XP;Java 1.6.0_06'),
(279, 'Azureus 3.1.1.0;Windows 2003;Java 1.6.0_07'),
(280, 'Azureus 3.1.1.0;Windows Vista;Java 1.6.0_07'),
(281, 'Azureus 3.0.5.2;Windows XP;Java 1.5.0_08'),
(282, 'Azureus 3.1.1.0;Windows XP;Java 1.6.0_05'),
(283, 'Azureus 3.1.1.0;Windows XP;Java 1.6.0_07'),
(284, 'Azureus 3.1.1.0;Windows 2003;Java 1.6.0_03'),
(285, 'Azureus 3.1.1.0;Mac OS X;Java 1.5.0_13'),
(286, 'Azureus 3.1.1.0;Windows XP;Java 1.6.0_06'),
(287, 'Azureus 3.0.5.2;Windows NT (unknown);Java 1.5.0_07'),
(288, 'Azureus 2.5.0.4;Windows Vista;Java 1.6.0_07'),
(289, 'Azureus 2.5.0.4;Windows XP;Java 1.6.0-rc'),
(290, 'Azureus 2.5.0.4;Linux;Java 1.6.0_0'),
(291, 'uTorrent/181B(11903)'),
(292, 'Transmission/1.32 (6455)'),
(293, 'Transmission/1.32 (6455)'),
(294, 'Transmission/1.32 (6455)'),
(295, 'Azureus 3.0.5.2;Windows XP;Java 1.6.0_07'),
(296, 'uTorrent/181B(11962)'),
(297, 'uTorrent/181B(11962)'),
(298, 'Azureus 2.5.0.4;Windows XP;Java 1.6.0_10-rc'),
(299, 'Transmission/1.33 (6594)'),
(300, 'Azureus 3.0.5.2;Windows XP;Java 1.6.0-rc'),
(301, 'Azureus 3.1.1.0;Linux;Java 1.6.0'),
(302, 'Azureus 3.0.5.2;Linux;Java 1.6.0_0'),
(303, 'Azureus 2.5.0.4;Linux;Java 1.6.0_07'),
(304, 'BitTorrent/6100'),
(305, 'uTorrent/181B(11882)'),
(306, 'Azureus 3.1.1.0;Linux;Java 1.7.0'),
(307, 'Transmission/1.33 (6608)'),
(308, 'uTorrent/181B(12024)'),
(309, 'uTorrent/181B(12024)'),
(310, 'Azureus 3.1.1.0;Linux;Java 1.6.0_0'),
(311, 'uTorrent/181B(12083)'),
(312, 'uTorrent/181B(12083)'),
(313, 'Azureus 3.0.5.0;Windows XP;Java 1.5.0_08'),
(314, 'uTorrent/181B(12154)'),
(315, 'uTorrent/181B(12154)'),
(316, 'uTorrent/181B(12132)'),
(317, 'Azureus 3.0.5.0;Windows XP;Java 1.6.0_04'),
(318, 'uTorrent/181B(12183)'),
(319, 'Transmission/1.34 (6770)'),
(320, 'uTorrent/181B(12285)'),
(321, 'uTorrent/181B(12320)'),
(322, 'uTorrent/181B(12320)'),
(323, 'uTorrent/181B(12323)'),
(324, 'MLDonkey/2.9.6'),
(325, 'Azureus 3.1.1.0;Windows XP;Java 1.5.0'),
(326, 'rtorrent/0.8.3/0.12.3'),
(327, 'Transmission/1.34 (6778)'),
(328, 'Azureus 2.5.0.4'),
(329, 'uTorrent/181B(12495)'),
(330, 'Azureus 3.0.5.0;Mac OS X;Java 1.5.0_16'),
(331, 'Azureus 2.5.0.4;Windows Vista;Java 1.6.0_04'),
(332, 'uTorrent/1810'),
(333, 'BitTorrent/6110'),
(334, 'Azureus 3.0.5.2;Mac OS X;Java 1.5.0_16'),
(335, 'Azureus 3.1.1.0;Windows Vista;Java 1.6.0'),
(336, 'Azureus 2.5.0.4;Windows Vista;Java 1.5.0_12'),
(337, 'Azureus 2.5.0.4;Windows Vista;Java 1.6.0_10-rc'),
(338, 'Azureus 3.1.1.0;Windows XP;Java 1.5.0_08'),
(339, 'Azureus 3.0.5.0;Windows Vista;Java 1.6.0_10-rc2'),
(340, 'Azureus 3.0.5.0;Windows Vista;Java 1.6.0'),
(341, 'Azureus 3.0.5.2;Linux;Java 1.6.0_07'),
(342, 'Azureus 3.1.1.0;Windows Vista;Java 1.6.0_03'),
(343, 'BitRocket/0.3.3(32) libtorrent/0.13.0.0'),
(344, 'Azureus 3.0.5.2;Mac OS X;Java 1.5.0_13'),
(345, 'Azureus 2.5.0.4;Mac OS X;Java 1.5.0_16'),
(346, 'Azureus 3.1.1.1;Windows XP;Java 1.5.0_06'),
(347, 'Azureus 3.0.5.0;Windows Vista;Java 1.6.0_02'),
(348, 'Azureus 3.0.5.2;Windows XP;Java 1.6.0_10'),
(349, 'Azureus 3.1.1.0;Linux;Java 1.6.0_10'),
(350, 'Azureus 2.5.0.4;Windows XP;Java 1.6.0_10'),
(351, 'Azureus 4.0.0.2;Windows Vista;Java 1.6.0_07'),
(352, 'Azureus 4.0.0.2;Windows XP;Java 1.6.0_03'),
(353, 'Azureus 4.0.0.2;Linux;Java 1.6.0_0'),
(354, 'Azureus 4.0.0.2;Linux;Java 1.6.0_0'),
(355, 'Azureus 4.0.0.2;Windows XP;Java 1.6.0_06'),
(356, 'Azureus 4.0.0.2;Windows XP;Java 1.5.0_08'),
(357, 'Azureus 4.0.0.2;Windows 2003;Java 1.6.0_07'),
(358, 'Azureus 4.0.0.2;Windows XP;Java 1.6.0_07');

-- --------------------------------------------------------

--
-- Table structure for table `codecs`
--

CREATE TABLE IF NOT EXISTS `codecs` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_index` int(10) unsigned NOT NULL default '0',
  `codec_desc` varchar(30) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `codecs`
--

INSERT INTO `codecs` (`id`, `name`, `image`, `sort_index`, `codec_desc`) VALUES
(1, 'H.264', '', 0, ''),
(2, 'VC-1', '', 0, ''),
(3, 'Xvid', '', 0, ''),
(4, 'MPEG-2', '', 0, ''),
(5, 'FLAC', '', 0, ''),
(6, 'APE', '', 0, ''),
(7, 'DTS', '', 0, ''),
(9, 'Other', '', 0, ''),
(8, 'AC-3', '', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `codeupdate`
--

CREATE TABLE IF NOT EXISTS `codeupdate` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` int(11) NOT NULL default '0',
  `added` datetime default NULL,
  `txt` text,
  PRIMARY KEY  (`id`),
  KEY `added` (`added`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `codeupdate`
--


-- --------------------------------------------------------

--
-- Table structure for table `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user` int(10) unsigned NOT NULL default '0',
  `torrent` int(10) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `text` text NOT NULL,
  `ori_text` text NOT NULL,
  `editedby` int(10) unsigned NOT NULL default '0',
  `editdate` datetime NOT NULL default '0000-00-00 00:00:00',
  `request` int(10) NOT NULL default '0',
  `offer` int(10) NOT NULL default '0',
  `bonus_change` int(10) NOT NULL default '0',
  `reason` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user` (`user`),
  KEY `torrent` (`torrent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `comments`
--


-- --------------------------------------------------------

--
-- Table structure for table `countries`
--

CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `flagpic` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=108 ;

--
-- Dumping data for table `countries`
--

INSERT INTO `countries` (`id`, `name`, `flagpic`) VALUES
(1, 'Sweden', 'sweden.gif'),
(2, 'United States of America', 'usa.gif'),
(3, 'Russia', 'russia.gif'),
(4, 'Finland', 'finland.gif'),
(5, 'Canada', 'canada.gif'),
(6, 'France', 'france.gif'),
(7, 'Germany', 'germany.gif'),
(8, '中国', 'china.gif'),
(9, 'Italy', 'italy.gif'),
(10, 'Denmark', 'denmark.gif'),
(11, 'Norway', 'norway.gif'),
(12, 'United Kingdom', 'uk.gif'),
(13, 'Ireland', 'ireland.gif'),
(14, 'Poland', 'poland.gif'),
(15, 'Netherlands', 'netherlands.gif'),
(16, 'Belgium', 'belgium.gif'),
(17, 'Japan', 'japan.gif'),
(18, 'Brazil', 'brazil.gif'),
(19, 'Argentina', 'argentina.gif'),
(20, 'Australia', 'australia.gif'),
(21, 'New Zealand', 'newzealand.gif'),
(23, 'Spain', 'spain.gif'),
(24, 'Portugal', 'portugal.gif'),
(25, 'Mexico', 'mexico.gif'),
(26, 'Singapore', 'singapore.gif'),
(70, 'India', 'india.gif'),
(65, 'Albania', 'albania.gif'),
(29, 'South Africa', 'southafrica.gif'),
(30, 'South Korea', 'southkorea.gif'),
(31, 'Jamaica', 'jamaica.gif'),
(32, 'Luxembourg', 'luxembourg.gif'),
(34, 'Belize', 'belize.gif'),
(35, 'Algeria', 'algeria.gif'),
(36, 'Angola', 'angola.gif'),
(37, 'Austria', 'austria.gif'),
(38, 'Yugoslavia', 'yugoslavia.gif'),
(39, 'Western Samoa', 'westernsamoa.gif'),
(40, 'Malaysia', 'malaysia.gif'),
(41, 'Dominican Republic', 'dominicanrep.gif'),
(42, 'Greece', 'greece.gif'),
(43, 'Guatemala', 'guatemala.gif'),
(44, 'Israel', 'israel.gif'),
(45, 'Pakistan', 'pakistan.gif'),
(46, 'Czech Republic', 'czechrep.gif'),
(47, 'Serbia', 'serbia.gif'),
(48, 'Seychelles', 'seychelles.gif'),
(50, 'Puerto Rico', 'puertorico.gif'),
(51, 'Chile', 'chile.gif'),
(52, 'Cuba', 'cuba.gif'),
(53, 'Congo', 'congo.gif'),
(54, 'Afghanistan', 'afghanistan.gif'),
(55, 'Turkey', 'turkey.gif'),
(56, 'Uzbekistan', 'uzbekistan.gif'),
(57, 'Switzerland', 'switzerland.gif'),
(58, 'Kiribati', 'kiribati.gif'),
(59, 'Philippines', 'philippines.gif'),
(60, 'Burkina Faso', 'burkinafaso.gif'),
(61, 'Nigeria', 'nigeria.gif'),
(62, 'Iceland', 'iceland.gif'),
(63, 'Nauru', 'nauru.gif'),
(64, 'Slovenia', 'slovenia.gif'),
(66, 'Turkmenistan', 'turkmenistan.gif'),
(67, 'Bosnia Herzegovina', 'bosniaherzegovina.gif'),
(68, 'Andorra', 'andorra.gif'),
(69, 'Lithuania', 'lithuania.gif'),
(71, 'Netherlands Antilles', 'nethantilles.gif'),
(72, 'Ukraine', 'ukraine.gif'),
(73, 'Venezuela', 'venezuela.gif'),
(74, 'Hungary', 'hungary.gif'),
(75, 'Romania', 'romania.gif'),
(76, 'Vanuatu', 'vanuatu.gif'),
(77, 'Vietnam', 'vietnam.gif'),
(78, 'Trinidad & Tobago', 'trinidadandtobago.gif'),
(79, 'Honduras', 'honduras.gif'),
(80, 'Kyrgyzstan', 'kyrgyzstan.gif'),
(81, 'Ecuador', 'ecuador.gif'),
(82, 'Bahamas', 'bahamas.gif'),
(83, 'Peru', 'peru.gif'),
(84, 'Cambodia', 'cambodia.gif'),
(85, 'Barbados', 'barbados.gif'),
(86, 'Bangladesh', 'bangladesh.gif'),
(87, 'Laos', 'laos.gif'),
(88, 'Uruguay', 'uruguay.gif'),
(89, 'Antigua Barbuda', 'antiguabarbuda.gif'),
(90, 'Paraguay', 'paraguay.gif'),
(93, 'Thailand', 'thailand.gif'),
(92, 'Union of Soviet Socialist Republics', 'ussr.gif'),
(94, 'Senegal', 'senegal.gif'),
(95, 'Togo', 'togo.gif'),
(96, 'North Korea', 'northkorea.gif'),
(97, 'Croatia', 'croatia.gif'),
(98, 'Estonia', 'estonia.gif'),
(99, 'Colombia', 'colombia.gif'),
(100, 'Lebanon', 'lebanon.gif'),
(101, 'Latvia', 'latvia.gif'),
(102, 'Costa Rica', 'costarica.gif'),
(103, 'Egypt', 'egypt.gif'),
(104, 'Bulgaria', 'bulgaria.gif'),
(105, 'Isla de Muerte', 'jollyroger.gif'),
(107, 'Pirates', 'jollyroger.gif');

-- --------------------------------------------------------

--
-- Table structure for table `downloadspeed`
--

CREATE TABLE IF NOT EXISTS `downloadspeed` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `downloadspeed`
--

INSERT INTO `downloadspeed` (`id`, `name`) VALUES
(1, '64kbps'),
(2, '128kbps'),
(3, '256kbps'),
(4, '512kbps'),
(5, '768kbps'),
(6, '1Mbps'),
(7, '1.5Mbps'),
(8, '2Mbps'),
(9, '3Mbps'),
(10, '4Mbps'),
(11, '5Mbps'),
(12, '6Mbps'),
(13, '7Mbps'),
(14, '8Mbps'),
(15, '9Mbps'),
(16, '10Mbps'),
(17, '48Mbps'),
(18, '100Mbit');

-- --------------------------------------------------------

--
-- Table structure for table `err`
--

CREATE TABLE IF NOT EXISTS `err` (
  `val` varbinary(255) NOT NULL,
  `agent` varbinary(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `err`
--


-- --------------------------------------------------------

--
-- Table structure for table `ext_img`
--

CREATE TABLE IF NOT EXISTS `ext_img` (
  `id` int(3) NOT NULL auto_increment,
  `sitename` varchar(20) NOT NULL,
  `localpath` varchar(200) NOT NULL,
  `file_url` varchar(200) NOT NULL,
  `userid` int(10) unsigned NOT NULL,
  `uptime` datetime NOT NULL default '0000-00-00 00:00:00',
  `needpost` enum('yes','no') NOT NULL default 'yes',
  `posttime` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ext_img`
--


-- --------------------------------------------------------

--
-- Table structure for table `faq`
--

CREATE TABLE IF NOT EXISTS `faq` (
  `id` int(10) NOT NULL auto_increment,
  `link_id` int(11) unsigned default NULL,
  `lang_id` int(10) unsigned NOT NULL default '6',
  `type` set('categ','item') NOT NULL default 'item',
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `flag` set('0','1','2','3') NOT NULL default '1',
  `categ` int(10) NOT NULL default '0',
  `order` int(10) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=224 ;

--
-- Dumping data for table `faq`
--

INSERT INTO `faq` (`id`, `link_id`, `lang_id`, `type`, `question`, `answer`, `flag`, `categ`, `order`) VALUES
(1, 1, 25, 'categ', '站点信息', '', '1', 0, 1),
(2, 2, 25, 'categ', '用户信息', '', '1', 0, 2),
(3, 3, 25, 'categ', '数据统计', '', '1', 0, 3),
(4, 4, 25, 'categ', '上传', '', '1', 0, 4),
(5, 5, 25, 'categ', '下载', '', '1', 0, 5),
(6, 6, 25, 'categ', '我该怎样提升下载速度？', '', '1', 0, 6),
(7, 7, 25, 'categ', '我的网络提供商（ISP）使用了透明代理。我应该怎么做？', '', '1', 0, 7),
(8, 8, 25, 'categ', '为什么我连不上？难道我被网站屏蔽了？', '', '1', 0, 8),
(9, 9, 25, 'categ', '如果从这里找不到我的问题的解答，我该怎么办？', '', '1', 0, 9),
(10, 10, 25, 'item', '到底什么是BT（Bittorrent）？我要如何才能弄到这类程序？', '参看<a class=faqlink href="http://www.btfaq.com/">Brian的BitTorrent FAQ及指导</a>。', '1', 1, 1),
(11, 11, 25, 'item', '我们捐出来的钱上哪儿去了？', '所有捐助的钱用于维护服务器的费用。', '1', 1, 2),
(12, 12, 25, 'item', '我从哪里可以搞到源代码的拷贝？', '这个Tracker使用的是Nexus Project的代码。代码获取事宜，请看<a class=faqlink href="aboutnexus.php">这里</a>。<br>\r\nNexus Project的代码是根据TBSource的源码改写的。TBDev网站，Tracker源代码以及社区论坛都在这里：<a class=faqlink href="http://www.tbdev.net/">TBDev.net</a>。', '1', 1, 3),
(13, 13, 25, 'item', '我注册了一个账号但是却没有收到验证邮件！', '这很有可能是Tracker所在的服务器网络出现了问题。你可以填写<a href=confirm_resend.php class=faqlink>这个表格</a>让服务器重发验证邮件。<br>\r\n通常没有得到确认的注册帐户会在24小时后被删除，所以你可以在第二天重试。需要注意的是，如果你第一次没有收到确认信，第二次有很大的可能仍然无法收到确认信，所以换一个E-mail地址是一个不错的主意。', '1', 2, 1),
(14, 14, 25, 'item', '我忘记了我的用户名/密码了，能帮我找回来么？', '请填写<a class=faqlink href=recover.php>这个表单</a>，我们将把登录详情发还给你。', '1', 2, 2),
(15, 15, 25, 'item', '我可以给我的账号改个名字么？', '我们并不支持给账号改名。', '1', 2, 3),
(16, 16, 25, 'item', '你可以删除一个（已确认的）账号么？', '我们一般不提供该类服务，所以不要请求删除任何一个被你邀请的帐号。', '1', 2, 4),
(17, 17, 25, 'item', '那么，什么是我的分享率（Ratio）？', '就在页面功能分区的下面。<br>\r\n<br>\r\n<img src="pic/ratio.png" alt="ratio" />\r\n<br>\r\n<br>\r\n区分你的整体分享率和独立分享率是很重要的。整体分享率关注的是自从你加入站点以来，账号的整体上传与下载量。而独立分享率则针对每一个你正在下载或做种的文件。\r\n<br>\r\n<br>\r\n你可能看到两种符号来代替数字："Inf."，这个是无限（Infinity）的缩写，意思是你的下载量为0字节，而上传量则是任意一个非零的值(上传量/下载量=无穷大)；"---"，应该被视为“不可用”，这说明了你的下载量和上传量都是0字节。(上传量/下载量=0/0 这是一个不确定的量)。\r\n', '1', 2, 5),
(18, 18, 25, 'item', '为什么我的IP地址显示在我的个人信息页面上？', '只有你自己和网站Moderator及以上的管理员可以看到你的IP地址和Email。普通用户是看不到这些信息的。', '1', 2, 6),
(21, 21, 25, 'item', '为什么我的“可连接”是“否”？（以及为什么我需要关注这个问题？）', 'Tracker服务器认为你在防火墙后，或者在NAT桥接后，并且无法接收其他Peer的连接请求。\r\n<br>\r\n<br>\r\n这意味着其它的大批Peer无法连接到你，只能由你连接到他们。更糟糕的情况是，如果两个Peer都处于这样的状态，他们将完全无法连接到对方。这对于整体速度有着非常不利的影响。\r\n<br>\r\n<br>\r\n对于这个问题，有以下解决方式：对于防火墙，打开用于接收连接的端口（即你在BT客户端中定义的端口）；对于NAT，你需要配置NAT服务器使用Basic NAT方式而不是NAPT（不同的路由有着不同的运行方式。翻阅你的路由文档或客服论坛。你也可以在<a class=faqlink href="http://portforward.com/">PortForward</a>找到关于此问题的大量信息）。\r\n\r\n\r\n\r\n\r\n\r\n', '1', 2, 9),
(22, 22, 25, 'item', '不同的用户等级代表了什么含义？', '<table cellspacing=3 cellpadding=0>\r\n<tr>\r\n<td class=embedded width=200 valign="top">&nbsp; <b class="Peasant_Name">Peasant</b></td>\r\n<td class=embedded width=5>&nbsp;</td>\r\n<td class=embedded> 被降级的用户, 他们有30天时间来提升分享率, 否则他们会被踢. 不能发表趣味盒内容; 不能申请友情链接; 不能上传字幕.\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="User_Name">User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>新用户的默认级别。只能在每周六中午12点至每周日晚上11点59分上传种子.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="PowerUser_Name">Power User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>得到一个邀请名额; 可以上传种子; 可以查看NFO文档; 可以查看用户列表; 可以请求续种; 可以发送邀请; 可以访问Power User论坛和External Trackers论坛; 可以查看排行榜; 可以查看其它用户的种子历史(如果用户隐私等级未设置为"强"); 可以删除自己上传的字幕.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="EliteUser_Name">Elite User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded><b class="EliteUser_Name">Elite User</b>及以上用户Park后不会被删除帐号.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="CrazyUser_Name">Crazy User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>得到两个邀请名额; 可以在做种/下载/上传的时候选择匿名模式.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="InsaneUser_Name">Insane User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>可以查看普通日志.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="VeteranUser_Name">Veteran User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>得到三个邀请名额; 可以查看其它用户的评论、帖子历史; <b class="VeteranUser_Name">Veteran User</b>及以上用户会永远保留账号.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="ExtremeUser_Name">Extreme User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>可以更新过期的外部信息; 可以查看Extreme User论坛.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="UltimateUser_Name">Ultimate User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>得到五个邀请名额; 可以查看种子文件结构.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="NexusMaster_Name">Nexus Master</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>得到十个邀请名额.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded  valign="top">&nbsp; <b><img src="pic/star.gif" alt="Star"></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>为网站捐款的主. </td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="VIP_Name">VIP</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>和<b class="NexusMaster_Name">Nexus Master</b>拥有相同权限并被认为是精英成员. 免除自动降级.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="User_Name">Other</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>自定义等级. </td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="Uploader_Name">Uploader</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>专注的上传者. 免除自动降级; 可以查看匿名用户的真实身份.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="Moderator_Name">Moderator</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>可以查看管理组信箱、举报信箱; 管理趣味盒内容、投票内容; 可以编辑或删除任何上传的种子; 可以管理候选; 可以管理论坛帖子、用户评论; 可以查看机密日志; 可以删除任何字幕; 可以管理日志中的代码、史册; 可以查看用户的邀请记录; 可以管理用户帐号的一般信息. 不能管理友情链接、最近消息、论坛版块; 不能将种子设为置顶或促销; 不能查看用户IP或Email等机密信息; 不能删除账号.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="Administrator_Name">Administrator</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>除了不能改变站点设定、管理捐赠外, 可以做任何事.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="SysOp_Name">SysOp</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>网站开发/维护人员, 可以改变站点设定, 不能管理捐赠.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="StaffLeader_Name">Staff Leader</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>网站主管, 可以做任何事.</td>\r\n</tr>\r\n</table>', '1', 2, 10),
(23, 23, 25, 'item', '提升和降级又是怎样被执行的呢？', '<table cellspacing=3 cellpadding=0>\r\n<tr>\r\n<td class=embedded width=200 valign="top">&nbsp; <b class="Peasant_Name">Peasant</b></td>\r\n<td class=embedded width=5>&nbsp;</td>\r\n<td class=embedded valign=top>当以下情况时将被自动降至本级:<br>\r\n1.如果你已经下载了超过50GB，你应该有大于0.4的分享率。<br>\r\n2.如果你已经下载了超过100GB，你应该有大于0.5的分享率。<br>\r\n3.如果你已经下载了超过200GB，你应该有大于0.6的分享率。<br>\r\n4.如果你已经下载了超过400GB，你应该有大于0.7的分享率。<br>\r\n5.如果你已经下载了超过800GB，你应该有大于0.8的分享率。</td>\r\n</tr>\r\n\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="PowerUser_Name">Power User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必须注册至少四周，并且下载至少50G，分享率大于1.05。<br>\r\n当条件符合时将被自动提升。注意，无论何时，如果你的分享率低于0.95，你将自动降级。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="EliteUser_Name">Elite User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必须注册至少八周，并且下载至少120G，分享率大于1.55。\r\n<br>\r\n当条件符合时将被自动提升。注意，无论何时，如果你的分享率低于1.45，你将自动降级。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="CrazyUser_Name">Crazy User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必须注册至少十五周，并且下载至少300G，分享率大于2.05。\r\n<br>\r\n当条件符合时将被自动提升。注意，无论何时，如果你的分享率低于1.95，你将自动降级。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="InsaneUser_Name">Insane User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必须注册至少二十五周，并且下载至少500G，分享率大于2.55。<br>\r\n当条件符合时将被自动提升。注意，无论何时，如果你的分享率低于2.45，你将自动降级。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="VeteranUser_Name">Veteran User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必须注册至少四十周，并且下载至少750G，分享率大于3.05。<br>\r\n当条件符合时将被自动提升。注意，无论何时，如果你的分享率低于2.95，你将自动降级。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="ExtremeUser_Name">Extreme User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必须注册至少六十周，并且下载至少1TB，分享率大于3.55。<br>\r\n当条件符合时将被自动提升。注意，无论何时，如果你的分享率低于3.45，你将自动降级。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="UltimateUser_Name">Ultimate User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必须注册至少八十周，并且下载至少1.5TB，分享率大于4.05。<br>\r\n当条件符合时将被自动提升。注意，无论何时，如果你的分享率低于3.95，你将自动降级。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="NexusMaster_Name">Nexus Master</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必须注册至少一百周，并且下载至少3TB，分享率大于4.55。<br>\r\n当条件符合时将被自动提升。注意，无论何时，如果你的分享率低于4.45，你将自动降级。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b><img src="pic/star.gif" alt="Star"></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>只需捐款，并且致信<a class=faqlink href=sendmessage.php?receiver=1> NexusHD</a> - 仅NexusHD - 通告详情。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="VIP_Name">VIP</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>由mods仔细斟酌后分配给他们认为对于站点某方面有特殊贡献的用户。<br>\r\n（任何索取VIP等级的要求将被自动无视）</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="User_Name">Other</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>用户使用Bonus兑换, 或由mods仔细斟酌后授权。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="Uploader_Name">Uploader</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>由Admins/SysOp分配(参见''上传''部分以了解详情).</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="Moderator_Name">Moderator</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>无需多问，我们会找到你的!</td>\r\n</tr>\r\n</table>', '1', 2, 11),
(25, 25, 25, 'item', '为什么我的朋友不能加入？', '用户数目有所限制（你可以查看“首页->站点数据->上限”）。当达到那个数目时，我们会停止接受新成员。<br>\r\n由于非活跃用户(长期不使用账号的用户)引起账号资源浪费，因此我们将清理该部分用户，为其他想加入用户腾出空间。<br>\r\n关于非活跃用户清理规则，参考<a class=faqlink href="rules.php">规则</a>。', '1', 2, 13),
(26, 26, 25, 'item', '怎样自定义头像？', '首先，找一个你喜欢的图片，当然了它不能违反我们的<a class=faqlink href=rules.php>规则</a>。然后你要找一个存放它的地方，比方说我们自己的<a class=faqlink href=bitbucket-upload.php>上传器</a>。出于服务器负载的考虑，我们更希望你将图片上传到别的网站，然后将其URL粘贴到你的<a class=faqlink href="usercp.php?action=personal">控制面板</a>的头像URL部分。 <br>\r\n<br>\r\n请不要为了仅仅测试头像而发帖。如果一切顺利，你将在你的详情页面看到它。', '1', 2, 14),
(27, 27, 25, 'item', '最常见的数据未能得到更新的原因', '<ul>\r\n<li>服务器过载/未响应。只要尝试着保持会话直到服务器恢复响应(不推荐连续手动刷新，这样会加重服务器负载)。</li>\r\n<li>你正在使用不稳定的客户端。如果你想要使用测试版或者CVS版本，你需要自己承担由此带来的风险。</li>\r\n</ul>', '1', 3, 1),
(28, 28, 25, 'item', '最佳的尝试', '<ul>\r\n<li>如果你当前正下载/上传的种子并不在你的用户详情页面中，你可以等一会或者强制进行手动更新。</li>\r\n<li>确保你正确地关闭了客户端软件，否则Tracker服务器无法收到"event=completed"的信号。</li>\r\n<li>如果Tracker服务器挂了，不要停止上传。只要在你退出客户端之前服务器恢复工作，所有的数据都会得到正确地更新。</li>\r\n</ul>', '1', 3, 2),
(29, 29, 25, 'item', '我可以任意选择Bittorrent客户端软件么？', '根据<a class=faqlink href=aboutnexus.php>Nexus Project</a>的对常见BitTorrent客户端的测试，目前本站Tracker<b>只允许</b>使用以下的BitTorrent客户端软件。<br>\r\n<a class=faqlink href=aboutnexus.php>Nexus Project</a>的测试报告可<a class=faqlink href="client/" title="点击下载">在此查看</a>。测试通过的客户端可<a class=faqlink href="client/">在此下载</a>。<br>\r\n你也可以点击客户端版本号下载。星星表示我们的推荐度。<br>\r\n<br>\r\n<b>Windows:</b>\r\n<ul>\r\n<li>Azureus: <a class=faqlink href="client/Windows/Azureus_2.5.0.4_Win32.setup.exe" title="下载"> 2.5.0.4</a> <img src="pic/4.5.gif" alt="推荐度：4.5" title="推荐度：4.5">, <a class=faqlink href="client/Windows/Azureus_3.0.5.0_windows.exe" title="下载">3.0.5.0</a> <img src="pic/4.5.gif" alt="推荐度：4.5" title="推荐度：4.5">, <a class=faqlink href="client/Windows/Azureus_3.0.5.2_windows.exe" title="下载">3.0.5.2</a> <img src="pic/3.gif" alt="推荐度：3" title="推荐度：3">及后续版本</li>\r\n<li>uTorrent: <a class=faqlink href="client/Windows/utorrent_1.6.1_490.exe" title="下载">1.6.1</a><img src="pic/4.gif" alt="推荐度：4" title="推荐度：4">, <a class=faqlink href="client/Windows/utorrent_1.7.5.exe" title="下载">1.7.5</a><img src="pic/4.gif" alt="推荐度：4" title="推荐度：4">, <a class=faqlink href="client/Windows/utorrent_1.7.6.exe" title="下载">1.7.6</a><img src="pic/4.gif" alt="推荐度：4" title="推荐度：4">, <a class=faqlink href="client/Windows/utorrent_1.7.7.exe" title="下载">1.7.7</a><img src="pic/4.gif" alt="推荐度：4" title="推荐度：4">, <a class=faqlink href="client/Windows/utorrent-1.8-beta-10364.upx.exe" title="下载">1.8Beta(Build 10364)</a><img src="pic/3.gif" alt="推荐度：3" title="推荐度：3">及后续版本</li>\r\n<li>BitTorrent: <a class=faqlink href="client/Windows/BitTorrent-6.0.1.exe" title="下载">6.0.1</a><img src="pic/4.gif" alt="推荐度：4" title="推荐度：4">, <a class=faqlink href="client/Windows/BitTorrent-6.0.2.exe" title="下载">6.0.2</a><img src="pic/4.gif" alt="推荐度：4" title="推荐度：4">, <a class=faqlink href="client/Windows/BitTorrent-6.0.3.exe" title="下载">6.0.3</a><img src="pic/4.gif" alt="推荐度：4" title="推荐度：4">及后续版本</li>\r\n<li>Deluge: <a class=faqlink href="client/Windows/deluge-0.5.9.1.exe" title="下载">0.5.9.1</a><img src="pic/3.5.gif" alt="推荐度：3.5" title="推荐度：3.5">, 1.1.6及后续版本</li>\r\n<li>Rufus: <a class=faqlink href="client/Windows/Rufus_0.6.9_win32_setup.exe" title="下载">0.6.9</a><img src="pic/2.gif" alt="推荐度：2" title="推荐度：2">, <a class=faqlink href="client/Windows/Rufus_0.7.0_win32_setup.exe" title="下载">0.7.0</a><img src="pic/2.gif" alt="推荐度：2" title="推荐度：2">及后续版本</li>\r\n<li>JRE: <a class=faqlink href="client/Windows/jre-6u3-windows-i586-p.exe" title="下载">jre-6u3-windows-i586-p</a>, 运行Azureus需要JRE</li>\r\n</ul>\r\n<b>Linux:</b>\r\n<ul>\r\n<li>Azureus: <a class=faqlink href="client/Linux/Azureus_2.5.0.4_linux.tar.bz2" title="下载"> 2.5.0.4</a> <img src="pic/4.5.gif" alt="推荐度：4.5" title="推荐度：4.5">, <a class=faqlink href="client/Linux/Azureus_3.0.5.2_linux.tar.bz2" title="下载">3.0.5.2</a> <img src="pic/3.gif" alt="推荐度：3" title="推荐度：3">及后续版本</li>\r\n<li>Deluge: <a class=faqlink href="client/Linux/deluge-0.5.9.1.tar.gz" title="下载">0.5.9.1</a><img src="pic/3.5.gif" alt="推荐度：3.5" title="推荐度：3.5">, 1.1.6及后续版本</li>\r\n<li>Rufus: <a class=faqlink href="client/Linux/Rufus_0.6.9_src.zip" title="下载">0.6.9</a><img src="pic/2.gif" alt="推荐度：2" title="推荐度：2">及后续版本</li>\r\n<li>Transmission: <a class=faqlink href="client/Linux/transmission-1.21.tar.bz2" title="下载">1.21</a><img src="pic/2.gif" alt="推荐度：2" title="推荐度：2">及后续版本</li>\r\n<li>rTorrent: <a class=faqlink href="client/Linux/rtorrent-0.8.0.tar.gz" title="下载">0.8.0</a><img src="pic/2.gif" alt="推荐度：2" title="推荐度：2">(with libtorrent <a class=faqlink href="client/Linux/libtorrent-0.12.0.tar.gz" title="下载">0.12.0</a> or later)及后续版本</li>\r\n</ul>\r\n<b>MacOS X:</b>\r\n<ul>\r\n<li>Azureus: <a class=faqlink href="client/MacOSX/Azureus_2.5.0.4_OSX.dmg" title="下载"> 2.5.0.4</a> <img src="pic/4.5.gif" alt="推荐度：4.5" title="推荐度：4.5">, <a class=faqlink href="client/MacOSX/Azureus_3.0.5.2a_macosx.dmg" title="下载">3.0.5.2a</a> <img src="pic/3.gif" alt="推荐度：3" title="推荐度：3">及后续版本</li>\r\n<li>Transmission: <a class=faqlink href="client/MacOSX/Transmission-1.21.dmg" title="下载">1.21</a><img src="pic/2.gif" alt="推荐度：2" title="推荐度：2">及后续版本</li>\r\n<li>BitRocket: <a class=faqlink href="client/MacOSX/BitRocket_32.dmg" title="下载">0.3.3(32)</a><img src="pic/2.gif" alt="推荐度：2" title="推荐度：2">及后续版本</li>\r\n<li>Enhanced CTorrent: <a class=faqlink href="client/Linux/ctorrent-dnh3.3.2.tar.gz" title="下载">3.3.2</a>及后续版本</li>\r\n</ul>\r\n<b>Symbian (仅供测试):</b>\r\n<ul>\r\n<li>SymTorrent: <a class=faqlink href="client/Symbian/SymTorrent_S60-3rd_1.41_2008-11-26.sis" title="下载"> 1.41 </a> <img src="pic/1.gif" alt="推荐度：1" title="推荐度：1">及后续版本</li>\r\n</ul>\r\n<br>\r\n\r\n<b>以上客户端在https支持方面</b>\r\n<ul>\r\n<li>uTorrent 1.61: 无法准确解析https的tracker, 同时在使用会将自己标识为uTorrent 1.5</li>\r\n<li>Rufus系列: 没有https支持, 并且已经3年没有继续开发</li>\r\n<li>rtorrent系列: 需要手工设置SSL证书, 详细信息请自行查阅其官方网站说明</li>\r\n</ul>\r\n\r\n<br>\r\n\r\n同时请尽量避免使用处于测试期的客户端软件, 如uTorrent 1.8.0B。\r\n\r\n为了从本站得到最好的下载体验,我们高度推荐<a class=faqlink href="http://www.utorrent.com/download.php">uTorrent</a> 以及<a class=faqlink href="http://azureus.sourceforge.net/download.php">Azureus</a>这两个软件的最新稳定版。', '1', 5, 3),
(30, 30, 25, 'item', '为什么我正在下载/做种的一个种子会在我的详情页面中被列出多次？', '如果因为某些原因(比方说死机，客户端失去响应)你的客户端非正常退出并且你又重新打开它，它会被分配到一个全新的Peer ID, 这样它显示为一个全新的种子。而旧的种子将永远不会收到“event=completed”或“event=stopped”的信号，因此将一直被列出直到Tracker清理超时的Peer。 无视了它就可以了，它最后会消失的。', '1', 3, 4),
(31, 31, 25, 'item', '为什么我已经完成/取消的种子仍然在我的详情页面里？', '有一些客户端，比如说TorrentStorm和Nova Torrent，在取消或者完成一个任务的时候不能向Tracker服务器正确发送信号。在那样的情况下，Tracker服务器将一直保持等待信号的状态（因此会一直列出种子的状态为做种/下载的状态）直到Tracker清理超时的Peer。无视了它就可以了，它最后会消失的。', '1', 3, 5),
(33, 33, 25, 'item', '多IP（我可以从不同的电脑登录/下载吗？）', '是的，目前Tracker服务器支持单个用户从任意个数的IP地址同时访问/下载。<br>\r\n然而，对于单种是有限制的。对于每个种子，最多允许3个做种的连接，最多只允许1个下载的连接（这意味着，对于某个种子你一次只能在一个地方下载）。', '1', 3, 7),
(36, 36, 25, 'item', '为什么我不能上传种子？', '请看<a class=faqlink href="rules.php">规则</a>。', '1', 4, 1),
(37, 37, 25, 'item', '我需要满足哪些条件才能加入上传小组呢？', '你所必须满足的条件：\r\n<ul>\r\n<li>具有稳定的资源来源</li>\r\n<li>平均每周资源发布数量不少于5个</li>\r\n</ul>\r\n你必须确保发布的文件符合以下特征:\r\n<ul>\r\n<li>不超过7天之前</li>\r\n<li>你必须要有做种的能力，或者可以确保至少有效供种24小时。</li>\r\n<li>你需要有至少达到2MBit的上传带宽。</li>\r\n</ul>\r\n如果你认为以上条件你符合以上条件，那么不要犹豫，<a class=faqlink href="contactstaff.php">联系管理组</a>吧。<br>\r\n<b>记住！</b> 仔细填写你的申请！确保申请中包含你的上传速度以及你计划上传的内容的类型。<br>\r\n只有仔细填写并且经过慎重考虑的申请才会纳入我们的视野。', '1', 4, 2),
(38, 38, 25, 'item', '我可以上传你们这里的种子到别的Tracker服务器么？', '不能。我们是一个封闭的、限制用户数的社区。只有注册用户才能够使用我们的Tracker。将我们的种子文件发布到其他Tracker服务器是徒劳的，因为绝大多数试图下载这些文件的人将无法连接到我们的服务器。将我们的种子上传到其他Tracker只让那里的用户恼怒（因为无法下载）并且对我们产生敌对情绪，所以这种行为是我们是不能容忍的。<br>\r\n<br>\r\n如果其他网站的管理员向我们举报我们的种子被发布在他们的站点上，对此负责的用户将因此被移出我们的社区。<br>\r\n<br>\r\n但是对于从我们这里下载得到的文件，你可以随意操控它们。你可以制作另一个种子，写入其他Tracker的地址，并上传到你喜欢的站点上。', '1', 4, 3),
(39, 39, 25, 'item', '下载来的文件该怎么打开？', '在这份<a class=faqlink href=formats.php>指引</a>里面找找看吧。', '1', 5, 1),
(40, 40, 25, 'item', '我下载了一部电影，但是不明白CAM/TS/TC/SCR是什么意思?', '在这份<a class=faqlink href=videoformats.php>指引</a>里面找找看吧。', '1', 5, 2),
(41, 41, 25, 'item', '为什么一个可用的种子忽然就消失了？', '以下原因都会导致这个现象的出现:<br>\r\n(<b>1</b>) 按照<a class=faqlink href=rules.php>网站规则</a>，这个种子不符合规则已被删除。\r\n<br>\r\n(<b>2</b>) 上传者因为文件存在问题而删除了它。一般来说，上传者会发布一个替代的版本的。<br>\r\n(<b>3</b>) 在长时间断种后种子被自动删除了。', '1', 5, 3),
(42, 42, 25, 'item', '我该怎样续传文件或者给一个文件续种呢？', '打开扩展名为.torrent的文件，当你的客户端软件询问保存的目录时，选择已经存在的文件存放的目录，它就能够开始续传/续种了。', '1', 5, 4),
(43, 43, 25, 'item', '为什么我的下载有时候停在99%?', '你所下载到的片段越多，寻找拥有你所缺少的片段的同伴就将变得越困难。这就是为什么有时候在下载即将完成的时候，速度会变得非常慢，甚至完全停止了。只要耐心等候，或早或晚剩下的部分一定能够下载到的。', '1', 5, 5),
(44, 44, 25, 'item', '"部分哈希验证出错"这条信息是什么意思？', 'BT的客户端会检查它所收到的数据的完整性。如果某一个片段在验证中出错，那么这个片段将被重新下载。偶尔的哈希验证错误是非常常见的现象，不用担心。<br>\r\n<br>\r\n有些客户端有屏蔽向你发送错误数据的其他客户端的功能。如果有这个选项，最好打开它。因为这样可以保证如果某个同伴经常向你发送错误的数据时，它将会被屏蔽。', '1', 5, 6),
(45, 45, 25, 'item', '100MB大小的种子，我怎么下了120MB的东西回来?', '参见哈希验证失败的那个问题。如果你的客户端收到了错误的数据，那么它将会重新下载这一部分，因此总下载量有可能比种子大小略微大一些。确保“屏蔽发送错误数据的客户端”的那个选项被打开了，这样可以减少额外的下载。', '1', 5, 7),
(46, 46, 25, 'item', '为什么我的客户端的Tracker服务器状态出现"Your ratio is too low! You need to wait xx h to start"的错误？', '在<b>新</b>种子被上传到Tracker服务器之后，有一些用户必须等一些时间才能开始下载。<br>\r\n这个延迟只会影响那些分享率较低且下载量大于10G的用户。<br>\r\n<br>\r\n<table cellspacing=3 cellpadding=0>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.4</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">延迟</td>\r\n	<td class=embedded width="100">24小时</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.5</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">延迟</td>\r\n	<td class=embedded width="100">12小时</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.6</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">延迟</td>\r\n	<td class=embedded width="100">6小时</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.8</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">延迟</td>\r\n	<td class=embedded width="100">3小时</td>\r\n</tr>\r\n</table>', '0', 5, 8),
(47, 47, 25, 'item', '为什么发生了这个错误？ "Port xxxx is blacklisted"?', '你的客户端向Tracker服务器报告它正在使用某个默认的BT协议端口(6881-6889)或是任何其他常见P2P端口来作为连接端口。<br>\r\n<br>\r\n本站不允许这些通常被P2P协议默认使用的端口。原因是目前ISP常常对这些端口进行限速。<br>\r\n<br>\r\n被屏蔽的端口如下：<br>\r\n<br>\r\n<table cellspacing=3 cellpadding=0>\r\n  <tr>\r\n	<td class=embedded width="100">Direct Connect</td>\r\n	<td class=embedded width="100">411 - 413</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">BitTorrent</td>\r\n	<td class=embedded width="100">6881 - 6889</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">BitTorrent</td>\r\n	<td class=embedded width="100">6881 - 6889</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">Kazza</td>\r\n	<td class=embedded width="100">1214</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">Gnutella</td>\r\n	<td class=embedded width="100">6346 - 6347</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">Emule</td>\r\n	<td class=embedded width="100">4662</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">WinMX</td>\r\n	<td class=embedded width="100">6699</td>\r\n  </tr>\r\n</table>\r\n<br>\r\n要使用我们的Tracker服务器，你必须配置你的客户端使用未在上面列出的端口范围(从49152到65535都是不错的选择，参看<a class=altlink href="http://www.iana.org/assignments/port-numbers">IANA</a>)。注意某些客户端，如Azureus 2.0.7.0或更高版本，对所有的种子都使用同一端口。而其他大多数客户端为每一个种子开放一个端口，你在选择端口范围应考虑到这个问题（一般来说端口范围小于10。设置一个过大的范围并不一定有好处，而且可能有安全隐患)。 <br>\r\n<br>\r\n这些端口是用于同伴间通信的，而非用于客户端连接到Tracker服务器。因此这个改动并不会影响你使用其他Tracker服务器（事实上，它甚至可能<i>加快</i>所有Tracker服务器上种子的速度）。你的客户端也仍然能够连接到那些使用默认端口的同伴。如果你的客户端不支持自己自定义端口，那么换一个吧。<br>\r\n<br>\r\n不要向我们询问，或者在论坛里面提问究竟应该选择什么端口。我们的用户选择的端口越随机，ISP就越难以捉摸清楚我们使用的端口，从而无法对我们的端口进行限速。如果我们只是简单地规定一个范围，那么ISP又会很快对那个范围内的端口进行限速的。<br>\r\n<br>\r\n最后还要说的是，记得在你的路由和/或防火墙上打开你选择的端口，如果你有这些东西的话。', '1', 5, 9),
(48, 48, 25, 'item', '那么这个呢？ “IO错误 - [错误号13] 许可被拒绝”？', '如果你只是想要解决这个问题的话，重新启动你的电脑应该就可以了。否则的话，继续读下去。<br>\r\n<br>\r\nIO错误指的是输入-输出错误，这是一个文件系统错误，而非来自我们的Tracker服务器。当你的客户端由于某些原因不能打开种子中未下载完成的文件时，这个错误就会发生。 通常原因是客户端的两个实例同时在运行：当上一次关闭客户端时因为某种原因它没有被真正关闭，从而始终在后台运行。因此文件被锁定，使得新的实例不能打开这个文件。<br>\r\n<br>\r\n另外一个不常出现的原因是因为老旧的FAT文件系统。某些系统崩溃可能导致未下载完成的文件损坏，接着就出现了这个错误。运行一次scandisk应该可以解决这个问题。注意，只有当你使用Windows 9X操作系统（只支持FAT文件系统）或者在Windows NT/2000/XP中使用FAT文件系统的时候才比较可能出现这个问题。NTFS文件系统要健壮许多，不太可能出现这样的问题。', '1', 5, 10),
(50, 50, 25, 'item', '不要马上下载新发布的种子', '下载速度主要取决于上传者/下载者比(SLR)。如果是种子是新发布的且非常受欢迎而SLR又很低的种子，下载速度低是常见的问题。<br>\r\n<br>\r\n请牢记你不喜欢低速下载。所以多<b>上传</b>让别人不用忍耐同样的困扰。\r\n<br>\r\n<br>由其是当你的带宽较窄时，不要马上下载新发布的种子。最好的下载速度通常在一个种子生命周期的一半时出现，此时SLR达到最大值（不过，这时下载的缺点是你的上传量不会很多。究竟如何平衡优点与缺点，取决于你自己)。', '1', 6, 1),
(51, 51, 25, 'item', '限制上传速度', '上传速度将从以下两种方式显著影响下载速度：<br>\r\n<ul>\r\n    <li>Bittorrent的同伴倾向于回馈那些给它们提上传的同伴。这就意味着如果A和B正在同时下载一个文件，而A又在高速向B传送数据，那么B将会尝试着回报A。因此高速上传将导致高速下载。</li>\r\n\r\n    <li>由于TCP协议的工作方式，当A正从B下载某些东西的时候，A必须不停地向B发送成功收到B所发送来的数据的信号（被称为确认──ACK ── 某种“已收到”的信息)。如果A没有发送ACK信号，那么B将暂停向A发送数据并且进入等候状态。如果A正在全速上传，很有可能没有用来发送ACK信号的带宽，因此ACK信号被耽搁。在这种情况下，过高速度的上传导致了低速的下载。</li>\r\n</ul>\r\n实际的效果是以上两个原因的结合。上传速度应该在保证ACK能正常传输的前提下被设得尽量高。 <b>一个很好的实践理论是保持上传速度在理论上限的80%。</b>你也可以细细研究什么是最适合你的速度（同时也请记住高速上传对于你的分享率很有帮助）。<br>\r\n<br>\r\n如果你正在运行一个以上的种子任务，你应该考虑的是全局上传速度。某些客户端能限制了全局上传速度，其他的则能对每一个种子分别进行设置。了解你的客户端。如果你正在使用你的电脑做别的某些应用（比方说上网或者从FTP拖东西），也需考虑一下它们对于全局上传的影响。', '1', 6, 2),
(52, 52, 25, 'item', '限制同时连接数', '某些操作系统（例如Windows 9X）对于大量连接数支持不完善，甚至有可能因此而崩溃。也有一些家用路由（尤其当运行着NAT以及/或者打开防火墙状态检查服务时）会因大量连接数而变得很慢或者崩溃。对于连接数没有固定的最佳值，你可以试试看60或者100。记住这些连接数是累加的，所以如果你的客户端运行了两个会话，这两个数字要加在一起。', '1', 6, 3),
(53, 53, 25, 'item', '限制同时上传数', '上传数难道和连接数有什么不一样吗？是的，两者是不同的。连接数限制了你的客户端所能对话以及/或者下载的同伴数。上传数则限制了你的客户端实际能上传的同伴数。理想的数值一般要比连接数低许多，并且与你的物理带宽高度相关。', '1', 6, 4),
(54, 54, 25, 'item', '那怎么办？等待一会吧', '如我们在上面所解释的，在BT下载过程中一个同伴更加倾向于回报那些上传给它的同伴。当你开始一个新的下载任务时，你没有文件片断提高给其他同伴，因此他们通常会无视你。这使得开始阶段的下载非常缓慢，由其是当你所连接到的同伴只有很少是（或者没有）做种者。一旦你获得了一些能用于共享的文件片断，下载速度会有所改观。', '1', 6, 5),
(55, 55, 25, 'item', '为什么在我下载的时候浏览网页速度如此之慢？', '你的下载带宽是有限的。如果你正在下载一个速度很快的种子，它几乎肯定将占满你的下载带宽。这是浏览网页显然就会变慢。很多BT客户端允许你限制下载速度，你可以试试。<br>\r\n<br>\r\n浏览网页只是作为举例之一，同样的问题也会出现在游戏，即时通信软件上......', '1', 6, 6),
(56, 56, 25, 'item', '什么是代理？', '基本上说，代理就是中间人。当你通过代理访问某个站点的时候，你的请求将首先被发送到代理处，然后由代理转发到你所请求的站点，而不是你直接连通到网站。下面是几种典型的代理分类（术语不是那么的规范）：<br>\r\n<br>\r\n<table cellspacing=3 cellpadding=0>\r\n <tr>\r\n	<td class=embedded valign="top" width="100">&nbsp;透明代理</td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded valign="top">透明代理在客户端无需配置。他将自动把80端口的信息重定向到代理(有时候也作为非匿名代理的同义词)；</td>\r\n </tr>\r\n <tr>\r\n	<td class=embedded valign="top">&nbsp;显式代理</td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded valign="top">浏览器必须经过配置才能使用代理；</td>\r\n </tr>\r\n <tr>\r\n	<td class=embedded valign="top">&nbsp;匿名代理</td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded valign="top">代理将不会把客户标记发送至服务器端 (HTTP_X_FORWARDED_FOR头标志将不被发送。服务器也因此看不到你的IP)；</td>\r\n </tr>\r\n <tr>\r\n	<td class=embedded valign="top">&nbsp;高度匿名代理</td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded valign="top">代理将不会把客户标记或代理标记发送至服务器端 (HTTP_X_FORWARDED_FOR和HTTP_VIA and HTTP_PROXY_CONNECTION头标志将不被发送。服务器看不到你的IP，甚至不知道你正在使用代理)；</td>\r\n </tr>\r\n <tr>\r\n	<td class=embedded valign="top">&nbsp;公用</td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded valign="top">(不言自明了)。</td>\r\n </tr>\r\n</table>\r\n<br>\r\n透明代理可能是匿名的，也可能是非匿名的，且匿名也有相应的等级。', '1', 7, 1),
(57, 57, 25, 'item', '我该怎样发现自己正处于一个（透明的/匿名的）代理后面？', '试试看<a href=http://proxyjudge.org class="faqlink">ProxyJudge</a>。它列出了服务器端从你这里所收到的HTTP的头标志。相关的几个标志是HTTP_CLIENT_IP，HTTP_X_FORWARDED_FOR和REMOTE_ADDR。', '1', 7, 2),
(75, 75, 25, 'item', '我的“可连接”是“否”尽管我并没有NAT或者防火墙？', 'Tracker服务器在寻找你的真实IP方面非常有天赋。但是这需要代理发送HTTP头标志HTTP_X_FORWARDED_FOR。如果你的ISP的代理没有这么做的话，Tracker服务器将把代理的IP当作你的客户端的IP。所以当你登录之后，Tracker服务器尝试连接你的客户端来确信你没有使用NAT/防火墙，服务器实际上将试图连接代理的IP（使用你的BT客户端报告的接收连接端口）。很自然地，代理服务器并没有监听那个端口。如此连接会失败，而Tracker服务器也因此认为你使用了NAT/防火墙。', '1', 7, 3),
(62, 62, 25, 'item', '也许是因为我的IP地址被列入黑名单了？', '这个网站有屏蔽被禁用户或攻击者的IP地址的功能。该功能在Apache/PHP层面上起作用，且只能屏蔽从这些地址<i>登录</i>网站。这不会阻止你<i>连接</i>到网站，更无法从底层的协议层面进行屏蔽。即便你的地址已经被列入了黑名单，你应该仍能够通过ping/traceroute命令连同服务器。如果你不能连通服务器，那么问题的原因在别处。<br>\r\n<br>\r\n如果你的IP地址因某种原因错误地被我们屏蔽了，请联系我们。', '1', 8, 1),
(63, 63, 25, 'item', '你的ISP屏蔽了本站的地址', '首先，这一般不像你的ISP的所作所为。DNS域名解析以及/或者网络问题是常见的真凶。\r\n<br>\r\n对此我们无能为力。你应该联系你的ISP（或者换一个）。记住你仍然可以通过代理访问本站，参看此常见问题关于代理的部分。在这种情况下，代理是否匿名或者使用哪个监听端口都不重要了。<br>\r\n<br>\r\n注意，你的“可连接状态”将因此一直被列为“否”，因为此时Tracker服务器无法检查你的BT客户端接收连接的状态。', '1', 8, 2),
(65, 65, 25, 'item', '不妨试试这个', '用任何手段在<a class="faqlink" href="forums.php">论坛</a>发帖。通常情况下你能得到友善而有用的帮助。这里给你一些基本的指导：<ul>\r\n<li>确保你的问题的确不在这篇FAQ中。这样的发帖导致的结果就是返回这篇FAQ。\r\n<li>在发帖之前，看看置顶。很多时候，还没有被我们的FAQ所收录的最新的信息都可以在那里被找到。</li>\r\n<li>帮助我们也就是帮助你自己。不要仅仅说“嘿我这里出问题了！！”提供一些详情，这样我们就不用猜测或者浪费时间来询问了。你使用的是什么客户端？什么操作系统？怎样的网络设置？如果发生了错误，是什么样的具体错误信息？有问题的种子文件是哪个？你所提供的信息越多，对你的帮助也就越容易，你的帖子也就更加容易得到回复。</li>\r\n<li>不需要说的是：保持礼貌。趾高气扬地来命令别人帮助你很少会有用。</li></ul>', '1', 9, 1),
(66, 66, 25, 'item', '什么是"Your slot limit is reached! You may at most download xx torrents at the same time"错误？', '这是“最大连接数系统”。最大连接数系统用于限制那些分享率较低且下载量大于10GB的用户的最大同时下载数。<br><br>\r\n规则如下: <br><br>\r\n<table cellspacing=3 cellpadding=0>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.5</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">最大连接数</td>\r\n	<td class=embedded width="40">1</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.65</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">最大连接数</td>\r\n	<td class=embedded width="40">2</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.8</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">最大连接数</td>\r\n	<td class=embedded width="40">3</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.95</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">最大连接数</td>\r\n	<td class=embedded width="40">4</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">分享率大于</td>\r\n	<td class=embedded width="40">0.95</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">最大连接数</td>\r\n	<td class=embedded width="40">无限制</td>\r\n</tr>\r\n</table>\r\n<br>\r\n无论何时，同时的上传数不设限。但是如果你当前的下载数已达到了你的最大连接数，这时开启新的做种任务，你也会收到同样的错误提示。在这种情况下，你必须先关闭一个下载任务，然后开启所有的上传任务，然后继续刚才关闭的下载任务。因为当你的连接数被占满，系统将不加验证直接拒绝任何下载或上传的请求。 <br>\r\n<br><br>\r\n你可以在任意时间察看自己的连接数，该信息在页面顶端信息栏中被列出。', '0', 5, 12),
(67, 67, 25, 'item', '什么是密钥系统？它是怎么工作的？', '密钥系统在BT客户端连接Tracker服务器时起到验证身份的作用。每一个用户都有一个系统随机生成的密钥。当用户下载某个种子文件时，他的私人密钥被添加到种子文件的Tracker服务器URL中。通过这种方式，你可以在家中或者办公室使用不同的IP来做种某个文件。\r\n\r\n', '1', 5, 13),
(68, 68, 25, 'item', '“Unknown passkey”这错误是咋回事？', '首先，如果你不是我们的注册用户，将会发生这个错误。其次，有可能你没有在登录状态下从我们的网页里下载种子文件。如果是这两种情况，只要注册一个帐号或者登录后下载种子文件就可以了。<br>\r\n另外，当你注册了一个新用户并且开始第一次下载的时候，或者你刚刚重置了你的密钥时，也可能出现这个错误。原因是系统并非实时检查密钥的改变。如果是因为这个原因，那么就让种子任务等一会儿，最后一定能收到Tracker服务器发回的成功信息。', '1', 5, 14),
(69, 69, 25, 'item', '什么时候我需要重置我的密钥?', '<ul><li> 如果你的密钥被泄漏，且别的用户正在使用这个密钥（即使用你的帐户）下载文件。在这种情况下，你能在你的详情页面看到你并未下载或上传的种子。</li>\r\n<li>当你的客户端崩溃，或者你的连接并没有正常被终止。在这样的情况下，就算你已经关闭了你的客户端，你仍然在你的详情页面看到正在上传/下载的记录。通常情况下这些“冗余种子”将在30分钟之内被自动清除，但是如果你马上继续你的下载而服务器又提示“You already are downloading the same torrent”的错误，那么你需要重置你的密钥，然后重新下载种子文件，之后继续下载过程。 </li></ul>', '1', 5, 15),
(70, 70, 25, 'item', 'DHT是什么？为什么一定要关闭这个功能？', 'DHT必须从你的客户端被禁止。DHT可能导致你的数据被错误地记录，可以视为一种作弊行为。任何使用DHT的用户将因作弊而被系统禁止。<br>\r\n幸运的是，目前Tracker服务器会自动分析用户上传的种子文件，强制去除DHT的支持。这也是为什么种子发布者必须重新下载种子才能正常做种的原因之一。', '1', 5, 16),
(71, 71, 25, 'categ', 'How can I help translate the site language into my native language?', '', '1', 0, 8),
(72, 72, 25, 'item', 'What skills do I need to do the translation?', 'Translate the site into another language is quite easy. You needn''t be skilled in PHP or dynamic website design. In fact, all you need is proficient understanding of English (the default site language) and the language you plan to translate into. Maybe some basic knowledge in HTML would help.<br><br>\r\nMoreover, we give a detailed tutorial on how to do the translation <a href="#73" class="faqlink"><b>HERE</b></a>. And our coders would be more than pleased to answer the questions you may encounter.<br><br>\r\nTranslate the whole site into another language would take estimated 10 hours. And extra time is needed to maintain the translation when site code is updated.<br><br>\r\nSo, if you think you could help, feel free to <a class=faqlink href="contactstaff.php"><b>CONTACT US</b></a>. Needless to say, you would be rewarded.', '1', 71, 1);
INSERT INTO `faq` (`id`, `link_id`, `lang_id`, `type`, `question`, `answer`, `flag`, `categ`, `order`) VALUES
(73, 73, 25, 'item', 'The translation tutorial', '<ul>\r\n<li>How does multi-language work?</li>\r\nCurrently we use language files to store all the static words that a user can see on web pages. <br>\r\nEvery php code file has a corresponding language file for a certain language. And we named the language file ''lang_'' plus the filename of the php code file. i.e. the language file of the php code file ''details.php'' would be ''lang_details.php''. <br>\r\nWe has some mechanism in php codes to read the exact language files of user''s preferred language, and you shouldn''t worry about that.<br> \r\n<li>What''s in language files?</li>\r\nIn a language file is an array of strings. These strings contain all the static words that a user can see on web pages. When we need to say some words on a php code file, we call for a string in the array. And the output of the php code file, that is what users see on the web pages, would show the value of the string.<br>\r\nSounds dizzying? Well, you need not care about all these. All you gotta do is translate the values of the strings in the language files into another language. <b>Let''s see an example</b>:<br><br>\r\nThe following is the content of the English language file ''lang_users.php'', which works for the php code file ''users.php''. <br><br>\r\n<img src="pic/langfileeng.png" alt="ratio" /><br>\r\nIf you wanna translate it into Simplified Chinese, all you need is edit the file into this:<br>\r\n<img src="pic/langfilechs.png" alt="ratio" /><br>\r\nSee, in every line, the left part, that is before <i>=></i>, is the name of a string, which you shouldn''t touch. All you need to is translate the right part, after <i>=></i>, which is the value of the string, into another language.<br>\r\nSometimes you need to look at the corresponding web pages to get the context meaning of some words.<br> \r\n<li>Sounds easy? See what do you need to do.</li>\r\nIf you feel like to help us, <a class=faqlink href="contactstaff.php"><b>CONTACT US</b></a> and we will send you a pack of the English language files (or any other available language if you prefer). Received it, you can start translating the value of strings (which is in English), into another language. It should take you several hours to do the whole work. After this, send back the translated language files to us.<br>\r\nIf no bugs or hacking codes are found in testing, we would put the new language into work.<br>\r\nSometimes the language files need to be updated, typically adding new strings, when site codes are updated. If you feel like it, you can help maintain the language files.<br>\r\n<li><font color=red><b>IMPORTANT</b></font><br></li>\r\nThe text of language files must be encoded in UTF-8. When saving files, be sure to set the character encoding to UTF-8. Otherwise mojibake may happen.</ul>', '1', 71, 2),
(74, 74, 25, 'item', '为什么我的磁盘还有充足的空间，客户端却提示磁盘剩余空间不足？', '很可能是因为你的磁盘分区的文件系统为FAT32，该文件系统不支持大于4GB的单个文件。如果你使用的是Windows系统，你可以在磁盘的属性中查看其文件系统信息。你可以将磁盘文件系统转换成更高级的NTFS来解决该问题。<br>\r\n你可以在命令行窗口使用convert命令将FAT32无损转成NTFS文件系统格式。<br><br>\r\n<ul><li><b>命令说明</b></li>\r\nCONVERT volume /FS:NTFS [/V] [/CvtArea:filename] [/NoSecurity] [/X]<br>\r\nvolume     指定驱动器号(后面跟一个冒号)、装载点或卷名。<br>\r\n/FS:NTFS   指定要被转换成 NTFS 的卷。<br>\r\n/V       指定 Convert 应该用详述模式运行。<br>\r\n/CvtArea:filename       将根目录中的一个接续文件指定为NTFS 系统文件的占位符。<br>\r\n/NoSecurity       指定每个人都可以访问转换的文件和目录的安全设置。<br>\r\n/X       如果必要，先强行卸载卷。该卷的所有打开的句柄则无效。 <br><br>\r\n<li><b>简单说</b>：</li>\r\n打开 命令提示符窗口。<br>\r\n在命令提示符窗口，请键入：<br>\r\nconvert drive_letter:/fs:ntfs<br>\r\n例如：转换D盘为NTFS，可输入convert D:/fs:ntfs <br></ul>\r\n', '1', 5, 17),
(76, 1, 28, 'categ', '站點信息', '', '1', 0, 1),
(77, 2, 28, 'categ', '用戶信息', '', '1', 0, 2),
(78, 3, 28, 'categ', '數據統計', '', '1', 0, 3),
(79, 4, 28, 'categ', '上傳', '', '1', 0, 4),
(80, 5, 28, 'categ', '下載', '', '1', 0, 5),
(81, 6, 28, 'categ', '我該怎樣提升下載速度？', '', '1', 0, 6),
(82, 7, 28, 'categ', '我的網絡提供商（ISP）使用了透明代理。我應該怎么做？', '', '1', 0, 7),
(83, 8, 28, 'categ', '為什么我連不上？難道我被網站屏蔽了？', '', '1', 0, 8),
(84, 9, 28, 'categ', '如果從這里找不到我的問題的解答，我該怎么辦？', '', '1', 0, 9),
(85, 10, 28, 'item', '到底什么是BT（Bittorrent）？我要如何才能弄到這類程序？', '參看<a class=faqlink href="http://www.btfaq.com/">Brian的BitTorrent FAQ及指導</a>。', '1', 76, 1),
(86, 11, 28, 'item', '我們捐出來的錢上哪兒去了？', '所有捐助的錢用于維護服務器的費用。', '1', 76, 2),
(87, 12, 28, 'item', '我從哪里可以搞到源代碼的拷貝？', '這個Tracker使用的是Nexus Project的代碼。代碼獲取事宜，請看<a class=faqlink href="aboutnexus.php">這里</a>。<br>\r\nNexus Project的代碼是根據TBSource的源碼改寫的。TBDev網站，Tracker源代碼以及社區論壇都在這里：<a class=faqlink href="http://www.tbdev.net/">TBDev.net</a>。', '1', 76, 3),
(88, 13, 28, 'item', '我注冊了一個賬號但是卻沒有收到驗証郵件！', '這很有可能是Tracker所在的服務器網絡出現了問題。你可以填寫<a href=confirm_resend.php class=faqlink>這個表格</a>讓伺服器重發驗証郵件。<br>\r\n 通常沒有得到確認的注冊帳戶會在24小時后被刪除，所以你可以在第二天重試。需要注意的是，如果你第一次沒有收到確認信，第二次有很大的可能仍然無法收到確認信，所以換一個E-mail地址是一個不錯的主意。', '1', 77, 1),
(89, 14, 28, 'item', '我忘記了我的用戶名/密碼了，能幫我找回來么？', '請填寫<a class=faqlink href=recover.php>這個表單</a>，我們將把登錄詳情發還給你。', '1', 77, 2),
(90, 15, 28, 'item', '我可以給我的賬號改個名字么？', '我們并不支持給賬號改名。', '1', 77, 3),
(91, 16, 28, 'item', '你可以刪除一個（已確認的）賬號么？', '我們一般不提供該類服務，所以不要請求刪除任何一個被你邀請的帳號。', '1', 77, 4),
(92, 17, 28, 'item', '那么，什么是我的分享率（Ratio）？', '就在頁面功能分區的下面。<br>\r\n<br>\r\n<img src="pic/ratio.png" alt="ratio" />\r\n<br>\r\n<br>\r\n區分你的整體分享率和獨立分享率是很重要的。整體分享率關注的是自從你加入站點以來，賬號的整體上傳與下載量。而獨立分享率則針對每一個你正在下載或做種的文件。\r\n<br>\r\n<br>\r\n你可能看到兩種符號來代替數字："Inf."，這個是無限（Infinity）的縮寫，意思是你的下載量為0字節，而上傳量則是任意一個非零的值(上傳量/下載量=無窮大)；"---"，應該被視為“不可用”，這說明了你的下載量和上傳量都是0字節。(上傳量/下載量=0/0 這是一個不確定的量)。\r\n', '1', 77, 5),
(93, 18, 28, 'item', '為什么我的IP地址顯示在我的個人信息頁面上？', '只有你自己和網站Moderator及以上的管理員可以看到你的IP地址和Email。普通用戶是看不到這些信息的。', '1', 77, 6),
(96, 21, 28, 'item', '為什麽我的“可連接”是“否”？（以及為什么我需要關注這個問題？）', 'Tracker服務器認為你在防火牆后，或者在NAT橋接后，并且無法接收其他Peer的連接請求。\r\n<br>\r\n<br>\r\n這意味着其它的大批Peer無法連接到你，只能由你連接到他們。更糟糕的情況是，如果兩個Peer都處于這樣的狀態，他們將完全無法連接到對方。這對于整體速度有着非常不利的影響。\r\n<br>\r\n<br>\r\n對于這個問題，有以下解決方式：對于防火牆，打開用于接收連接的端口（即你在BT客戶端中定義的端口）；對于NAT，你需要配置NAT服務器使用Basic NAT方式而不是NAPT（不同的路由有着不同的運行方式。翻閱你的路由文檔或客服論壇。你也可以在<a class=faqlink href="http://portforward.com/">PortForward</a>找到關于此問題的大量信息）。', '1', 77, 9),
(97, 22, 28, 'item', '不同的用戶等級代表了什么含義？', '<table cellspacing=3 cellpadding=0>\r\n<tr>\r\n<td class=embedded width=200 valign="top">&nbsp; <b class="Peasant_Name">Peasant</b></td>\r\n<td class=embedded width=5>&nbsp;</td>\r\n<td class=embedded> 被降級的用戶, 他們有30天時間來提升分享率, 否則他們會被踢. 不能發表趣味盒內容; 不能申請友情鏈接; 不能上傳字幕.\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="User_Name">User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>新用戶的默認級別。只能在每周六中午12點至每周日晚上11點59分上傳種子.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="PowerUser_Name">Power User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>得到一個邀請名額; 可以上傳種子; 可以查看NFO文檔; 可以查看用戶列表; 可以請求續種; 可以發送邀請; 可以訪問Power User論壇和External Trackers論壇; 可以查看排行榜; 可以查看其它用戶的種子曆史(如果用戶隱私等級未設置為"強"); 可以刪除自己上傳的字幕.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="EliteUser_Name">Elite User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded><b class="EliteUser_Name">Elite User</b>及以上用戶Park后不會被刪除帳號.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="CrazyUser_Name">Crazy User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>得到兩個邀請名額; 可以在做種/下載/上傳的時候選擇匿名模式.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="InsaneUser_Name">Insane User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>可以查看普通日志.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="VeteranUser_Name">Veteran User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>得到三個邀請名額; 可以查看其它用戶的評論、帖子曆史; <b class="VeteranUser_Name">Veteran User</b>及以上用戶會永遠保留賬號.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="ExtremeUser_Name">Extreme User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>可以更新過期的外部信息; 可以查看Extreme User論壇.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="UltimateUser_Name">Ultimate User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>得到五個邀請名額; 可以查看種子文件結搆.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="NexusMaster_Name">Nexus Master</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>得到十個邀請名額.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded  valign="top">&nbsp; <b><img src="pic/star.gif" alt="Star"></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>為網站捐款的主. </td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="VIP_Name">VIP</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>和<b class="NexusMaster_Name">Nexus Master</b>擁有相同權限并被認為是精英成員. 免除自動降級.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="User_Name">Other</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>自定義等級. </td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="Uploader_Name">Uploader</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>專注的上傳者. 免除自動降級; 可以查看匿名用戶的真實身份.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="Moderator_Name">Moderator</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>可以查看管理組信箱、舉報信箱; 管理趣味盒內容、投票內容; 可以編輯或刪除任何上傳的種子; 可以管理候選; 可以管理論壇帖子、用戶評論; 可以查看機密日志; 可以刪除任何字幕; 可以管理日志中的代碼、史冊; 可以查看用戶的邀請記錄; 可以管理用戶帳號的一般信息. 不能管理友情鏈接、最近消息、論壇版塊; 不能將種子設為置頂或促銷; 不能查看用戶IP或Email等機密信息; 不能刪除賬號.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="Administrator_Name">Administrator</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>除了不能改變站點設定、管理捐贈外, 可以做任何事.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="SysOp_Name">SysOp</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>網站開發/維護人員, 可以改變站點設定, 不能管理捐贈.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="StaffLeader_Name">Staff Leader</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>網站主管, 可以做任何事.</td>\r\n</tr>\r\n</table>', '1', 77, 10),
(98, 23, 28, 'item', '提升和降級又是怎樣被執行的呢？', '<table cellspacing=3 cellpadding=0>\r\n<tr>\r\n<td class=embedded width=200 valign="top">&nbsp; <b class="Peasant_Name">Peasant</b></td>\r\n<td class=embedded width=5>&nbsp;</td>\r\n<td class=embedded valign=top>當以下情況時將被自動降至本級:<br>\r\n1.如果你已經下載了超過50GB，你應該有大于0.4的分享率。<br>\r\n2.如果你已經下載了超過100GB，你應該有大于0.5的分享率。<br>\r\n3.如果你已經下載了超過200GB，你應該有大于0.6的分享率。<br>\r\n4.如果你已經下載了超過400GB，你應該有大于0.7的分享率。<br>\r\n5.如果你已經下載了超過800GB，你應該有大于0.8的分享率。</td>\r\n</tr>\r\n\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="PowerUser_Name">Power User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必須注冊至少四周，并且下載至少50G，分享率大于1.05。<br>\r\n當條件符合時將被自動提升。注意，無論何時，如果你的分享率低于0.95，你將自動降級。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="EliteUser_Name">Elite User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必須注冊至少八周，并且下載至少120G，分享率大于1.55。\r\n<br>\r\n當條件符合時將被自動提升。注意，無論何時，如果你的分享率低于1.45，你將自動降級。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="CrazyUser_Name">Crazy User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必須注冊至少十五周，并且下載至少300G，分享率大于2.05。\r\n<br>\r\n當條件符合時將被自動提升。注意，無論何時，如果你的分享率低于1.95，你將自動降級。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="InsaneUser_Name">Insane User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必須注冊至少二十五周，并且下載至少500G，分享率大于2.55。<br>\r\n當條件符合時將被自動提升。注意，無論何時，如果你的分享率低于2.45，你將自動降級。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="VeteranUser_Name">Veteran User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必須注冊至少四十周，并且下載至少750G，分享率大于3.05。<br>\r\n當條件符合時將被自動提升。注意，無論何時，如果你的分享率低于2.95，你將自動降級。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="ExtremeUser_Name">Extreme User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必須注冊至少六十周，并且下載至少1TB，分享率大于3.55。<br>\r\n當條件符合時將被自動提升。注意，無論何時，如果你的分享率低于3.45，你將自動降級。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="UltimateUser_Name">Ultimate User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必須注冊至少八十周，并且下載至少1.5TB，分享率大于4.05。<br>\r\n當條件符合時將被自動提升。注意，無論何時，如果你的分享率低于3.95，你將自動降級。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="NexusMaster_Name">Nexus Master</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>必須注冊至少一百周，并且下載至少3TB，分享率大于4.55。<br>\r\n當條件符合時將被自動提升。注意，無論何時，如果你的分享率低于4.45，你將自動降級。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b><img src="pic/star.gif" alt="Star"></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>只需捐款，并且致信<a class=faqlink href=sendmessage.php?receiver=1> NexusHD</a> - 僅NexusHD - 通告詳情。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="VIP_Name">VIP</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>由mods仔細斟酌后分配給他們認為對于站點某方面有特殊貢獻的用戶。<br>\r\n（任何索取VIP等級的要求將被自動無視）</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="User_Name">Other</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>用戶使用Bonus兌換, 或由mods仔細斟酌后授權。</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="Uploader_Name">Uploader</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>由Admins/SysOp分配(參見''上傳''部分以了解詳情).</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="Moderator_Name">Moderator</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>無需多問，我們會找到你的!</td>\r\n</tr>\r\n</table>', '1', 77, 11),
(100, 25, 28, 'item', '為什么我的朋友不能加入？', '用戶數目有所限制（你可以查看“首頁->站點數據->上限”）。當達到那個數目時，我們會停止接受新成員。<br>\r\n由于非活躍用戶(長期不使用賬號的用戶)引起賬號資源浪費，因此我們將清理該部分用戶，為其他想加入用戶騰出空間。<br>\r\n關于非活躍用戶清理規則，參考<a class=faqlink href="rules.php">規則</a>。', '1', 77, 13),
(101, 26, 28, 'item', '怎樣自定義頭像？', '首先，找一個你喜歡的圖片，當然了它不能違反我們的<a class=faqlink href=rules.php>規則</a>。然后你要找一個存放它的地方，比方說我們自己的<a class=faqlink href=bitbucket-upload.php>上傳器</a>。出于服務器負載的考慮，我們更希望你將圖片上傳到別的網站，然后將其URL粘貼到你的<a class=faqlink href="usercp.php?action=personal">控制面板</a>的頭像URL部分。 <br>\r\n<br>\r\n請不要為了僅僅測試頭像而發帖。如果一切順利，你將在你的詳情頁面看到它。', '1', 77, 14),
(102, 27, 28, 'item', '最常見的數據未能得到更新的原因', '<ul>\r\n<li>服務器過載/未響應。只要嘗試着保持會話直到服務器恢復響應(不推荐連續手動刷新，這樣會加重服務器負載)。</li>\r\n<li>你正在使用不穩定的客戶端。如果你想要使用測試版或者CVS版本，你需要自己承擔由此帶來的風險。</li>\r\n</ul>', '1', 78, 1),
(103, 28, 28, 'item', '最佳的嘗試', '<ul>\r\n<li>如果你當前正下載/上傳的種子并不在你的用戶詳情頁面中，你可以等一會或者強制進行手動更新。</li>\r\n<li>確保你正確地關閉了客戶端軟件，否則Tracker服務器無法收到"event=completed"的信號。</li>\r\n<li>如果Tracker服務器掛了，不要停止上傳。只要在你退出客戶端之前服務器恢復工作，所有的數據都會得到正確地更新。</li>\r\n</ul>', '1', 78, 2),
(104, 29, 28, 'item', '我可以任意選擇Bittorrent客戶端軟件么？', '根據<a class=faqlink href=aboutnexus.php>Nexus Project</a>的對常見BitTorrent客戶端的測試，目前本站Tracker<b>只允許</b>使用以下的BitTorrent客戶端軟件。<br>\r\n<a class=faqlink href=aboutnexus.php>Nexus Project</a>的測試報告可<a class=faqlink href="client/" title="點擊下載">在此查看</a>。測試通過的客戶端可<a class=faqlink href="client/">在此下載</a>。<br>\r\n你也可以點擊客戶端版本號下載。星星表示我們的推荐度。<br>\r\n<br>\r\n<b>Windows:</b>\r\n<ul>\r\n<li>Azureus: <a class=faqlink href="client/Windows/Azureus_2.5.0.4_Win32.setup.exe" title="下載"> 2.5.0.4</a> <img src="pic/4.5.gif" alt="推荐度：4.5" title="推荐度：4.5">, <a class=faqlink href="client/Windows/Azureus_3.0.5.0_windows.exe" title="下載">3.0.5.0</a> <img src="pic/4.5.gif" alt="推荐度：4.5" title="推荐度：4.5">, <a class=faqlink href="client/Windows/Azureus_3.0.5.2_windows.exe" title="下載">3.0.5.2</a> <img src="pic/3.gif" alt="推荐度：3" title="推荐度：3">及后續版本</li>\r\n<li>uTorrent: <a class=faqlink href="client/Windows/utorrent_1.6.1_490.exe" title="下載">1.6.1</a><img src="pic/4.gif" alt="推荐度：4" title="推荐度：4">, <a class=faqlink href="client/Windows/utorrent_1.7.5.exe" title="下載">1.7.5</a><img src="pic/4.gif" alt="推荐度：4" title="推荐度：4">, <a class=faqlink href="client/Windows/utorrent_1.7.6.exe" title="下載">1.7.6</a><img src="pic/4.gif" alt="推荐度：4" title="推荐度：4">, <a class=faqlink href="client/Windows/utorrent_1.7.7.exe" title="下載">1.7.7</a><img src="pic/4.gif" alt="推荐度：4" title="推荐度：4">, <a class=faqlink href="client/Windows/utorrent-1.8-beta-10364.upx.exe" title="下載">1.8Beta(Build 10364)</a><img src="pic/3.gif" alt="推荐度：3" title="推荐度：3">及后續版本</li>\r\n<li>BitTorrent: <a class=faqlink href="client/Windows/BitTorrent-6.0.1.exe" title="下載">6.0.1</a><img src="pic/4.gif" alt="推荐度：4" title="推荐度：4">, <a class=faqlink href="client/Windows/BitTorrent-6.0.2.exe" title="下載">6.0.2</a><img src="pic/4.gif" alt="推荐度：4" title="推荐度：4">, <a class=faqlink href="client/Windows/BitTorrent-6.0.3.exe" title="下載">6.0.3</a><img src="pic/4.gif" alt="推荐度：4" title="推荐度：4">及后續版本</li>\r\n<li>Deluge: <a class=faqlink href="client/Windows/deluge-0.5.9.1.exe" title="下載">0.5.9.1</a><img src="pic/3.5.gif" alt="推荐度：3.5" title="推荐度：3.5"> , 1.1.6及后續版本</li>\r\n<li>Rufus: <a class=faqlink href="client/Windows/Rufus_0.6.9_win32_setup.exe" title="下載">0.6.9</a><img src="pic/2.gif" alt="推荐度：2" title="推荐度：2">, <a class=faqlink href="client/Windows/Rufus_0.7.0_win32_setup.exe" title="下載">0.7.0</a><img src="pic/2.gif" alt="推荐度：2" title="推荐度：2">及后續版本</li>\r\n<li>JRE: <a class=faqlink href="client/Windows/jre-6u3-windows-i586-p.exe" title="下載">jre-6u3-windows-i586-p</a>, 運行Azureus需要JRE</li>\r\n</ul>\r\n<b>Linux:</b>\r\n<ul>\r\n<li>Azureus: <a class=faqlink href="client/Linux/Azureus_2.5.0.4_linux.tar.bz2" title="下載"> 2.5.0.4</a> <img src="pic/4.5.gif" alt="推荐度：4.5" title="推荐度：4.5">, <a class=faqlink href="client/Linux/Azureus_3.0.5.2_linux.tar.bz2" title="下載">3.0.5.2</a> <img src="pic/3.gif" alt="推荐度：3" title="推荐度：3">及后續版本</li>\r\n<li>Deluge: <a class=faqlink href="client/Linux/deluge-0.5.9.1.tar.gz" title="下載">0.5.9.1</a><img src="pic/3.5.gif" alt="推荐度：3.5" title="推荐度：3.5"> , 1.1.6及后續版本</li>\r\n<li>Rufus: <a class=faqlink href="client/Linux/Rufus_0.6.9_src.zip" title="下載">0.6.9</a><img src="pic/2.gif" alt="推荐度：2" title="推荐度：2">及后續版本</li>\r\n<li>Transmission: <a class=faqlink href="client/Linux/transmission-1.21.tar.bz2" title="下載">1.21</a><img src="pic/2.gif" alt="推荐度：2" title="推荐度：2">及后續版本</li>\r\n<li>rTorrent: <a class=faqlink href="client/Linux/rtorrent-0.8.0.tar.gz" title="下載">0.8.0</a><img src="pic/2.gif" alt="推荐度：2" title="推荐度：2">(with libtorrent <a class=faqlink href="client/Linux/libtorrent-0.12.0.tar.gz" title="下載">0.12.0</a> or later)及后續版本</li>\r\n<li>Enhanced CTorrent: <a class=faqlink href="client/Linux/ctorrent-dnh3.3.2.tar.gz" title="Download">3.3.2</a>及后續版本</li>\r\n</ul>\r\n<b>MacOS X:</b>\r\n<ul>\r\n<li>Azureus: <a class=faqlink href="client/MacOSX/Azureus_2.5.0.4_OSX.dmg" title="下載"> 2.5.0.4</a> <img src="pic/4.5.gif" alt="推荐度：4.5" title="推荐度：4.5">, <a class=faqlink href="client/MacOSX/Azureus_3.0.5.2a_macosx.dmg" title="下載">3.0.5.2a</a> <img src="pic/3.gif" alt="推荐度：3" title="推荐度：3">及后續版本</li>\r\n<li>Transmission: <a class=faqlink href="client/MacOSX/Transmission-1.21.dmg" title="下載">1.21</a><img src="pic/2.gif" alt="推荐度：2" title="推荐度：2">及后續版本</li>\r\n<li>BitRocket: <a class=faqlink href="client/MacOSX/BitRocket_32.dmg" title="下載">0.3.3(32)</a><img src="pic/2.gif" alt="推荐度：2" title="推荐度：2">及后續版本</li>\r\n</ul>\r\n<b>Symbian (僅供測試):</b>\r\n<ul>\r\n<li>SymTorrent: <a class=faqlink href="client/Symbian/SymTorrent_S60-3rd_1.41_2008-11-26.sis" title="下載"> 1.41 </a> <img src="pic/1.gif" alt="推荐度：1" title="推荐度：1">及後續版本</li>\r\n</ul>\r\n<br>\r\n\r\n<b>以上客戶端在https支持方面</b>\r\n<ul>\r\n<li>uTorrent 1.61: 無法准確解析https的tracker, 同時在使用會將自己標識為uTorrent 1.5</li>\r\n<li>Rufus系列: 沒有https支持, 并且已經3年沒有繼續開發</li>\r\n<li>rtorrent系列: 需要手工設置SSL證書, 詳細信息請自行查閱其官方網站說明</li>\r\n</ul>\r\n\r\n<br>\r\n\r\n同時請盡量避免使用處于測試期的客戶端軟件, 如uTorrent 1.8.0B。\r\n\r\n為了從本站得到最好的下載體驗,我們高度推荐<a class=faqlink href="http://www.utorrent.com/download.php">uTorrent</a> 以及<a class=faqlink href="http://azureus.sourceforge.net/download.php">Azureus</a>這兩個軟件的最新穩定版。', '1', 80, 3),
(105, 30, 28, 'item', '為什么我正在下載/做種的一個種子會在我的詳情頁面中被列出多次？', '如果因為某些原因(比方說死機，客戶端失去響應)你的客戶端非正常退出并且你又重新打開它，它會被分配到一個全新的Peer ID, 這樣它顯示為一個全新的種子。而舊的種子將永遠不會收到“event=completed”或“event=stopped”的信號，因此將一直被列出直到Tracker清理超時的Peer。 無視了它就可以了，它最后會消失的。', '1', 78, 4),
(106, 31, 28, 'item', '為什么我已經完成/取消的種子仍然在我的詳情頁面里？', '有一些客戶端，比如說TorrentStorm和Nova Torrent，在取消或者完成一個任務的時候不能向Tracker服務器正確發送信號。在那樣的情況下，Tracker服務器將一直保持等待信號的狀態（因此會一直列出種子的狀態為做種/下載的狀態）直到Tracker清理超時的Peer。無視了它就可以了，它最后會消失的。', '1', 78, 5),
(108, 33, 28, 'item', '多IP（我可以從不同的電腦登錄/下載嗎？）', '是的，目前Tracker服務器支持單個用戶從任意個數的IP地址同時訪問/下載。<br>\r\n然而，對于單種是有限制的。對于每個種子，最多允許3個做種的連接，最多只允許1個下載的連接（這意味着，對于某個種子你一次只能在一個地方下載）。', '1', 78, 7),
(110, 36, 28, 'item', '為什么我不能上傳種子？', '請看<a class=faqlink href="rules.php">規則</a>。', '1', 79, 1),
(111, 37, 28, 'item', '我需要滿足哪些條件才能加入上傳小組呢？', '你所必須滿足的條件：\r\n<ul>\r\n<li>具有穩定的資源來源</li>\r\n<li>平均每周資源發布數量不少于5個</li>\r\n</ul>\r\n你必須確保發布的文件符合以下特征:\r\n<ul>\r\n<li>不超過7天之前</li>\r\n<li>你必須要有做種的能力，或者可以確保至少有效供種24小時。</li>\r\n<li>你需要有至少達到2MBit的上傳帶寬。</li>\r\n</ul>\r\n如果你認為以上條件你符合以上條件，那么不要猶豫，<a class=faqlink href="contactstaff.php">聯系管理組</a>吧。<br>\r\n<b>記住！</b> 仔細填寫你的申請！確保申請中包含你的上傳速度以及你計划上傳的內容的類型。<br>\r\n只有仔細填寫并且經過慎重考慮的申請才會納入我們的視野。', '1', 79, 2),
(112, 38, 28, 'item', '我可以上傳你們這里的種子到別的Tracker服務器么？', '不能。我們是一個封閉的、限制用戶數的社區。只有注冊用戶才能夠使用我們的Tracker。將我們的種子文件發布到其他Tracker服務器是徒勞的，因為絕大多數試圖下載這些文件的人將無法連接到我們的服務器。將我們的種子上傳到其他Tracker只讓那里的用戶惱怒（因為無法下載）并且對我們產生敵對情緒，所以這種行為是我們是不能容忍的。<br>\r\n<br>\r\n如果其他網站的管理員向我們舉報我們的種子被發布在他們的站點上，對此負責的用戶將因此被移出我們的社區。<br>\r\n<br>\r\n但是對于從我們這里下載得到的文件，你可以隨意操控它們。你可以制作另一個種子，寫入其他Tracker的地址，并上傳到你喜歡的站點上。', '1', 79, 3),
(113, 39, 28, 'item', '下載來的文件該怎么打開？', '在這份<a class=faqlink href=formats.php>指引</a>里面找找看吧。', '1', 80, 1),
(114, 40, 28, 'item', '我下載了一部電影，但是不明白CAM/TS/TC/SCR是什么意思?', '在這份<a class=faqlink href=videoformats.php>指引</a>里面找找看吧。', '1', 80, 2),
(115, 41, 28, 'item', '為什么一個可用的種子忽然就消失了？', '以下原因都會導致這個現象的出現:<br>\r\n(<b>1</b>) 按照<a class=faqlink href=rules.php>網站規則</a>，這個種子不符合規則已被刪除。\r\n<br>\r\n(<b>2</b>) 上傳者因為文件存在問題而刪除了它。一般來說，上傳者會發布一個替代的版本的。<br>\r\n(<b>3</b>) 在長時間斷種后種子被自動刪除了。', '1', 80, 3),
(116, 42, 28, 'item', '我該怎樣續傳文件或者給一個文件續種呢？', '打開擴展名為.torrent的文件，當你的客戶端軟件詢問保存的目錄時，選擇已經存在的文件存放的目錄，它就能夠開始續傳/續種了。', '1', 80, 4),
(117, 43, 28, 'item', '為什么我的下載有時候停在99%?', '你所下載到的片段越多，尋找擁有你所缺少的片段的同伴就將變得越困難。這就是為什么有時候在下載即將完成的時候，速度會變得非常慢，甚至完全停止了。只要耐心等候，或早或晚剩下的部分一定能夠下載到的。', '1', 80, 5),
(118, 44, 28, 'item', '"部分哈希驗證出錯"這條信息是什么意思？', 'BT的客戶端會檢查它所收到的數據的完整性。如果某一個片段在驗證中出錯，那么這個片段將被重新下載。偶爾的哈希驗證錯誤是非常常見的現象，不用擔心。<br>\r\n<br>\r\n有些客戶端有屏蔽向你發送錯誤數據的其他客戶端的功能。如果有這個選項，最好打開它。因為這樣可以保證如果某個同伴經常向你發送錯誤的數據時，它將會被屏蔽。', '1', 80, 6),
(119, 45, 28, 'item', '100MB大小的種子，我怎么下了120MB的東西回來?', '參見哈希驗證失敗的那個問題。如果你的客戶端收到了錯誤的數據，那么它將會重新下載這一部分，因此總下載量有可能比種子大小略微大一些。確保“屏蔽發送錯誤數據的客戶端”的那個選項被打開了，這樣可以減少額外的下載。', '1', 80, 7),
(120, 46, 28, 'item', '為什么我的客戶端的Tracker服務器狀態出現"Your ratio is too low! You need to wait xx h to start"的錯誤？', '在<b>新</b>種子被上傳到Tracker服務器之后，有一些用戶必須等一些時間才能開始下載。<br>\r\n這個延遲只會影響那些分享率較低且下載量大于10G的用戶。<br>\r\n<br>\r\n<table cellspacing=3 cellpadding=0>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.4</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">延遲</td>\r\n	<td class=embedded width="100">24小時</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.5</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">延遲</td>\r\n	<td class=embedded width="100">12小時</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.6</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">延遲</td>\r\n	<td class=embedded width="100">6小時</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.8</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">延遲</td>\r\n	<td class=embedded width="100">3小時</td>\r\n</tr>\r\n</table>', '0', 80, 8),
(121, 47, 28, 'item', '為什么發生了這個錯誤？ "Port xxxx is blacklisted"?', '你的客戶端向Tracker服務器報告它正在使用某個默認的BT協議端口(6881-6889)或是任何其他常見P2P端口來作為連接端口。<br>\r\n<br>\r\n本站不允許這些通常被P2P協議默認使用的端口。原因是目前ISP常常對這些端口進行限速。<br>\r\n<br>\r\n被屏蔽的端口如下：<br>\r\n<br>\r\n<table cellspacing=3 cellpadding=0>\r\n  <tr>\r\n	<td class=embedded width="100">Direct Connect</td>\r\n	<td class=embedded width="100">411 - 413</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">BitTorrent</td>\r\n	<td class=embedded width="100">6881 - 6889</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">BitTorrent</td>\r\n	<td class=embedded width="100">6881 - 6889</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">Kazza</td>\r\n	<td class=embedded width="100">1214</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">Gnutella</td>\r\n	<td class=embedded width="100">6346 - 6347</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">Emule</td>\r\n	<td class=embedded width="100">4662</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">WinMX</td>\r\n	<td class=embedded width="100">6699</td>\r\n  </tr>\r\n</table>\r\n<br>\r\n要使用我們的Tracker服務器，你必須配置你的客戶端使用未在上面列出的端口范圍(從49152到65535都是不錯的選擇，參看<a class=altlink href="http://www.iana.org/assignments/port-numbers">IANA</a>)。注意某些客戶端，如Azureus 2.0.7.0或更高版本，對所有的種子都使用同一端口。而其他大多數客戶端為每一個種子開放一個端口，你在選擇端口范圍應考慮到這個問題（一般來說端口范圍小于10。設置一個過大的范圍并不一定有好處，而且可能有安全隱患)。 <br>\r\n<br>\r\n這些端口是用于同伴間通信的，而非用于客戶端連接到Tracker服務器。因此這個改動并不會影響你使用其他Tracker服務器（事實上，它甚至可能<i>加快</i>所有Tracker服務器上種子的速度）。你的客戶端也仍然能夠連接到那些使用默認端口的同伴。如果你的客戶端不支持自己自定義端口，那么換一個吧。<br>\r\n<br>\r\n不要向我們詢問，或者在論壇里面提問究竟應該選擇什么端口。我們的用戶選擇的端口越隨機，ISP就越難以捉摸清楚我們使用的端口，從而無法對我們的端口進行限速。如果我們只是簡單地規定一個范圍，那么ISP又會很快對那個范圍內的端口進行限速的。<br>\r\n<br>\r\n最后還要說的是，記得在你的路由和/或防火牆上打開你選擇的端口，如果你有這些東西的話。', '1', 80, 9),
(122, 48, 28, 'item', '那么這個呢？ “IO錯誤 - [錯誤號13] 許可被拒絕”？', '如果你只是想要解決這個問題的話，重新啟動你的電腦應該就可以了。否則的話，繼續讀下去。<br>\r\n<br>\r\nIO錯誤指的是輸入-輸出錯誤，這是一個文件系統錯誤，而非來自我們的Tracker服務器。當你的客戶端由于某些原因不能打開種子中未下載完成的文件時，這個錯誤就會發生。 通常原因是客戶端的兩個實例同時在運行：當上一次關閉客戶端時因為某種原因它沒有被真正關閉，從而始終在后台運行。因此文件被鎖定，使得新的實例不能打開這個文件。<br>\r\n<br>\r\n另外一個不常出現的原因是因為老舊的FAT文件系統。某些系統崩潰可能導致未下載完成的文件損壞，接着就出現了這個錯誤。運行一次scandisk應該可以解決這個問題。注意，只有當你使用Windows 9X操作系統（只支持FAT文件系統）或者在Windows NT/2000/XP中使用FAT文件系統的時候才比較可能出現這個問題。NTFS文件系統要健壯許多，不太可能出現這樣的問題。', '1', 80, 10),
(124, 50, 28, 'item', '不要馬上下載新發布的種子', '下載速度主要取決于上傳者/下載者比(SLR)。如果是種子是新發布的且非常受歡迎而SLR又很低的種子，下載速度低是常見的問題。<br>\r\n<br>\r\n請牢記你不喜歡低速下載。所以多<b>上傳</b>讓別人不用忍耐同樣的困擾。\r\n<br>\r\n<br>由其是當你的帶寬較窄時，不要馬上下載新發布的種子。最好的下載速度通常在一個種子生命周期的一半時出現，此時SLR達到最大值（不過，這時下載的缺點是你的上傳量不會很多。究竟如何平衡優點與缺點，取決于你自己)。', '1', 81, 1),
(125, 51, 28, 'item', '限制上傳速度', '上傳速度將從以下兩種方式顯著影響下載速度：<br>\r\n<ul>\r\n    <li>Bittorrent的同伴傾向于回饋那些給它們提上傳的同伴。這就意味着如果A和B正在同時下載一個文件，而A又在高速向B傳送數據，那么B將會嘗試着回報A。因此高速上傳將導致高速下載。</li>\r\n\r\n    <li>由于TCP協議的工作方式，當A正從B下載某些東西的時候，A必須不停地向B發送成功收到B所發送來的數據的信號（被稱為確認──ACK ── 某種“已收到”的信息)。如果A沒有發送ACK信號，那么B將暫停向A發送數據并且進入等候狀態。如果A正在全速上傳，很有可能沒有用來發送ACK信號的帶寬，因此ACK信號被耽擱。在這種情況下，過高速度的上傳導致了低速的下載。</li>\r\n</ul>\r\n實際的效果是以上兩個原因的結合。上傳速度應該在保證ACK能正常傳輸的前提下被設得盡量高。 <b>一個很好的實踐理論是保持上傳速度在理論上限的80%。</b>你也可以細細研究什么是最適合你的速度（同時也請記住高速上傳對于你的分享率很有幫助）。<br>\r\n<br>\r\n如果你正在運行一個以上的種子任務，你應該考慮的是全局上傳速度。某些客戶端能限制了全局上傳速度，其他的則能對每一個種子分別進行設置。了解你的客戶端。如果你正在使用你的電腦做別的某些應用（比方說上網或者從FTP拖東西），也需考慮一下它們對于全局上傳的影響。', '1', 81, 2),
(126, 52, 28, 'item', '限制同時連接數', '某些操作系統（例如Windows 9X）對于大量連接數支持不完善，甚至有可能因此而崩潰。也有一些家用路由（尤其當運行着NAT以及/或者打開防火牆狀態檢查服務時）會因大量連接數而變得很慢或者崩潰。對于連接數沒有固定的最佳值，你可以試試看60或者100。記住這些連接數是累加的，所以如果你的客戶端運行了兩個會話，這兩個數字要加在一起。', '1', 81, 3),
(127, 53, 28, 'item', '限制同時上傳數', '上傳數難道和連接數有什么不一樣嗎？是的，兩者是不同的。連接數限制了你的客戶端所能對話以及/或者下載的同伴數。上傳數則限制了你的客戶端實際能上傳的同伴數。理想的數值一般要比連接數低許多，并且與你的物理帶寬高度相關。', '1', 81, 4),
(128, 54, 28, 'item', '那怎么辦？等待一會吧', '如我們在上面所解釋的，在BT下載過程中一個同伴更加傾向于回報那些上傳給它的同伴。當你開始一個新的下載任務時，你沒有文件片斷提高給其他同伴，因此他們通常會無視你。這使得開始階段的下載非常緩慢，由其是當你所連接到的同伴只有很少是（或者沒有）做種者。一旦你獲得了一些能用于共享的文件片斷，下載速度會有所改觀。', '1', 81, 5),
(129, 55, 28, 'item', '為什么在我下載的時候瀏覽網頁速度如此之慢？', '你的下載帶寬是有限的。如果你正在下載一個速度很快的種子，它几乎肯定將占滿你的下載帶寬。這是瀏覽網頁顯然就會變慢。很多BT客戶端允許你限制下載速度，你可以試試。<br>\r\n<br>\r\n瀏覽網頁只是作為舉例之一，同樣的問題也會出現在游戲，即時通信軟件上......', '1', 81, 6),
(130, 56, 28, 'item', '什么是代理？', '基本上說，代理就是中間人。當你通過代理訪問某個站點的時候，你的請求將首先被發送到代理處，然后由代理轉發到你所請求的站點，而不是你直接連通到網站。下面是几種典型的代理分類（朮語不是那么的規范）：<br>\r\n<br>\r\n<table cellspacing=3 cellpadding=0>\r\n <tr>\r\n	<td class=embedded valign="top" width="100">&nbsp;透明代理</td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded valign="top">透明代理在客戶端無需配置。他將自動把80端口的信息重定向到代理(有時候也作為非匿名代理的同義詞)；</td>\r\n </tr>\r\n <tr>\r\n	<td class=embedded valign="top">&nbsp;顯式代理</td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded valign="top">瀏覽器必須經過配置才能使用代理；</td>\r\n </tr>\r\n <tr>\r\n	<td class=embedded valign="top">&nbsp;匿名代理</td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded valign="top">代理將不會把客戶標記發送至服務器端 (HTTP_X_FORWARDED_FOR頭標志將不被發送。服務器也因此看不到你的IP)；</td>\r\n </tr>\r\n <tr>\r\n	<td class=embedded valign="top">&nbsp;高度匿名代理</td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded valign="top">代理將不會把客戶標記或代理標記發送至服務器端 (HTTP_X_FORWARDED_FOR和HTTP_VIA and HTTP_PROXY_CONNECTION頭標志將不被發送。服務器看不到你的IP，甚至不知道你正在使用代理)；</td>\r\n </tr>\r\n <tr>\r\n	<td class=embedded valign="top">&nbsp;公用</td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded valign="top">(不言自明了)。</td>\r\n </tr>\r\n</table>\r\n<br>\r\n透明代理可能是匿名的，也可能是非匿名的，且匿名也有相應的等級。', '1', 82, 1),
(131, 57, 28, 'item', '我該怎樣發現自己正處于一個（透明的/匿名的）代理后面？', '試試看<a href=http://proxyjudge.org class="faqlink">ProxyJudge</a>。它列出了服務器端從你這里所收到的HTTP的頭標志。相關的几個標志是HTTP_CLIENT_IP，HTTP_X_FORWARDED_FOR和REMOTE_ADDR。', '1', 82, 2),
(132, 75, 28, 'item', '我的“可連接”是“否”盡管我并沒有NAT或者防火牆？', 'Tracker服務器在尋找你的真實IP方面非常有天賦。但是這需要代理發送HTTP頭標志HTTP_X_FORWARDED_FOR。如果你的ISP的代理沒有這么做的話，Tracker服務器將把代理的IP當作你的客戶端的IP。所以當你登錄之后，Tracker服務器嘗試連接你的客戶端來確信你沒有使用NAT/防火牆，服務器實際上將試圖連接代理的IP（使用你的BT客戶端報告的接收連接端口）。很自然地，代理服務器并沒有監聽那個端口。如此連接會失敗，而Tracker服務器也因此認為你使用了NAT/防火牆。', '1', 82, 3),
(137, 62, 28, 'item', '也許是因為我的IP地址被列入黑名單了？', '這個網站有屏蔽被禁用戶或攻擊者的IP地址的功能。該功能在Apache/PHP層面上起作用，且只能屏蔽從這些地址<i>登錄</i>網站。這不會阻止你<i>連接</i>到網站，更無法從底層的協議層面進行屏蔽。即便你的地址已經被列入了黑名單，你應該仍能夠通過ping/traceroute命令連同服務器。如果你不能連通服務器，那么問題的原因在別處。<br>\r\n<br>\r\n如果你的IP地址因某種原因錯誤地被我們屏蔽了，請聯系我們。', '1', 83, 1),
(138, 63, 28, 'item', '你的ISP屏蔽了本站的地址', '首先，這一般不像你的ISP的所作所為。DNS域名解析以及/或者網絡問題是常見的真凶。\r\n<br>\r\n對此我們無能為力。你應該聯系你的ISP（或者換一個）。記住你仍然可以通過代理訪問本站，參看此常見問題關于代理的部分。在這種情況下，代理是否匿名或者使用哪個監聽端口都不重要了。<br>\r\n<br>\r\n注意，你的“可連接狀態”將因此一直被列為“否”，因為此時Tracker服務器無法檢查你的BT客戶端接收連接的狀態。', '1', 83, 2),
(140, 65, 28, 'item', '不妨試試這個', '用任何手段在<a class="faqlink" href="forums.php">論壇</a>發帖。通常情況下你能得到友善而有用的幫助。這里給你一些基本的指導：<ul>\r\n<li>確保你的問題的確不在這篇FAQ中。這樣的發帖導致的結果就是返回這篇FAQ。\r\n<li>在發帖之前，看看置頂。很多時候，還沒有被我們的FAQ所收錄的最新的信息都可以在那里被找到。</li>\r\n<li>幫助我們也就是幫助你自己。不要僅僅說“嘿我這里出問題了！！”提供一些詳情，這樣我們就不用猜測或者浪費時間來詢問了。你使用的是什么客戶端？什么操作系統？怎樣的網絡設置？如果發生了錯誤，是什么樣的具體錯誤信息？有問題的種子文件是哪個？你所提供的信息越多，對你的幫助也就越容易，你的帖子也就更加容易得到回復。</li>\r\n<li>不需要說的是：保持禮貌。趾高氣揚地來命令別人幫助你很少會有用。</li></ul>', '1', 84, 1);
INSERT INTO `faq` (`id`, `link_id`, `lang_id`, `type`, `question`, `answer`, `flag`, `categ`, `order`) VALUES
(141, 66, 28, 'item', '什么是"Your slot limit is reached! You may at most download xx torrents at the same time"錯誤？', '這是“最大連接數系統”。最大連接數系統用于限制那些分享率較低且下載量大于10GB的用戶的最大同時下載數。<br><br>\r\n規則如下: <br><br>\r\n<table cellspacing=3 cellpadding=0>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.5</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">最大連接數</td>\r\n	<td class=embedded width="100">1</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.65</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">最大連接數</td>\r\n	<td class=embedded width="100">2</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.8</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">最大連接數</td>\r\n	<td class=embedded width="100">3</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">分享率低于</td>\r\n	<td class=embedded width="40">0.95</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">最大連接數</td>\r\n	<td class=embedded width="100">4</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">分享率大于</td>\r\n	<td class=embedded width="40">0.95</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">最大連接數</td>\r\n	<td class=embedded width="100">無限制</td>\r\n</tr>\r\n</table>\r\n<br>\r\n無論何時，同時的上傳數不設限。但是如果你當前的下載數已達到了你的最大連接數，這時開啟新的做種任務，你也會收到同樣的錯誤提示。在這種情況下，你必須先關閉一個下載任務，然后開啟所有的上傳任務，然后繼續剛才關閉的下載任務。因為當你的連接數被占滿，系統將不加驗證直接拒絕任何下載或上傳的請求。 <br>\r\n<br><br>\r\n你可以在任意時間察看自己的連接數，該信息在頁面頂端信息欄中被列出。', '0', 80, 12),
(142, 67, 28, 'item', '什么是密鑰系統？它是怎么工作的？', '密鑰系統在BT客戶端連接Tracker服務器時起到驗證身份的作用。每一個用戶都有一個系統隨機生成的密鑰。當用戶下載某個種子文件時，他的私人密鑰被添加到種子文件的Tracker服務器URL中。通過這種方式，你可以在家中或者辦公室使用不同的IP來做種某個文件。\r\n\r\n', '1', 80, 13),
(143, 68, 28, 'item', '“Unknown passkey”這錯誤是咋回事？', '首先，如果你不是我們的注冊用戶，將會發生這個錯誤。其次，有可能你沒有在登錄狀態下從我們的網頁里下載種子文件。如果是這兩種情況，只要注冊一個帳號或者登錄后下載種子文件就可以了。<br>\r\n另外，當你注冊了一個新用戶并且開始第一次下載的時候，或者你剛剛重置了你的密鑰時，也可能出現這個錯誤。原因是系統并非實時檢查密鑰的改變。如果是因為這個原因，那么就讓種子任務等一會兒，最后一定能收到Tracker服務器發回的成功信息。', '1', 80, 14),
(144, 69, 28, 'item', '什么時候我需要重置我的密鑰?', '<ul><li> 如果你的密鑰被泄漏，且別的用戶正在使用這個密鑰（即使用你的帳戶）下載文件。在這種情況下，你能在你的詳情頁面看到你并未下載或上傳的種子。</li>\r\n<li>當你的客戶端崩潰，或者你的連接并沒有正常被終止。在這樣的情況下，就算你已經關閉了你的客戶端，你仍然在你的詳情頁面看到正在上傳/下載的記錄。通常情況下這些“冗余種子”將在30分鐘之內被自動清除，但是如果你馬上繼續你的下載而服務器又提示“You already are downloading the same torrent”的錯誤，那么你需要重置你的密鑰，然后重新下載種子文件，之后繼續下載過程。 </li></ul>', '1', 80, 15),
(145, 70, 28, 'item', 'DHT是什么？為什么一定要關閉這個功能？', 'DHT必須從你的客戶端被禁止。DHT可能導致你的數據被錯誤地記錄，可以視為一種作弊行為。任何使用DHT的用戶將因作弊而被系統禁止。<br>\r\n幸運的是，目前Tracker服務器會自動分析用戶上傳的種子文件，強制去除DHT的支持。這也是為什么種子發布者必須重新下載種子才能正常做種的原因之一。', '1', 80, 16),
(146, 71, 28, 'categ', 'How can I help translate the site language into my native language?', '', '1', 80, 8),
(147, 72, 28, 'item', 'What skills do I need to do the translation?', 'Translate the site into another language is quite easy. You needn''t be skilled in PHP or dynamic website design. In fact, all you need is proficient understanding of English (the default site language) and the language you plan to translate into. Maybe some basic knowledge in HTML would help.<br><br>\r\nMoreover, we give a detailed tutorial on how to do the translation <a href="#73" class="faqlink"><b>HERE</b></a>. And our coders would be more than pleased to answer the questions you may encounter.<br><br>\r\nTranslate the whole site into another language would take estimated 10 hours. And extra time is needed to maintain the translation when site code is updated.<br><br>\r\nSo, if you think you could help, feel free to <a class=faqlink href="contactstaff.php"><b>CONTACT US</b></a>. Needless to say, you would be rewarded.', '1', 146, 1),
(148, 73, 28, 'item', 'The translation tutorial', '<ul>\r\n<li>How does multi-language work?</li>\r\nCurrently we use language files to store all the static words that a user can see on web pages. <br>\r\nEvery php code file has a corresponding language file for a certain language. And we named the language file ''lang_'' plus the filename of the php code file. i.e. the language file of the php code file ''details.php'' would be ''lang_details.php''. <br>\r\nWe has some mechanism in php codes to read the exact language files of user''s preferred language, and you shouldn''t worry about that.<br> \r\n<li>What''s in language files?</li>\r\nIn a language file is an array of strings. These strings contain all the static words that a user can see on web pages. When we need to say some words on a php code file, we call for a string in the array. And the output of the php code file, that is what users see on the web pages, would show the value of the string.<br>\r\nSounds dizzying? Well, you need not care about all these. All you gotta do is translate the values of the strings in the language files into another language. <b>Let''s see an example</b>:<br><br>\r\nThe following is the content of the English language file ''lang_users.php'', which works for the php code file ''users.php''. <br><br>\r\n<img src="pic/langfileeng.png" alt="ratio" /><br>\r\nIf you wanna translate it into Simplified Chinese, all you need is edit the file into this:<br>\r\n<img src="pic/langfilechs.png" alt="ratio" /><br>\r\nSee, in every line, the left part, that is before <i>=></i>, is the name of a string, which you shouldn''t touch. All you need to is translate the right part, after <i>=></i>, which is the value of the string, into another language.<br>\r\nSometimes you need to look at the corresponding web pages to get the context meaning of some words.<br> \r\n<li>Sounds easy? See what do you need to do.</li>\r\nIf you feel like to help us, <a class=faqlink href="contactstaff.php"><b>CONTACT US</b></a> and we will send you a pack of the English language files (or any other available language if you prefer). Received it, you can start translating the value of strings (which is in English), into another language. It should take you several hours to do the whole work. After this, send back the translated language files to us.<br>\r\nIf no bugs or hacking codes are found in testing, we would put the new language into work.<br>\r\nSometimes the language files need to be updated, typically adding new strings, when site codes are updated. If you feel like it, you can help maintain the language files.<br>\r\n<li><font color=red><b>IMPORTANT</b></font><br></li>\r\nThe text of language files must be encoded in UTF-8. When saving files, be sure to set the character encoding to UTF-8. Otherwise mojibake may happen.</ul>', '1', 146, 2),
(149, 74, 28, 'item', '為什么我的磁槃還有充足的空間，客戶端卻提示磁槃剩余空間不足？', '很可能是因為你的磁槃分區的文件系統為FAT32，該文件系統不支持大于4GB的單個文件。如果你使用的是Windows系統，你可以在磁槃的屬性中查看其文件系統信息。你可以將磁槃文件系統轉換成更高級的NTFS來解決該問題。<br>\r\n你可以在命令行窗口使用convert命令將FAT32無損轉成NTFS文件系統格式。<br><br>\r\n<ul><li><b>命令說明</b></li>\r\nCONVERT volume /FS:NTFS [/V] [/CvtArea:filename] [/NoSecurity] [/X]<br>\r\nvolume     指定驅動器號(后面跟一個冒號)、裝載點或卷名。<br>\r\n/FS:NTFS   指定要被轉換成 NTFS 的卷。<br>\r\n/V       指定 Convert 應該用詳述模式運行。<br>\r\n/CvtArea:filename       將根目錄中的一個接續文件指定為NTFS 系統文件的占位符。<br>\r\n/NoSecurity       指定每個人都可以訪問轉換的文件和目錄的安全設置。<br>\r\n/X       如果必要，先強行卸載卷。該卷的所有打開的句柄則無效。 <br><br>\r\n<li><b>簡單說</b>：</li>\r\n打開 命令提示符窗口。<br>\r\n在命令提示符窗口，請鍵入：<br>\r\nconvert drive_letter:/fs:ntfs<br>\r\n例如：轉換D槃為NTFS，可輸入convert D:/fs:ntfs <br></ul>\r\n', '1', 80, 17),
(150, 1, 6, 'categ', 'Site information', '', '1', 0, 1),
(151, 2, 6, 'categ', 'User information', '', '1', 0, 2),
(152, 3, 6, 'categ', 'Stats', '', '1', 0, 3),
(153, 4, 6, 'categ', 'Uploading', '', '1', 0, 4),
(154, 5, 6, 'categ', 'Downloading', '', '1', 0, 5),
(155, 6, 6, 'categ', 'How can I improve my download speed?', '', '1', 0, 6),
(156, 7, 6, 'categ', 'My ISP uses a transparent proxy. What should I do?', '', '1', 0, 7),
(157, 8, 6, 'categ', 'Why can''t I connect? Is the site blocking me?', '', '1', 0, 8),
(158, 9, 6, 'categ', 'What if I can''t find the answer to my problem here?', '', '1', 0, 9),
(159, 10, 6, 'item', 'What is this bittorrent all about anyway? How do I get the files?', 'Check out <a class=faqlink href="http://www.btfaq.com/">Brian''s BitTorrent FAQ and Guide</a>.', '1', 150, 1),
(160, 11, 6, 'item', 'Where does the donated money go?', 'All donated money goes to the cost of server that this tracker is on.', '1', 150, 2),
(161, 12, 6, 'item', 'Where can I get a copy of the source code?', 'This tracker is powered by Nexus Project. If you like to use Nexus Project to power your tracker, <a class=faqlink href="aboutnexus.php">Contact Us</a>.<br>\r\nThe first stage of Nexus Project forks from TBSource. You may find more information about TBSource at <a class=faqlink href="http://www.tbdev.net/">TBDev.net</a>.', '1', 150, 3),
(162, 13, 6, 'item', 'I registered an account but did not receive the confirmation e-mail!', 'One possible reason may be that the network around the tracker has encountered some problems. You can use <a href=confirm_resend.php class=faqlink>this form</a> ask the tracker to resend confirmation e-mail.<br>\r\nTypically registered users would be deleted after 24 hours if not confirmed, so you may try again the next day. Note though that if you didn''t receive the email the first time it will probably not succeed the second time either so you should really try another email address.', '1', 151, 1),
(163, 14, 6, 'item', 'I''ve lost my user name or password! Can you send it to me?', 'Please use <a class=faqlink href=recover.php>this form</a> to have the login details mailed back to you.', '1', 151, 2),
(164, 15, 6, 'item', 'Can you rename my account? ', 'No, we do not rename accounts. Don''t ask for it.', '1', 151, 3),
(165, 16, 6, 'item', 'Can you delete my (confirmed) account?', 'No, we don''t delete accounts. Don''t ask for it.', '1', 151, 4),
(166, 17, 6, 'item', 'So, what''s MY ratio?', 'It''s on the left-top of pages.<br>\r\n<br>\r\n<img src="pic/ratio.png" alt="ratio" />\r\n<br>\r\n<br>\r\nIt''s important to distinguish between your overall ratio and the individual ratio on each torrent you may be seeding or leeching. The overall ratio takes into account the total uploaded and downloaded from your account since you joined the site. The individual ratio takes into account those values for each torrent.\r\n<br>\r\n<br>\r\nYou may see two symbols instead of a number: "Inf.", which is just an abbreviation for Infinity, and means that you have downloaded 0 bytes while uploading a non-zero amount (ul/dl becomes infinity); "---", which should be read as "non-available", and shows up when you have both downloaded and uploaded 0 bytes (ul/dl = 0/0 which is an indeterminate amount).\r\n', '1', 151, 5),
(167, 18, 6, 'item', 'Why is my IP displayed on my details page?', 'Only you and the site moderators can view your IP address and email. Regular users do not see that information.', '1', 151, 6),
(170, 21, 6, 'item', 'Why am I listed as not connectable? (And why should I care?)', 'The tracker has determined that you are firewalled or NATed and cannot accept incoming connections. \r\n<br>\r\n<br>\r\nThis means that other peers in the swarm will be unable to connect to you, only you to them. Even worse, if two peers are both in this state they will not be able to connect at all. This has obviously a detrimental effect on the overall speed. \r\n<br>\r\n<br>\r\nThe way to solve the problem involves opening the ports used for incoming connections (the same range you defined in your client) on the firewall and/or configuring your NAT server to use a basic form of NAT for that range instead of NAPT (the actual process differs widely between different router models. Check your router documentation and/or support forum. You will also find lots of information on the subject at <a class=faqlink href="http://portforward.com/">PortForward</a>).\r\n\r\n\r\n\r\n\r\n\r\n', '1', 151, 9),
(171, 22, 6, 'item', 'What are the different user classes?', '<table cellspacing=3 cellpadding=0>\r\n<tr>\r\n<td class=embedded width=200 valign="top">&nbsp; <b class="Peasant_Name">Peasant</b></td>\r\n<td class=embedded width=5>&nbsp;</td>\r\n<td class=embedded> Demoted users. They must improve their ratio within 30 days or they will be banned. Cannot post funbox item, apply for links or upload subtitles.\r\n</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="User_Name">User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>The default class of new members. may upload torrents between 12:00, Saturday and 23:59 Sunday of every week.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="PowerUser_Name">Power User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>Get a invitation. Can upload torrents, view NFO files, view user list, ask for reseed, send invitation, access Power User and External Trackers forums, view Top 10, view other users'' torrent history (if user''s privacy level is not set ''strong''), delete subtitle uploaded by oneself.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="EliteUser_Name">Elite User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded><b class="EliteUser_Name">Elite User</b> or above would never be deleted if parked.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="CrazyUser_Name">Crazy User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>Get two invitations. Can be anonymous when seeding/leeching/uploading. </td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="InsaneUser_Name">Insane User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>Can view general logs.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="VeteranUser_Name">Veteran User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>Get three invitations. Can view other users'' history of comments and forum posts. <b class="VeteranUser_Name">Veteran User</b> or above would never be deleted whether parked or not.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="ExtremeUser_Name">Extreme User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>Can update outdated external information and access Extreme User forum.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="UltimateUser_Name">Ultimate User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>Get 5 invitations. Can view torrent structure.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="NexusMaster_Name">Nexus Master</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>Get 10 invitations.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b><img src="pic/star.gif" alt="Star"></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>Has donated money to this tracker.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="VIP_Name">VIP</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>Same privileges as <b class="NexusMaster_Name">Nexus Master</b> and is considered an Elite Member of this tracker. Immune to automatic demotion.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="User_Name">Other</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>Customized title. </td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="Uploader_Name">Uploader</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>Dedicated uploader, immune to automatic demotion. Can view who anonymous ones are.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="Moderator_Name">Moderator</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>Can view staffbox and reportbox, manage funbox and polls, edit and delete any uploaded torrent, manage offers, manage forum posts and user comments, view confidential logs, delete any uploaded subtitle, manage code updates and chronicles at logs, view users'' invitation history, change general user account information. <b>Cannot</b> manage links,recent news or forums. <b>Cannot</b> set torrents sticky or on promotion.<b>Cannot</b> view users'' confidential information (e.g. IP address and Email address). <b>Cannot</b> delete user account.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="Administrator_Name">Administrator</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>Except changing site settings and managing donation, can do just about anything.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="SysOp_Name">SysOp</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>Dedicated site developer. Except managing donation, can do anything (including changing site settings)</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="StaffLeader_Name">Staff Leader</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>The boss. Can do anything.</td>\r\n</tr>\r\n</table>', '1', 151, 10),
(172, 23, 6, 'item', 'How does this promotion thing work anyway?', '<table cellspacing=3 cellpadding=0>\r\n<tr>\r\n<td class=embedded width=200 valign="top">&nbsp; <b class="Peasant_Name">Peasant</b></td>\r\n<td class=embedded width=5>&nbsp;</td>\r\n<td class=embedded valign=top>User would be demoted to this class under any of the following circumstances:<br>\r\n1.Downloaded more than 50 GB and with ratio below 0.4<br>\r\n2.Downloaded more than 100 GB and with ratio below 0.5<br>\r\n3.Downloaded more than 200 GB and with ratio below 0.6<br>\r\n4.Downloaded more than 400 GB and with ratio below 0.7<br>\r\n5.Downloaded more than 800 GB and with ratio below 0.8</td>\r\n</tr>\r\n\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="PowerUser_Name">Power User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>Must have been be a member for at least 4 weeks, have downloaded at least 50GB and have a ratio at or above 1.05. The promotion is automatic when these conditions are met. <br>\r\nNote that you will be automatically demoted from this status if your ratio drops below 0.95 at any time.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="EliteUser_Name">Elite User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>Must have been be a member for at least 8 weeks, have downloaded at least 120GB and have a ratio at or above 1.55. The promotion is automatic when these conditions are met. <br>\r\nNote that you will be automatically demoted from this status if your ratio drops below 1.45 at any time.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="CrazyUser_Name">Crazy User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>Must have been be a member for at least 15 weeks, have downloaded at least 300GB and have a ratio at or above 2.05. The promotion is automatic when these conditions are met. <br>\r\nNote that you will be automatically demoted from this status if your ratio drops below 1.95 at any time.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="InsaneUser_Name">Insane User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>Must have been be a member for at least 25 weeks, have downloaded at least 500GB and have a ratio at or above 2.55. The promotion is automatic when these conditions are met. <br>\r\nNote that you will be automatically demoted from this status if your ratio drops below 2.45 at any time.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="VeteranUser_Name">Veteran User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>Must have been be a member for at least 40 weeks, have downloaded at least 750GB and have a ratio at or above 3.05. The promotion is automatic when these conditions are met. <br>\r\nNote that you will be automatically demoted from this status if your ratio drops below 2.95 at any time.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="ExtremeUser_Name">Extreme User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>Must have been be a member for at least 60 weeks, have downloaded at least 1TB and have a ratio at or above 3.55. The promotion is automatic when these conditions are met. <br>\r\nNote that you will be automatically demoted from this status if your ratio drops below 3.45 at any time.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="UltimateUser_Name">Ultimate User</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>Must have been be a member for at least 80 weeks, have downloaded at least 1.5TB and have a ratio at or above 4.05. The promotion is automatic when these conditions are met. <br>\r\nNote that you will be automatically demoted from this status if your ratio drops below 3.95 at any time.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="NexusMaster_Name">Nexus Master</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>Must have been be a member for at least 100 weeks, have downloaded at least 3TB and have a ratio at or above 4.55. The promotion is automatic when these conditions are met. <br>\r\nNote that you will be automatically demoted from this status if your ratio drops below 4.45 at any time.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b><img src="pic/star.gif" alt="Star"></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>Just donate, and send PM to <a class=faqlink href=sendmessage.php?receiver=1> NexusHD</a> (only him) with the details.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="VIP_Name">VIP</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded valign=top>Assigned by mods at their discretion to users they feel contribute something special to the site. (Anyone begging for VIP status will be automatically disqualified.)</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b class="User_Name">Other</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>Customized title. Exchanged at bonus system or granted by admins.</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="Uploader_Name">Uploader</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>Appointed by Admins/SysOp/Staff Leader (see the ''Uploading'' section for conditions).</td>\r\n</tr>\r\n<tr>\r\n<td class=embedded valign="top">&nbsp; <b  class="Moderator_Name">Moderator</b></td>\r\n<td class=embedded>&nbsp;</td>\r\n<td class=embedded>You don''t ask us, we''ll ask you!</td>\r\n</tr>\r\n</table>', '1', 151, 11),
(174, 25, 6, 'item', 'Why can''t my friend become a member?', 'There is a users limit (it is list at Home -> Tracker Statistics -> Limit). When that number is reached we stop accepting new members. Accounts inactive (i.e. not logged in for a long time) are automatically deleted, so keep trying.<br>\r\nWhen are inactive user accounts deleted? See <a class=faqlink href="rules.php">Rules</a>', '1', 151, 13),
(175, 26, 6, 'item', 'How do I add an avatar to my profile?', 'First, find an image that you like, and that is within the <a class=faqlink href=rules.php>rules</a>. Then you will have to find a place to host it, such as our own <a class=faqlink href=bitbucket-upload.php>BitBucket</a>. To lighten tracker''s load, we recommend you upload it to other websites and copy the URL you were given when uploading it to the Avatar URL field in <a class=faqlink href="usercp.php?action=personal">UserCP</a>.<br>\r\n<br>\r\nPlease do not make a post just to test your avatar. If everything is all right you''ll see it in your details page. ', '1', 151, 14),
(176, 27, 6, 'item', 'Most common reason for stats not updating', '<ul>\r\n<li>The server is overloaded and unresponsive. Just try to keep the session open until the server responds again. (Flooding the server with consecutive manual updates is not recommended.)</li>\r\n<li>You are using a faulty client. If you want to use an experimental or CVS version you do it at your own risk.</li>\r\n</ul>', '1', 152, 1),
(177, 28, 6, 'item', 'Best practices', '<ul>\r\n<li>If a torrent you are currently leeching/seeding is not listed on your detail page, just wait or force a manual update.</li>\r\n<li>Make sure you exit your client properly, so that the tracker receives "event=completed".</li>\r\n<li>If the tracker is down, do not stop seeding. As long as the tracker is back up before you exit the client the stats should update properly.</li>\r\n</ul>', '1', 152, 2),
(178, 29, 6, 'item', 'May I use any bittorrent client?', 'No. According to tests of common bittorrent clients by <a class=faqlink href=aboutnexus.php>Nexus Project</a>, we allowed <b>only</b> the following bittorrent clients.<br>\r\nThe test report by <a class=faqlink href=aboutnexus.php>Nexus Project</a> is <a class=faqlink href="clients/" title="Click to download">here</a>. And you may download recommended bittorrent clients <a class=faqlink href="clients/">here</a>.<br>\r\nAlso, you may click on version name of a client to download. Stars show our recommendation for each client.<br>\r\n<br>\r\n<b>Windows:</b>\r\n<ul>\r\n<li>Azureus: <a class=faqlink href="client/Windows/Azureus_2.5.0.4_Win32.setup.exe" title="Download"> 2.5.0.4</a> <img src="pic/4.5.gif" alt="Rating：4.5" title="Rating：4.5">, <a class=faqlink href="client/Windows/Azureus_3.0.5.0_windows.exe" title="Download">3.0.5.0</a> <img src="pic/4.5.gif" alt="Rating：4.5" title="Rating：4.5">, <a class=faqlink href="client/Windows/Azureus_3.0.5.2_windows.exe" title="Download">3.0.5.2</a> <img src="pic/3.gif" alt="Rating：3" title="Rating：3"> and later versions</li>\r\n<li>uTorrent: <a class=faqlink href="client/Windows/utorrent_1.6.1_490.exe" title="Download">1.6.1</a><img src="pic/4.gif" alt="Rating：4" title="Rating：4">, <a class=faqlink href="client/Windows/utorrent_1.7.5.exe" title="Download">1.7.5</a><img src="pic/4.gif" alt="Rating：4" title="Rating：4">, <a class=faqlink href="client/Windows/utorrent_1.7.6.exe" title="Download">1.7.6</a><img src="pic/4.gif" alt="Rating：4" title="Rating：4">, <a class=faqlink href="client/Windows/utorrent_1.7.7.exe" title="Download">1.7.7</a><img src="pic/4.gif" alt="Rating：4" title="Rating：4">, <a class=faqlink href="client/Windows/utorrent-1.8-beta-10364.upx.exe" title="Download">1.8Beta(Build 10364)</a><img src="pic/3.gif" alt="Rating：3" title="Rating：3"> and later versions</li>\r\n<li>BitTorrent: <a class=faqlink href="client/Windows/BitTorrent-6.0.1.exe" title="Download">6.0.1</a><img src="pic/4.gif" alt="Rating：4" title="Rating：4">, <a class=faqlink href="client/Windows/BitTorrent-6.0.2.exe" title="Download">6.0.2</a><img src="pic/4.gif" alt="Rating：4" title="Rating：4">, <a class=faqlink href="client/Windows/BitTorrent-6.0.3.exe" title="Download">6.0.3</a><img src="pic/4.gif" alt="Rating：4" title="Rating：4"> and later versions</li>\r\n<li>Deluge: <a class=faqlink href="client/Windows/deluge-0.5.9.1.exe" title="Download">0.5.9.1</a><img src="pic/3.5.gif" alt="Rating：3.5" title="Rating：3.5">, 1.1.6 and later versions</li>\r\n<li>Rufus: <a class=faqlink href="client/Windows/Rufus_0.6.9_win32_setup.exe" title="Download">0.6.9</a><img src="pic/2.gif" alt="Rating：2" title="Rating：2">, <a class=faqlink href="client/Windows/Rufus_0.7.0_win32_setup.exe" title="Download">0.7.0</a><img src="pic/2.gif" alt="Rating：2" title="Rating：2"> and later versions</li>\r\n<li>JRE: <a class=faqlink href="client/Windows/jre-6u3-windows-i586-p.exe" title="Download">jre-6u3-windows-i586-p</a>, needed to run Azureus</li>\r\n</ul>\r\n<b>Linux:</b>\r\n<ul>\r\n<li>Azureus: <a class=faqlink href="client/Linux/Azureus_2.5.0.4_linux.tar.bz2" title="Download"> 2.5.0.4</a> <img src="pic/4.5.gif" alt="Rating：4.5" title="Rating：4.5">, <a class=faqlink href="client/Linux/Azureus_3.0.5.2_linux.tar.bz2" title="Download">3.0.5.2</a> <img src="pic/3.gif" alt="Rating：3" title="Rating：3"> and later versions</li>\r\n<li>Deluge: <a class=faqlink href="client/Linux/deluge-0.5.9.1.tar.gz" title="Download">0.5.9.1</a><img src="pic/3.5.gif" alt="Rating：3.5" title="Rating：3.5"> , 1.1.6 and later versions</li>\r\n<li>Rufus: <a class=faqlink href="client/Linux/Rufus_0.6.9_src.zip" title="Download">0.6.9</a><img src="pic/2.gif" alt="Rating：2" title="Rating：2"> and later versions</li>\r\n<li>Transmission: <a class=faqlink href="client/Linux/transmission-1.21.tar.bz2" title="Download">1.21</a><img src="pic/2.gif" alt="Rating：2" title="Rating：2"> and later versions</li>\r\n<li>rTorrent: <a class=faqlink href="client/Linux/rtorrent-0.8.0.tar.gz" title="Download">0.8.0</a><img src="pic/2.gif" alt="Rating：2" title="Rating：2">(with libtorrent <a class=faqlink href="client/Linux/libtorrent-0.12.0.tar.gz" title="Download">0.12.0</a> or later) and later versions</li>\r\n<li>Enhanced CTorrent: <a class=faqlink href="client/Linux/ctorrent-dnh3.3.2.tar.gz" title="Download">3.3.2</a> and later versions</li>\r\n</ul>\r\n<b>MacOS X:</b>\r\n<ul>\r\n<li>Azureus: <a class=faqlink href="client/MacOSX/Azureus_2.5.0.4_OSX.dmg" title="Download"> 2.5.0.4</a> <img src="pic/4.5.gif" alt="Rating：4.5" title="Rating：4.5">, <a class=faqlink href="client/MacOSX/Azureus_3.0.5.2a_macosx.dmg" title="Download">3.0.5.2a</a> <img src="pic/3.gif" alt="Rating：3" title="Rating：3"> and later versions</li>\r\n<li>Transmission: <a class=faqlink href="client/MacOSX/Transmission-1.21.dmg" title="Download">1.21</a><img src="pic/2.gif" alt="Rating：2" title="Rating：2"> and later versions</li>\r\n<li>BitRocket: <a class=faqlink href="client/MacOSX/BitRocket_32.dmg" title="Download">0.3.3(32)</a><img src="pic/2.gif" alt="Rating：2" title="Rating：2"> and later versions</li>\r\n</ul>\r\n<b>Symbian (For Testing Only):</b>\r\n<ul>\r\n<li>SymTorrent: <a class=faqlink href="client/Symbian/SymTorrent_S60-3rd_1.41_2008-11-26.sis" title="Download"> 1.41 </a> <img src="pic/1.gif" alt="Rating：1" title="Rating：1"> and later versions</li>\r\n</ul>\r\n<br>\r\n\r\n<b>Support for https:</b>\r\n<ul>\r\n<li>uTorrent 1.61: cannot parse tracker https url, and marks itself as uTorrent 1.5</li>\r\n<li>Rufus: no support for https, and development ceased for 3 years now.</li>\r\n<li>rtorrent: needs to add SSL certification manually, see User Guide at its official site.</li>\r\n</ul>\r\n\r\n<br>\r\n\r\nPlease do not use any beta or testing version of bittorrent clients, e.g. uTorrent 1.8.0B. To get the best downloading experience, we highly recommend latest stable version of <a class=faqlink href="http://www.utorrent.com/download.php">uTorrent</a> and <a class=faqlink href="http://azureus.sourceforge.net/download.php">Azureus</a>.', '1', 154, 3),
(179, 30, 6, 'item', 'Why is a torrent I''m leeching/seeding listed several times in my profile?', 'If for some reason (e.g. PC crash, or frozen client) your client exits improperly and you restart it, it will have a new peer_id, so it will show as a new torrent. The old one will never receive a "event=completed" or "event=stopped" and will be listed until some tracker timeout. Just ignore it, it will eventually go away.', '1', 152, 4),
(180, 31, 6, 'item', 'I''ve finished or cancelled a torrent. Why is it still listed in my profile?', 'Some clients, notably TorrentStorm and Nova Torrent, do not report properly to the tracker when canceling or finishing a torrent. In that case the tracker will keep waiting for some message - and thus listing the torrent as seeding or leeching - until some timeout occurs. Just ignore it, it will eventually go away.', '1', 152, 5),
(182, 33, 6, 'item', 'Multiple IPs (Can I login from different computers?)', 'Yes, the tracker is capable of following sessions from different IPs for the same user. You may access the site and seed/leech simultaneously from as many computers as you want with the same account.<br>\r\nHowever, there is a limit for a single torrent. Per torrent 3 simultaneous connections are permitted per user, and in case of leeching only 1, which means you can leech a torrent from one location only at a time.', '1', 152, 7),
(184, 36, 6, 'item', 'Why can''t I upload torrents?', 'See <a class=faqlink href="rules.php">Rules</a>.', '1', 153, 1),
(185, 37, 6, 'item', 'What criteria must I meet before I can join the Uploader team?', 'You must:\r\n<ul>\r\n<li>have steady access to resources.</li>\r\n<li>upload not less than 5 torrents per week.</li>\r\n</ul>\r\nYou must be able to provide releases that:\r\n<ul>\r\n<li>are not older than 7 days</li>\r\n<li>you''ll be able to seed, or make sure are well-seeded, for at least 24 hours.</li>\r\n<li>Also, you should have at least 2MBit upload bandwith.</li>\r\n</ul>\r\nIf you think you can match these criteria do not hesitate to <a class=faqlink href="contactstaff.php">contact the staff</a>.<br>\r\n<b>Remember!</b> Write your application carefully! Be sure to include your upload speed and what kind of stuff you''re planning to upload.<br>\r\nOnly well written letters with serious intent will be considered.', '1', 153, 2),
(186, 38, 6, 'item', 'Can I upload your torrents to other trackers?', 'No. We are a closed, limited-membership community. Only registered users can use the tracker. Posting our torrents on other trackers is useless, since most people who attempt to download them will be unable to connect with us. This generates a lot of frustration and bad-will against us, and will therefore not be tolerated.<br>\r\n<br>\r\nComplaints from other sites'' administrative staff about our torrents being posted on their sites will result in the banning of the users responsible.\r\n<br>\r\n<br>\r\n(However, the files you download from us are yours to do as you please. You can always create another torrent, pointing to some other tracker, and upload it to the site of your choice.)', '1', 153, 3),
(187, 39, 6, 'item', 'How do I use the files I''ve downloaded?', 'Check out <a class=faqlink href=formats.php>this guide</a>.', '1', 154, 1),
(188, 40, 6, 'item', 'Downloaded a movie and don''t know what CAM/TS/TC/SCR means?', 'Check out <a class=faqlink href=videoformats.php>this guide</a>.', '1', 154, 2),
(189, 41, 6, 'item', 'Why did an active torrent suddenly disappear?', 'There may be three reasons for this:<br>\r\n(<b>1</b>) The torrent may have been against the site <a class=faqlink href=rules.php>rules</a>.\r\n<br>\r\n(<b>2</b>) The uploader may have deleted it because it was a bad release. A replacement will probably be uploaded to take its place.<br>\r\n(<b>3</b>) Torrents are automatically deleted after being dead for a long time.', '1', 154, 3),
(190, 42, 6, 'item', 'How do I resume a broken download or reseed something?', 'Open the .torrent file. When your client asks you for a location, choose the location of the existing file(s) and it will resume/reseed the torrent.', '1', 154, 4),
(191, 43, 6, 'item', 'Why do my downloads sometimes stall at 99%?', 'The more pieces you have, the harder it becomes to find peers who have pieces you are missing. That is why downloads sometimes slow down or even stall when there are just a few percent remaining. Just be patient and you will, sooner or later, get the remaining pieces.', '1', 154, 5),
(192, 44, 6, 'item', 'What are these "a piece has failed a hash check" messages? ', 'Bittorrent clients check the data they receive for integrity. When a piece fails this check it is automatically re-downloaded. Occasional hash fails are a common occurrence, and you shouldn''t worry.<br>\r\n<br>\r\nSome clients have an (advanced) option/preference to ''kick/ban clients that send you bad data'' or similar. It should be turned on, since it makes sure that if a peer repeatedly sends you pieces that fail the hash check it will be ignored in the future.', '1', 154, 6),
(193, 45, 6, 'item', 'The torrent is supposed to be 100MB. How come I downloaded 120MB? ', 'See the hash fails topic. If your client receives bad data it will have to re-download it, therefore the total downloaded may be larger than the torrent size. Make sure the "kick/ban" option is turned on to minimize the extra downloads.', '1', 154, 7),
(194, 46, 6, 'item', 'Why do I get a "Your ratio is too low! You need to wait xx h to start" error?', 'From the time that each <b>new</b> torrent is uploaded to the tracker, there is a period of time that some users must wait before they can download it.<br>\r\nThis delay in downloading will only affect users with a low ratio and downloaded amount above 10 GB.<br>\r\n<br>\r\n<table cellspacing=3 cellpadding=0>\r\n<tr>\r\n	<td class=embedded width="100">Ratio below</td>\r\n	<td class=embedded width="40">0.4</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">delay of</td>\r\n	<td class=embedded width="100">24h</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">Ratio below</td>\r\n	<td class=embedded width="40">0.5</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">delay of</td>\r\n	<td class=embedded width="100">12h</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">Ratio below</td>\r\n	<td class=embedded width="40">0.6</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">delay of</td>\r\n	<td class=embedded width="100">6h</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">Ratio below</td>\r\n	<td class=embedded width="40">0.8</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">delay of</td>\r\n	<td class=embedded width="100">3h</td>\r\n</tr>\r\n</table>', '0', 154, 8),
(195, 47, 6, 'item', 'Why do I get a "Port xxxx is blacklisted" error?', 'Your client is reporting to the tracker that it uses one of the default bittorrent ports (6881-6889) or any other common p2p port for incoming connections.<br>\r\n<br>\r\nWe does not allow clients to use ports commonly associated with p2p protocols. The reason for this is that it is a common practice for ISPs to throttle those ports (that is, limit the bandwidth, hence the speed). <br>\r\n<br>\r\nThe blocked ports list include the following:<br>\r\n<br>\r\n<table cellspacing=3 cellpadding=0>\r\n  <tr>\r\n	<td class=embedded width="100">Direct Connect</td>\r\n	<td class=embedded width="100">411 - 413</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">BitTorrent</td>\r\n	<td class=embedded width="100">6881 - 6889</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">BitTorrent</td>\r\n	<td class=embedded width="100">6881 - 6889</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">Kazza</td>\r\n	<td class=embedded width="100">1214</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">Gnutella</td>\r\n	<td class=embedded width="100">6346 - 6347</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">Emule</td>\r\n	<td class=embedded width="100">4662</td>\r\n  </tr>\r\n  <tr>\r\n	<td class=embedded width="100">WinMX</td>\r\n	<td class=embedded width="100">6699</td>\r\n  </tr>\r\n</table>\r\n<br>\r\nIn order to use our tracker you must configure your client to use any port range that does not contain those ports (a range within the region 49152 through 65535 is preferable,\r\ncf. <a class=faqlink href="http://www.iana.org/assignments/port-numbers">IANA</a>). Notice that some clients, like Azureus 2.0.7.0 or higher, use a single port for all torrents, while most others use one port per open torrent. The size of the range you choose should take this into account (typically less than 10 ports wide. There is no benefit whatsoever in choosing a wide range, and there are possible security implications). <br>\r\n<br>\r\nThese ports are used for connections between peers, not client to tracker. Therefore this change will not interfere with your ability to use other trackers (in fact it should <i>increase</i> your speed with torrents from any tracker, not just ours). Your client will also still be able to connect to peers that are using the standard ports. If your client does not allow custom ports to be used, you will have to switch to one that does.<br>\r\n<br>\r\nDo not ask us, or in the forums, which ports you should choose. The more random the choice is the harder it will be for ISPs to catch on to us and start limiting speeds on the ports we use. If we simply define another range ISPs will start throttling that range also. <br>\r\n<br>\r\nFinally, remember to forward the chosen ports in your router and/or open them in your\r\nfirewall, should you have them.', '1', 154, 9),
(196, 48, 6, 'item', 'What''s this "IOError - [Errno13] Permission denied" error?', 'If you just want to fix it reboot your computer, it should solve the problem. Otherwise read on.<br>\r\nIOError means Input-Output Error, and that is a file system error, not a tracker one. It shows up when your client is for some reason unable to open the partially downloaded torrent files. The most common cause is two instances of the client to be running simultaneously: the last time the client was closed it somehow didn''t really close but kept running in the background, and is therefore still locking the files, making it impossible for the new instance to open them.<br>\r\nA more uncommon occurrence is a corrupted FAT. A crash may result in corruption that makes the partially downloaded files unreadable, and the error ensues. Running scandisk should solve the problem. (Note that this may happen only if you''re running Windows 9x - which only support FAT - or NT/2000/XP with FAT formatted hard drives. NTFS is much more robust and should never permit this problem.)<br>\r\n', '1', 154, 10),
(198, 50, 6, 'item', 'Do not immediately jump on new torrents', 'The download speed mostly depends on the seeder-to-leecher ratio (SLR). Poor download speed is mainly a problem with new and very popular torrents where the SLR is low.<br>\r\n(Note: make sure you remember that you did not enjoy the low speed. Seed so that others will not endure the same.)<br>\r\n<br>In particular, do not do it if you have a slow connection. The best speeds will be found around the half-life of a torrent, when the SLR will be at its highest. (The downside is that you will not be able to seed so much. It''s up to you to balance the pros and cons of this.)', '1', 155, 1),
(199, 51, 6, 'item', 'Limit your upload speed', 'The upload speed affects the download speed in essentially two ways:<br>\r\n<ul>\r\n    <li>Bittorrent peers tend to favour those other peers that upload to them. This means that if A and B are leeching the same torrent and A is sending data to B at high speed then B will try to reciprocate. So due to this effect high upload speeds lead to high download speeds.</li>\r\n\r\n    <li>Due to the way TCP works, when A is downloading something from B it has to keep telling B that it received the data sent to him. (These are called acknowledgements - ACKs -, a sort of "got it!" messages). If A fails to do this then B will stop sending data and wait. If A is uploading at full speed there may be no bandwidth left for the ACKs and they will be delayed. So due to this effect excessively high upload speeds lead to low download speeds.</li>\r\n</ul>\r\n\r\nThe full effect is a combination of the two. The upload should be kept as high as possible while allowing the ACKs to get through without delay. <b>A good thumb rule is keeping the upload at about 80% of the theoretical upload speed. </b>You will have to fine tune yours to find out what works best for you. (Remember that keeping the upload high has the additional benefit of helping with your ratio.) <br>\r\n<br>\r\nIf you are running more than one instance of a client it is the overall upload speed that you must take into account. Some clients limit global upload speed, others do it on a per torrent basis. Know your client. The same applies if you are using your connection for anything else (e.g. browsing or ftp), always think of the overall upload speed.', '1', 155, 2),
(200, 52, 6, 'item', 'Limit the number of simultaneous connections', 'Some operating systems (like Windows 9x) do not deal well with a large number of connections, and may even crash. Also some home routers (particularly when running NAT and/or firewall with stateful inspection services) tend to become slow or crash when having to deal with too many connections. There are no fixed values for this, you may try 60 or 100 and experiment with the value. Note that these numbers are additive, if you have two instances of a client running the numbers add up.', '1', 155, 3),
(201, 53, 6, 'item', 'Limit the number of simultaneous uploads', 'Isn''t this the same as above? No. Connections limit the number of peers your client is talking to and/or downloading from. Uploads limit the number of peers your client is actually uploading to. The ideal number is typically much lower than the number of connections, and highly dependent on your (physical) connection.', '1', 155, 4),
(202, 54, 6, 'item', 'Just give it some time', 'As explained above peers favour other peers that upload to them. When you start leeching a new torrent you have nothing to offer to other peers and they will tend to ignore you. This makes the starts slow, in particular if, by chance, the peers you are connected to include few or no seeders. The download speed should increase as soon as you have some pieces to share.', '1', 155, 5),
(203, 55, 6, 'item', 'Why is my browsing so slow while leeching?', 'Your download speed is always finite. If you are a peer in a fast torrent it will almost certainly saturate your download bandwidth, and your browsing will suffer. Many clients allows you to limit the download speed and try it.<br>\r\n<br>\r\nBrowsing was used just as an example, the same would apply to gaming, IMing, etc...', '1', 155, 6);
INSERT INTO `faq` (`id`, `link_id`, `lang_id`, `type`, `question`, `answer`, `flag`, `categ`, `order`) VALUES
(204, 56, 6, 'item', 'What is a proxy?', 'Basically a middleman. When you are browsing a site through a proxy your requests are sent to the proxy and the proxy forwards them to the site instead of you connecting directly to the site. There are several classifications (the terminology is far from standard):<br>\r\n<br>\r\n\r\n\r\n<table cellspacing=3 cellpadding=0>\r\n <tr>\r\n	<td class=embedded valign="top" width="100">&nbsp;Transparent</td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded valign="top">A transparent proxy is one that needs no configuration on the clients. It works by automatically redirecting all port 80 traffic to the proxy. (Sometimes used as synonymous for non-anonymous.)</td>\r\n </tr>\r\n <tr>\r\n	<td class=embedded valign="top">&nbsp;Explicit/Voluntary</td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded valign="top">Clients must configure their browsers to use them.</td>\r\n </tr>\r\n <tr>\r\n	<td class=embedded valign="top">&nbsp;Anonymous</td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded valign="top">The proxy sends no client identification to the server. (HTTP_X_FORWARDED_FOR header is not sent; the server does not see your IP.)</td>\r\n </tr>\r\n <tr>\r\n	<td class=embedded valign="top">&nbsp;Highly Anonymous</td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded valign="top">The proxy sends no client nor proxy identification to the server. (HTTP_X_FORWARDED_FOR, HTTP_VIA and HTTP_PROXY_CONNECTION headers are not sent; the server doesn''t see your IP and doesn''t even know you''re using a proxy.)</td>\r\n </tr>\r\n <tr>\r\n	<td class=embedded valign="top">&nbsp;Public</td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded valign="top">(Self explanatory)</td>\r\n </tr>\r\n</table>\r\n<br>\r\nA transparent proxy may or may not be anonymous, and there are several levels of anonymity.', '1', 156, 1),
(205, 57, 6, 'item', 'How do I find out if I''m behind a (transparent/anonymous) proxy?', 'Try <a href=http://proxyjudge.org class="faqlink">ProxyJudge</a>. It lists the HTTP headers that the server where it is running received from you. The relevant ones are HTTP_CLIENT_IP, HTTP_X_FORWARDED_FOR and REMOTE_ADDR.', '1', 156, 2),
(206, 75, 6, 'item', 'Why am I listed as not connectable even though I''m not NAT/Firewalled?', 'The tracker is quite smart at finding your real IP, but it does need the proxy to send the HTTP header HTTP_X_FORWARDED_FOR. If your ISP''s proxy does not then what happens is that the tracker will interpret the proxy''s IP address as the client''s IP address. So when you login and the tracker tries to connect to your client to see if you are NAT/firewalled it will actually try to connect to the proxy on the port your client reports to be using for incoming connections. Naturally the proxy will not be listening on that port, the connection will fail and the tracker will think you are NAT/firewalled.', '1', 156, 3),
(211, 62, 6, 'item', 'Maybe my address is blacklisted?', 'The site keeps a list of blocked IP addresses for banned users or attackers. This works at Apache/PHP level, and only blocks <i>logins</i> from those addresses. It should not stop you from reaching the site. In particular it does not block lower level protocols, you should be able to ping/traceroute the server even if your address is blacklisted. If you cannot then the reason for the problem lies elsewhere.<br>\r\n<br>\r\nIf somehow your address is blocked by mistake, contact us about it.', '1', 157, 1),
(212, 63, 6, 'item', 'Your ISP blocks the site''s address', '(In first place, it''s unlikely your ISP is doing so. DNS name resolution and/or network problems are the usual culprits.) \r\n<br>\r\nThere''s nothing we can do. You should contact your ISP (or get a new one). Note that you can still visit the site via a proxy, follow the instructions in the relevant section. In this case it doesn''t matter if the proxy is anonymous or not, or which port it listens to.<br>\r\n<br>\r\nNotice that you will always be listed as an "unconnectable" client because the tracker will be unable to check that you''re capable of accepting incoming connections.', '1', 157, 2),
(214, 65, 6, 'item', 'You may try this', 'Post in the <a class="faqlink" href="forums.php">Forums</a>, by all means. You''ll find they are usually a friendly and helpful place, provided you follow a few basic guidelines: <ul>\r\n<li>Make sure your problem is not really in this FAQ. There''s no point in posting just to be sent back here. \r\n<li>Before posting read the sticky topics (the ones at the top). Many times new information that still hasn''t been incorporated in the FAQ can be found there.</li>\r\n<li>Help us in helping you. Do not just say "it doesn''t work!". Provide details so that we don''t have to guess or waste time asking. What client do you use? What''s your OS? What''s your network setup? What''s the exact error message you get, if any? What are the torrents you are having problems with? The more you tell the easiest it will be for us, and the more probable your post will get a reply.</li>\r\n<li>And needless to say: be polite. Demanding help rarely works, asking for it usually does the trick.</li></ul>', '1', 158, 1),
(215, 66, 6, 'item', 'Why do I get a "Your slot limit is reached! You may at most download xx torrents at the same time" error?', 'This is part of the "Slot System". The slot system is being used to limit the concurrent downloads for users that have low ratio and downloaded amount above 10 GB<br><br>\r\nRules: <br>\r\n<table cellspacing=3 cellpadding=0>\r\n<tr>\r\n	<td class=embedded width="100">Ratio below</td>\r\n	<td class=embedded width="40">0.5</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">available slots</td>\r\n	<td class=embedded width="40">1</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">Ratio below</td>\r\n	<td class=embedded width="40">0.65</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">available slots</td>\r\n	<td class=embedded width="100">2</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">Ratio below</td>\r\n	<td class=embedded width="40">0.8</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">available slots</td>\r\n	<td class=embedded width="100">3</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">Ratio below</td>\r\n	<td class=embedded width="40">0.95</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">available slots</td>\r\n	<td class=embedded width="100">4</td>\r\n</tr>\r\n<tr>\r\n	<td class=embedded width="100">Ratio above</td>\r\n	<td class=embedded width="40">0.95</div></font></td>\r\n	<td class=embedded width="10">&nbsp;</td>\r\n	<td class=embedded width="100">available slots</td>\r\n	<td class=embedded width="100">unlimited</td>\r\n</tr>\r\n</table>\r\n<br>\r\nIn all cases the seeding slots are unlimited. However if you have already filled all your available download slots and try to start seeding you will receive the same error. In this case you must free at least one download slot in order to start all your seeds and then start the download. If all your download slots are filled the system will deny any connection before validating if you want to download or seed. So first start your seeds and after that your downloads. <br>\r\n<br><br>\r\nAny time, you can check your available slots in the member bar on top of the page.', '0', 154, 12),
(216, 67, 6, 'item', 'What is the passkey System? How does it work?', 'The passkey system is implemented to verify if you are registered with the tracker. Every user has a personal passkey, a random key generated by the system. When a user tries to download a torrent, his personal passkey is imprinted in the tracker URL of the torrent, allowing to the tracker to identify any source connected on it. In this way, you can seed a torrent for example, at home and at your office simultaneously without any problem with the 2 different IPs.\r\n', '1', 154, 13),
(217, 68, 6, 'item', 'Why do I get an "Unknown passkey" error? ', 'You will get this error, firstly if you are not registered on our tracker, or if you haven''t downloaded the torrent to use from our webpage, when you were logged in. In this case, just register or log in and re-download the torrent.<br>\r\nThere is a chance to get this error also, at the first time you download anything as a new user, or at the first download after you reset your passkey. The reason is simply that the tracker reviews the changes in the passkeys every few minutes and not instantly. For that reason just leave the torrent running for a few minutes, and you will get eventually an OK message from the tracker.', '1', 154, 14),
(218, 69, 6, 'item', 'When do I need to reset my passkey?', '<ul><li>If your passkey has been leaked and other user(s) uses it to download torrents using your account. In this case, you will see torrents stated in your account that you are not leeching or seeding . <br></li>\r\n<li>When your clients hangs up or your connection is terminated without pressing the stop button of your client. In this case, in your account you will see that you are still leeching/seeding the torrents even that your client has been closed. Normally these "ghost peers" will be cleaned automatically within 30 minutes, but if you want to resume your downloads and the tracker denied that due to the fact that you "already are downloading the same torrent" then you should reset your passkey and re-download the torrent, then resume it.  </li></ul>', '1', 154, 15),
(219, 70, 6, 'item', 'What is DHT? Why must I turn it off and how?', 'DHT must be disabled in your client. DHT can cause your stats to be recorded incorrectly and could be seen as cheating. Anyone using this will be banned for cheating the system.\r\n<br>\r\nFortunately, this tracker would parse uploaded .torrent files and automatically disable DHT. That''s why you must re-downloaded the torrent before starting seeding.', '1', 154, 16),
(220, 71, 6, 'categ', 'How can I help translate the site language into my native language?', '', '1', 150, 8),
(221, 72, 6, 'item', 'What skills do I need to do the translation?', 'Translate the site into another language is quite easy. You needn''t be skilled in PHP or dynamic website design. In fact, all you need is proficient understanding of English (the default site language) and the language you plan to translate into. Maybe some basic knowledge in HTML would help.<br><br>\r\nMoreover, we give a detailed tutorial on how to do the translation <a href="#73" class="faqlink"><b>HERE</b></a>. And our coders would be more than pleased to answer the questions you may encounter.<br><br>\r\nTranslate the whole site into another language would take estimated 10 hours. And extra time is needed to maintain the translation when site code is updated.<br><br>\r\nSo, if you think you could help, feel free to <a class=faqlink href="contactstaff.php"><b>CONTACT US</b></a>. Needless to say, you would be rewarded.', '1', 220, 1),
(222, 73, 6, 'item', 'The translation tutorial', '<ul>\r\n<li>How does multi-language work?</li>\r\nCurrently we use language files to store all the static words that a user can see on web pages. <br>\r\nEvery php code file has a corresponding language file for a certain language. And we named the language file ''lang_'' plus the filename of the php code file. i.e. the language file of the php code file ''details.php'' would be ''lang_details.php''. <br>\r\nWe has some mechanism in php codes to read the exact language files of user''s preferred language, and you shouldn''t worry about that.<br> \r\n<li>What''s in language files?</li>\r\nIn a language file is an array of strings. These strings contain all the static words that a user can see on web pages. When we need to say some words on a php code file, we call for a string in the array. And the output of the php code file, that is what users see on the web pages, would show the value of the string.<br>\r\nSounds dizzying? Well, you need not care about all these. All you gotta do is translate the values of the strings in the language files into another language. <b>Let''s see an example</b>:<br><br>\r\nThe following is the content of the English language file ''lang_users.php'', which works for the php code file ''users.php''. <br><br>\r\n<img src="pic/langfileeng.png" alt="ratio" /><br>\r\nIf you wanna translate it into Simplified Chinese, all you need is edit the file into this:<br>\r\n<img src="pic/langfilechs.png" alt="ratio" /><br>\r\nSee, in every line, the left part, that is before <i>=></i>, is the name of a string, which you shouldn''t touch. All you need to is translate the right part, after <i>=></i>, which is the value of the string, into another language.<br>\r\nSometimes you need to look at the corresponding web pages to get the context meaning of some words.<br> \r\n<li>Sounds easy? See what do you need to do.</li>\r\nIf you feel like to help us, <a class=faqlink href="contactstaff.php"><b>CONTACT US</b></a> and we will send you a pack of the English language files (or any other available language if you prefer). Received it, you can start translating the value of strings (which is in English), into another language. It should take you several hours to do the whole work. After this, send back the translated language files to us.<br>\r\nIf no bugs or hacking codes are found in testing, we would put the new language into work.<br>\r\nSometimes the language files need to be updated, typically adding new strings, when site codes are updated. If you feel like it, you can help maintain the language files.<br>\r\n<li><font color=red><b>IMPORTANT</b></font><br></li>\r\nThe text of language files must be encoded in UTF-8. When saving files, be sure to set the character encoding to UTF-8. Otherwise mojibake may happen.</ul>', '1', 220, 2),
(223, 74, 6, 'item', 'Why does my client notify me of low disk space even if there is plenty left?', 'Most possible reason is that the file system of your disk partitions is FAT32, which has a maximum file size limit of 4 GB. If your operation system is Windows, consider converting file system to NTFS. Check <a class=faqlink href=http://technet.microsoft.com/en-us/library/bb456984.aspx>here</a> for details.\r\n', '1', 154, 17);

-- --------------------------------------------------------

--
-- Table structure for table `files`
--

CREATE TABLE IF NOT EXISTS `files` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `torrent` int(10) unsigned NOT NULL default '0',
  `filename` varchar(255) NOT NULL default '',
  `size` bigint(20) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `torrent` (`torrent`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `files`
--


-- --------------------------------------------------------

--
-- Table structure for table `forummods`
--

CREATE TABLE IF NOT EXISTS `forummods` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `forumid` int(10) unsigned default NULL,
  `userid` int(10) unsigned default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `forummods`
--


-- --------------------------------------------------------

--
-- Table structure for table `forums`
--

CREATE TABLE IF NOT EXISTS `forums` (
  `sort` tinyint(3) unsigned NOT NULL default '0',
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(60) NOT NULL,
  `description` varchar(200) default NULL,
  `minclassread` tinyint(3) unsigned NOT NULL default '0',
  `minclasswrite` tinyint(3) unsigned NOT NULL default '0',
  `postcount` int(10) unsigned NOT NULL default '0',
  `topiccount` int(10) unsigned NOT NULL default '0',
  `minclasscreate` tinyint(3) unsigned NOT NULL default '0',
  `forid` tinyint(4) default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `forums`
--


-- --------------------------------------------------------

--
-- Table structure for table `friends`
--

CREATE TABLE IF NOT EXISTS `friends` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` int(10) unsigned NOT NULL default '0',
  `friendid` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `userfriend` (`userid`,`friendid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `friends`
--


-- --------------------------------------------------------

--
-- Table structure for table `fun`
--

CREATE TABLE IF NOT EXISTS `fun` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` int(11) NOT NULL,
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `body` text NOT NULL,
  `title` varchar(255) NOT NULL default '',
  `status` enum('normal','dull','notfunny','funny','veryfunny','banned') default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `fun`
--


-- --------------------------------------------------------

--
-- Table structure for table `funds`
--

CREATE TABLE IF NOT EXISTS `funds` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `usd` decimal(8,2) NOT NULL default '0.00',
  `cny` decimal(8,2) NOT NULL default '0.00',
  `user` int(10) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `memo` varchar(200) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `funds`
--


-- --------------------------------------------------------

--
-- Table structure for table `funvotes`
--

CREATE TABLE IF NOT EXISTS `funvotes` (
  `funid` int(10) unsigned NOT NULL,
  `userid` int(11) NOT NULL,
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `vote` enum('fun','dull') default NULL,
  PRIMARY KEY  (`funid`,`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `funvotes`
--


-- --------------------------------------------------------

--
-- Table structure for table `highdef`
--

CREATE TABLE IF NOT EXISTS `highdef` (
  `id` int(3) NOT NULL auto_increment,
  `family` varchar(50) NOT NULL,
  `start_name` varchar(100) NOT NULL,
  `peer_id_pattern` varchar(200) NOT NULL,
  `peer_id_match_num` int(5) unsigned NOT NULL,
  `peer_id_matchtype` enum('dec','hex') NOT NULL default 'dec',
  `peer_id_start` varchar(20) NOT NULL,
  `agent_pattern` varchar(200) NOT NULL,
  `agent_match_num` int(5) unsigned NOT NULL,
  `agent_matchtype` enum('dec','hex') NOT NULL default 'dec',
  `agent_start` varchar(100) NOT NULL,
  `exception` enum('yes','no') NOT NULL default 'no',
  `comment` varchar(200) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `highdef`
--


-- --------------------------------------------------------

--
-- Table structure for table `invites`
--

CREATE TABLE IF NOT EXISTS `invites` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `inviter` int(10) unsigned NOT NULL default '0',
  `invitee` varchar(80) NOT NULL default '',
  `hash` varchar(32) NOT NULL default '',
  `time_invited` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY `inviter` (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `invites`
--


-- --------------------------------------------------------

--
-- Table structure for table `iplog`
--

CREATE TABLE IF NOT EXISTS `iplog` (
  `id` int(100) unsigned NOT NULL auto_increment,
  `ip` varchar(64) default NULL,
  `userid` int(10) default NULL,
  `access` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `iplog`
--


-- --------------------------------------------------------

--
-- Table structure for table `ips`
--

CREATE TABLE IF NOT EXISTS `ips` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` int(10) unsigned NOT NULL,
  `ip` varchar(64) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ips`
--


-- --------------------------------------------------------

--
-- Table structure for table `language`
--

CREATE TABLE IF NOT EXISTS `language` (
  `lang_id` int(10) unsigned NOT NULL auto_increment,
  `lang_name` varchar(50) default NULL,
  `flagpic` varchar(50) default NULL,
  `sub_lang` tinyint(1) NOT NULL default '1',
  `rule_lang` tinyint(1) NOT NULL default '0',
  `site_lang` tinyint(1) NOT NULL default '1',
  `site_lang_folder` varchar(10) NOT NULL,
  `trans_state` enum('up-to-date','outdate','incomplete','need-new','unavailable') NOT NULL default 'unavailable',
  PRIMARY KEY  (`lang_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=31 ;

--
-- Dumping data for table `language`
--

INSERT INTO `language` (`lang_id`, `lang_name`, `flagpic`, `sub_lang`, `rule_lang`, `site_lang`, `site_lang_folder`, `trans_state`) VALUES
(1, 'Bulgarian', 'bulgaria.gif', 1, 0, 0, '', 'unavailable'),
(2, 'Croatian', 'croatia.gif', 1, 0, 0, '', 'unavailable'),
(3, 'Czech', 'czechrep.gif', 1, 0, 0, '', 'unavailable'),
(4, 'Danish', 'denmark.gif', 1, 0, 0, '', 'unavailable'),
(5, 'Dutch', 'netherlands.gif', 1, 0, 0, '', 'unavailable'),
(6, 'English', 'uk.gif', 1, 1, 1, 'en', 'up-to-date'),
(7, 'Estonian', 'estonia.gif', 1, 0, 0, '', 'unavailable'),
(8, 'Finnish', 'finland.gif', 1, 0, 0, '', 'unavailable'),
(9, 'French', 'france.gif', 1, 0, 0, '', 'unavailable'),
(10, 'German', 'germany.gif', 1, 0, 0, '', 'unavailable'),
(11, 'Greek', 'greece.gif', 1, 0, 0, '', 'unavailable'),
(12, 'Hebrew', 'israel.gif', 1, 0, 0, '', 'unavailable'),
(13, 'Hungarian', 'hungary.gif', 1, 0, 0, '', 'unavailable'),
(14, 'Italian', 'italy.gif', 1, 0, 0, '', 'unavailable'),
(15, '日本語', 'japan.gif', 1, 0, 0, 'ja', 'unavailable'),
(16, '한국어', 'southkorea.gif', 1, 0, 0, 'ko', 'incomplete'),
(17, 'Norwegian', 'norway.gif', 1, 0, 0, '', 'unavailable'),
(18, 'Other', 'jollyroger.gif', 1, 0, 0, '', 'unavailable'),
(19, 'Polish', 'poland.gif', 1, 0, 0, '', 'unavailable'),
(20, 'Portuguese', 'portugal.gif', 1, 0, 0, '', 'unavailable'),
(21, 'Romanian', 'romania.gif', 1, 0, 0, '', 'unavailable'),
(22, 'Russian', 'russia.gif', 1, 0, 0, '', 'unavailable'),
(23, 'Serbian', 'serbia.gif', 1, 0, 0, '', 'unavailable'),
(24, 'Slovak', 'slovakia.gif', 1, 0, 0, '', 'unavailable'),
(25, '简体中文', 'china.gif', 1, 1, 1, 'chs', 'up-to-date'),
(26, 'Spanish', 'spain.gif', 1, 0, 0, '', 'unavailable'),
(27, 'Swedish', 'sweden.gif', 1, 0, 0, '', 'unavailable'),
(28, '繁體中文', 'hongkong.gif', 1, 1, 1, 'cht', 'up-to-date'),
(29, 'Turkish', 'turkey.gif', 1, 0, 0, '', 'unavailable'),
(30, 'Slovenian', 'slovenia.gif', 1, 0, 0, '', 'unavailable');

-- --------------------------------------------------------

--
-- Table structure for table `leecherspmlog`
--

CREATE TABLE IF NOT EXISTS `leecherspmlog` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user` int(10) unsigned NOT NULL default '0',
  `date` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `leecherspmlog`
--


-- --------------------------------------------------------

--
-- Table structure for table `links`
--

CREATE TABLE IF NOT EXISTS `links` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `url` varchar(200) NOT NULL,
  `title` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `links`
--


-- --------------------------------------------------------

--
-- Table structure for table `locations`
--

CREATE TABLE IF NOT EXISTS `locations` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `location_main` varchar(200) NOT NULL,
  `location_sub` varchar(200) NOT NULL,
  `flagpic` varchar(50) default NULL,
  `start_ip` varchar(20) NOT NULL,
  `end_ip` varchar(20) NOT NULL,
  `theory_upspeed` int(10) unsigned NOT NULL default '10',
  `practical_upspeed` int(10) unsigned NOT NULL default '10',
  `theory_downspeed` int(10) unsigned NOT NULL default '10',
  `practical_downspeed` int(10) unsigned NOT NULL default '10',
  `hit` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1997 ;

--
-- Dumping data for table `locations`
--

INSERT INTO `locations` (`id`, `name`, `location_main`, `location_sub`, `flagpic`, `start_ip`, `end_ip`, `theory_upspeed`, `practical_upspeed`, `theory_downspeed`, `practical_downspeed`, `hit`) VALUES
(718, 'CerNet', '教育网', '中国教育网', NULL, '202.38.96.0', '202.38.127.255', 10, 10, 10, 10, 0),
(719, 'CerNet', '教育网', '中国教育网', NULL, '202.112.0.0', '202.112.31.255', 10, 10, 10, 10, 0),
(720, 'CerNet', '教育网', '中国教育网', NULL, '202.192.0.0', '202.207.255.255', 10, 10, 10, 10, 0),
(721, 'CerNet', '教育网', '中国教育网', NULL, '210.25.0.0', '210.47.255.255', 10, 10, 10, 10, 0),
(722, 'CerNet', '教育网', '中国教育网', NULL, '211.64.0.0', '211.69.255.255', 10, 10, 10, 10, 0),
(723, 'CerNet', '教育网', '教育网上海', NULL, '202.38.0.0', '202.38.1.255', 10, 10, 10, 10, 0),
(724, 'CerNet', '教育网', '教育网上海', NULL, '202.38.135.0', '202.38.135.255', 10, 10, 10, 10, 0),
(725, 'CerNet', '教育网', '教育网上海', NULL, '202.120.0.0', '202.121.255.255', 10, 10, 10, 10, 0),
(726, 'CerNet', '教育网', '教育网上海', NULL, '202.122.0.0', '202.122.7.255', 10, 10, 10, 10, 0),
(727, 'CerNet', '教育网', '教育网上海', NULL, '210.35.64.0', '210.35.127.255', 10, 10, 10, 10, 0),
(728, 'CerNet', '教育网', '教育网上海', NULL, '211.80.37.0', '211.80.43.255', 10, 10, 10, 10, 0),
(729, 'CerNet', '教育网', '教育网云南', NULL, '202.38.130.0', '202.38.131.255', 10, 10, 10, 10, 0),
(730, 'CerNet', '教育网', '教育网云南', NULL, '202.203.160.0', '202.203.255.255', 10, 10, 10, 10, 0),
(731, 'CerNet', '教育网', '教育网云南', NULL, '210.40.240.0', '210.40.255.255', 10, 10, 10, 10, 0),
(732, 'CerNet', '教育网', '教育网内蒙古', NULL, '202.207.0.0', '202.207.79.255', 10, 10, 10, 10, 0),
(733, 'CerNet', '教育网', '教育网北京', NULL, '162.105.0.0', '162.105.255.255', 10, 10, 10, 10, 0),
(734, 'CerNet', '教育网', '教育网北京', NULL, '166.111.0.0', '166.111.255.255', 10, 10, 10, 10, 0),
(735, 'CerNet', '教育网', '教育网北京', NULL, '202.4.128.0', '202.4.159.255', 10, 10, 10, 10, 0),
(736, 'CerNet', '教育网', '教育网北京', NULL, '202.14.88.0', '202.14.88.255', 10, 10, 10, 10, 0),
(737, 'CerNet', '教育网', '教育网北京', NULL, '202.38.142.0', '202.38.142.255', 10, 10, 10, 10, 0),
(738, 'CerNet', '教育网', '教育网北京', NULL, '202.112.8.0', '202.112.8.255', 10, 10, 10, 10, 0),
(739, 'CerNet', '教育网', '教育网北京', NULL, '202.112.56.0', '202.112.255.255', 10, 10, 10, 10, 0),
(740, 'CerNet', '教育网', '教育网北京', NULL, '202.204.0.0', '202.205.255.255', 10, 10, 10, 10, 0),
(741, 'CerNet', '教育网', '教育网北京', NULL, '211.68.0.0', '211.68.127.255', 10, 10, 10, 10, 0),
(742, 'CerNet', '教育网', '教育网吉林', NULL, '202.198.0.0', '202.198.255.255', 10, 10, 10, 10, 0),
(743, 'CerNet', '教育网', '教育网吉林', NULL, '210.47.0.0', '210.47.55.255', 10, 10, 10, 10, 0),
(744, 'CerNet', '教育网', '教育网四川', NULL, '202.115.0.0', '202.115.255.255', 10, 10, 10, 10, 0),
(745, 'CerNet', '教育网', '教育网四川', NULL, '202.202.0.0', '202.202.255.255', 10, 10, 10, 10, 0),
(746, 'CerNet', '教育网', '教育网四川', NULL, '210.41.128.0', '210.41.255.255', 10, 10, 10, 10, 0),
(747, 'CerNet', '教育网', '教育网天津', NULL, '202.113.0.0', '202.113.255.255', 10, 10, 10, 10, 0),
(748, 'CerNet', '教育网', '教育网天津', NULL, '211.68.192.0', '211.68.255.255', 10, 10, 10, 10, 0),
(749, 'CerNet', '教育网', '教育网宁夏', NULL, '202.201.128.0', '202.201.143.255', 10, 10, 10, 10, 0),
(750, 'CerNet', '教育网', '教育网宁夏', NULL, '210.27.240.0', '210.27.255.255', 10, 10, 10, 10, 0),
(751, 'CerNet', '教育网', '教育网安徽', NULL, '202.38.64.0', '202.38.96.255', 10, 10, 10, 10, 0),
(752, 'CerNet', '教育网', '教育网安徽', NULL, '210.45.0.0', '210.45.255.255', 10, 10, 10, 10, 0),
(753, 'CerNet', '教育网', '教育网山东', NULL, '202.194.0.0', '202.194.255.255', 10, 10, 10, 10, 0),
(754, 'CerNet', '教育网', '教育网山东', NULL, '210.44.0.0', '210.44.255.25', 10, 10, 10, 10, 0),
(755, 'CerNet', '教育网', '教育网山东', NULL, '211.64.0.0', '211.64.255.255', 10, 10, 10, 10, 0),
(756, 'CerNet', '教育网', '教育网山西', NULL, '202.207.128.0', '202.207.255.255', 10, 10, 10, 10, 0),
(757, 'CerNet', '教育网', '教育网广东', NULL, '202.38.140.0', '202.38.141.255', 10, 10, 10, 10, 0),
(758, 'CerNet', '教育网', '教育网广东', NULL, '202.116.0.0', '202.116.239.255', 10, 10, 10, 10, 0),
(759, 'CerNet', '教育网', '教育网广东', NULL, '202.192.0.0', '202.192.255.255', 10, 10, 10, 10, 0),
(760, 'CerNet', '教育网', '教育网广东', NULL, '202.201.80.0', '202.201.80.255', 10, 10, 10, 10, 0),
(761, 'CerNet', '教育网', '教育网广东', NULL, '210.38.0.0', '210.39.255.255', 10, 10, 10, 10, 0),
(762, 'CerNet', '教育网', '教育网广东', NULL, '211.66.0.0', '211.66.255.255', 10, 10, 10, 10, 0),
(763, 'CerNet', '教育网', '教育网广西', NULL, '202.193.0.0', '202.193.255.255', 10, 10, 10, 10, 0),
(764, 'CerNet', '教育网', '教育网广西', NULL, '210.36.0.0', '210.36.255.255', 10, 10, 10, 10, 0),
(765, 'CerNet', '教育网', '教育网新疆', NULL, '202.201.240.0', '202.201.255.255', 10, 10, 10, 10, 0),
(766, 'CerNet', '教育网', '教育网新疆', NULL, '210.26.128.0', '210.26.191.255', 10, 10, 10, 10, 0),
(767, 'CerNet', '教育网', '教育网江苏', NULL, '202.38.2.0', '202.38.3.255', 10, 10, 10, 10, 0),
(768, 'CerNet', '教育网', '教育网江苏', NULL, '202.38.143.0', '202.38.143.255', 10, 10, 10, 10, 0),
(769, 'CerNet', '教育网', '教育网江苏', NULL, '202.119.0.0', '202.119.255.255', 10, 10, 10, 10, 0),
(770, 'CerNet', '教育网', '教育网江苏', NULL, '202.195.0.0', '202.195.255.255', 10, 10, 10, 10, 0),
(771, 'CerNet', '教育网', '教育网江苏', NULL, '210.28.0.0', '210.29.255.255', 10, 10, 10, 10, 0),
(772, 'CerNet', '教育网', '教育网江苏', NULL, '211.65.0.0', '211.65.255.255', 10, 10, 10, 10, 0),
(773, 'CerNet', '教育网', '教育网江西', NULL, '210.35.0.0', '210.35.23.255', 10, 10, 10, 10, 0),
(774, 'CerNet', '教育网', '教育网江西', NULL, '210.35.128.0', '210.35.255.255', 10, 10, 10, 10, 0),
(775, 'CerNet', '教育网', '教育网河北', NULL, '202.206.0.0', '202.206.255.255', 10, 10, 10, 10, 0),
(776, 'CerNet', '教育网', '教育网河北', NULL, '202.207.120.0', '202.207.127.255', 10, 10, 10, 10, 0),
(777, 'CerNet', '教育网', '教育网河北', NULL, '211.68.128.0', '211.68.175.255', 10, 10, 10, 10, 0),
(778, 'CerNet', '教育网', '教育网河南', NULL, '202.196.0.0', '202.196.255.255', 10, 10, 10, 10, 0),
(779, 'CerNet', '教育网', '教育网河南', NULL, '210.43.0.0', '210.43.39.255', 10, 10, 10, 10, 0),
(780, 'CerNet', '教育网', '教育网河南', NULL, '211.69.0.0', '211.69.15.255', 10, 10, 10, 10, 0),
(781, 'CerNet', '教育网', '教育网浙江', NULL, '210.32.16.0', '210.32.63.255', 10, 10, 10, 10, 0),
(782, 'CerNet', '教育网', '教育网浙江', NULL, '210.32.68.0', '210.33.127.255', 10, 10, 10, 10, 0),
(783, 'CerNet', '教育网', '教育网浙江', NULL, '210.32.192.0', '210.33.255.255', 10, 10, 10, 10, 0),
(784, 'CerNet', '教育网', '教育网浙江', NULL, '210.35.32.0', '210.35.49.255', 10, 10, 10, 10, 0),
(785, 'CerNet', '教育网', '教育网海南', NULL, '202.116.240.0', '202.116.255.255', 10, 10, 10, 10, 0),
(786, 'CerNet', '教育网', '教育网海南', NULL, '210.37.0.0', '210.37.255.255', 10, 10, 10, 10, 0),
(787, 'CerNet', '教育网', '教育网湖北', NULL, '202.114.0.0', '202.114.255.255', 10, 10, 10, 10, 0),
(788, 'CerNet', '教育网', '教育网湖北', NULL, '210.42.0.0', '210.42.175.255', 10, 10, 10, 10, 0),
(789, 'CerNet', '教育网', '教育网湖北', NULL, '211.69.128.0', '211.69.143.255', 10, 10, 10, 10, 0),
(790, 'CerNet', '教育网', '教育网湖南', NULL, '202.197.0.0', '202.197.255.255', 10, 10, 10, 10, 0),
(791, 'CerNet', '教育网', '教育网湖南', NULL, '210.42.176.0', '210.42.255.255', 10, 10, 10, 10, 0),
(792, 'CerNet', '教育网', '教育网湖南', NULL, '210.43.40.0', '210.43.255.255', 10, 10, 10, 10, 0),
(793, 'CerNet', '教育网', '教育网湖南', NULL, '211.69.72.0', '211.69.119.255', 10, 10, 10, 10, 0),
(794, 'CerNet', '教育网', '教育网甘肃', NULL, '202.201.0.0', '202.201.31.255', 10, 10, 10, 10, 0),
(795, 'CerNet', '教育网', '教育网甘肃', NULL, '210.26.0.0', '210.26.39.255', 10, 10, 10, 10, 0),
(796, 'CerNet', '教育网', '教育网福建', NULL, '210.34.0.0', '210.34.255.255', 10, 10, 10, 10, 0),
(797, 'CerNet', '教育网', '教育网西藏', NULL, '210.41.0.0', '210.41.19.255', 10, 10, 10, 10, 0),
(798, 'CerNet', '教育网', '教育网贵州', NULL, '202.203.0.0', '202.203.31.255', 10, 10, 10, 10, 0),
(799, 'CerNet', '教育网', '教育网贵州', NULL, '210.40.0.0', '210.40.127.255', 10, 10, 10, 10, 0),
(800, 'CerNet', '教育网', '教育网辽宁', NULL, '202.118.0.0', '202.118.127.255', 10, 10, 10, 10, 0),
(801, 'CerNet', '教育网', '教育网辽宁', NULL, '202.199.0.0', '202.199.255.255', 10, 10, 10, 10, 0),
(802, 'CerNet', '教育网', '教育网辽宁', NULL, '210.30.0.0', '210.30.255.255', 10, 10, 10, 10, 0),
(803, 'CerNet', '教育网', '教育网辽宁', NULL, '210.47.144.0', '210.47.255.255', 10, 10, 10, 10, 0),
(804, 'CerNet', '教育网', '教育网陕西', NULL, '202.117.0.0', '202.117.255.255', 10, 10, 10, 10, 0),
(805, 'CerNet', '教育网', '教育网陕西', NULL, '202.200.0.0', '202.200.255.255', 10, 10, 10, 10, 0),
(806, 'CerNet', '教育网', '教育网陕西', NULL, '210.27.0.0', '210.27.79.255', 10, 10, 10, 10, 0),
(807, 'CerNet', '教育网', '教育网黑龙江', NULL, '202.118.128.0', '202.118.255.255', 10, 10, 10, 10, 0),
(808, 'CerNet', '教育网', '教育网黑龙江', NULL, '210.46.0.0', '210.46.211.255', 10, 10, 10, 10, 0),
(809, 'CerNet', '教育网', '教育网黑龙江', NULL, '210.47.64.0', '210.47.143.255', 10, 10, 10, 10, 0),
(810, 'China', '中国', '上海', NULL, '61.129.0.0', '61.129.255.255', 10, 10, 10, 10, 0),
(811, 'China', '中国', '上海', NULL, '61.151.0.0', '61.151.255.255', 10, 10, 10, 10, 0),
(812, 'China', '中国', '上海', NULL, '61.152.128.0', '61.153.255.255', 10, 10, 10, 10, 0),
(813, 'China', '中国', '上海', NULL, '61.165.0.0', '61.165.255.255', 10, 10, 10, 10, 0),
(814, 'China', '中国', '上海', NULL, '61.169.0.0', '61.171.255.255', 10, 10, 10, 10, 0),
(815, 'China', '中国', '上海', NULL, '202.22.224.0', '202.22.255.255', 10, 10, 10, 10, 0),
(816, 'China', '中国', '上海', NULL, '202.38.4.0', '202.38.7.255', 10, 10, 10, 10, 0),
(817, 'China', '中国', '上海', NULL, '202.38.132.0', '202.38.134.255', 10, 10, 10, 10, 0),
(818, 'China', '中国', '上海', NULL, '202.95.2.0', '202.95.3.255', 10, 10, 10, 10, 0),
(819, 'China', '中国', '上海', NULL, '202.96.192.0', '202.96.255.255', 10, 10, 10, 10, 0),
(820, 'China', '中国', '上海', NULL, '202.101.0.0', '202.101.63.255', 10, 10, 10, 10, 0),
(821, 'China', '中国', '上海', NULL, '202.109.0.0', '202.109.127.255', 10, 10, 10, 10, 0),
(822, 'China', '中国', '上海', NULL, '202.112.40.0', '202.112.47.255', 10, 10, 10, 10, 0),
(823, 'China', '中国', '上海', NULL, '202.127.0.0', '202.127.1.255', 10, 10, 10, 10, 0),
(824, 'China', '中国', '上海', NULL, '202.127.16.1', '202.127.31.255', 10, 10, 10, 10, 0),
(825, 'China', '中国', '上海', NULL, '202.130.248.0', '202.130.249.255', 10, 10, 10, 10, 0),
(826, 'China', '中国', '上海', NULL, '203.93.56.111', '203.93.56.230', 10, 10, 10, 10, 0),
(827, 'China', '中国', '上海', NULL, '203.93.203.0', '203.93.203.255', 10, 10, 10, 10, 0),
(828, 'China', '中国', '上海', NULL, '203.207.144.0', '203.207.144.255', 10, 10, 10, 10, 0),
(829, 'China', '中国', '上海', NULL, '210.35.50.0', '210.35.51.255', 10, 10, 10, 10, 0),
(830, 'China', '中国', '上海', NULL, '210.35.96.214', '210.35.96.214', 10, 10, 10, 10, 0),
(831, 'China', '中国', '上海', NULL, '210.35.96.219', '210.35.96.219', 10, 10, 10, 10, 0),
(832, 'China', '中国', '上海', NULL, '210.52.207.0', '210.52.217.255', 10, 10, 10, 10, 0),
(833, 'China', '中国', '上海', NULL, '210.72.8.0', '210.72.15.255', 10, 10, 10, 10, 0),
(834, 'China', '中国', '上海', NULL, '210.74.224.0', '210.74.255.255', 10, 10, 10, 10, 0),
(835, 'China', '中国', '上海', NULL, '210.78.24.0', '210.78.26.255', 10, 10, 10, 10, 0),
(836, 'China', '中国', '上海', NULL, '211.52.209.0', '211.52.209.255', 10, 10, 10, 10, 0),
(837, 'China', '中国', '上海', NULL, '211.95.1.0', '211.95.127.255', 10, 10, 10, 10, 0),
(838, 'China', '中国', '上海', NULL, '211.98.49.0', '211.98.49.255', 10, 10, 10, 10, 0),
(839, 'China', '中国', '上海', NULL, '211.98.55.0', '211.98.55.255', 10, 10, 10, 10, 0),
(840, 'China', '中国', '上海', NULL, '211.144.64.0', '211.144.95.255', 10, 10, 10, 10, 0),
(841, 'China', '中国', '上海', NULL, '211.154.64.0', '211.154.95.255', 10, 10, 10, 10, 0),
(842, 'China', '中国', '上海', NULL, '211.156.0.0', '211.156.72.255', 10, 10, 10, 10, 0),
(843, 'China', '中国', '上海', NULL, '211.161.0.0', '211.161.255.255', 10, 10, 10, 10, 0),
(844, 'China', '中国', '上海', NULL, '211.167.96.0', '211.167.127.255', 10, 10, 10, 10, 0),
(845, 'China', '中国', '上海', NULL, '211.167.96.0', '211.167.159.255', 10, 10, 10, 10, 0),
(846, 'China', '中国', '上海', NULL, '211.167.192.0', '211.167.223.255', 10, 10, 10, 10, 0),
(847, 'China', '中国', '上海', NULL, '218.1.0.0', '218.1.255.255', 10, 10, 10, 10, 0),
(848, 'China', '中国', '东方环讯', NULL, '202.95.0.0', '202.95.3.255', 10, 10, 10, 10, 0),
(849, 'China', '中国', '中网', NULL, '202.94.0.0', '202.94.31.255', 10, 10, 10, 10, 0),
(850, 'China', '中国', '乌鲁木齐', NULL, '203.93.185.0', '203.93.185.255', 10, 10, 10, 10, 0),
(851, 'China', '中国', '云南', NULL, '61.138.192.0', '61.138.223.255', 10, 10, 10, 10, 0),
(852, 'China', '中国', '云南', NULL, '61.166.0.0', '61.166.255.255', 10, 10, 10, 10, 0),
(853, 'China', '中国', '云南', NULL, '202.98.64.0', '202.98.95.255', 10, 10, 10, 10, 0),
(854, 'China', '中国', '云南', NULL, '202.98.160.0', '202.98.191.255', 10, 10, 10, 10, 0),
(855, 'China', '中国', '云南', NULL, '210.14.249.0', '210.14.249.255', 10, 10, 10, 10, 0),
(856, 'China', '中国', '云南', NULL, '211.92.144.0', '211.92.175.255', 10, 10, 10, 10, 0),
(857, 'China', '中国', '云南', NULL, '211.98.72.0', '211.98.72.255', 10, 10, 10, 10, 0),
(858, 'China', '中国', '云南', NULL, '218.62.0.0', '218.63.255.255', 10, 10, 10, 10, 0),
(859, 'China', '中国', '内蒙古', NULL, '61.134.96.0', '61.134.127.255', 10, 10, 10, 10, 0),
(860, 'China', '中国', '内蒙古', NULL, '202.99.224.0', '202.99.255.255', 10, 10, 10, 10, 0),
(861, 'China', '中国', '内蒙古', NULL, '211.90.74.0', '211.90.74.255', 10, 10, 10, 10, 0),
(862, 'China', '中国', '内蒙古', NULL, '211.93.153.0', '211.93.158.255', 10, 10, 10, 10, 0),
(863, 'China', '中国', '内蒙古', NULL, '211.163.30.0', '211.163.30.255', 10, 10, 10, 10, 0),
(864, 'China', '中国', '内蒙古', NULL, '218.21.128.0', '218.21.255.255', 10, 10, 10, 10, 0),
(865, 'China', '中国', '北京', NULL, '61.135.0.0', '61.135.255.255', 10, 10, 10, 10, 0),
(866, 'China', '中国', '北京', NULL, '132.246.27.0', '132.246.27.255', 10, 10, 10, 10, 0),
(867, 'China', '中国', '北京', NULL, '168.160.224.0', '168.160.233.255', 10, 10, 10, 10, 0),
(868, 'China', '中国', '北京', NULL, '202.4.224.0', '202.4.255.255', 10, 10, 10, 10, 0),
(869, 'China', '中国', '北京', NULL, '202.20.120.0', '202.20.120.255', 10, 10, 10, 10, 0),
(870, 'China', '中国', '北京', NULL, '202.38.8.0', '202.38.47.255', 10, 10, 10, 10, 0),
(871, 'China', '中国', '北京', NULL, '202.38.126.0', '202.38.127.255', 10, 10, 10, 10, 0),
(872, 'China', '中国', '北京', NULL, '202.38.128.0', '202.38.129.255', 10, 10, 10, 10, 0),
(873, 'China', '中国', '北京', NULL, '202.38.136.0', '202.38.138.255', 10, 10, 10, 10, 0),
(874, 'China', '中国', '北京', NULL, '202.38.146.0', '202.38.161.255', 10, 10, 10, 10, 0),
(875, 'China', '中国', '北京', NULL, '202.38.168.0', '202.38.170.255', 10, 10, 10, 10, 0),
(876, 'China', '中国', '北京', NULL, '202.38.174.0', '202.38.176.255', 10, 10, 10, 10, 0),
(877, 'China', '中国', '北京', NULL, '202.91.0.0', '202.91.131.255', 10, 10, 10, 10, 0),
(878, 'China', '中国', '北京', NULL, '202.92.252.0', '202.92.255.255', 10, 10, 10, 10, 0),
(879, 'China', '中国', '北京', NULL, '202.93.252.0', '202.93.255.255', 10, 10, 10, 10, 0),
(880, 'China', '中国', '北京', NULL, '202.96.0.0', '202.96.51.255', 10, 10, 10, 10, 0),
(881, 'China', '中国', '北京', NULL, '202.97.26.0', '202.97.28.255', 10, 10, 10, 10, 0),
(882, 'China', '中国', '北京', NULL, '202.99.0.0', '202.99.63.255', 10, 10, 10, 10, 0),
(883, 'China', '中国', '北京', NULL, '202.106.0.0', '202.106.255.255', 10, 10, 10, 10, 0),
(884, 'China', '中国', '北京', NULL, '202.108.0.0', '202.108.255.255', 10, 10, 10, 10, 0),
(885, 'China', '中国', '北京', NULL, '202.112.32.0', '202.112.39.255', 10, 10, 10, 10, 0),
(886, 'China', '中国', '北京', NULL, '202.122.32.0', '202.122.128.255', 10, 10, 10, 10, 0),
(887, 'China', '中国', '北京', NULL, '202.127.40.0', '202.127.47.255', 10, 10, 10, 10, 0),
(888, 'China', '中国', '北京', NULL, '202.130.3.0', '202.130.3.255', 10, 10, 10, 10, 0),
(889, 'China', '中国', '北京', NULL, '202.130.226.0', '202.130.247.255', 10, 10, 10, 10, 0),
(890, 'China', '中国', '北京', NULL, '203.90.0.0', '203.90.3.255', 10, 10, 10, 10, 0),
(891, 'China', '中国', '北京', NULL, '203.93.9.0', '203.93.9.255', 10, 10, 10, 10, 0),
(892, 'China', '中国', '北京', NULL, '203.93.10.0', '203.93.12.255', 10, 10, 10, 10, 0),
(893, 'China', '中国', '北京', NULL, '203.93.18.111', '203.93.18.248', 10, 10, 10, 10, 0),
(894, 'China', '中国', '北京', NULL, '203.93.32.0', '203.93.32.255', 10, 10, 10, 10, 0),
(895, 'China', '中国', '北京', NULL, '203.93.63.0', '203.93.63.255', 10, 10, 10, 10, 0),
(896, 'China', '中国', '北京', NULL, '203.93.66.0', '203.93.85.255', 10, 10, 10, 10, 0),
(897, 'China', '中国', '北京', NULL, '203.93.87.0', '203.93.127.255', 10, 10, 10, 10, 0),
(898, 'China', '中国', '北京', NULL, '203.196.0.0', '203.196.3.255', 10, 10, 10, 10, 0),
(899, 'China', '中国', '北京', NULL, '203.207.195.0', '203.207.195.255', 10, 10, 10, 10, 0),
(900, 'China', '中国', '北京', NULL, '203.207.228.0', '203.207.228.255', 10, 10, 10, 10, 0),
(901, 'China', '中国', '北京', NULL, '203.208.6.0', '203.208.6.255', 10, 10, 10, 10, 0),
(902, 'China', '中国', '北京', NULL, '205.183.212.0', '205.183.212.255', 10, 10, 10, 10, 0),
(903, 'China', '中国', '北京', NULL, '210.12.0.0', '210.12.3.31', 10, 10, 10, 10, 0),
(904, 'China', '中国', '北京', NULL, '210.12.5.0', '210.12.7.255', 10, 10, 10, 10, 0),
(905, 'China', '中国', '北京', NULL, '210.12.36.0', '210.12.36.255', 10, 10, 10, 10, 0),
(906, 'China', '中国', '北京', NULL, '210.12.38.0', '210.12.38.95', 10, 10, 10, 10, 0),
(907, 'China', '中国', '北京', NULL, '210.12.40.0', '210.12.40.63', 10, 10, 10, 10, 0),
(908, 'China', '中国', '北京', NULL, '210.12.42.0', '210.12.42.255', 10, 10, 10, 10, 0),
(909, 'China', '中国', '北京', NULL, '210.12.45.0', '210.12.45.255', 10, 10, 10, 10, 0),
(910, 'China', '中国', '北京', NULL, '210.12.53.0', '210.12.53.255', 10, 10, 10, 10, 0),
(911, 'China', '中国', '北京', NULL, '210.12.64.0', '210.12.64.255', 10, 10, 10, 10, 0),
(912, 'China', '中国', '北京', NULL, '210.12.154.0', '210.12.155.255', 10, 10, 10, 10, 0),
(913, 'China', '中国', '北京', NULL, '210.15.68.0', '210.15.69.255', 10, 10, 10, 10, 0),
(914, 'China', '中国', '北京', NULL, '210.25.16.0', '210.25.19.255', 10, 10, 10, 10, 0),
(915, 'China', '中国', '北京', NULL, '210.25.64.0', '210.25.67.255', 10, 10, 10, 10, 0),
(916, 'China', '中国', '北京', NULL, '210.52.149.0', '210.52.149.255', 10, 10, 10, 10, 0),
(917, 'China', '中国', '北京', NULL, '210.72.32.0', '210.72.43.255', 10, 10, 10, 10, 0),
(918, 'China', '中国', '北京', NULL, '210.72.45.0', '210.72.47.255', 10, 10, 10, 10, 0),
(919, 'China', '中国', '北京', NULL, '210.72.192.0', '210.72.255.255', 10, 10, 10, 10, 0),
(920, 'China', '中国', '北京', NULL, '210.73.64.0', '210.73.95.255', 10, 10, 10, 10, 0),
(921, 'China', '中国', '北京', NULL, '210.74.32.0', '210.74.64.255', 10, 10, 10, 10, 0),
(922, 'China', '中国', '北京', NULL, '210.74.160.0', '210.74.191.255', 10, 10, 10, 10, 0),
(923, 'China', '中国', '北京', NULL, '210.76.96.0', '210.76.127.255', 10, 10, 10, 10, 0),
(924, 'China', '中国', '北京', NULL, '210.77.32.0', '210.77.64.255', 10, 10, 10, 10, 0),
(925, 'China', '中国', '北京', NULL, '210.78.128.0', '210.79.255.255', 10, 10, 10, 10, 0),
(926, 'China', '中国', '北京', NULL, '211.71.16.0', '211.71.31.255', 10, 10, 10, 10, 0),
(927, 'China', '中国', '北京', NULL, '211.94.1.0', '211.94.191.255', 10, 10, 10, 10, 0),
(928, 'China', '中国', '北京', NULL, '211.98.11.0', '211.98.11.255', 10, 10, 10, 10, 0),
(929, 'China', '中国', '北京', NULL, '211.99.0.0', '211.99.63.255', 10, 10, 10, 10, 0),
(930, 'China', '中国', '北京', NULL, '211.99.65.0', '211.99.74.255', 10, 10, 10, 10, 0),
(931, 'China', '中国', '北京', NULL, '211.99.126.0', '211.101.248.255', 10, 10, 10, 10, 0),
(932, 'China', '中国', '北京', NULL, '211.152.1.0', '211.152.159.255', 10, 10, 10, 10, 0),
(933, 'China', '中国', '北京', NULL, '211.153.0.0', '211.153.1.255', 10, 10, 10, 10, 0),
(934, 'China', '中国', '北京', NULL, '211.153.1.0', '211.153.255.255', 10, 10, 10, 10, 0),
(935, 'China', '中国', '北京', NULL, '211.155.159.0', '211.155.251.255', 10, 10, 10, 10, 0),
(936, 'China', '中国', '北京', NULL, '211.157.57.0', '211.157.245.255', 10, 10, 10, 10, 0),
(937, 'China', '中国', '北京', NULL, '211.159.80.0', '211.159.85.255', 10, 10, 10, 10, 0),
(938, 'China', '中国', '北京', NULL, '211.159.93.0', '211.159.93.255', 10, 10, 10, 10, 0),
(939, 'China', '中国', '北京', NULL, '211.167.32.0', '211.167.64.255', 10, 10, 10, 10, 0),
(940, 'China', '中国', '北京', NULL, '211.167.160.0', '211.167.175.255', 10, 10, 10, 10, 0),
(941, 'China', '中国', '北京', NULL, '211.167.224.0', '211.167.253.255', 10, 10, 10, 10, 0),
(942, 'China', '中国', '台湾', NULL, '24.179.140.0', '24.179.150.255', 10, 10, 10, 10, 0),
(943, 'China', '中国', '台湾', NULL, '61.58.65.0', '61.58.70.255', 10, 10, 10, 10, 0),
(944, 'China', '中国', '台湾', NULL, '61.216.0.0', '61.219.255.255', 10, 10, 10, 10, 0),
(945, 'China', '中国', '台湾', NULL, '133.223.0.0', '139.223.255.255', 10, 10, 10, 10, 0),
(946, 'China', '中国', '台湾', NULL, '139.175.0.0', '139.175.255.255', 10, 10, 10, 10, 0),
(947, 'China', '中国', '台湾', NULL, '140.92.0.0', '140.138.255.255', 10, 10, 10, 10, 0),
(948, 'China', '中国', '台湾', NULL, '163.25.0.0', '163.32.255.255', 10, 10, 10, 10, 0),
(949, 'China', '中国', '台湾', NULL, '168.95.10.0', '168.95.199.255', 10, 10, 10, 10, 0),
(950, 'China', '中国', '台湾', NULL, '192.188.171.0', '192.188.171.255', 10, 10, 10, 10, 0),
(951, 'China', '中国', '台湾', NULL, '194.117.103.0', '194.117.103.255', 10, 10, 10, 10, 0),
(952, 'China', '中国', '台湾', NULL, '195.112.176.0', '195.112.176.3', 10, 10, 10, 10, 0),
(953, 'China', '中国', '台湾', NULL, '199.107.119.0', '199.107.119.255', 10, 10, 10, 10, 0),
(954, 'China', '中国', '台湾', NULL, '202.2.52.0', '202.2.55.255', 10, 10, 10, 10, 0),
(955, 'China', '中国', '台湾', NULL, '202.5.224.0', '202.5.255.255', 10, 10, 10, 10, 0),
(956, 'China', '中国', '台湾', NULL, '202.14.8.0', '202.14.15.255', 10, 10, 10, 10, 0),
(957, 'China', '中国', '台湾', NULL, '202.39.0.0', '202.39.255.255', 10, 10, 10, 10, 0),
(958, 'China', '中国', '台湾', NULL, '202.43.64.0', '202.43.95.255', 10, 10, 10, 10, 0),
(959, 'China', '中国', '台湾', NULL, '202.52.64.0', '202.52.127.255', 10, 10, 10, 10, 0),
(960, 'China', '中国', '台湾', NULL, '202.60.64.0', '202.60.95.255', 10, 10, 10, 10, 0),
(961, 'China', '中国', '台湾', NULL, '202.61.32.0', '202.61.63.255', 10, 10, 10, 10, 0),
(962, 'China', '中国', '台湾', NULL, '202.80.128.0', '202.80.159.255', 10, 10, 10, 10, 0),
(963, 'China', '中国', '台湾', NULL, '202.145.32.0', '202.145.255.255', 10, 10, 10, 10, 0),
(964, 'China', '中国', '台湾', NULL, '202.160.64.0', '202.160.95.255', 10, 10, 10, 10, 0),
(965, 'China', '中国', '台湾', NULL, '202.162.64.0', '202.162.95.255', 10, 10, 10, 10, 0),
(966, 'China', '中国', '台湾', NULL, '202.166.192.0', '202.166.255.255', 10, 10, 10, 10, 0),
(967, 'China', '中国', '台湾', NULL, '202.178.224.0', '202.178.255.255', 10, 10, 10, 10, 0),
(968, 'China', '中国', '台湾', NULL, '203.64.0.0', '203.75.255.255', 10, 10, 10, 10, 0),
(969, 'China', '中国', '台湾', NULL, '203.77.0.0', '203.77.127.255', 10, 10, 10, 10, 0),
(970, 'China', '中国', '台湾', NULL, '203.78.0.0', '203.78.31.255', 10, 10, 10, 10, 0),
(971, 'China', '中国', '台湾', NULL, '203.79.0.0', '203.79.255.255', 10, 10, 10, 10, 0),
(972, 'China', '中国', '台湾', NULL, '203.95.128.0', '203.95.255.255', 10, 10, 10, 10, 0),
(973, 'China', '中国', '台湾', NULL, '203.107.0.0', '203.107.63.255', 10, 10, 10, 10, 0),
(974, 'China', '中国', '台湾', NULL, '203.133.0.0', '203.133.63.255', 10, 10, 10, 10, 0),
(975, 'China', '中国', '台湾', NULL, '203.135.224.0', '203.135.255.255', 10, 10, 10, 10, 0),
(976, 'China', '中国', '台湾', NULL, '203.160.224.0', '203.160.255.255', 10, 10, 10, 10, 0),
(977, 'China', '中国', '台湾', NULL, '210.0.180.0', '210.0.180.255', 10, 10, 10, 10, 0),
(978, 'China', '中国', '台湾', NULL, '210.17.0.0', '210.17.127.255', 10, 10, 10, 10, 0),
(979, 'China', '中国', '台湾', NULL, '210.58.0.0', '210.71.255.255', 10, 10, 10, 10, 0),
(980, 'China', '中国', '台湾', NULL, '210.192.0.0', '210.192.255.255', 10, 10, 10, 10, 0),
(981, 'China', '中国', '台湾', NULL, '210.200.0.0', '210.200.95.255', 10, 10, 10, 10, 0),
(982, 'China', '中国', '台湾', NULL, '210.208.0.0', '210.209.63.255', 10, 10, 10, 10, 0),
(983, 'China', '中国', '台湾', NULL, '210.240.0.0', '210.247.255.255', 10, 10, 10, 10, 0),
(984, 'China', '中国', '台湾', NULL, '211.20.0.0', '211.20.255.255', 10, 10, 10, 10, 0),
(985, 'China', '中国', '台湾', NULL, '211.21.30.0', '211.21.30.255', 10, 10, 10, 10, 0),
(986, 'China', '中国', '台湾', NULL, '211.21.237.0', '211.22.209.255', 10, 10, 10, 10, 0),
(987, 'China', '中国', '台湾', NULL, '211.22.0.0', '211.22.255.255', 10, 10, 10, 10, 0),
(988, 'China', '中国', '台湾', NULL, '211.22.241.0', '211.22.241.255', 10, 10, 10, 10, 0),
(989, 'China', '中国', '台湾', NULL, '211.23.87.0', '211.23.203.255', 10, 10, 10, 10, 0),
(990, 'China', '中国', '台湾', NULL, '211.23.96.0', '211.23.96.255', 10, 10, 10, 10, 0),
(991, 'China', '中国', '台湾', NULL, '211.72.0.0', '211.75.255.255', 10, 10, 10, 10, 0),
(992, 'China', '中国', '吉林', NULL, '61.138.128.0', '61.138.191.255', 10, 10, 10, 10, 0),
(993, 'China', '中国', '吉林', NULL, '202.38.164.0', '202.38.167.255', 10, 10, 10, 10, 0),
(994, 'China', '中国', '吉林', NULL, '202.98.0.0', '202.98.31.255', 10, 10, 10, 10, 0),
(995, 'China', '中国', '吉林', NULL, '202.111.160.0', '202.111.191.255', 10, 10, 10, 10, 0),
(996, 'China', '中国', '吉林', NULL, '203.93.111.31', '203.93.111.62', 10, 10, 10, 10, 0),
(997, 'China', '中国', '吉林', NULL, '203.93.144.192', '203.93.144.255', 10, 10, 10, 10, 0),
(998, 'China', '中国', '吉林', NULL, '203.93.181.0', '203.93.181.255', 10, 10, 10, 10, 0),
(999, 'China', '中国', '吉林', NULL, '210.12.11.0', '210.12.12.255', 10, 10, 10, 10, 0),
(1000, 'China', '中国', '吉林', NULL, '210.12.28.0', '210.12.28.255', 10, 10, 10, 10, 0),
(1001, 'China', '中国', '吉林', NULL, '210.12.39.0', '210.12.39.255', 10, 10, 10, 10, 0),
(1002, 'China', '中国', '吉林', NULL, '210.12.50.0', '210.12.50.255', 10, 10, 10, 10, 0),
(1003, 'China', '中国', '吉林', NULL, '210.12.79.0', '210.12.79.255', 10, 10, 10, 10, 0),
(1004, 'China', '中国', '吉林', NULL, '210.12.82.0', '210.12.82.255', 10, 10, 10, 10, 0),
(1005, 'China', '中国', '吉林', NULL, '210.12.85.0', '210.12.85.255', 10, 10, 10, 10, 0),
(1006, 'China', '中国', '吉林', NULL, '211.93.65.0', '211.93.74.255', 10, 10, 10, 10, 0),
(1007, 'China', '中国', '吉林', NULL, '211.111.178.0', '211.111.178.255', 10, 10, 10, 10, 0),
(1008, 'China', '中国', '吉林', NULL, '218.27.88.0', '218.27.90.255', 10, 10, 10, 10, 0),
(1009, 'China', '中国', '四川', NULL, '61.139.0.0', '61.139.127.255', 10, 10, 10, 10, 0),
(1010, 'China', '中国', '四川', NULL, '61.157.0.0', '61.157.255.255', 10, 10, 10, 10, 0),
(1011, 'China', '中国', '四川', NULL, '61.188.0.0', '61.188.255.255', 10, 10, 10, 10, 0),
(1012, 'China', '中国', '四川', NULL, '202.95.1.0', '202.95.1.255', 10, 10, 10, 10, 0),
(1013, 'China', '中国', '四川', NULL, '202.98.96.0', '202.98.159.255', 10, 10, 10, 10, 0),
(1014, 'China', '中国', '四川', NULL, '203.93.86.0', '203.93.86.255', 10, 10, 10, 10, 0),
(1015, 'China', '中国', '四川', NULL, '203.207.180.0', '203.207.180.255', 10, 10, 10, 10, 0),
(1016, 'China', '中国', '四川', NULL, '203.207.189.0', '203.207.189.255', 10, 10, 10, 10, 0),
(1017, 'China', '中国', '四川', NULL, '210.12.8.0', '210.12.8.255', 10, 10, 10, 10, 0),
(1018, 'China', '中国', '四川', NULL, '210.12.57.0', '210.12.57.255', 10, 10, 10, 10, 0),
(1019, 'China', '中国', '四川', NULL, '210.12.60.0', '210.12.60.255', 10, 10, 10, 10, 0),
(1020, 'China', '中国', '四川', NULL, '210.12.62.0', '210.12.62.255', 10, 10, 10, 10, 0),
(1021, 'China', '中国', '四川', NULL, '210.12.159.0', '210.12.159.255', 10, 10, 10, 10, 0),
(1022, 'China', '中国', '四川', NULL, '210.12.162.0', '210.12.162.255', 10, 10, 10, 10, 0),
(1023, 'China', '中国', '四川', NULL, '210.12.168.0', '210.12.168.255', 10, 10, 10, 10, 0),
(1024, 'China', '中国', '四川', NULL, '210.12.179.0', '210.12.179.255', 10, 10, 10, 10, 0),
(1025, 'China', '中国', '四川', NULL, '210.53.19.0', '210.53.19.255', 10, 10, 10, 10, 0),
(1026, 'China', '中国', '四川', NULL, '210.79.244.0', '210.79.244.255', 10, 10, 10, 10, 0),
(1027, 'China', '中国', '四川', NULL, '211.92.72.0', '211.92.107.255', 10, 10, 10, 10, 0),
(1028, 'China', '中国', '四川', NULL, '211.93.73.0', '211.93.73.255', 10, 10, 10, 10, 0),
(1029, 'China', '中国', '四川', NULL, '211.95.128.0', '211.95.173.255', 10, 10, 10, 10, 0),
(1030, 'China', '中国', '四川', NULL, '211.162.130.0', '211.162.133.255', 10, 10, 10, 10, 0),
(1031, 'China', '中国', '四川', NULL, '211.163.17.0', '211.163.19.255', 10, 10, 10, 10, 0),
(1032, 'China', '中国', '四川', NULL, '218.6.128.0', '218.6.255.255', 10, 10, 10, 10, 0),
(1033, 'China', '中国', '天津', NULL, '61.136.0.0', '61.136.63.255', 10, 10, 10, 10, 0),
(1034, 'China', '中国', '天津', NULL, '61.181.0.0', '61.181.255.255', 10, 10, 10, 10, 0),
(1035, 'China', '中国', '天津', NULL, '202.99.64.0', '202.99.127.255', 10, 10, 10, 10, 0),
(1036, 'China', '中国', '天津', NULL, '203.93.120.255', '203.93.122.255', 10, 10, 10, 10, 0),
(1037, 'China', '中国', '天津', NULL, '203.207.135.0', '203.207.135.255', 10, 10, 10, 10, 0),
(1038, 'China', '中国', '天津', NULL, '210.12.25.0', '210.12.26.127', 10, 10, 10, 10, 0),
(1039, 'China', '中国', '天津', NULL, '210.12.169.0', '210.12.170.255', 10, 10, 10, 10, 0),
(1040, 'China', '中国', '天津', NULL, '210.52.163.0', '210.52.164.255', 10, 10, 10, 10, 0),
(1041, 'China', '中国', '天津', NULL, '210.76.200.0', '210.76.203.255', 10, 10, 10, 10, 0),
(1042, 'China', '中国', '天津', NULL, '211.94.192.0', '211.94.215.255', 10, 10, 10, 10, 0),
(1043, 'China', '中国', '天津', NULL, '211.103.2.0', '211.103.6.255', 10, 10, 10, 10, 0),
(1044, 'China', '中国', '天津', NULL, '211.103.80.0', '211.103.85.255', 10, 10, 10, 10, 0),
(1045, 'China', '中国', '天津', NULL, '211.159.86.0', '211.159.96.255', 10, 10, 10, 10, 0),
(1046, 'China', '中国', '宁夏', NULL, '61.133.192.0', '61.133.223.255', 10, 10, 10, 10, 0),
(1047, 'China', '中国', '宁夏', NULL, '202.100.96.0', '202.100.127.255', 10, 10, 10, 10, 0),
(1048, 'China', '中国', '宁夏', NULL, '211.93.1.0', '211.93.3.255', 10, 10, 10, 10, 0),
(1049, 'China', '中国', '宁夏', NULL, '218.21.0.0', '218.21.47.255', 10, 10, 10, 10, 0),
(1050, 'China', '中国', '安徽', NULL, '61.133.128.0', '61.133.191.255', 10, 10, 10, 10, 0),
(1051, 'China', '中国', '安徽', NULL, '61.190.0.0', '61.190.30.255', 10, 10, 10, 10, 0),
(1052, 'China', '中国', '安徽', NULL, '202.102.192.0', '202.102.223.255', 10, 10, 10, 10, 0),
(1053, 'China', '中国', '安徽', NULL, '202.111.192.0', '202.111.223.255', 10, 10, 10, 10, 0),
(1054, 'China', '中国', '安徽', NULL, '202.127.200.0', '202.127.207.255', 10, 10, 10, 10, 0),
(1055, 'China', '中国', '安徽', NULL, '203.93.4.0', '203.93.4.255', 10, 10, 10, 10, 0),
(1056, 'China', '中国', '安徽', NULL, '210.15.28.0', '210.15.28.255', 10, 10, 10, 10, 0),
(1057, 'China', '中国', '安徽', NULL, '211.91.88.0', '211.91.111.255', 10, 10, 10, 10, 0),
(1058, 'China', '中国', '安徽', NULL, '211.163.193.0', '211.163.193.255', 10, 10, 10, 10, 0),
(1059, 'China', '中国', '安徽', NULL, '218.22.0.0', '218.23.255.255', 10, 10, 10, 10, 0),
(1060, 'China', '中国', '山东', NULL, '61.133.0.0', '61.133.127.255', 10, 10, 10, 10, 0),
(1061, 'China', '中国', '山东', NULL, '61.156.0.0', '61.156.255.255', 10, 10, 10, 10, 0),
(1062, 'China', '中国', '山东', NULL, '61.162.0.0', '61.162.255.255', 10, 10, 10, 10, 0),
(1063, 'China', '中国', '山东', NULL, '61.179.0.0', '61.179.255.255', 10, 10, 10, 10, 0),
(1064, 'China', '中国', '山东', NULL, '168.160.152.0', '168.160.152.255', 10, 10, 10, 10, 0),
(1065, 'China', '中国', '山东', NULL, '202.102.132.0', '202.102.190.255', 10, 10, 10, 10, 0),
(1066, 'China', '中国', '山东', NULL, '202.110.192.0', '202.110.255.255', 10, 10, 10, 10, 0),
(1067, 'China', '中国', '山东', NULL, '203.93.80.0', '203.93.80.255', 10, 10, 10, 10, 0),
(1068, 'China', '中国', '山东', NULL, '203.93.94.213', '203.93.94.254', 10, 10, 10, 10, 0),
(1069, 'China', '中国', '山东', NULL, '203.93.188.0', '203.93.188.255', 10, 10, 10, 10, 0),
(1070, 'China', '中国', '山东', NULL, '203.207.150.0', '203.207.153.255', 10, 10, 10, 10, 0),
(1071, 'China', '中国', '山东', NULL, '210.12.3.32', '210.12.3.95', 10, 10, 10, 10, 0),
(1072, 'China', '中国', '山东', NULL, '210.12.15.0', '210.12.15.255', 10, 10, 10, 10, 0),
(1073, 'China', '中国', '山东', NULL, '210.12.16.64', '210.12.17.255', 10, 10, 10, 10, 0),
(1074, 'China', '中国', '山东', NULL, '210.12.31.0', '210.12.31.255', 10, 10, 10, 10, 0),
(1075, 'China', '中国', '山东', NULL, '210.12.54.0', '210.12.55.255', 10, 10, 10, 10, 0),
(1076, 'China', '中国', '山东', NULL, '210.12.99.0', '210.12.99.255', 10, 10, 10, 10, 0),
(1077, 'China', '中国', '山东', NULL, '210.12.171.0', '210.12.171.255', 10, 10, 10, 10, 0),
(1078, 'China', '中国', '山东', NULL, '210.25.32.0', '210.25.35.255', 10, 10, 10, 10, 0),
(1079, 'China', '中国', '山东', NULL, '210.52.2.0', '210.52.2.255', 10, 10, 10, 10, 0),
(1080, 'China', '中国', '山东', NULL, '210.52.7.0', '210.52.7.255', 10, 10, 10, 10, 0),
(1081, 'China', '中国', '山东', NULL, '210.76.128.0', '210.76.159.255', 10, 10, 10, 10, 0),
(1082, 'China', '中国', '山东', NULL, '210.77.222.0', '210.77.222.255', 10, 10, 10, 10, 0),
(1083, 'China', '中国', '山东', NULL, '210.77.240.0', '210.77.240.255', 10, 10, 10, 10, 0),
(1084, 'China', '中国', '山东', NULL, '211.97.168.0', '211.97.235.255', 10, 10, 10, 10, 0),
(1085, 'China', '中国', '山东', NULL, '211.99.96.0', '211.99.127.255', 10, 10, 10, 10, 0),
(1086, 'China', '中国', '山东', NULL, '218.57.12.0', '218.57.168.255', 10, 10, 10, 10, 0),
(1087, 'China', '中国', '山东', NULL, '218.58.0.0', '218.58.87.255', 10, 10, 10, 10, 0),
(1088, 'China', '中国', '山西', NULL, '61.134.192.0', '61.134.255.255', 10, 10, 10, 10, 0),
(1089, 'China', '中国', '山西', NULL, '202.97.128.0', '202.97.159.255', 10, 10, 10, 10, 0),
(1090, 'China', '中国', '山西', NULL, '202.99.192.0', '202.99.223.255', 10, 10, 10, 10, 0),
(1091, 'China', '中国', '山西', NULL, '210.12.13.0', '210.12.13.255', 10, 10, 10, 10, 0),
(1092, 'China', '中国', '山西', NULL, '210.12.35.0', '210.12.35.127', 10, 10, 10, 10, 0),
(1093, 'China', '中国', '山西', NULL, '210.12.37.0', '210.12.37.255', 10, 10, 10, 10, 0),
(1094, 'China', '中国', '山西', NULL, '211.90.79.0', '211.90.86.255', 10, 10, 10, 10, 0),
(1095, 'China', '中国', '山西', NULL, '211.98.136.0', '211.98.136.255', 10, 10, 10, 10, 0),
(1096, 'China', '中国', '山西', NULL, '218.26.0.0', '218.26.20.255', 10, 10, 10, 10, 0),
(1097, 'China', '中国', '广东', NULL, '61.140.0.0', '61.143.255.255', 10, 10, 10, 10, 0),
(1098, 'China', '中国', '广东', NULL, '202.38.171.0', '202.38.172.255', 10, 10, 10, 10, 0),
(1099, 'China', '中国', '广东', NULL, '202.38.192.0', '202.38.255.255', 10, 10, 10, 10, 0),
(1100, 'China', '中国', '广东', NULL, '202.90.0.0', '202.90.7.255', 10, 10, 10, 10, 0),
(1101, 'China', '中国', '广东', NULL, '202.93.0.0', '202.93.3.255', 10, 10, 10, 10, 0),
(1102, 'China', '中国', '广东', NULL, '202.96.128.0', '202.96.191.255', 10, 10, 10, 10, 0),
(1103, 'China', '中国', '广东', NULL, '202.103.128.0', '202.103.191.255', 10, 10, 10, 10, 0),
(1104, 'China', '中国', '广东', NULL, '202.104.0.0', '202.105.255.255', 10, 10, 10, 10, 0),
(1105, 'China', '中国', '广东', NULL, '202.112.48.0', '202.112.55.255', 10, 10, 10, 10, 0),
(1106, 'China', '中国', '广东', NULL, '202.130.8.0', '202.130.8.255', 10, 10, 10, 10, 0),
(1107, 'China', '中国', '广东', NULL, '203.93.48.0', '203.93.49.255', 10, 10, 10, 10, 0),
(1108, 'China', '中国', '广东', NULL, '203.93.58.111', '203.93.58.206', 10, 10, 10, 10, 0),
(1109, 'China', '中国', '广东', NULL, '203.93.197.0', '203.93.197.255', 10, 10, 10, 10, 0),
(1110, 'China', '中国', '广东', NULL, '203.93.210.0', '203.93.210.255', 10, 10, 10, 10, 0),
(1111, 'China', '中国', '广东', NULL, '203.207.171.0', '203.207.173.255', 10, 10, 10, 10, 0),
(1112, 'China', '中国', '广东', NULL, '203.207.178.0', '203.207.179.255', 10, 10, 10, 10, 0),
(1113, 'China', '中国', '广东', NULL, '203.208.1.0', '203.208.0O2.255', 10, 10, 10, 10, 0),
(1114, 'China', '中国', '广东', NULL, '203.208.4.0', '203.208.5.255', 10, 10, 10, 10, 0),
(1115, 'China', '中国', '广东', NULL, '203.208.8.0', '203.208.18.255', 10, 10, 10, 10, 0),
(1116, 'China', '中国', '广东', NULL, '203.254.234.0', '203.254.234.255', 10, 10, 10, 10, 0),
(1117, 'China', '中国', '广东', NULL, '210.12.10.0', '210.12.10.255', 10, 10, 10, 10, 0),
(1118, 'China', '中国', '广东', NULL, '210.12.44.0', '210.12.44.255', 10, 10, 10, 10, 0),
(1119, 'China', '中国', '广东', NULL, '210.12.56.0', '210.12.56.255', 10, 10, 10, 10, 0),
(1120, 'China', '中国', '广东', NULL, '210.14.224.0', '210.14.226.255', 10, 10, 10, 10, 0),
(1121, 'China', '中国', '广东', NULL, '210.14.234.0', '210.14.234.255', 10, 10, 10, 10, 0),
(1122, 'China', '中国', '广东', NULL, '210.14.253.0', '210.14.253.255', 10, 10, 10, 10, 0),
(1123, 'China', '中国', '广东', NULL, '210.14.254.0', '210.14.254.255', 10, 10, 10, 10, 0),
(1124, 'China', '中国', '广东', NULL, '210.21.29.0', '210.21.29.255', 10, 10, 10, 10, 0),
(1125, 'China', '中国', '广东', NULL, '210.21.134.0', '210.21.134.255', 10, 10, 10, 10, 0),
(1126, 'China', '中国', '广东', NULL, '210.21.196.0', '210.21.196.255', 10, 10, 10, 10, 0),
(1127, 'China', '中国', '广东', NULL, '210.25.80.0', '210.25.83.255', 10, 10, 10, 10, 0),
(1128, 'China', '中国', '广东', NULL, '210.51.0.0', '210.51.255.255', 10, 10, 10, 10, 0),
(1129, 'China', '中国', '广东', NULL, '210.52.66.0', '210.52.68.255', 10, 10, 10, 10, 0),
(1130, 'China', '中国', '广东', NULL, '210.53.32.0', '210.53.33.255', 10, 10, 10, 10, 0),
(1131, 'China', '中国', '广东', NULL, '210.55.169.0', '210.55.169.255', 10, 10, 10, 10, 0),
(1132, 'China', '中国', '广东', NULL, '210.74.122.0', '210.74.122.255', 10, 10, 10, 10, 0),
(1133, 'China', '中国', '广东', NULL, '210.74.148.0', '210.74.148.255', 10, 10, 10, 10, 0),
(1134, 'China', '中国', '广东', NULL, '210.75.32.0', '210.75.63.255', 10, 10, 10, 10, 0),
(1135, 'China', '中国', '广东', NULL, '210.76.64.0', '210.76.95.255', 10, 10, 10, 10, 0),
(1136, 'China', '中国', '广东', NULL, '210.77.96.0', '210.77.127.255', 10, 10, 10, 10, 0),
(1137, 'China', '中国', '广东', NULL, '211.95.192.0', '211.97.47.255', 10, 10, 10, 10, 0),
(1138, 'China', '中国', '广东', NULL, '211.98.57.0', '211.98.59.255', 10, 10, 10, 10, 0),
(1139, 'China', '中国', '广东', NULL, '211.152.160.0', '211.152.191.255', 10, 10, 10, 10, 0),
(1140, 'China', '中国', '广东', NULL, '211.154.100.0', '211.154.131.255', 10, 10, 10, 10, 0),
(1141, 'China', '中国', '广东', NULL, '211.156.96.0', '211.156.107.255', 10, 10, 10, 10, 0),
(1142, 'China', '中国', '广东', NULL, '211.159.0.0', '211.159.60.255', 10, 10, 10, 10, 0),
(1143, 'China', '中国', '广东', NULL, '211.159.84.0', '211.159.84.255', 10, 10, 10, 10, 0),
(1144, 'China', '中国', '广东', NULL, '211.167.0.0', '211.167.31.255', 10, 10, 10, 10, 0),
(1145, 'China', '中国', '广东', NULL, '218.13.3.0', '218.20.255.255', 10, 10, 10, 10, 0),
(1146, 'China', '中国', '广西', NULL, '61.139.192.0', '61.139.255.255', 10, 10, 10, 10, 0),
(1147, 'China', '中国', '广西', NULL, '202.103.192.0', '202.103.255.255', 10, 10, 10, 10, 0),
(1148, 'China', '中国', '广西', NULL, '210.12.18.0', '210.12.18.7', 10, 10, 10, 10, 0),
(1149, 'China', '中国', '广西', NULL, '210.14.220.0', '210.14.220.255', 10, 10, 10, 10, 0),
(1150, 'China', '中国', '广西', NULL, '210.14.234.0', '210.14.234.255', 10, 10, 10, 10, 0),
(1151, 'China', '中国', '广西', NULL, '210.14.251.0', '210.14.251.255', 10, 10, 10, 10, 0),
(1152, 'China', '中国', '广西', NULL, '211.97.64.0', '211.97.83.255', 10, 10, 10, 10, 0),
(1153, 'China', '中国', '广西', NULL, '211.98.66.0', '211.98.69.255', 10, 10, 10, 10, 0),
(1154, 'China', '中国', '广西', NULL, '211.98.77.0', '211.98.80.255', 10, 10, 10, 10, 0),
(1155, 'China', '中国', '广西', NULL, '218.21.65.0', '218.21.125.255', 10, 10, 10, 10, 0),
(1156, 'China', '中国', '广西', NULL, '218.65.240.0', '218.65.243.255', 10, 10, 10, 10, 0),
(1157, 'China', '中国', '新疆', NULL, '61.128.96.0', '61.128.127.255', 10, 10, 10, 10, 0),
(1158, 'China', '中国', '新疆', NULL, '202.100.160.0', '202.100.191.255', 10, 10, 10, 10, 0),
(1159, 'China', '中国', '新疆', NULL, '202.107.144.0', '202.107.159.255', 10, 10, 10, 10, 0),
(1160, 'China', '中国', '新疆', NULL, '210.12.19.0', '210.12.19.31', 10, 10, 10, 10, 0),
(1161, 'China', '中国', '新疆', NULL, '210.12.33.0', '210.12.33.255', 10, 10, 10, 10, 0),
(1162, 'China', '中国', '新疆', NULL, '211.93.16.0', '211.93.22.255', 10, 10, 10, 10, 0),
(1163, 'China', '中国', '新疆', NULL, '211.163.32.0', '211.163.37.255', 10, 10, 10, 10, 0),
(1164, 'China', '中国', '新疆', NULL, '218.31.2.0', '218.31.110.255', 10, 10, 10, 10, 0),
(1165, 'China', '中国', '武汉', NULL, '141.30.117.0', '141.30.117.255', 10, 10, 10, 10, 0),
(1166, 'China', '中国', '武汉', NULL, '211.161.144.0', '211.161.159.255', 10, 10, 10, 10, 0),
(1167, 'China', '中国', '江苏', NULL, '61.132.0.0', '61.132.127.255', 10, 10, 10, 10, 0),
(1168, 'China', '中国', '江苏', NULL, '61.147.8.0', '61.147.242.255', 10, 10, 10, 10, 0),
(1169, 'China', '中国', '江苏', NULL, '61.155.0.0', '61.155.255.255', 10, 10, 10, 10, 0),
(1170, 'China', '中国', '江苏', NULL, '61.160.48.0', '61.160.49.255', 10, 10, 10, 10, 0),
(1171, 'China', '中国', '江苏', NULL, '61.172.0.0', '61.173.255.255', 10, 10, 10, 10, 0),
(1172, 'China', '中国', '江苏', NULL, '61.177.0.0', '61.177.255.255', 10, 10, 10, 10, 0),
(1173, 'China', '中国', '江苏', NULL, '193.10.176.0', '193.10.176.225', 10, 10, 10, 10, 0),
(1174, 'China', '中国', '江苏', NULL, '202.92.0.0', '202.92.3.255', 10, 10, 10, 10, 0),
(1175, 'China', '中国', '江苏', NULL, '202.102.0.0', '202.102.127.255', 10, 10, 10, 10, 0),
(1176, 'China', '中国', '江苏', NULL, '202.111.0.0', '202.111.127.255', 10, 10, 10, 10, 0),
(1177, 'China', '中国', '江苏', NULL, '202.127.12.0', '202.127.15.255', 10, 10, 10, 10, 0),
(1178, 'China', '中国', '江苏', NULL, '203.93.134.0', '203.93.135.255', 10, 10, 10, 10, 0),
(1179, 'China', '中国', '江苏', NULL, '203.93.243.0', '203.93.243.255', 10, 10, 10, 10, 0),
(1180, 'China', '中国', '江苏', NULL, '210.12.27.0', '210.12.27.255', 10, 10, 10, 10, 0),
(1181, 'China', '中国', '江苏', NULL, '210.12.52.0', '210.12.52.255', 10, 10, 10, 10, 0),
(1182, 'China', '中国', '江苏', NULL, '210.15.22.0', '210.15.22.255', 10, 10, 10, 10, 0),
(1183, 'China', '中国', '江苏', NULL, '210.15.23.0', '210.15.23.255', 10, 10, 10, 10, 0),
(1184, 'China', '中国', '江苏', NULL, '210.15.31.0', '210.15.31.255', 10, 10, 10, 10, 0),
(1185, 'China', '中国', '江苏', NULL, '210.25.48.0', '210.25.51.255', 10, 10, 10, 10, 0),
(1186, 'China', '中国', '江苏', NULL, '210.52.238.0', '210.52.240.255', 10, 10, 10, 10, 0),
(1187, 'China', '中国', '江苏', NULL, '210.77.240.98', '210.77.240.98', 10, 10, 10, 10, 0),
(1188, 'China', '中国', '江苏', NULL, '211.70.0.0', '211.70.255.255', 10, 10, 10, 10, 0),
(1189, 'China', '中国', '江苏', NULL, '211.90.100.0', '211.90.195.255', 10, 10, 10, 10, 0),
(1190, 'China', '中国', '江苏', NULL, '211.98.43.0', '211.98.43.255', 10, 10, 10, 10, 0),
(1191, 'China', '中国', '江苏', NULL, '211.98.53.0', '211.98.53.255', 10, 10, 10, 10, 0),
(1192, 'China', '中国', '江苏', NULL, '211.152.228.0', '211.152.228.255', 10, 10, 10, 10, 0),
(1193, 'China', '中国', '江苏', NULL, '211.163.97.0', '211.163.105.255', 10, 10, 10, 10, 0),
(1194, 'China', '中国', '江苏', NULL, '218.2.0.0', '218.3.255.255', 10, 10, 10, 10, 0),
(1195, 'China', '中国', '江西', NULL, '61.131.128.0', '61.131.255.255', 10, 10, 10, 10, 0),
(1196, 'China', '中国', '江西', NULL, '61.180.0.0', '61.180.128.255', 10, 10, 10, 10, 0),
(1197, 'China', '中国', '江西', NULL, '202.101.192.0', '202.101.255.255', 10, 10, 10, 10, 0),
(1198, 'China', '中国', '江西', NULL, '202.109.128.0', '202.109.191.255', 10, 10, 10, 10, 0),
(1199, 'China', '中国', '江西', NULL, '210.15.29.0', '210.15.29.255', 10, 10, 10, 10, 0),
(1200, 'China', '中国', '江西', NULL, '211.91.248.0', '211.92.1.255', 10, 10, 10, 10, 0),
(1201, 'China', '中国', '江西', NULL, '211.98.56.0', '211.98.56.255', 10, 10, 10, 10, 0),
(1202, 'China', '中国', '江西', NULL, '218.64.0.0', '218.64.23.255', 10, 10, 10, 10, 0),
(1203, 'China', '中国', '河北', NULL, '61.134.128.0', '61.134.191.255', 10, 10, 10, 10, 0),
(1204, 'China', '中国', '河北', NULL, '61.182.0.0', '61.182.255.255', 10, 10, 10, 10, 0),
(1205, 'China', '中国', '河北', NULL, '202.99.130.0', '202.99.191.255', 10, 10, 10, 10, 0),
(1206, 'China', '中国', '河北', NULL, '210.12.14.0', '210.12.14.255', 10, 10, 10, 10, 0),
(1207, 'China', '中国', '河北', NULL, '210.12.163.0', '210.12.163.255', 10, 10, 10, 10, 0),
(1208, 'China', '中国', '河北', NULL, '210.76.192.0', '210.76.199.255', 10, 10, 10, 10, 0),
(1209, 'China', '中国', '河北', NULL, '211.90.8.0', '211.90.45.255', 10, 10, 10, 10, 0),
(1210, 'China', '中国', '河北', NULL, '211.152.196.0', '211.152.196.255', 10, 10, 10, 10, 0),
(1211, 'China', '中国', '河北', NULL, '211.163.41.0', '211.163.41.255', 10, 10, 10, 10, 0),
(1212, 'China', '中国', '河北', NULL, '218.11.0.0', '218.12.255.255', 10, 10, 10, 10, 0),
(1213, 'China', '中国', '河南', NULL, '61.136.64.0', '61.136.127.255', 10, 10, 10, 10, 0),
(1214, 'China', '中国', '河南', NULL, '61.158.128.0', '61.158.194.255', 10, 10, 10, 10, 0),
(1215, 'China', '中国', '河南', NULL, '61.163.3.0', '61.163.3.255', 10, 10, 10, 10, 0),
(1216, 'China', '中国', '河南', NULL, '61.168.0.0', '61.168.255.255', 10, 10, 10, 10, 0),
(1217, 'China', '中国', '河南', NULL, '202.102.224.0', '202.102.255.255', 10, 10, 10, 10, 0),
(1218, 'China', '中国', '河南', NULL, '202.110.64.0', '202.110.127.255', 10, 10, 10, 10, 0),
(1219, 'China', '中国', '河南', NULL, '202.111.128.0', '202.111.159.255', 10, 10, 10, 10, 0),
(1220, 'China', '中国', '河南', NULL, '210.12.4.0', '210.12.4.255', 10, 10, 10, 10, 0),
(1221, 'China', '中国', '河南', NULL, '210.76.0.0', '210.76.31.255', 10, 10, 10, 10, 0),
(1222, 'China', '中国', '河南', NULL, '211.91.184.0', '211.91.211.255', 10, 10, 10, 10, 0),
(1223, 'China', '中国', '河南', NULL, '211.98.194.0', '211.98.194.255', 10, 10, 10, 10, 0),
(1224, 'China', '中国', '浙江', NULL, '61.130.0.0', '61.130.255.255', 10, 10, 10, 10, 0),
(1225, 'China', '中国', '浙江', NULL, '61.130.93.0', '61.130.254.255', 10, 10, 10, 10, 0),
(1226, 'China', '中国', '浙江', NULL, '61.153.0.0', '61.153.255.255', 10, 10, 10, 10, 0),
(1227, 'China', '中国', '浙江', NULL, '61.164.0.0', '61.164.255.255', 10, 10, 10, 10, 0),
(1228, 'China', '中国', '浙江', NULL, '61.174.0.0', '61.175.255.255', 10, 10, 10, 10, 0),
(1229, 'China', '中国', '浙江', NULL, '202.96.96.0', '202.96.127.255', 10, 10, 10, 10, 0),
(1230, 'China', '中国', '浙江', NULL, '202.101.160.0', '202.101.191.255', 10, 10, 10, 10, 0),
(1231, 'China', '中国', '浙江', NULL, '202.107.192.0', '202.107.255.255', 10, 10, 10, 10, 0),
(1232, 'China', '中国', '浙江', NULL, '203.93.240.0', '203.93.240.255', 10, 10, 10, 10, 0),
(1233, 'China', '中国', '浙江', NULL, '203.93.242.0', '203.93.242.255', 10, 10, 10, 10, 0),
(1234, 'China', '中国', '浙江', NULL, '210.15.8.0', '210.15.8.255', 10, 10, 10, 10, 0),
(1235, 'China', '中国', '浙江', NULL, '210.15.25.0', '210.15.25.255', 10, 10, 10, 10, 0),
(1236, 'China', '中国', '浙江', NULL, '210.25.112.0', '210.25.115.255', 10, 10, 10, 10, 0),
(1237, 'China', '中国', '浙江', NULL, '210.35.52.0', '210.35.63.255', 10, 10, 10, 10, 0),
(1238, 'China', '中国', '浙江', NULL, '210.81.110.0', '210.83.255.255', 10, 10, 10, 10, 0),
(1239, 'China', '中国', '浙江', NULL, '210.90.237.0', '210.90.237.255', 10, 10, 10, 10, 0),
(1240, 'China', '中国', '浙江', NULL, '210.140.12.0', '210.140.14.255', 10, 10, 10, 10, 0),
(1241, 'China', '中国', '浙江', NULL, '211.90.193.0', '211.91.41.255', 10, 10, 10, 10, 0);
INSERT INTO `locations` (`id`, `name`, `location_main`, `location_sub`, `flagpic`, `start_ip`, `end_ip`, `theory_upspeed`, `practical_upspeed`, `theory_downspeed`, `practical_downspeed`, `hit`) VALUES
(1242, 'China', '中国', '浙江', NULL, '211.138.120.0', '211.138.120.255', 10, 10, 10, 10, 0),
(1243, 'China', '中国', '浙江', NULL, '211.140.12.0', '211.140.15.255', 10, 10, 10, 10, 0),
(1244, 'China', '中国', '浙江', NULL, '211.163.113.0', '211.163.113.255', 10, 10, 10, 10, 0),
(1245, 'China', '中国', '浙江', NULL, '211.167.149.0', '211.167.149.255', 10, 10, 10, 10, 0),
(1246, 'China', '中国', '浙江', NULL, '211.167.149.0', '211.167.149.255', 10, 10, 10, 10, 0),
(1247, 'China', '中国', '浙江', NULL, '218.0.0.0', '218.0.255.255', 10, 10, 10, 10, 0),
(1248, 'China', '中国', '海南', NULL, '61.139.128.0', '61.139.191.255', 10, 10, 10, 10, 0),
(1249, 'China', '中国', '海南', NULL, '61.186.0.0', '61.186.128.255', 10, 10, 10, 10, 0),
(1250, 'China', '中国', '海南', NULL, '202.100.192.0', '202.100.223.255', 10, 10, 10, 10, 0),
(1251, 'China', '中国', '海南', NULL, '203.207.176.0', '203.207.176.255', 10, 10, 10, 10, 0),
(1252, 'China', '中国', '海南', NULL, '210.14.255.0', '210.14.255.255', 10, 10, 10, 10, 0),
(1253, 'China', '中国', '海南', NULL, '211.97.96.0', '211.97.103.255', 10, 10, 10, 10, 0),
(1254, 'China', '中国', '湖北', NULL, '61.136.141.0', '61.136.141.255', 10, 10, 10, 10, 0),
(1255, 'China', '中国', '湖北', NULL, '61.136.192.0', '61.136.255.255', 10, 10, 10, 10, 0),
(1256, 'China', '中国', '湖北', NULL, '61.183.0.0', '61.184.255.255', 10, 10, 10, 10, 0),
(1257, 'China', '中国', '湖北', NULL, '202.103.0.0', '202.103.63.255', 10, 10, 10, 10, 0),
(1258, 'China', '中国', '湖北', NULL, '202.110.128.0', '202.110.191.255', 10, 10, 10, 10, 0),
(1259, 'China', '中国', '湖北', NULL, '203.93.5.0', '203.93.6.255', 10, 10, 10, 10, 0),
(1260, 'China', '中国', '湖北', NULL, '203.93.112.30', '203.93.112.125', 10, 10, 10, 10, 0),
(1261, 'China', '中国', '湖北', NULL, '203.93.189.0', '203.93.189.255', 10, 10, 10, 10, 0),
(1262, 'China', '中国', '湖北', NULL, '203.207.170.0', '203.207.170.255', 10, 10, 10, 10, 0),
(1263, 'China', '中国', '湖北', NULL, '203.208.7.0', '203.208.7.255', 10, 10, 10, 10, 0),
(1264, 'China', '中国', '湖北', NULL, '210.12.16.0', '210.12.16.63', 10, 10, 10, 10, 0),
(1265, 'China', '中国', '湖北', NULL, '210.12.20.0', '210.12.20.255', 10, 10, 10, 10, 0),
(1266, 'China', '中国', '湖北', NULL, '210.12.58.0', '210.12.58.255', 10, 10, 10, 10, 0),
(1267, 'China', '中国', '湖北', NULL, '210.12.61.0', '210.12.61.255', 10, 10, 10, 10, 0),
(1268, 'China', '中国', '湖北', NULL, '210.72.20.0', '210.72.21.255', 10, 10, 10, 10, 0),
(1269, 'China', '中国', '湖北', NULL, '210.72.44.0', '210.72.44.255', 10, 10, 10, 10, 0),
(1270, 'China', '中国', '湖北', NULL, '210.74.126.0', '210.74.126.255', 10, 10, 10, 10, 0),
(1271, 'China', '中国', '湖北', NULL, '210.77.246.0', '210.77.246.255', 10, 10, 10, 10, 0),
(1272, 'China', '中国', '湖北', NULL, '211.91.120.0', '211.91.149.255', 10, 10, 10, 10, 0),
(1273, 'China', '中国', '湖北', NULL, '211.99.64.0', '211.99.64.255', 10, 10, 10, 10, 0),
(1274, 'China', '中国', '湖北', NULL, '211.137.56.0', '211.137.56.255', 10, 10, 10, 10, 0),
(1275, 'China', '中国', '湖北', NULL, '211.163.26.0', '211.163.26.255', 10, 10, 10, 10, 0),
(1276, 'China', '中国', '湖南', NULL, '61.137.0.0', '61.137.127.255', 10, 10, 10, 10, 0),
(1277, 'China', '中国', '湖南', NULL, '61.187.0.0', '61.187.255.255', 10, 10, 10, 10, 0),
(1278, 'China', '中国', '湖南', NULL, '202.103.64.0', '202.103.127.255', 10, 10, 10, 10, 0),
(1279, 'China', '中国', '湖南', NULL, '210.12.59.0', '210.12.59.255', 10, 10, 10, 10, 0),
(1280, 'China', '中国', '湖南', NULL, '210.12.63.0', '210.12.63.255', 10, 10, 10, 10, 0),
(1281, 'China', '中国', '湖南', NULL, '210.12.131.0', '210.12.131.255', 10, 10, 10, 10, 0),
(1282, 'China', '中国', '湖南', NULL, '211.91.216.0', '211.91.242.255', 10, 10, 10, 10, 0),
(1283, 'China', '中国', '湖南', NULL, '211.98.71.0', '211.98.76.255', 10, 10, 10, 10, 0),
(1284, 'China', '中国', '湖南', NULL, '211.98.74.0', '211.98.74.255', 10, 10, 10, 10, 0),
(1285, 'China', '中国', '澳门', NULL, '202.171.0.0', '202.175.255.255', 10, 10, 10, 10, 0),
(1286, 'China', '中国', '甘肃', NULL, '61.134.64.0', '61.134.95.255', 10, 10, 10, 10, 0),
(1287, 'China', '中国', '甘肃', NULL, '61.159.0.0', '61.159.255.255', 10, 10, 10, 10, 0),
(1288, 'China', '中国', '甘肃', NULL, '61.178.0.0', '61.178.255.255', 10, 10, 10, 10, 0),
(1289, 'China', '中国', '甘肃', NULL, '202.100.64.0', '202.100.95.255', 10, 10, 10, 10, 0),
(1290, 'China', '中国', '甘肃', NULL, '210.12.32.0', '210.12.32.255', 10, 10, 10, 10, 0),
(1291, 'China', '中国', '甘肃', NULL, '211.92.248.0', '211.92.251.255', 10, 10, 10, 10, 0),
(1292, 'China', '中国', '甘肃', NULL, '211.98.122.0', '211.98.127.255', 10, 10, 10, 10, 0),
(1293, 'China', '中国', '福建', NULL, '61.131.0.0', '61.131.127.255', 10, 10, 10, 10, 0),
(1294, 'China', '中国', '福建', NULL, '61.154.0.0', '61.154.255.255', 10, 10, 10, 10, 0),
(1295, 'China', '中国', '福建', NULL, '202.101.96.0', '202.101.159.255', 10, 10, 10, 10, 0),
(1296, 'China', '中国', '福建', NULL, '202.109.192.0', '202.109.255.255', 10, 10, 10, 10, 0),
(1297, 'China', '中国', '福建', NULL, '203.93.241.0', '203.93.241.255', 10, 10, 10, 10, 0),
(1298, 'China', '中国', '福建', NULL, '203.93.245.0', '203.93.247.255', 10, 10, 10, 10, 0),
(1299, 'China', '中国', '福建', NULL, '210.12.9.0', '210.12.9.255', 10, 10, 10, 10, 0),
(1300, 'China', '中国', '福建', NULL, '210.15.24.0', '210.15.24.255', 10, 10, 10, 10, 0),
(1301, 'China', '中国', '福建', NULL, '210.15.26.0', '210.15.26.255', 10, 10, 10, 10, 0),
(1302, 'China', '中国', '福建', NULL, '211.80.145.0', '211.80.209.255', 10, 10, 10, 10, 0),
(1303, 'China', '中国', '福建', NULL, '211.97.104.0', '211.97.161.255', 10, 10, 10, 10, 0),
(1304, 'China', '中国', '福建', NULL, '211.98.50.0', '211.98.52.255', 10, 10, 10, 10, 0),
(1305, 'China', '中国', '福建', NULL, '218.5.0.0', '218.6.127.255', 10, 10, 10, 10, 0),
(1306, 'China', '中国', '福建', NULL, '218.67.54.0', '218.67.115.255', 10, 10, 10, 10, 0),
(1307, 'China', '中国', '西安', NULL, '210.52.148.0', '210.52.148.255', 10, 10, 10, 10, 0),
(1308, 'China', '中国', '西藏', NULL, '202.98.224.0', '202.98.255.255', 10, 10, 10, 10, 0),
(1309, 'China', '中国', '西藏', NULL, '211.92.180.0', '211.92.183.255', 10, 10, 10, 10, 0),
(1310, 'China', '中国', '西藏', NULL, '211.163.31.0', '211.163.31.255', 10, 10, 10, 10, 0),
(1311, 'China', '中国', '贵州', NULL, '61.138.224.0', '61.138.255.255', 10, 10, 10, 10, 0),
(1312, 'China', '中国', '贵州', NULL, '61.189.146.0', '61.189.150.255', 10, 10, 10, 10, 0),
(1313, 'China', '中国', '贵州', NULL, '61.189.212.0', '61.189.213.255', 10, 10, 10, 10, 0),
(1314, 'China', '中国', '贵州', NULL, '202.98.192.0', '202.98.223.255', 10, 10, 10, 10, 0),
(1315, 'China', '中国', '贵州', NULL, '202.101.64.0', '202.101.95.255', 10, 10, 10, 10, 0),
(1316, 'China', '中国', '贵州', NULL, '210.14.250.0', '210.14.250.255', 10, 10, 10, 10, 0),
(1317, 'China', '中国', '贵州', NULL, '211.92.136.0', '211.92.139.255', 10, 10, 10, 10, 0),
(1318, 'China', '中国', '贵州', NULL, '211.103.59.0', '211.103.59.255', 10, 10, 10, 10, 0),
(1319, 'China', '中国', '辽宁', NULL, '61.137.128.0', '61.137.255.255', 10, 10, 10, 10, 0),
(1320, 'China', '中国', '辽宁', NULL, '61.176.0.0', '61.176.255.255', 10, 10, 10, 10, 0),
(1321, 'China', '中国', '辽宁', NULL, '61.189.112.0', '61.189.118.255', 10, 10, 10, 10, 0),
(1322, 'China', '中国', '辽宁', NULL, '168.160.121.0', '168.160.122.255', 10, 10, 10, 10, 0),
(1323, 'China', '中国', '辽宁', NULL, '202.38.173.0', '202.38.173.255', 10, 10, 10, 10, 0),
(1324, 'China', '中国', '辽宁', NULL, '202.93.110.0', '202.93.110.255', 10, 10, 10, 10, 0),
(1325, 'China', '中国', '辽宁', NULL, '202.96.64.0', '202.96.95.255', 10, 10, 10, 10, 0),
(1326, 'China', '中国', '辽宁', NULL, '202.97.160.0', '202.97.191.255', 10, 10, 10, 10, 0),
(1327, 'China', '中国', '辽宁', NULL, '202.107.6.0', '202.107.100.255', 10, 10, 10, 10, 0),
(1328, 'China', '中国', '辽宁', NULL, '202.110.0.0', '202.110.63.255', 10, 10, 10, 10, 0),
(1329, 'China', '中国', '辽宁', NULL, '203.93.110.0', '203.93.110.255', 10, 10, 10, 10, 0),
(1330, 'China', '中国', '辽宁', NULL, '203.93.111.95', '203.93.111.126', 10, 10, 10, 10, 0),
(1331, 'China', '中国', '辽宁', NULL, '203.93.153.0', '203.93.153.255', 10, 10, 10, 10, 0),
(1332, 'China', '中国', '辽宁', NULL, '203.93.195.0', '203.93.195.255', 10, 10, 10, 10, 0),
(1333, 'China', '中国', '辽宁', NULL, '203.93.204.0', '203.93.204.255', 10, 10, 10, 10, 0),
(1334, 'China', '中国', '辽宁', NULL, '203.207.121.0', '203.207.121.255', 10, 10, 10, 10, 0),
(1335, 'China', '中国', '辽宁', NULL, '210.12.24.0', '210.12.24.255', 10, 10, 10, 10, 0),
(1336, 'China', '中国', '辽宁', NULL, '210.12.34.0', '210.12.34.255', 10, 10, 10, 10, 0),
(1337, 'China', '中国', '辽宁', NULL, '210.12.71.0', '210.12.71.255', 10, 10, 10, 10, 0),
(1338, 'China', '中国', '辽宁', NULL, '210.12.124.0', '210.12.124.255', 10, 10, 10, 10, 0),
(1339, 'China', '中国', '辽宁', NULL, '210.12.126.0', '210.12.128.255', 10, 10, 10, 10, 0),
(1340, 'China', '中国', '辽宁', NULL, '210.73.44.0', '210.73.46.255', 10, 10, 10, 10, 0),
(1341, 'China', '中国', '辽宁', NULL, '210.76.160.0', '210.76.191.255', 10, 10, 10, 10, 0),
(1342, 'China', '中国', '辽宁', NULL, '211.93.80.0', '211.93.126.255', 10, 10, 10, 10, 0),
(1343, 'China', '中国', '辽宁', NULL, '211.163.1.0', '211.163.1.255', 10, 10, 10, 10, 0),
(1344, 'China', '中国', '辽宁', NULL, '218.24.0.0', '218.24.129.255', 10, 10, 10, 10, 0),
(1345, 'China', '中国', '辽宁', NULL, '218.60.0.0', '218.60.79.255', 10, 10, 10, 10, 0),
(1346, 'China', '中国', '重庆', NULL, '61.128.128.0', '61.128.255.255', 10, 10, 10, 10, 0),
(1347, 'China', '中国', '重庆', NULL, '61.186.129.0', '61.186.255.255', 10, 10, 10, 10, 0),
(1348, 'China', '中国', '重庆', NULL, '202.98.32.0', '202.98.63.255', 10, 10, 10, 10, 0),
(1349, 'China', '中国', '重庆', NULL, '203.93.111.159', '203.93.111.190', 10, 10, 10, 10, 0),
(1350, 'China', '中国', '重庆', NULL, '203.93.221.0', '203.93.221.255', 10, 10, 10, 10, 0),
(1351, 'China', '中国', '重庆', NULL, '203.207.190.0', '203.207.190.255', 10, 10, 10, 10, 0),
(1352, 'China', '中国', '重庆', NULL, '203.208.3.0', '203.208.0O3.255', 10, 10, 10, 10, 0),
(1353, 'China', '中国', '重庆', NULL, '210.74.123.0', '210.74.123.255', 10, 10, 10, 10, 0),
(1354, 'China', '中国', '重庆', NULL, '210.77.161.0', '210.77.161.255', 10, 10, 10, 10, 0),
(1355, 'China', '中国', '重庆', NULL, '210.77.169.0', '210.77.169.255', 10, 10, 10, 10, 0),
(1356, 'China', '中国', '重庆', NULL, '211.92.8.0', '211.92.27.255', 10, 10, 10, 10, 0),
(1357, 'China', '中国', '重庆', NULL, '211.139.30.0', '211.139.40.255', 10, 10, 10, 10, 0),
(1358, 'China', '中国', '重庆', NULL, '211.158.1.0', '211.158.3.255', 10, 10, 10, 10, 0),
(1359, 'China', '中国', '重庆', NULL, '218.70.64.0', '218.70.64.255', 10, 10, 10, 10, 0),
(1360, 'China', '中国', '陕西', NULL, '61.134.0.0', '61.134.63.255', 10, 10, 10, 10, 0),
(1361, 'China', '中国', '陕西', NULL, '61.185.16.0', '61.185.255.255', 10, 10, 10, 10, 0),
(1362, 'China', '中国', '陕西', NULL, '202.97.30.0', '202.97.30.255', 10, 10, 10, 10, 0),
(1363, 'China', '中国', '陕西', NULL, '202.100.0.0', '202.100.63.255', 10, 10, 10, 10, 0),
(1364, 'China', '中国', '陕西', NULL, '202.130.26.0', '202.130.26.255', 10, 10, 10, 10, 0),
(1365, 'China', '中国', '陕西', NULL, '202.130.33.0', '202.130.33.255', 10, 10, 10, 10, 0),
(1366, 'China', '中国', '陕西', NULL, '203.93.41.0', '203.93.41.255', 10, 10, 10, 10, 0),
(1367, 'China', '中国', '陕西', NULL, '210.12.23.0', '210.12.23.255', 10, 10, 10, 10, 0),
(1368, 'China', '中国', '陕西', NULL, '210.77.253.0', '210.77.253.255', 10, 10, 10, 10, 0),
(1369, 'China', '中国', '陕西', NULL, '211.92.184.0', '211.92.223.255', 10, 10, 10, 10, 0),
(1370, 'China', '中国', '陕西', NULL, '211.98.100.0', '211.98.100.255', 10, 10, 10, 10, 0),
(1371, 'China', '中国', '陕西', NULL, '211.164.152.0', '211.164.152.255', 10, 10, 10, 10, 0),
(1372, 'China', '中国', '青海', NULL, '61.133.224.0', '61.133.255.255', 10, 10, 10, 10, 0),
(1373, 'China', '中国', '青海', NULL, '202.100.128.0', '202.100.159.255', 10, 10, 10, 10, 0),
(1374, 'China', '中国', '青海', NULL, '211.93.8.0', '211.93.11.255', 10, 10, 10, 10, 0),
(1375, 'China', '中国', '青海', NULL, '211.163.128.0', '211.163.128.255', 10, 10, 10, 10, 0),
(1376, 'China', '中国', '香港', NULL, '61.10.200.0', '61.10.220.255', 10, 10, 10, 10, 0),
(1377, 'China', '中国', '香港', NULL, '61.18.0.0', '61.18.235.255', 10, 10, 10, 10, 0),
(1378, 'China', '中国', '香港', NULL, '137.189.0.0', '137.189.255.255', 10, 10, 10, 10, 0),
(1379, 'China', '中国', '香港', NULL, '143.89.0.0', '143.89.255.255', 10, 10, 10, 10, 0),
(1380, 'China', '中国', '香港', NULL, '144.214.0.0', '144.214.255.255', 10, 10, 10, 10, 0),
(1381, 'China', '中国', '香港', NULL, '147.8.0.0', '147.8.255.255', 10, 10, 10, 10, 0),
(1382, 'China', '中国', '香港', NULL, '158.132.0.0', '158.182.255.255', 10, 10, 10, 10, 0),
(1383, 'China', '中国', '香港', NULL, '161.64.0.0', '161.64.255.255', 10, 10, 10, 10, 0),
(1384, 'China', '中国', '香港', NULL, '167.216.0.0', '167.216.255.255', 10, 10, 10, 10, 0),
(1385, 'China', '中国', '香港', NULL, '168.70.0.0', '168.70.255.255', 10, 10, 10, 10, 0),
(1386, 'China', '中国', '香港', NULL, '192.203.232.0', '192.245.208.255', 10, 10, 10, 10, 0),
(1387, 'China', '中国', '香港', NULL, '198.112.169.0', '198.112.169.255', 10, 10, 10, 10, 0),
(1388, 'China', '中国', '香港', NULL, '202.0.77.0', '202.0.78.255', 10, 10, 10, 10, 0),
(1389, 'China', '中国', '香港', NULL, '202.0.100.0', '202.0.100.255', 10, 10, 10, 10, 0),
(1390, 'China', '中国', '香港', NULL, '202.0.104.0', '202.0.104.255', 10, 10, 10, 10, 0),
(1391, 'China', '中国', '香港', NULL, '202.0.112.0', '202.0.112.255', 10, 10, 10, 10, 0),
(1392, 'China', '中国', '香港', NULL, '202.0.122.0', '202.0.123.255', 10, 10, 10, 10, 0),
(1393, 'China', '中国', '香港', NULL, '202.0.128.0', '202.0.147.255', 10, 10, 10, 10, 0),
(1394, 'China', '中国', '香港', NULL, '202.0.160.0', '202.0.183.255', 10, 10, 10, 10, 0),
(1395, 'China', '中国', '香港', NULL, '202.1.6.0', '202.1.7.255', 10, 10, 10, 10, 0),
(1396, 'China', '中国', '香港', NULL, '202.2.32.0', '202.2.51.255', 10, 10, 10, 10, 0),
(1397, 'China', '中国', '香港', NULL, '202.2.64.0', '202.2.95.255', 10, 10, 10, 10, 0),
(1398, 'China', '中国', '香港', NULL, '202.4.159.0', '202.4.223.255', 10, 10, 10, 10, 0),
(1399, 'China', '中国', '香港', NULL, '202.7.128.0', '202.7.159.255', 10, 10, 10, 10, 0),
(1400, 'China', '中国', '香港', NULL, '202.12.4.0', '202.12.7.255', 10, 10, 10, 10, 0),
(1401, 'China', '中国', '香港', NULL, '202.14.67.0', '202.14.68.255', 10, 10, 10, 10, 0),
(1402, 'China', '中国', '香港', NULL, '202.14.80.0', '202.14.80.255', 10, 10, 10, 10, 0),
(1403, 'China', '中国', '香港', NULL, '202.14.222.0', '202.14.222.255', 10, 10, 10, 10, 0),
(1404, 'China', '中国', '香港', NULL, '202.20.66.0', '202.20.66.255', 10, 10, 10, 10, 0),
(1405, 'China', '中国', '香港', NULL, '202.20.88.0', '202.20.89.255', 10, 10, 10, 10, 0),
(1406, 'China', '中国', '香港', NULL, '202.20.94.0', '202.20.95.255', 10, 10, 10, 10, 0),
(1407, 'China', '中国', '香港', NULL, '202.20.98.0', '202.20.98.255', 10, 10, 10, 10, 0),
(1408, 'China', '中国', '香港', NULL, '202.20.100.0', '202.20.101.255', 10, 10, 10, 10, 0),
(1409, 'China', '中国', '香港', NULL, '202.20.111.0', '202.20.111.255', 10, 10, 10, 10, 0),
(1410, 'China', '中国', '香港', NULL, '202.20.117.0', '202.20.118.255', 10, 10, 10, 10, 0),
(1411, 'China', '中国', '香港', NULL, '202.20.125.0', '202.20.127.255', 10, 10, 10, 10, 0),
(1412, 'China', '中国', '香港', NULL, '202.21.128.0', '202.21.128.255', 10, 10, 10, 10, 0),
(1413, 'China', '中国', '香港', NULL, '202.40.0.0', '202.40.255.255', 10, 10, 10, 10, 0),
(1414, 'China', '中国', '香港', NULL, '202.45.0.0', '202.45.255.255', 10, 10, 10, 10, 0),
(1415, 'China', '中国', '香港', NULL, '202.52.128.0', '202.52.159.255', 10, 10, 10, 10, 0),
(1416, 'China', '中国', '香港', NULL, '202.53.128.0', '202.53.159.255', 10, 10, 10, 10, 0),
(1417, 'China', '中国', '香港', NULL, '202.57.224.0', '202.57.255.255', 10, 10, 10, 10, 0),
(1418, 'China', '中国', '香港', NULL, '202.60.224.0', '202.60.255.255', 10, 10, 10, 10, 0),
(1419, 'China', '中国', '香港', NULL, '202.63.0.0', '202.63.31.255', 10, 10, 10, 10, 0),
(1420, 'China', '中国', '香港', NULL, '202.63.128.0', '202.63.159.255', 10, 10, 10, 10, 0),
(1421, 'China', '中国', '香港', NULL, '202.64.0.0', '202.65.31.255', 10, 10, 10, 10, 0),
(1422, 'China', '中国', '香港', NULL, '202.65.224.0', '202.74.31.255', 10, 10, 10, 10, 0),
(1423, 'China', '中国', '香港', NULL, '202.74.224.0', '202.75.95.255', 10, 10, 10, 10, 0),
(1424, 'China', '中国', '香港', NULL, '202.75.224.0', '202.76.127.255', 10, 10, 10, 10, 0),
(1425, 'China', '中国', '香港', NULL, '202.76.224.0', '202.78.31.255', 10, 10, 10, 10, 0),
(1426, 'China', '中国', '香港', NULL, '202.78.224.0', '202.79.31.255', 10, 10, 10, 10, 0),
(1427, 'China', '中国', '香港', NULL, '202.79.224.0', '202.80.31.255', 10, 10, 10, 10, 0),
(1428, 'China', '中国', '香港', NULL, '202.81.0.0', '202.89.255.255', 10, 10, 10, 10, 0),
(1429, 'China', '中国', '香港', NULL, '202.130.64.0', '202.130.159.255', 10, 10, 10, 10, 0),
(1430, 'China', '中国', '香港', NULL, '202.140.96.0', '202.140.127.255', 10, 10, 10, 10, 0),
(1431, 'China', '中国', '香港', NULL, '202.144.224.0', '202.144.255.255', 10, 10, 10, 10, 0),
(1432, 'China', '中国', '香港', NULL, '202.146.96.0', '202.146.127.255', 10, 10, 10, 10, 0),
(1433, 'China', '中国', '香港', NULL, '202.161.224.0', '202.161.255.255', 10, 10, 10, 10, 0),
(1434, 'China', '中国', '香港', NULL, '202.163.0.0', '202.163.31.255', 10, 10, 10, 10, 0),
(1435, 'China', '中国', '香港', NULL, '202.169.0.0', '202.169.31.255', 10, 10, 10, 10, 0),
(1436, 'China', '中国', '香港', NULL, '202.170.0.0', '202.170.31.255', 10, 10, 10, 10, 0),
(1437, 'China', '中国', '香港', NULL, '202.177.0.0', '202.177.31.255', 10, 10, 10, 10, 0),
(1438, 'China', '中国', '香港', NULL, '202.181.224.0', '202.181.255.255', 10, 10, 10, 10, 0),
(1439, 'China', '中国', '香港', NULL, '202.182.224.0', '202.182.255.255', 10, 10, 10, 10, 0),
(1440, 'China', '中国', '香港', NULL, '203.80.0.0', '203.86.255.255', 10, 10, 10, 10, 0),
(1441, 'China', '中国', '香港', NULL, '203.90.224.0', '203.90.255.255', 10, 10, 10, 10, 0),
(1442, 'China', '中国', '香港', NULL, '203.105.0.0', '203.105.63.255', 10, 10, 10, 10, 0),
(1443, 'China', '中国', '香港', NULL, '203.131.224.0', '203.131.255.255', 10, 10, 10, 10, 0),
(1444, 'China', '中国', '香港', NULL, '203.184.192.0', '203.185.63.255', 10, 10, 10, 10, 0),
(1445, 'China', '中国', '香港', NULL, '203.186.0.0', '203.186.95.255', 10, 10, 10, 10, 0),
(1446, 'China', '中国', '香港', NULL, '203.198.0.0', '203.198.31.255', 10, 10, 10, 10, 0),
(1447, 'China', '中国', '香港', NULL, '205.252.144.0', '205.252.144.255', 10, 10, 10, 10, 0),
(1448, 'China', '中国', '香港', NULL, '206.220.224.0', '206.220.227.255', 10, 10, 10, 10, 0),
(1449, 'China', '中国', '香港', NULL, '207.176.113.0', '207.176.113.255', 10, 10, 10, 10, 0),
(1450, 'China', '中国', '香港', NULL, '208.139.98.0', '208.139.98.255', 10, 10, 10, 10, 0),
(1451, 'China', '中国', '香港', NULL, '208.151.79.0', '208.151.79.255', 10, 10, 10, 10, 0),
(1452, 'China', '中国', '香港', NULL, '210.87.248.0', '210.87.255.255', 10, 10, 10, 10, 0),
(1453, 'China', '中国', '香港', NULL, '210.176.0.0', '210.176.255.255', 10, 10, 10, 10, 0),
(1454, 'China', '中国', '黑龙江', NULL, '61.138.0.0', '61.138.63.255', 10, 10, 10, 10, 0),
(1455, 'China', '中国', '黑龙江', NULL, '61.158.0.0', '61.158.63.255', 10, 10, 10, 10, 0),
(1456, 'China', '中国', '黑龙江', NULL, '61.167.0.0', '61.167.255.255', 10, 10, 10, 10, 0),
(1457, 'China', '中国', '黑龙江', NULL, '61.180.129.0', '61.180.255.255', 10, 10, 10, 10, 0),
(1458, 'China', '中国', '黑龙江', NULL, '202.97.192.0', '202.97.255.255', 10, 10, 10, 10, 0),
(1459, 'China', '中国', '黑龙江', NULL, '202.130.29.0', '202.130.29.255', 10, 10, 10, 10, 0),
(1460, 'China', '中国', '黑龙江', NULL, '210.12.30.0', '210.12.30.255', 10, 10, 10, 10, 0),
(1461, 'China', '中国', '黑龙江', NULL, '210.12.41.0', '210.12.41.255', 10, 10, 10, 10, 0),
(1462, 'China', '中国', '黑龙江', NULL, '210.12.43.0', '210.12.43.255', 10, 10, 10, 10, 0),
(1463, 'China', '中国', '黑龙江', NULL, '210.12.106.0', '210.12.109.255', 10, 10, 10, 10, 0),
(1464, 'China', '中国', '黑龙江', NULL, '210.12.115.0', '210.12.115.255', 10, 10, 10, 10, 0),
(1465, 'China', '中国', '黑龙江', NULL, '210.74.99.0', '210.74.120.255', 10, 10, 10, 10, 0),
(1466, 'China', '中国', '黑龙江', NULL, '210.76.32.0', '210.76.63.255', 10, 10, 10, 10, 0),
(1467, 'China', '中国', '黑龙江', NULL, '211.93.24.0', '211.93.56.255', 10, 10, 10, 10, 0),
(1468, 'China', '中国', '黑龙江', NULL, '211.98.90.0', '211.98.90.255', 10, 10, 10, 10, 0),
(1469, 'China', '中国', '黑龙江', NULL, '211.152.194.0', '211.152.195.255', 10, 10, 10, 10, 0),
(1470, 'China', '中国', '黑龙江', NULL, '211.154.48.0', '211.154.48.255', 10, 10, 10, 10, 0),
(1471, 'China', '中国', '黑龙江', NULL, '211.163.9.0', '211.163.11.255', 10, 10, 10, 10, 0),
(1472, 'China', '中国', '黑龙江', NULL, '218.7.1.0', '218.10.255.255', 10, 10, 10, 10, 0),
(1473, 'Asia', '亚洲', '不丹', NULL, '202.144.128.0', '202.144.159.255', 10, 10, 10, 10, 0),
(1474, 'Asia', '亚洲', '中国', NULL, '61.128.0.0', '61.159.255.255', 10, 10, 10, 10, 0),
(1475, 'Asia', '亚洲', '中国', NULL, '159.226.0.0', '159.226.255.255', 10, 10, 10, 10, 0),
(1476, 'Asia', '亚洲', '中国', NULL, '161.207.0.0', '161.207.255.255', 10, 10, 10, 10, 0),
(1477, 'Asia', '亚洲', '中国', NULL, '168.160.0.0', '168.160.255.255', 10, 10, 10, 10, 0),
(1478, 'Asia', '亚洲', '中国', NULL, '192.188.170.0', '192.188.170.255', 10, 10, 10, 10, 0),
(1479, 'Asia', '亚洲', '中国', NULL, '202.0.110.0', '202.0.110.255', 10, 10, 10, 10, 0),
(1480, 'Asia', '亚洲', '中国', NULL, '202.14.235.0', '202.14.238.255', 10, 10, 10, 10, 0),
(1481, 'Asia', '亚洲', '中国', NULL, '202.38.0.0', '202.38.255.255', 10, 10, 10, 10, 0),
(1482, 'Asia', '亚洲', '中国', NULL, '202.95.252.0', '202.95.255.255', 10, 10, 10, 10, 0),
(1483, 'Asia', '亚洲', '中国', NULL, '202.130.0.0', '202.130.31.255', 10, 10, 10, 10, 0),
(1484, 'Asia', '亚洲', '中国', NULL, '202.130.224.0', '202.130.255.255', 10, 10, 10, 10, 0),
(1485, 'Asia', '亚洲', '中国', NULL, '202.136.252.0', '202.136.255.255', 10, 10, 10, 10, 0),
(1486, 'Asia', '亚洲', '中国', NULL, '203.87.224.0', '203.88.63.255', 10, 10, 10, 10, 0),
(1487, 'Asia', '亚洲', '中国', NULL, '203.89.0.0', '203.89.63.255', 10, 10, 10, 10, 0),
(1488, 'Asia', '亚洲', '中国', NULL, '203.90.0.0', '203.90.63.255', 10, 10, 10, 10, 0),
(1489, 'Asia', '亚洲', '中国', NULL, '203.91.0.0', '203.91.63.255', 10, 10, 10, 10, 0),
(1490, 'Asia', '亚洲', '中国', NULL, '203.92.0.0', '203.92.63.255', 10, 10, 10, 10, 0),
(1491, 'Asia', '亚洲', '中国', NULL, '203.93.0.0', '203.93.255.255', 10, 10, 10, 10, 0),
(1492, 'Asia', '亚洲', '中国', NULL, '203.94.0.0', '203.94.63.255', 10, 10, 10, 10, 0),
(1493, 'Asia', '亚洲', '中国', NULL, '203.95.0.0', '203.95.63.255', 10, 10, 10, 10, 0),
(1494, 'Asia', '亚洲', '中国', NULL, '203.184.0.0', '203.184.31.255', 10, 10, 10, 10, 0),
(1495, 'Asia', '亚洲', '中国', NULL, '203.192.0.0', '203.196.255.255', 10, 10, 10, 10, 0),
(1496, 'Asia', '亚洲', '中国', NULL, '203.204.0.0', '203.208.255.255', 10, 10, 10, 10, 0),
(1497, 'Asia', '亚洲', '中国', NULL, '203.207.64.0', '203.207.79.255', 10, 10, 10, 10, 0),
(1498, 'Asia', '亚洲', '中国', NULL, '203.223.0.0', '203.223.255.255', 10, 10, 10, 10, 0),
(1499, 'Asia', '亚洲', '中国', NULL, '210.12.0.0', '210.12.179.255', 10, 10, 10, 10, 0),
(1500, 'Asia', '亚洲', '中国', NULL, '210.12.29.0', '210.12.29.255', 10, 10, 10, 10, 0),
(1501, 'Asia', '亚洲', '中国', NULL, '210.14.224.0', '210.14.255.255', 10, 10, 10, 10, 0),
(1502, 'Asia', '亚洲', '中国', NULL, '210.21.0.0', '210.22.255.255', 10, 10, 10, 10, 0),
(1503, 'Asia', '亚洲', '中国', NULL, '210.25.0.0', '210.25.3.255', 10, 10, 10, 10, 0),
(1504, 'Asia', '亚洲', '中国', NULL, '210.51.0.0', '210.53.255.255', 10, 10, 10, 10, 0),
(1505, 'Asia', '亚洲', '中国', NULL, '210.52.128.0', '210.52.255.255', 10, 10, 10, 10, 0),
(1506, 'Asia', '亚洲', '中国', NULL, '210.72.0.0', '210.72.127.255', 10, 10, 10, 10, 0),
(1507, 'Asia', '亚洲', '中国', NULL, '210.73.0.0', '210.73.31.255', 10, 10, 10, 10, 0),
(1508, 'Asia', '亚洲', '中国', NULL, '211.136.0.0', '211.141.255.255', 10, 10, 10, 10, 0),
(1509, 'Asia', '亚洲', '中国', NULL, '211.161.0.0', '211.162.255.255', 10, 10, 10, 10, 0),
(1510, 'Asia', '亚洲', '乌克兰', NULL, '193.193.193.0', '193.193.199.255', 10, 10, 10, 10, 0),
(1511, 'Asia', '亚洲', '乌兹别克斯坦', NULL, '212.110.233.0', '212.110.233.255', 10, 10, 10, 10, 0),
(1512, 'Asia', '亚洲', '亚洲', NULL, '61.0.0.0', '61.255.255.255', 10, 10, 10, 10, 0),
(1513, 'Asia', '亚洲', '亚洲', NULL, '210.0.0.0', '210.255.255.255', 10, 10, 10, 10, 0),
(1514, 'Asia', '亚洲', '以色列', NULL, '192.114.0.0', '192.118.255.255', 10, 10, 10, 10, 0),
(1515, 'Asia', '亚洲', '南朝鲜', NULL, '202.6.95.0', '202.6.95.255', 10, 10, 10, 10, 0),
(1516, 'Asia', '亚洲', '南朝鲜', NULL, '202.14.165.0', '202.14.165.255', 10, 10, 10, 10, 0),
(1517, 'Asia', '亚洲', '南朝鲜', NULL, '202.20.82.0', '202.20.86.255', 10, 10, 10, 10, 0),
(1518, 'Asia', '亚洲', '南朝鲜', NULL, '202.20.99.0', '202.20.99.255', 10, 10, 10, 10, 0),
(1519, 'Asia', '亚洲', '南朝鲜', NULL, '202.20.119.0', '202.20.119.255', 10, 10, 10, 10, 0),
(1520, 'Asia', '亚洲', '南朝鲜', NULL, '202.20.128.0', '202.21.7.255', 10, 10, 10, 10, 0),
(1521, 'Asia', '亚洲', '南朝鲜', NULL, '202.30.0.0', '202.31.255.255', 10, 10, 10, 10, 0),
(1522, 'Asia', '亚洲', '南朝鲜', NULL, '210.90.0.0', '210.127.255.255', 10, 10, 10, 10, 0),
(1523, 'Asia', '亚洲', '南朝鲜', NULL, '210.204.0.0', '210.207.255.255', 10, 10, 10, 10, 0),
(1524, 'Asia', '亚洲', '南朝鲜', NULL, '210.216.0.0', '210.223.255.255', 10, 10, 10, 10, 0),
(1525, 'Asia', '亚洲', '印度', NULL, '128.210.0.0', '128.211.255.255', 10, 10, 10, 10, 0),
(1526, 'Asia', '亚洲', '印度', NULL, '202.9.128.0', '202.9.159.255', 10, 10, 10, 10, 0),
(1527, 'Asia', '亚洲', '印度', NULL, '202.21.147.0', '202.21.147.255', 10, 10, 10, 10, 0),
(1528, 'Asia', '亚洲', '印度', NULL, '202.41.0.0', '202.41.255.255', 10, 10, 10, 10, 0),
(1529, 'Asia', '亚洲', '印度', NULL, '202.43.32.0', '202.43.63.255', 10, 10, 10, 10, 0),
(1530, 'Asia', '亚洲', '印度', NULL, '202.51.32.0', '202.51.63.255', 10, 10, 10, 10, 0),
(1531, 'Asia', '亚洲', '印度', NULL, '202.54.0.0', '202.56.31.255', 10, 10, 10, 10, 0),
(1532, 'Asia', '亚洲', '印度', NULL, '202.56.224.0', '202.57.31.255', 10, 10, 10, 10, 0),
(1533, 'Asia', '亚洲', '印度', NULL, '202.60.128.0', '202.60.159.255', 10, 10, 10, 10, 0),
(1534, 'Asia', '亚洲', '印度', NULL, '202.63.96.0', '202.63.127.255', 10, 10, 10, 10, 0),
(1535, 'Asia', '亚洲', '印度', NULL, '202.65.128.0', '202.65.159.255', 10, 10, 10, 10, 0),
(1536, 'Asia', '亚洲', '印度', NULL, '202.134.128.0', '202.134.159.255', 10, 10, 10, 10, 0),
(1537, 'Asia', '亚洲', '印度', NULL, '202.140.128.0', '202.140.159.255', 10, 10, 10, 10, 0),
(1538, 'Asia', '亚洲', '印度', NULL, '202.141.0.0', '202.143.31.255', 10, 10, 10, 10, 0),
(1539, 'Asia', '亚洲', '印度', NULL, '202.144.0.0', '202.144.63.255', 10, 10, 10, 10, 0),
(1540, 'Asia', '亚洲', '印度', NULL, '202.144.160.0', '202.144.191.255', 10, 10, 10, 10, 0),
(1541, 'Asia', '亚洲', '印度', NULL, '202.162.128.0', '202.162.255.255', 10, 10, 10, 10, 0),
(1542, 'Asia', '亚洲', '印度', NULL, '202.164.96.0', '202.164.127.255', 10, 10, 10, 10, 0),
(1543, 'Asia', '亚洲', '印度', NULL, '202.169.64.0', '202.169.159.255', 10, 10, 10, 10, 0),
(1544, 'Asia', '亚洲', '印度', NULL, '202.170.128.0', '202.170.159.255', 10, 10, 10, 10, 0),
(1545, 'Asia', '亚洲', '印度', NULL, '202.177.128.0', '202.177.255.255', 10, 10, 10, 10, 0),
(1546, 'Asia', '亚洲', '印度', NULL, '202.179.64.0', '202.179.95.255', 10, 10, 10, 10, 0),
(1547, 'Asia', '亚洲', '印度', NULL, '203.94.224.0', '203.94.255.255', 10, 10, 10, 10, 0),
(1548, 'Asia', '亚洲', '印度', NULL, '203.112.128.0', '203.112.159.255', 10, 10, 10, 10, 0),
(1549, 'Asia', '亚洲', '印度', NULL, '203.129.224.0', '203.129.255.255', 10, 10, 10, 10, 0),
(1550, 'Asia', '亚洲', '印度', NULL, '203.197.0.0', '203.197.255.255', 10, 10, 10, 10, 0),
(1551, 'Asia', '亚洲', '印度', NULL, '210.212.0.0', '210.212.255.255', 10, 10, 10, 10, 0),
(1552, 'Asia', '亚洲', '印度尼西亚', NULL, '192.188.175.0', '192.188.175.255', 10, 10, 10, 10, 0),
(1553, 'Asia', '亚洲', '印度尼西亚', NULL, '202.0.81.0', '202.0.81.255', 10, 10, 10, 10, 0),
(1554, 'Asia', '亚洲', '印度尼西亚', NULL, '202.0.103.0', '202.0.103.255', 10, 10, 10, 10, 0),
(1555, 'Asia', '亚洲', '印度尼西亚', NULL, '202.0.116.0', '202.0.116.255', 10, 10, 10, 10, 0),
(1556, 'Asia', '亚洲', '印度尼西亚', NULL, '202.3.96.0', '202.3.127.255', 10, 10, 10, 10, 0),
(1557, 'Asia', '亚洲', '印度尼西亚', NULL, '202.20.106.0', '202.20.109.255', 10, 10, 10, 10, 0),
(1558, 'Asia', '亚洲', '印度尼西亚', NULL, '202.43.224.0', '202.43.255.255', 10, 10, 10, 10, 0),
(1559, 'Asia', '亚洲', '印度尼西亚', NULL, '202.46.0.0', '202.46.31.255', 10, 10, 10, 10, 0),
(1560, 'Asia', '亚洲', '印度尼西亚', NULL, '202.46.64.0', '202.46.255.255', 10, 10, 10, 10, 0),
(1561, 'Asia', '亚洲', '印度尼西亚', NULL, '202.51.192.0', '202.51.255.255', 10, 10, 10, 10, 0),
(1562, 'Asia', '亚洲', '印度尼西亚', NULL, '202.53.224.0', '202.53.255.255', 10, 10, 10, 10, 0),
(1563, 'Asia', '亚洲', '印度尼西亚', NULL, '202.137.0.0', '202.137.31.255', 10, 10, 10, 10, 0),
(1564, 'Asia', '亚洲', '印度尼西亚', NULL, '202.138.224.0', '202.138.255.255', 10, 10, 10, 10, 0),
(1565, 'Asia', '亚洲', '印度尼西亚', NULL, '202.145.0.0', '202.145.31.255', 10, 10, 10, 10, 0),
(1566, 'Asia', '亚洲', '印度尼西亚', NULL, '202.146.0.0', '202.146.31.255', 10, 10, 10, 10, 0),
(1567, 'Asia', '亚洲', '印度尼西亚', NULL, '202.146.128.0', '202.146.255.255', 10, 10, 10, 10, 0),
(1568, 'Asia', '亚洲', '印度尼西亚', NULL, '202.147.224.0', '202.148.31.255', 10, 10, 10, 10, 0),
(1569, 'Asia', '亚洲', '印度尼西亚', NULL, '202.149.1.0', '202.152.255.255', 10, 10, 10, 10, 0),
(1570, 'Asia', '亚洲', '印度尼西亚', NULL, '202.154.0.0', '202.159.255.255', 10, 10, 10, 10, 0),
(1571, 'Asia', '亚洲', '印度尼西亚', NULL, '202.164.0.0', '202.164.31.255', 10, 10, 10, 10, 0),
(1572, 'Asia', '亚洲', '印度尼西亚', NULL, '202.170.224.0', '202.170.255.255', 10, 10, 10, 10, 0),
(1573, 'Asia', '亚洲', '印度尼西亚', NULL, '202.180.0.0', '202.180.31.255', 10, 10, 10, 10, 0),
(1574, 'Asia', '亚洲', '印度尼西亚', NULL, '202.183.0.0', '202.183.31.255', 10, 10, 10, 10, 0),
(1575, 'Asia', '亚洲', '印度尼西亚', NULL, '203.77.224.0', '203.77.255.255', 10, 10, 10, 10, 0),
(1576, 'Asia', '亚洲', '印度尼西亚', NULL, '203.109.0.0', '203.109.31.255', 10, 10, 10, 10, 0),
(1577, 'Asia', '亚洲', '印度尼西亚', NULL, '203.130.192.0', '203.130.255.255', 10, 10, 10, 10, 0),
(1578, 'Asia', '亚洲', '印度尼西亚', NULL, '203.153.0.0', '203.153.255.255', 10, 10, 10, 10, 0),
(1579, 'Asia', '亚洲', '土耳其', NULL, '212.156.0.0', '212.156.193.255', 10, 10, 10, 10, 0),
(1580, 'Asia', '亚洲', '孟加拉国', NULL, '202.4.96.0', '202.4.127.255', 10, 10, 10, 10, 0),
(1581, 'Asia', '亚洲', '孟加拉国', NULL, '202.5.32.0', '202.5.63.255', 10, 10, 10, 10, 0),
(1582, 'Asia', '亚洲', '孟加拉国', NULL, '202.168.224.0', '202.168.255.255', 10, 10, 10, 10, 0),
(1583, 'Asia', '亚洲', '孟加拉国', NULL, '203.188.128.0', '203.191.255.255', 10, 10, 10, 10, 0),
(1584, 'Asia', '亚洲', '尼泊尔', NULL, '202.51.0.0', '202.51.31.255', 10, 10, 10, 10, 0),
(1585, 'Asia', '亚洲', '尼泊尔', NULL, '202.52.0.0', '202.52.31.255', 10, 10, 10, 10, 0),
(1586, 'Asia', '亚洲', '尼泊尔', NULL, '202.52.224.0', '202.53.31.255', 10, 10, 10, 10, 0),
(1587, 'Asia', '亚洲', '尼泊尔', NULL, '202.79.32.0', '202.79.63.255', 10, 10, 10, 10, 0),
(1588, 'Asia', '亚洲', '巴基斯坦', NULL, '202.5.128.0', '202.5.159.255', 10, 10, 10, 10, 0),
(1589, 'Asia', '亚洲', '巴基斯坦', NULL, '202.163.96.0', '202.163.127.255', 10, 10, 10, 10, 0),
(1590, 'Asia', '亚洲', '巴基斯坦', NULL, '202.165.224.0', '202.165.255.255', 10, 10, 10, 10, 0),
(1591, 'Asia', '亚洲', '巴基斯坦', NULL, '202.179.128.0', '202.179.159.255', 10, 10, 10, 10, 0),
(1592, 'Asia', '亚洲', '巴基斯坦', NULL, '203.128.0.0', '203.129.63.255', 10, 10, 10, 10, 0),
(1593, 'Asia', '亚洲', '巴基斯坦', NULL, '203.130.0.0', '203.130.63.255', 10, 10, 10, 10, 0),
(1594, 'Asia', '亚洲', '巴基斯坦', NULL, '203.133.192.0', '203.133.255.255', 10, 10, 10, 10, 0),
(1595, 'Asia', '亚洲', '巴基斯坦', NULL, '203.134.192.0', '203.135.63.255', 10, 10, 10, 10, 0),
(1596, 'Asia', '亚洲', '巴基斯坦', NULL, '210.56.0.0', '210.56.31.255', 10, 10, 10, 10, 0),
(1597, 'Asia', '亚洲', '文莱', NULL, '202.12.26.0', '202.12.26.255', 10, 10, 10, 10, 0),
(1598, 'Asia', '亚洲', '文莱', NULL, '202.160.0.0', '202.160.63.255', 10, 10, 10, 10, 0),
(1599, 'Asia', '亚洲', '斯里兰卡', NULL, '202.51.128.0', '202.51.159.255', 10, 10, 10, 10, 0),
(1600, 'Asia', '亚洲', '斯里兰卡', NULL, '203.115.0.0', '203.115.63.255', 10, 10, 10, 10, 0),
(1601, 'Asia', '亚洲', '斯里兰卡', NULL, '203.142.0.0', '203.142.31.255', 10, 10, 10, 10, 0),
(1602, 'Asia', '亚洲', '斯里兰卡', NULL, '203.143.0.0', '203.143.31.255', 10, 10, 10, 10, 0),
(1603, 'Asia', '亚洲', '新加坡', NULL, '137.132.0.0', '137.132.255.255', 10, 10, 10, 10, 0),
(1604, 'Asia', '亚洲', '新加坡', NULL, '155.69.0.0', '155.69.255.255', 10, 10, 10, 10, 0),
(1605, 'Asia', '亚洲', '新加坡', NULL, '165.21.0.0', '165.21.255.255', 10, 10, 10, 10, 0),
(1606, 'Asia', '亚洲', '新加坡', NULL, '192.203.41.0', '192.203.41.255', 10, 10, 10, 10, 0),
(1607, 'Asia', '亚洲', '新加坡', NULL, '202.0.71.0', '202.0.71.255', 10, 10, 10, 10, 0),
(1608, 'Asia', '亚洲', '新加坡', NULL, '202.0.127.0', '202.0.127.255', 10, 10, 10, 10, 0),
(1609, 'Asia', '亚洲', '新加坡', NULL, '202.0.149.0', '202.0.150.255', 10, 10, 10, 10, 0),
(1610, 'Asia', '亚洲', '新加坡', NULL, '202.0.152.0', '202.0.152.255', 10, 10, 10, 10, 0),
(1611, 'Asia', '亚洲', '新加坡', NULL, '202.1.64.0', '202.1.159.255', 10, 10, 10, 10, 0),
(1612, 'Asia', '亚洲', '新加坡', NULL, '202.6.102.0', '202.6.102.255', 10, 10, 10, 10, 0),
(1613, 'Asia', '亚洲', '新加坡', NULL, '202.8.94.0', '202.8.95.255', 10, 10, 10, 10, 0),
(1614, 'Asia', '亚洲', '新加坡', NULL, '202.12.94.0', '202.12.95.255', 10, 10, 10, 10, 0),
(1615, 'Asia', '亚洲', '新加坡', NULL, '202.20.114.0', '202.20.116.255', 10, 10, 10, 10, 0),
(1616, 'Asia', '亚洲', '新加坡', NULL, '202.21.145.0', '202.21.146.255', 10, 10, 10, 10, 0),
(1617, 'Asia', '亚洲', '新加坡', NULL, '202.21.154.0', '202.21.154.255', 10, 10, 10, 10, 0),
(1618, 'Asia', '亚洲', '新加坡', NULL, '202.21.192.0', '202.21.255.255', 10, 10, 10, 10, 0),
(1619, 'Asia', '亚洲', '新加坡', NULL, '202.27.16.0', '202.27.31.255', 10, 10, 10, 10, 0),
(1620, 'Asia', '亚洲', '新加坡', NULL, '202.42.0.0', '202.42.255.255', 10, 10, 10, 10, 0),
(1621, 'Asia', '亚洲', '新加坡', NULL, '202.160.224.0', '202.160.255.255', 10, 10, 10, 10, 0),
(1622, 'Asia', '亚洲', '新加坡', NULL, '202.166.0.0', '202.166.63.255', 10, 10, 10, 10, 0),
(1623, 'Asia', '亚洲', '新加坡', NULL, '202.169.224.0', '202.169.255.255', 10, 10, 10, 10, 0),
(1624, 'Asia', '亚洲', '新加坡', NULL, '202.176.0.0', '202.176.0.31', 10, 10, 10, 10, 0),
(1625, 'Asia', '亚洲', '新加坡', NULL, '203.112.0.0', '203.112.31.255', 10, 10, 10, 10, 0),
(1626, 'Asia', '亚洲', '新加坡', NULL, '203.116.0.0', '203.127.255.255', 10, 10, 10, 10, 0),
(1627, 'Asia', '亚洲', '新加坡', NULL, '210.23.128.0', '210.23.159.255', 10, 10, 10, 10, 0),
(1628, 'Asia', '亚洲', '新加坡', NULL, '210.24.0.0', '210.24.255.255', 10, 10, 10, 10, 0),
(1629, 'Asia', '亚洲', '日本', NULL, '61.112.0.0', '61.112.255.255', 10, 10, 10, 10, 0),
(1630, 'Asia', '亚洲', '日本', NULL, '61.117.30.0', '61.117.35.255', 10, 10, 10, 10, 0),
(1631, 'Asia', '亚洲', '日本', NULL, '61.124.30.0', '61.124.45.255', 10, 10, 10, 10, 0),
(1632, 'Asia', '亚洲', '日本', NULL, '130.34.195.0', '130.34.195.255', 10, 10, 10, 10, 0),
(1633, 'Asia', '亚洲', '日本', NULL, '130.153.0.0', '130.153.255.255', 10, 10, 10, 10, 0),
(1634, 'Asia', '亚洲', '日本', NULL, '165.76.0.0', '165.76.255.255', 10, 10, 10, 10, 0),
(1635, 'Asia', '亚洲', '日本', NULL, '202.0.65.0', '202.0.66.255', 10, 10, 10, 10, 0),
(1636, 'Asia', '亚洲', '日本', NULL, '202.0.72.0', '202.0.73.255', 10, 10, 10, 10, 0),
(1637, 'Asia', '亚洲', '日本', NULL, '202.0.76.0', '202.0.76.255', 10, 10, 10, 10, 0),
(1638, 'Asia', '亚洲', '日本', NULL, '202.0.93.0', '202.0.93.255', 10, 10, 10, 10, 0),
(1639, 'Asia', '亚洲', '日本', NULL, '202.6.98.0', '202.6.98.255', 10, 10, 10, 10, 0),
(1640, 'Asia', '亚洲', '日本', NULL, '202.6.103.0', '202.6.103.255', 10, 10, 10, 10, 0),
(1641, 'Asia', '亚洲', '日本', NULL, '202.12.8.0', '202.12.15.255', 10, 10, 10, 10, 0),
(1642, 'Asia', '亚洲', '日本', NULL, '202.13.0.0', '202.13.254.255', 10, 10, 10, 10, 0),
(1643, 'Asia', '亚洲', '日本', NULL, '202.15.0.0', '202.19.255.255', 10, 10, 10, 10, 0),
(1644, 'Asia', '亚洲', '日本', NULL, '202.20.90.0', '202.20.90.255', 10, 10, 10, 10, 0),
(1645, 'Asia', '亚洲', '日本', NULL, '202.20.110.0', '202.20.110.255', 10, 10, 10, 10, 0),
(1646, 'Asia', '亚洲', '日本', NULL, '202.20.123.0', '202.20.124.255', 10, 10, 10, 10, 0),
(1647, 'Asia', '亚洲', '日本', NULL, '202.21.112.0', '202.21.127.255', 10, 10, 10, 10, 0),
(1648, 'Asia', '亚洲', '日本', NULL, '202.21.150.0', '202.21.153.255', 10, 10, 10, 10, 0),
(1649, 'Asia', '亚洲', '日本', NULL, '202.22.64.0', '202.22.127.255', 10, 10, 10, 10, 0),
(1650, 'Asia', '亚洲', '日本', NULL, '202.23.0.0', '202.26.255.255', 10, 10, 10, 10, 0),
(1651, 'Asia', '亚洲', '日本', NULL, '202.32.0.0', '202.35.255.255', 10, 10, 10, 10, 0),
(1652, 'Asia', '亚洲', '日本', NULL, '202.48.0.0', '202.48.255.255', 10, 10, 10, 10, 0),
(1653, 'Asia', '亚洲', '日本', NULL, '202.139.192.0', '202.139.207.255', 10, 10, 10, 10, 0),
(1654, 'Asia', '亚洲', '日本', NULL, '202.140.0.0', '202.140.31.255', 10, 10, 10, 10, 0),
(1655, 'Asia', '亚洲', '日本', NULL, '202.176.0.32', '202.176.3.255', 10, 10, 10, 10, 0),
(1656, 'Asia', '亚洲', '日本', NULL, '202.208.0.0', '202.255.255.255', 10, 10, 10, 10, 0),
(1657, 'Asia', '亚洲', '日本', NULL, '203.136.0.0', '203.141.255.255', 10, 10, 10, 10, 0),
(1658, 'Asia', '亚洲', '日本', NULL, '203.178.0.0', '203.183.255.255', 10, 10, 10, 10, 0),
(1659, 'Asia', '亚洲', '日本', NULL, '203.216.0.0', '203.216.255.255', 10, 10, 10, 10, 0),
(1660, 'Asia', '亚洲', '日本', NULL, '210.7.128.0', '210.7.255.255', 10, 10, 10, 10, 0),
(1661, 'Asia', '亚洲', '日本', NULL, '210.81.0.0', '210.81.31.255', 10, 10, 10, 10, 0),
(1662, 'Asia', '亚洲', '日本', NULL, '210.88.0.0', '210.88.191.255', 10, 10, 10, 10, 0),
(1663, 'Asia', '亚洲', '日本', NULL, '210.128.0.0', '210.175.255.255', 10, 10, 10, 10, 0),
(1664, 'Asia', '亚洲', '日本', NULL, '210.188.0.0', '210.191.255.255', 10, 10, 10, 10, 0),
(1665, 'Asia', '亚洲', '日本', NULL, '210.196.0.0', '210.199.255.255', 10, 10, 10, 10, 0),
(1666, 'Asia', '亚洲', '日本', NULL, '210.224.0.0', '210.239.255.255', 10, 10, 10, 10, 0),
(1667, 'Asia', '亚洲', '日本', NULL, '210.248.0.0', '211.255.255.255', 10, 10, 10, 10, 0),
(1668, 'Asia', '亚洲', '日本', NULL, '211.8.0.0', '211.19.255.255', 10, 10, 10, 10, 0),
(1669, 'Asia', '亚洲', '泰国', NULL, '192.188.172.0', '192.188.172.255', 10, 10, 10, 10, 0),
(1670, 'Asia', '亚洲', '泰国', NULL, '202.0.79.0', '202.0.79.255', 10, 10, 10, 10, 0),
(1671, 'Asia', '亚洲', '泰国', NULL, '202.0.111.0', '202.0.111.255', 10, 10, 10, 10, 0),
(1672, 'Asia', '亚洲', '泰国', NULL, '202.0.117.0', '202.0.120.255', 10, 10, 10, 10, 0),
(1673, 'Asia', '亚洲', '泰国', NULL, '202.6.90.0', '202.6.90.255', 10, 10, 10, 10, 0),
(1674, 'Asia', '亚洲', '泰国', NULL, '202.6.100.0', '202.6.101.255', 10, 10, 10, 10, 0),
(1675, 'Asia', '亚洲', '泰国', NULL, '202.6.107.0', '202.6.107.255', 10, 10, 10, 10, 0),
(1676, 'Asia', '亚洲', '泰国', NULL, '202.6.111.0', '202.6.111.255', 10, 10, 10, 10, 0),
(1677, 'Asia', '亚洲', '泰国', NULL, '202.8.64.0', '202.8.75.255', 10, 10, 10, 10, 0),
(1678, 'Asia', '亚洲', '泰国', NULL, '202.12.73.0', '202.12.74.255', 10, 10, 10, 10, 0),
(1679, 'Asia', '亚洲', '泰国', NULL, '202.12.97.0', '202.12.97.255', 10, 10, 10, 10, 0),
(1680, 'Asia', '亚洲', '泰国', NULL, '202.12.116.0', '202.12.116.255', 10, 10, 10, 10, 0),
(1681, 'Asia', '亚洲', '泰国', NULL, '202.14.90.0', '202.14.94.255', 10, 10, 10, 10, 0),
(1682, 'Asia', '亚洲', '泰国', NULL, '202.14.162.0', '202.14.164.255', 10, 10, 10, 10, 0),
(1683, 'Asia', '亚洲', '泰国', NULL, '202.20.67.0', '202.20.68.255', 10, 10, 10, 10, 0),
(1684, 'Asia', '亚洲', '泰国', NULL, '202.20.87.0', '202.20.87.255', 10, 10, 10, 10, 0),
(1685, 'Asia', '亚洲', '泰国', NULL, '202.20.105.0', '202.20.105.255', 10, 10, 10, 10, 0),
(1686, 'Asia', '亚洲', '泰国', NULL, '202.21.134.0', '202.21.135.255', 10, 10, 10, 10, 0),
(1687, 'Asia', '亚洲', '泰国', NULL, '202.21.140.0', '202.21.140.255', 10, 10, 10, 10, 0),
(1688, 'Asia', '亚洲', '泰国', NULL, '202.21.144.0', '202.21.144.255', 10, 10, 10, 10, 0),
(1689, 'Asia', '亚洲', '泰国', NULL, '202.21.149.0', '202.21.149.255', 10, 10, 10, 10, 0),
(1690, 'Asia', '亚洲', '泰国', NULL, '202.22.8.0', '202.22.15.255', 10, 10, 10, 10, 0),
(1691, 'Asia', '亚洲', '泰国', NULL, '202.28.0.0', '202.29.255.255', 10, 10, 10, 10, 0),
(1692, 'Asia', '亚洲', '泰国', NULL, '202.44.0.0', '202.44.255.255', 10, 10, 10, 10, 0),
(1693, 'Asia', '亚洲', '泰国', NULL, '202.47.248.0', '202.47.255.255', 10, 10, 10, 10, 0),
(1694, 'Asia', '亚洲', '泰国', NULL, '202.57.128.0', '202.57.159.255', 10, 10, 10, 10, 0),
(1695, 'Asia', '亚洲', '泰国', NULL, '202.59.224.0', '202.59.255.255', 10, 10, 10, 10, 0),
(1696, 'Asia', '亚洲', '泰国', NULL, '202.74.32.0', '202.74.63.255', 10, 10, 10, 10, 0),
(1697, 'Asia', '亚洲', '泰国', NULL, '202.80.224.0', '202.80.255.255', 10, 10, 10, 10, 0),
(1698, 'Asia', '亚洲', '泰国', NULL, '202.153.0.0', '202.153.255.255', 10, 10, 10, 10, 0),
(1699, 'Asia', '亚洲', '泰国', NULL, '202.182.0.0', '202.182.31.255', 10, 10, 10, 10, 0),
(1700, 'Asia', '亚洲', '泰国', NULL, '202.183.192.0', '202.183.255.255', 10, 10, 10, 10, 0),
(1701, 'Asia', '亚洲', '泰国', NULL, '203.144.192.0', '203.145.63.255', 10, 10, 10, 10, 0),
(1702, 'Asia', '亚洲', '泰国', NULL, '203.146.0.0', '203.147.63.255', 10, 10, 10, 10, 0),
(1703, 'Asia', '亚洲', '泰国', NULL, '203.148.160.0', '203.152.63.255', 10, 10, 10, 10, 0),
(1704, 'Asia', '亚洲', '泰国', NULL, '203.154.0.0', '203.159.255.255', 10, 10, 10, 10, 0),
(1705, 'Asia', '亚洲', '泰国', NULL, '203.185.64.0', '203.185.159.255', 10, 10, 10, 10, 0),
(1706, 'Asia', '亚洲', '老挝', NULL, '202.58.0.0', '202.58.31.255', 10, 10, 10, 10, 0),
(1707, 'Asia', '亚洲', '老挝', NULL, '202.137.128.0', '202.137.159.255', 10, 10, 10, 10, 0),
(1708, 'Asia', '亚洲', '菲律宾', NULL, '192.188.174.0', '192.188.174.255', 10, 10, 10, 10, 0),
(1709, 'Asia', '亚洲', '菲律宾', NULL, '202.0.16.0', '202.0.31.255', 10, 10, 10, 10, 0),
(1710, 'Asia', '亚洲', '菲律宾', NULL, '202.4.0.0', '202.4.15.255', 10, 10, 10, 10, 0),
(1711, 'Asia', '亚洲', '菲律宾', NULL, '202.8.224.0', '202.8.255.255', 10, 10, 10, 10, 0),
(1712, 'Asia', '亚洲', '菲律宾', NULL, '202.12.17.0', '202.12.18.255', 10, 10, 10, 10, 0),
(1713, 'Asia', '亚洲', '菲律宾', NULL, '202.43.128.0', '202.43.159.255', 10, 10, 10, 10, 0),
(1714, 'Asia', '亚洲', '菲律宾', NULL, '202.47.0.0', '202.47.31.255', 10, 10, 10, 10, 0),
(1715, 'Asia', '亚洲', '菲律宾', NULL, '202.47.96.0', '202.47.141.255', 10, 10, 10, 10, 0),
(1716, 'Asia', '亚洲', '菲律宾', NULL, '202.56.96.0', '202.56.127.255', 10, 10, 10, 10, 0),
(1717, 'Asia', '亚洲', '菲律宾', NULL, '202.57.32.0', '202.57.127.255', 10, 10, 10, 10, 0),
(1718, 'Asia', '亚洲', '菲律宾', NULL, '202.58.96.0', '202.58.127.255', 10, 10, 10, 10, 0),
(1719, 'Asia', '亚洲', '菲律宾', NULL, '202.58.224.0', '202.58.255.255', 10, 10, 10, 10, 0),
(1720, 'Asia', '亚洲', '菲律宾', NULL, '202.59.128.0', '202.59.159.255', 10, 10, 10, 10, 0),
(1721, 'Asia', '亚洲', '菲律宾', NULL, '202.61.64.0', '202.61.95.255', 10, 10, 10, 10, 0),
(1722, 'Asia', '亚洲', '菲律宾', NULL, '202.78.64.0', '202.78.95.255', 10, 10, 10, 10, 0),
(1723, 'Asia', '亚洲', '菲律宾', NULL, '202.79.128.0', '202.79.159.255', 10, 10, 10, 10, 0),
(1724, 'Asia', '亚洲', '菲律宾', NULL, '202.134.0.0', '202.134.31.255', 10, 10, 10, 10, 0),
(1725, 'Asia', '亚洲', '菲律宾', NULL, '202.134.224.0', '202.134.255.255', 10, 10, 10, 10, 0),
(1726, 'Asia', '亚洲', '菲律宾', NULL, '202.136.0.0', '202.136.127.255', 10, 10, 10, 10, 0),
(1727, 'Asia', '亚洲', '菲律宾', NULL, '202.138.128.0', '202.138.159.255', 10, 10, 10, 10, 0),
(1728, 'Asia', '亚洲', '菲律宾', NULL, '202.163.224.0', '202.163.255.255', 10, 10, 10, 10, 0),
(1729, 'Asia', '亚洲', '菲律宾', NULL, '202.164.128.0', '202.164.159.255', 10, 10, 10, 10, 0),
(1730, 'Asia', '亚洲', '菲律宾', NULL, '202.168.0.0', '202.168.31.255', 10, 10, 10, 10, 0),
(1731, 'Asia', '亚洲', '菲律宾', NULL, '203.78.224.0', '203.78.255.255', 10, 10, 10, 10, 0),
(1732, 'Asia', '亚洲', '菲律宾', NULL, '203.167.0.0', '203.167.31.255', 10, 10, 10, 10, 0),
(1733, 'Asia', '亚洲', '菲律宾', NULL, '203.168.0.0', '203.177.255.255', 10, 10, 10, 10, 0),
(1734, 'Asia', '亚洲', '菲律宾', NULL, '210.14.0.0', '210.14.31.255', 10, 10, 10, 10, 0),
(1735, 'Asia', '亚洲', '菲律宾', NULL, '210.16.0.0', '210.16.127.255', 10, 10, 10, 10, 0),
(1736, 'Asia', '亚洲', '菲律宾', NULL, '210.23.224.0', '210.23.255.255', 10, 10, 10, 10, 0),
(1737, 'Asia', '亚洲', '蒙古', NULL, '202.131.0.0', '202.131.255.255', 10, 10, 10, 10, 0),
(1738, 'Asia', '亚洲', '蒙古', NULL, '202.170.64.0', '202.170.95.255', 10, 10, 10, 10, 0),
(1739, 'Asia', '亚洲', '蒙古', NULL, '202.179.0.0', '202.179.31.255', 10, 10, 10, 10, 0),
(1740, 'Asia', '亚洲', '越南', NULL, '203.160.0.0', '203.160.223.255', 10, 10, 10, 10, 0),
(1741, 'Asia', '亚洲', '越南', NULL, '203.161.0.0', '203.162.255.255', 10, 10, 10, 10, 0),
(1742, 'Asia', '亚洲', '阿联酋', NULL, '202.43.0.0', '202.43.31.255', 10, 10, 10, 10, 0),
(1743, 'Asia', '亚洲', '韩国', NULL, '165.194.0.0', '165.246.255.255', 10, 10, 10, 10, 0),
(1744, 'Asia', '亚洲', '韩国', NULL, '203.244.0.0', '203.255.255.255', 10, 10, 10, 10, 0),
(1745, 'Asia', '亚洲', '韩国', NULL, '210.178.0.0', '210.184.95.255', 10, 10, 10, 10, 0),
(1746, 'Asia', '亚洲', '韩国', NULL, '211.32.0.0', '211.51.31.255', 10, 10, 10, 10, 0),
(1747, 'Asia', '亚洲', '韩国', NULL, '211.51.32.0', '211.51.32.255', 10, 10, 10, 10, 0),
(1748, 'Asia', '亚洲', '韩国', NULL, '211.104.220.0', '211.104.230.255', 10, 10, 10, 10, 0),
(1749, 'Asia', '亚洲', '韩国', NULL, '211.117.39.0', '211.117.39.255', 10, 10, 10, 10, 0),
(1750, 'Asia', '亚洲', '韩国', NULL, '211.174.0.0', '211.216.255.255', 10, 10, 10, 10, 0),
(1751, 'Asia', '亚洲', '韩国', NULL, '211.180.1.0', '211.182.255.255', 10, 10, 10, 10, 0),
(1752, 'Asia', '亚洲', '韩国', NULL, '211.200.180.0', '211.200.185.255', 10, 10, 10, 10, 0),
(1753, 'Asia', '亚洲', '韩国', NULL, '211.216.0.0', '211.216.255.255', 10, 10, 10, 10, 0),
(1754, 'Asia', '亚洲', '马尔代夫', NULL, '202.1.192.0', '202.1.223.255', 10, 10, 10, 10, 0),
(1755, 'Asia', '亚洲', '马来西亚', NULL, '161.142.0.0', '161.142.255.255', 10, 10, 10, 10, 0),
(1756, 'Asia', '亚洲', '马来西亚', NULL, '202.0.94.0', '202.0.94.255', 10, 10, 10, 10, 0),
(1757, 'Asia', '亚洲', '马来西亚', NULL, '202.9.64.0', '202.9.95.255', 10, 10, 10, 10, 0),
(1758, 'Asia', '亚洲', '马来西亚', NULL, '202.21.148.0', '202.21.148.255', 10, 10, 10, 10, 0),
(1759, 'Asia', '亚洲', '马来西亚', NULL, '202.75.128.0', '202.75.159.255', 10, 10, 10, 10, 0),
(1760, 'Asia', '亚洲', '马来西亚', NULL, '202.137.224.0', '202.137.255.255', 10, 10, 10, 10, 0),
(1761, 'Asia', '亚洲', '马来西亚', NULL, '202.162.0.0', '202.162.31.255', 10, 10, 10, 10, 0),
(1762, 'Asia', '亚洲', '马来西亚', NULL, '202.178.0.0', '202.178.63.255', 10, 10, 10, 10, 0),
(1763, 'Asia', '亚洲', '马来西亚', NULL, '202.184.0.0', '202.191.255.255', 10, 10, 10, 10, 0),
(1764, 'Asia', '亚洲', '马来西亚', NULL, '203.106.0.0', '203.106.63.255', 10, 10, 10, 10, 0),
(1765, 'Oceania', '大洋洲', '大洋洲', NULL, '202.0.0.0', '202.0.15.255', 10, 10, 10, 10, 0),
(1766, 'Oceania', '大洋洲', '大洋洲', NULL, '202.0.32.0', '202.0.64.255', 10, 10, 10, 10, 0),
(1767, 'Oceania', '大洋洲', '大洋洲', NULL, '202.0.82.0', '202.0.92.255', 10, 10, 10, 10, 0),
(1768, 'Oceania', '大洋洲', '大洋洲', NULL, '202.0.95.0', '202.0.99.255', 10, 10, 10, 10, 0),
(1769, 'Oceania', '大洋洲', '大洋洲', NULL, '202.0.153.0', '202.0.154.255', 10, 10, 10, 10, 0),
(1770, 'Oceania', '大洋洲', '大洋洲', NULL, '202.1.8.0', '202.1.31.255', 10, 10, 10, 10, 0);
INSERT INTO `locations` (`id`, `name`, `location_main`, `location_sub`, `flagpic`, `start_ip`, `end_ip`, `theory_upspeed`, `practical_upspeed`, `theory_downspeed`, `practical_downspeed`, `hit`) VALUES
(1771, 'Oceania', '大洋洲', '大洋洲', NULL, '202.2.0.0', '202.2.31.255', 10, 10, 10, 10, 0),
(1772, 'Oceania', '大洋洲', '大洋洲', NULL, '202.3.0.0', '202.3.31.255', 10, 10, 10, 10, 0),
(1773, 'Oceania', '大洋洲', '大洋洲', NULL, '202.6.3.0', '202.6.87.255', 10, 10, 10, 10, 0),
(1774, 'Oceania', '大洋洲', '大洋洲', NULL, '202.6.91.0', '202.6.93.255', 10, 10, 10, 10, 0),
(1775, 'Oceania', '大洋洲', '大洋洲', NULL, '202.6.108.0', '202.6.110.255', 10, 10, 10, 10, 0),
(1776, 'Oceania', '大洋洲', '大洋洲', NULL, '202.6.112.0', '202.7.63.255', 10, 10, 10, 10, 0),
(1777, 'Oceania', '大洋洲', '大洋洲', NULL, '202.7.224.0', '202.8.39.255', 10, 10, 10, 10, 0),
(1778, 'Oceania', '大洋洲', '大洋洲', NULL, '202.9.224.0', '202.12.3.255', 10, 10, 10, 10, 0),
(1779, 'Oceania', '大洋洲', '大洋洲', NULL, '202.12.32.0', '202.12.72.255', 10, 10, 10, 10, 0),
(1780, 'Oceania', '大洋洲', '大洋洲', NULL, '202.12.75.0', '202.12.93.255', 10, 10, 10, 10, 0),
(1781, 'Oceania', '大洋洲', '大洋洲', NULL, '202.12.98.0', '202.12.115.255', 10, 10, 10, 10, 0),
(1782, 'Oceania', '大洋洲', '大洋洲', NULL, '202.12.119.0', '202.12.242.255', 10, 10, 10, 10, 0),
(1783, 'Oceania', '大洋洲', '大洋洲', NULL, '202.14.16.0', '202.14.66.255', 10, 10, 10, 10, 0),
(1784, 'Oceania', '大洋洲', '大洋洲', NULL, '202.14.73.0', '202.14.79.255', 10, 10, 10, 10, 0),
(1785, 'Oceania', '大洋洲', '大洋洲', NULL, '202.14.81.0', '202.14.84.255', 10, 10, 10, 10, 0),
(1786, 'Oceania', '大洋洲', '大洋洲', NULL, '202.14.95.0', '202.14.161.255', 10, 10, 10, 10, 0),
(1787, 'Oceania', '大洋洲', '大洋洲', NULL, '202.14.166.0', '202.14.221.255', 10, 10, 10, 10, 0),
(1788, 'Oceania', '大洋洲', '大洋洲', NULL, '202.14.223.0', '202.14.234.255', 10, 10, 10, 10, 0),
(1789, 'Oceania', '大洋洲', '大洋洲', NULL, '202.14.239.0', '202.14.254.255', 10, 10, 10, 10, 0),
(1790, 'Oceania', '大洋洲', '大洋洲', NULL, '202.20.0.0', '202.20.65.255', 10, 10, 10, 10, 0),
(1791, 'Oceania', '大洋洲', '大洋洲', NULL, '202.20.69.0', '202.20.81.255', 10, 10, 10, 10, 0),
(1792, 'Oceania', '大洋洲', '大洋洲', NULL, '202.21.8.0', '202.21.111.255', 10, 10, 10, 10, 0),
(1793, 'Oceania', '大洋洲', '巴布亚新几内亚', NULL, '202.0.80.0', '202.0.80.255', 10, 10, 10, 10, 0),
(1794, 'Oceania', '大洋洲', '巴布亚新几内亚', NULL, '202.1.32.0', '202.1.63.255', 10, 10, 10, 10, 0),
(1795, 'Oceania', '大洋洲', '巴布亚新几内亚', NULL, '202.1.240.0', '202.1.255.255', 10, 10, 10, 10, 0),
(1796, 'Oceania', '大洋洲', '巴布亚新几内亚', NULL, '202.58.128.0', '202.58.159.255', 10, 10, 10, 10, 0),
(1797, 'Oceania', '大洋洲', '巴布亚新几内亚', NULL, '202.61.0.0', '202.61.31.255', 10, 10, 10, 10, 0),
(1798, 'Oceania', '大洋洲', '所罗门群岛', NULL, '202.1.160.0', '202.1.191.255', 10, 10, 10, 10, 0),
(1799, 'Oceania', '大洋洲', '所罗门群岛', NULL, '202.63.224.0', '202.63.255.255', 10, 10, 10, 10, 0),
(1800, 'Oceania', '大洋洲', '斐济', NULL, '202.62.0.0', '202.62.127.255', 10, 10, 10, 10, 0),
(1801, 'Oceania', '大洋洲', '斐济', NULL, '202.62.224.0', '202.62.255.255', 10, 10, 10, 10, 0),
(1802, 'Oceania', '大洋洲', '新喀里多尼亚', NULL, '202.0.156.0', '202.0.159.255', 10, 10, 10, 10, 0),
(1803, 'Oceania', '大洋洲', '新喀里多尼亚', NULL, '202.22.128.0', '202.22.159.255', 10, 10, 10, 10, 0),
(1804, 'Oceania', '大洋洲', '新西兰', NULL, '202.0.121.0', '202.0.121.255', 10, 10, 10, 10, 0),
(1805, 'Oceania', '大洋洲', '新西兰', NULL, '202.0.124.0', '202.0.125.255', 10, 10, 10, 10, 0),
(1806, 'Oceania', '大洋洲', '新西兰', NULL, '202.0.151.0', '202.0.151.255', 10, 10, 10, 10, 0),
(1807, 'Oceania', '大洋洲', '新西兰', NULL, '202.4.16.0', '202.4.24.255', 10, 10, 10, 10, 0),
(1808, 'Oceania', '大洋洲', '新西兰', NULL, '202.12.96.0', '202.12.96.255', 10, 10, 10, 10, 0),
(1809, 'Oceania', '大洋洲', '新西兰', NULL, '202.20.91.0', '202.20.93.255', 10, 10, 10, 10, 0),
(1810, 'Oceania', '大洋洲', '新西兰', NULL, '202.20.96.0', '202.20.97.255', 10, 10, 10, 10, 0),
(1811, 'Oceania', '大洋洲', '新西兰', NULL, '202.20.102.0', '202.20.104.255', 10, 10, 10, 10, 0),
(1812, 'Oceania', '大洋洲', '新西兰', NULL, '202.20.113.0', '202.20.113.255', 10, 10, 10, 10, 0),
(1813, 'Oceania', '大洋洲', '新西兰', NULL, '202.20.121.0', '202.20.122.255', 10, 10, 10, 10, 0),
(1814, 'Oceania', '大洋洲', '新西兰', NULL, '202.21.130.0', '202.21.133.255', 10, 10, 10, 10, 0),
(1815, 'Oceania', '大洋洲', '新西兰', NULL, '202.21.138.0', '202.21.139.255', 10, 10, 10, 10, 0),
(1816, 'Oceania', '大洋洲', '新西兰', NULL, '202.21.141.0', '202.21.143.255', 10, 10, 10, 10, 0),
(1817, 'Oceania', '大洋洲', '新西兰', NULL, '202.21.155.0', '202.21.157.255', 10, 10, 10, 10, 0),
(1818, 'Oceania', '大洋洲', '新西兰', NULL, '202.22.0.0', '202.22.7.255', 10, 10, 10, 10, 0),
(1819, 'Oceania', '大洋洲', '新西兰', NULL, '202.22.16.0', '202.22.31.255', 10, 10, 10, 10, 0),
(1820, 'Oceania', '大洋洲', '新西兰', NULL, '202.27.0.0', '202.27.15.255', 10, 10, 10, 10, 0),
(1821, 'Oceania', '大洋洲', '新西兰', NULL, '202.27.32.0', '202.27.255.255', 10, 10, 10, 10, 0),
(1822, 'Oceania', '大洋洲', '新西兰', NULL, '202.36.0.0', '202.37.255.255', 10, 10, 10, 10, 0),
(1823, 'Oceania', '大洋洲', '新西兰', NULL, '202.49.0.0', '202.50.255.255', 10, 10, 10, 10, 0),
(1824, 'Oceania', '大洋洲', '新西兰', NULL, '202.78.128.0', '202.78.159.255', 10, 10, 10, 10, 0),
(1825, 'Oceania', '大洋洲', '新西兰', NULL, '202.148.128.0', '202.148.191.255', 10, 10, 10, 10, 0),
(1826, 'Oceania', '大洋洲', '新西兰', NULL, '203.96.0.0', '203.98.63.255', 10, 10, 10, 10, 0),
(1827, 'Oceania', '大洋洲', '新西兰', NULL, '203.99.0.0', '203.99.71.255', 10, 10, 10, 10, 0),
(1828, 'Oceania', '大洋洲', '新西兰', NULL, '203.109.192.0', '203.110.31.255', 10, 10, 10, 10, 0),
(1829, 'Oceania', '大洋洲', '新西兰', NULL, '203.167.192.0', '203.167.255.255', 10, 10, 10, 10, 0),
(1830, 'Oceania', '大洋洲', '新西兰', NULL, '210.48.0.0', '210.50.255.255', 10, 10, 10, 10, 0),
(1831, 'Oceania', '大洋洲', '汤加', NULL, '202.59.0.0', '202.59.31.255', 10, 10, 10, 10, 0),
(1832, 'Oceania', '大洋洲', '波利尼西亚', NULL, '202.3.128.0', '202.3.255.255', 10, 10, 10, 10, 0),
(1833, 'Oceania', '大洋洲', '澳大利亚', NULL, '61.8.0.0', '61.8.31.255', 10, 10, 10, 10, 0),
(1834, 'Oceania', '大洋洲', '澳大利亚', NULL, '138.77.0.0', '139.132.255.255', 10, 10, 10, 10, 0),
(1835, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.0.67.0', '202.0.70.255', 10, 10, 10, 10, 0),
(1836, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.0.74.0', '202.0.75.255', 10, 10, 10, 10, 0),
(1837, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.0.101.0', '202.0.102.255', 10, 10, 10, 10, 0),
(1838, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.0.105.0', '202.0.109.255', 10, 10, 10, 10, 0),
(1839, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.0.113.0', '202.0.115.255', 10, 10, 10, 10, 0),
(1840, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.0.148.0', '202.0.148.255', 10, 10, 10, 10, 0),
(1841, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.1.0.0', '202.1.4.255', 10, 10, 10, 10, 0),
(1842, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.1.224.0', '202.1.231.255', 10, 10, 10, 10, 0),
(1843, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.5.0.0', '202.5.31.255', 10, 10, 10, 10, 0),
(1844, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.5.96.0', '202.5.127.255', 10, 10, 10, 10, 0),
(1845, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.6.106.0', '202.6.106.255', 10, 10, 10, 10, 0),
(1846, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.8.96.0', '202.8.127.255', 10, 10, 10, 10, 0),
(1847, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.9.0.0', '202.9.15.255', 10, 10, 10, 10, 0),
(1848, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.12.22.0', '202.12.25.255', 10, 10, 10, 10, 0),
(1849, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.14.0.0', '202.14.7.255', 10, 10, 10, 10, 0),
(1850, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.14.89.0', '202.14.89.255', 10, 10, 10, 10, 0),
(1851, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.46.32.0', '202.46.63.255', 10, 10, 10, 10, 0),
(1852, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.47.32.0', '202.47.63.255', 10, 10, 10, 10, 0),
(1853, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.53.32.0', '202.53.63.255', 10, 10, 10, 10, 0),
(1854, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.59.32.0', '202.59.63.255', 10, 10, 10, 10, 0),
(1855, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.61.192.0', '202.61.255.255', 10, 10, 10, 10, 0),
(1856, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.62.128.0', '202.62.159.255', 10, 10, 10, 10, 0),
(1857, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.65.64.0', '202.65.95.255', 10, 10, 10, 10, 0),
(1858, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.74.128.0', '202.74.159.255', 10, 10, 10, 10, 0),
(1859, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.76.128.0', '202.76.159.255', 10, 10, 10, 10, 0),
(1860, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.80.64.0', '202.80.95.255', 10, 10, 10, 10, 0),
(1861, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.137.64.0', '202.137.95.255', 10, 10, 10, 10, 0),
(1862, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.138.0.0', '202.138.63.255', 10, 10, 10, 10, 0),
(1863, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.139.0.0', '202.139.63.255', 10, 10, 10, 10, 0),
(1864, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.139.224.0', '202.139.255.255', 10, 10, 10, 10, 0),
(1865, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.140.224.0', '202.140.255.255', 10, 10, 10, 10, 0),
(1866, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.143.64.0', '202.143.95.255', 10, 10, 10, 10, 0),
(1867, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.147.0.0', '202.147.159.255', 10, 10, 10, 10, 0),
(1868, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.148.64.0', '202.148.95.255', 10, 10, 10, 10, 0),
(1869, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.161.0.0', '202.161.127.255', 10, 10, 10, 10, 0),
(1870, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.163.128.0', '202.163.159.255', 10, 10, 10, 10, 0),
(1871, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.164.224.0', '202.165.159.255', 10, 10, 10, 10, 0),
(1872, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.168.96.0', '202.168.159.255', 10, 10, 10, 10, 0),
(1873, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.177.64.0', '202.177.95.255', 10, 10, 10, 10, 0),
(1874, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.179.224.0', '202.179.255.255', 10, 10, 10, 10, 0),
(1875, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.180.224.0', '202.181.31.255', 10, 10, 10, 10, 0),
(1876, 'Oceania', '大洋洲', '澳大利亚', NULL, '202.182.64.0', '202.182.95.255', 10, 10, 10, 10, 0),
(1877, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.0.0.0', '203.63.255.255', 10, 10, 10, 10, 0),
(1878, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.76.0.0', '203.76.255.255', 10, 10, 10, 10, 0),
(1879, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.87.0.0', '203.87.63.255', 10, 10, 10, 10, 0),
(1880, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.88.64.0', '203.88.255.255', 10, 10, 10, 10, 0),
(1881, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.89.224.0', '203.89.255.255', 10, 10, 10, 10, 0),
(1882, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.91.64.0', '203.91.255.255', 10, 10, 10, 10, 0),
(1883, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.92.224.0', '203.92.255.255', 10, 10, 10, 10, 0),
(1884, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.100.0.0', '203.104.255.255', 10, 10, 10, 10, 0),
(1885, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.108.0.0', '203.108.255.255', 10, 10, 10, 10, 0),
(1886, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.110.128.0', '203.111.255.255', 10, 10, 10, 10, 0),
(1887, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.131.0.0', '203.131.63.255', 10, 10, 10, 10, 0),
(1888, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.132.0.0', '203.132.255.255', 10, 10, 10, 10, 0),
(1889, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.134.0.0', '203.134.63.255', 10, 10, 10, 10, 0),
(1890, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.142.224.0', '203.142.255.255', 10, 10, 10, 10, 0),
(1891, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.143.224.0', '203.144.31.255', 10, 10, 10, 10, 0),
(1892, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.147.192.0', '203.147.255.255', 10, 10, 10, 10, 0),
(1893, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.152.224.0', '203.152.255.255', 10, 10, 10, 10, 0),
(1894, 'Oceania', '大洋洲', '澳大利亚', NULL, '203.166.0.0', '203.166.255.255', 10, 10, 10, 10, 0),
(1895, 'Oceania', '大洋洲', '澳大利亚', NULL, '210.0.0.0', '210.0.31.255', 10, 10, 10, 10, 0),
(1896, 'Oceania', '大洋洲', '澳大利亚', NULL, '210.8.0.0', '210.9.255.255', 10, 10, 10, 10, 0),
(1897, 'Oceania', '大洋洲', '澳大利亚', NULL, '210.15.192.0', '210.15.255.255', 10, 10, 10, 10, 0),
(1898, 'Oceania', '大洋洲', '澳大利亚', NULL, '210.84.0.0', '210.84.255.255', 10, 10, 10, 10, 0),
(1899, 'Oceania', '大洋洲', '瑙鲁', NULL, '203.98.224.0', '203.98.255.255', 10, 10, 10, 10, 0),
(1900, 'Oceania', '大洋洲', '西萨摩亚', NULL, '202.4.32.0', '202.4.63.255', 10, 10, 10, 10, 0),
(1901, 'Oceania', '大洋洲', '西萨摩亚', NULL, '203.99.255.0', '203.99.255.255', 10, 10, 10, 10, 0),
(1902, 'Europe', '欧洲', '丹麦', NULL, '195.82.192.0', '195.82.223.255', 10, 10, 10, 10, 0),
(1903, 'Europe', '欧洲', '俄罗斯', NULL, '212.46.200.0', '212.46.205.255', 10, 10, 10, 10, 0),
(1904, 'Europe', '欧洲', '俄罗斯', NULL, '212.110.234.0', '212.110.237.255', 10, 10, 10, 10, 0),
(1905, 'Europe', '欧洲', '俄罗斯', NULL, '213.24.93.0', '213.24.93.255', 10, 10, 10, 10, 0),
(1906, 'Europe', '欧洲', '俄罗斯', NULL, '213.158.0.0', '213.158.1.255', 10, 10, 10, 10, 0),
(1907, 'Europe', '欧洲', '南斯拉夫', NULL, '161.53.0.0', '161.53.255.255', 10, 10, 10, 10, 0),
(1908, 'Europe', '欧洲', '奥地利', NULL, '192.35.244.0', '192.36.244.255', 10, 10, 10, 10, 0),
(1909, 'Europe', '欧洲', '德国', NULL, '41.39.198.0', '41.39.198.255', 10, 10, 10, 10, 0),
(1910, 'Europe', '欧洲', '德国', NULL, '53.0.0.0', '53.255.255.255', 10, 10, 10, 10, 0),
(1911, 'Europe', '欧洲', '德国', NULL, '129.69.0.0', '129.70.255.255', 10, 10, 10, 10, 0),
(1912, 'Europe', '欧洲', '德国', NULL, '131.246.0.0', '131.246.255.255', 10, 10, 10, 10, 0),
(1913, 'Europe', '欧洲', '德国', NULL, '137.226.0.0', '137.226.255.255', 10, 10, 10, 10, 0),
(1914, 'Europe', '欧洲', '德国', NULL, '141.44.0.0', '141.44.255.255', 10, 10, 10, 10, 0),
(1915, 'Europe', '欧洲', '意大利', NULL, '212.216.160.0', '212.216.167.255', 10, 10, 10, 10, 0),
(1916, 'Europe', '欧洲', '捷克', NULL, '212.20.96.0', '212.20.111.255', 10, 10, 10, 10, 0),
(1917, 'Europe', '欧洲', '斯洛伐克', NULL, '195.146.128.0', '195.146.143.255', 10, 10, 10, 10, 0),
(1918, 'Europe', '欧洲', '格鲁吉亚', NULL, '212.110.225.0', '212.110.232.255', 10, 10, 10, 10, 0),
(1919, 'Europe', '欧洲', '格鲁吉亚', NULL, '212.110.239.0', '212.110.239.255', 10, 10, 10, 10, 0),
(1920, 'Europe', '欧洲', '欧洲', NULL, '62.0.0.0', '62.255.255.255', 10, 10, 10, 10, 0),
(1921, 'Europe', '欧洲', '欧洲', NULL, '193.0.0.0', '195.255.255.0', 10, 10, 10, 10, 0),
(1922, 'Europe', '欧洲', '欧洲', NULL, '212.0.0.0', '213.255.255.255', 10, 10, 10, 10, 0),
(1923, 'Europe', '欧洲', '比利时', NULL, '139.165.0.0', '139.165.255.255', 10, 10, 10, 10, 0),
(1924, 'Europe', '欧洲', '法国', NULL, '57.0.0.0', '57.255.255.255', 10, 10, 10, 10, 0),
(1925, 'Europe', '欧洲', '法国', NULL, '195.242.64.0', '195.242.79.255', 10, 10, 10, 10, 0),
(1926, 'Europe', '欧洲', '瑞典', NULL, '192.36.140.0', '192.36.140.255', 10, 10, 10, 10, 0),
(1927, 'Europe', '欧洲', '瑞典', NULL, '195.163.72.0', '195.163.79.255', 10, 10, 10, 10, 0),
(1928, 'Europe', '欧洲', '芬兰', NULL, '193.166.0.0', '193.166.255.255', 10, 10, 10, 10, 0),
(1929, 'Europe', '欧洲', '英国', NULL, '51.0.0.0', '51.255.255.255', 10, 10, 10, 10, 0),
(1930, 'Europe', '欧洲', '英国', NULL, '130.88.1.0', '130.88.255.255', 10, 10, 10, 10, 0),
(1931, 'Europe', '欧洲', '英国', NULL, '150.204.0.0', '150.204.255.255', 10, 10, 10, 10, 0),
(1932, 'Europe', '欧洲', '英国', NULL, '172.188.0.0', '172.188.255.255', 10, 10, 10, 10, 0),
(1933, 'Europe', '欧洲', '英国', NULL, '195.153.0.0', '195.153.255.255', 10, 10, 10, 10, 0),
(1934, 'Europe', '欧洲', '英国', NULL, '218.48.51.0', '218.48.51.255', 10, 10, 10, 10, 0),
(1935, 'America', '美洲', '关岛', NULL, '202.20.112.0', '202.20.112.255', 10, 10, 10, 10, 0),
(1936, 'America', '美洲', '关岛', NULL, '202.128.0.0', '202.128.95.255', 10, 10, 10, 10, 0),
(1937, 'America', '美洲', '加拿大', NULL, '4.0.0.0', '4.255.255.255', 10, 10, 10, 10, 0),
(1938, 'America', '美洲', '加拿大', NULL, '24.0.0.0', '24.141.255.255', 10, 10, 10, 10, 0),
(1939, 'America', '美洲', '加拿大', NULL, '47.0.0.0', '47.255.255.255', 10, 10, 10, 10, 0),
(1940, 'America', '美洲', '加拿大', NULL, '142.0.0.0', '142.255.255.255', 10, 10, 10, 10, 0),
(1941, 'America', '美洲', '加拿大', NULL, '149.99.133.0', '149.99.133.255', 10, 10, 10, 10, 0),
(1942, 'America', '美洲', '加拿大', NULL, '152.174.114.0', '152.174.114.255', 10, 10, 10, 10, 0),
(1943, 'America', '美洲', '加拿大', NULL, '154.5.0.0', '154.20.70.255', 10, 10, 10, 10, 0),
(1944, 'America', '美洲', '加拿大', NULL, '172.161.213.0', '172.161.213.255', 10, 10, 10, 10, 0),
(1945, 'America', '美洲', '加拿大', NULL, '199.105.88.0', '199.105.88.255', 10, 10, 10, 10, 0),
(1946, 'America', '美洲', '加拿大', NULL, '209.148.228.0', '209.148.228.255', 10, 10, 10, 10, 0),
(1947, 'America', '美洲', '加拿大', NULL, '216.154.0.0', '216.154.255.255', 10, 10, 10, 10, 0),
(1948, 'America', '美洲', '坎布里奇', NULL, '4.48.92.0', '4.48.92.255', 10, 10, 10, 10, 0),
(1949, 'America', '美洲', '墨西哥', NULL, '148.246.49.0', '148.246.49.255', 10, 10, 10, 10, 0),
(1950, 'America', '美洲', '巴西', NULL, '200.0.0.0', '200.255.255.255', 10, 10, 10, 10, 0),
(1951, 'America', '美洲', '波多黎各', NULL, '192.188.173.0', '192.188.173.255', 10, 10, 10, 10, 0),
(1952, 'America', '美洲', '美国', NULL, '003.0.0.0', '3.255.255.255', 10, 10, 10, 10, 0),
(1953, 'America', '美洲', '美国', NULL, '12.74.0.0', '12.74.255.255', 10, 10, 10, 10, 0),
(1954, 'America', '美洲', '美国', NULL, '18.0.0.0', '18.255.255.255', 10, 10, 10, 10, 0),
(1955, 'America', '美洲', '美国', NULL, '48.0.0.0', '50.255.255.255', 10, 10, 10, 10, 0),
(1956, 'America', '美洲', '美国', NULL, '52.0.0.0', '52.255.255.255', 10, 10, 10, 10, 0),
(1957, 'America', '美洲', '美国', NULL, '54.0.0.0', '56.255.255.255', 10, 10, 10, 10, 0),
(1958, 'America', '美洲', '美国', NULL, '63.0.0.0', '66.27.255.255', 10, 10, 10, 10, 0),
(1959, 'America', '美洲', '美国', NULL, '130.39.0.0', '131.230.255.255', 10, 10, 10, 10, 0),
(1960, 'America', '美洲', '美国', NULL, '144.92.0.0', '144.92.255.255', 10, 10, 10, 10, 0),
(1961, 'America', '美洲', '美国', NULL, '151.0.0.0', '152.255.255.255', 10, 10, 10, 10, 0),
(1962, 'America', '美洲', '美国', NULL, '161.58.0.0', '161.58.255.255', 10, 10, 10, 10, 0),
(1963, 'America', '美洲', '美国', NULL, '162.42.0.0', '162.42.255.255', 10, 10, 10, 10, 0),
(1964, 'America', '美洲', '美国', NULL, '168.122.0.0', '168.122.255.255', 10, 10, 10, 10, 0),
(1965, 'America', '美洲', '美国', NULL, '171.208.0.0', '171.220.255.255', 10, 10, 10, 10, 0),
(1966, 'America', '美洲', '美国', NULL, '172.145.0.0', '172.156.255.255', 10, 10, 10, 10, 0),
(1967, 'America', '美洲', '美国', NULL, '172.172.0.0', '172.186.255.255', 10, 10, 10, 10, 0),
(1968, 'America', '美洲', '美国', NULL, '197.0.0.0', '198.255.255.255', 10, 10, 10, 10, 0),
(1969, 'America', '美洲', '美国', NULL, '199.0.0.0', '199.255.255.255', 10, 10, 10, 10, 0),
(1970, 'America', '美洲', '美国', NULL, '200.187.196.0', '200.187.198.255', 10, 10, 10, 10, 0),
(1971, 'America', '美洲', '美国', NULL, '201.0.0.0', '201.255.255.255', 10, 10, 10, 10, 0),
(1972, 'America', '美洲', '美国', NULL, '202.0.188.0', '202.0.255.255', 10, 10, 10, 10, 0),
(1973, 'America', '美洲', '美国', NULL, '204.0.0.0', '209.255.255.255', 10, 10, 10, 10, 0),
(1974, 'America', '美洲', '美国', NULL, '214.0.0.0', '215.255.255.255', 10, 10, 10, 10, 0),
(1975, 'America', '美洲', '美国', NULL, '216.0.0.0', '216.255.255.255', 10, 10, 10, 10, 0),
(1976, 'America', '美洲', '美国', NULL, '224.0.0.0', '224.255.255.255', 10, 10, 10, 10, 0),
(1977, 'America', '美洲', '阿根廷', NULL, '216.244.192.0', '216.244.207.255', 10, 10, 10, 10, 0),
(1978, 'Africa', '非洲', '加纳', '', '193.194.160.0', '193.194.191.255', 10, 10, 10, 10, 0),
(1979, 'Africa', '非洲', '南非/加勒比海', NULL, '196.0.0.0', '196.255.255.255', 10, 10, 10, 10, 0),
(1980, 'Africa', '非洲', '毛里求斯', NULL, '202.60.0.0', '202.60.31.255', 10, 10, 10, 10, 0),
(1981, 'APNIC', 'APNIC', 'APNIC', NULL, '202.2.128.0', '202.2.255.255', 10, 10, 10, 10, 0),
(1982, 'APNIC', 'APNIC', 'APNIC', NULL, '202.6.88.0', '202.6.89.255', 10, 10, 10, 10, 0),
(1983, 'APNIC', 'APNIC', 'APNIC', NULL, '202.8.128.0', '202.8.159.255', 10, 10, 10, 10, 0),
(1984, 'APNIC', 'APNIC', 'APNIC', NULL, '202.12.19.0', '202.12.21.255', 10, 10, 10, 10, 0),
(1985, 'APNIC', 'APNIC', 'APNIC', NULL, '202.12.27.0', '202.12.31.255', 10, 10, 10, 10, 0),
(1986, 'APNIC', 'APNIC', 'APNIC', NULL, '202.132.0.0', '202.133.255.255', 10, 10, 10, 10, 0),
(1987, 'APNIC', 'APNIC', 'APNIC', NULL, '202.135.0.0', '202.135.255.255', 10, 10, 10, 10, 0),
(1988, 'APNIC', 'APNIC', 'APNIC', NULL, '202.161.128.0', '202.161.159.255', 10, 10, 10, 10, 0),
(1989, 'APNIC', 'APNIC', 'APNIC', NULL, '202.167.0.0', '202.167.255.255', 10, 10, 10, 10, 0),
(1990, 'APNIC', 'APNIC', 'APNIC', NULL, '203.145.224.0', '203.145.255.255', 10, 10, 10, 10, 0),
(1991, 'APNIC', 'APNIC', 'APNIC', NULL, '203.163.0.0', '203.163.63.255', 10, 10, 10, 10, 0),
(1992, 'Local.Marchine', 'Local.Marchine', '本地机器', NULL, '127.0.0.0', '127.255.255.255', 10, 10, 10, 10, 0),
(1993, 'Unknown', 'Unknown', '未知地区', NULL, '61.0.0.0', '61.255.255.255', 10, 10, 10, 10, 0),
(1994, 'Unknown', 'Unknown', '未知地区', NULL, '202.0.0.0', '202.255.255.255', 10, 10, 10, 10, 0),
(1995, 'Unknown', 'Unknown', '未知地区', NULL, '218.0.0.0', '218.255.255.255', 10, 10, 10, 10, 0),
(1996, 'Unknown', 'Unknown', '未知地区', NULL, '222.205.128.0', '222.205.255.255', 10, 10, 10, 10, 0);

-- --------------------------------------------------------

--
-- Table structure for table `loginattempts`
--

CREATE TABLE IF NOT EXISTS `loginattempts` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `ip` varchar(15) NOT NULL default '',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `banned` enum('yes','no') NOT NULL default 'no',
  `attempts` int(10) NOT NULL default '0',
  `type` enum('login','recover') NOT NULL default 'login',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `loginattempts`
--


-- --------------------------------------------------------

--
-- Table structure for table `media`
--

CREATE TABLE IF NOT EXISTS `media` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_index` int(10) unsigned NOT NULL default '0',
  `source_desc` varchar(30) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

--
-- Dumping data for table `media`
--

INSERT INTO `media` (`id`, `name`, `image`, `sort_index`, `source_desc`) VALUES
(1, 'Blu-ray', '', 0, ''),
(2, 'HD DVD', '', 1, ''),
(4, 'MiniBD', '', 4, ''),
(5, 'HDTV', '', 5, ''),
(6, 'DVDR', '', 6, ''),
(7, 'Encode', '', 3, ''),
(3, 'Remux', '', 2, ''),
(8, 'CD', '', 7, ''),
(9, 'Track', '', 9, '');

-- --------------------------------------------------------

--
-- Table structure for table `messages`
--

CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `sender` int(10) unsigned NOT NULL default '0',
  `receiver` int(10) unsigned NOT NULL default '0',
  `added` datetime default NULL,
  `subject` varchar(100) NOT NULL default 'No Subject',
  `msg` text,
  `unread` enum('yes','no') NOT NULL default 'yes',
  `poster` bigint(20) unsigned NOT NULL default '0',
  `location` smallint(6) NOT NULL default '1',
  `saved` enum('no','yes') NOT NULL default 'no',
  PRIMARY KEY  (`id`),
  KEY `receiver` (`receiver`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `messages`
--


-- --------------------------------------------------------

--
-- Table structure for table `modpanel`
--

CREATE TABLE IF NOT EXISTS `modpanel` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `url` varchar(50) default NULL,
  `info` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1016 ;

--
-- Dumping data for table `modpanel`
--

INSERT INTO `modpanel` (`id`, `name`, `url`, `info`) VALUES
(1000, 'Leechers', 'leechers.php', 'Show users with ratio under 0.40'),
(1001, 'Uploaders info panel', 'uploaderinfopanel.php', 'Addon to monitor uploades activity'),
(1002, 'Ratio above 100', 'ratio100.php', 'Show users with ratio above 100'),
(1003, 'Abnormal Upload Speed Detector', 'cheaters.php', 'See cheaters'),
(1004, 'Duplicate IP Check', 'ipcheck.php', 'Check for Duplicate IP Users'),
(1005, 'All Clients (currently)', 'allagents.php', 'Show All Clients (currently downloading/uploading/seeding)'),
(1006, 'User List', 'userslist.php', 'List Registered Users.'),
(1007, 'Staffbox', 'staffbox.php', 'Staffbox (Staff Contacts)'),
(1009, 'Polls', 'makepoll.php', 'Make a Poll'),
(1012, 'Uploaders', 'uploaders.php', 'Uploaders'),
(1011, 'List Polls', 'polloverview.php', 'List Polls'),
(1013, 'Stats', 'stats.php', 'Tracker Stats'),
(1014, 'IP Test', 'testip.php', 'Test if IP is banned'),
(1015, 'Reports', 'reports.php', 'Show Reports (forum,comment,torrent)');

-- --------------------------------------------------------

--
-- Table structure for table `news`
--

CREATE TABLE IF NOT EXISTS `news` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` int(11) NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `body` text NOT NULL,
  `title` varchar(255) NOT NULL default '',
  `notify` enum('yes','no') NOT NULL default 'no',
  PRIMARY KEY  (`id`),
  KEY `added` (`added`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `news`
--


-- --------------------------------------------------------

--
-- Table structure for table `notconnectablepmlog`
--

CREATE TABLE IF NOT EXISTS `notconnectablepmlog` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user` int(10) unsigned NOT NULL default '0',
  `date` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `notconnectablepmlog`
--


-- --------------------------------------------------------

--
-- Table structure for table `offers`
--

CREATE TABLE IF NOT EXISTS `offers` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` int(10) unsigned NOT NULL default '0',
  `name` varchar(225) default NULL,
  `descr` text NOT NULL,
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `allowedtime` datetime default '0000-00-00 00:00:00',
  `yeah` int(10) unsigned NOT NULL default '0',
  `against` int(10) unsigned NOT NULL default '0',
  `category` int(10) NOT NULL default '0',
  `comments` int(10) NOT NULL default '0',
  `allowed` enum('allowed','pending','denied') NOT NULL default 'pending',
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `offers`
--


-- --------------------------------------------------------

--
-- Table structure for table `offervotes`
--

CREATE TABLE IF NOT EXISTS `offervotes` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `offerid` int(10) unsigned NOT NULL default '0',
  `userid` int(10) unsigned NOT NULL default '0',
  `vote` enum('yeah','against') NOT NULL default 'yeah',
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `offervotes`
--


-- --------------------------------------------------------

--
-- Table structure for table `overforums`
--

CREATE TABLE IF NOT EXISTS `overforums` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(60) NOT NULL,
  `description` varchar(200) default NULL,
  `minclassview` tinyint(3) unsigned NOT NULL default '0',
  `forid` tinyint(3) unsigned NOT NULL default '1',
  `sort` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `overforums`
--


-- --------------------------------------------------------

--
-- Table structure for table `peers`
--

CREATE TABLE IF NOT EXISTS `peers` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `torrent` int(10) unsigned NOT NULL default '0',
  `peer_id` varbinary(20) NOT NULL,
  `ip` varchar(64) NOT NULL default '',
  `ip2` varchar(64) NOT NULL,
  `port` smallint(5) unsigned NOT NULL default '0',
  `uploaded` bigint(20) unsigned NOT NULL default '0',
  `downloaded` bigint(20) unsigned NOT NULL default '0',
  `to_go` bigint(20) unsigned NOT NULL default '0',
  `seeder` enum('yes','no') NOT NULL default 'no',
  `started` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_action` datetime NOT NULL default '0000-00-00 00:00:00',
  `prev_action` datetime NOT NULL default '0000-00-00 00:00:00',
  `connectable` enum('yes','no') NOT NULL default 'yes',
  `userid` int(10) unsigned NOT NULL default '0',
  `agent` varchar(60) NOT NULL default '',
  `finishedat` int(10) unsigned NOT NULL default '0',
  `downloadoffset` bigint(20) unsigned NOT NULL default '0',
  `uploadoffset` bigint(20) unsigned NOT NULL default '0',
  `passkey` varchar(32) NOT NULL default '',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `torrent_peer_id` (`torrent`,`peer_id`),
  KEY `torrent` (`torrent`),
  KEY `torrent_seeder` (`torrent`,`seeder`),
  KEY `last_action` (`last_action`),
  KEY `connectable` (`connectable`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `peers`
--


-- --------------------------------------------------------

--
-- Table structure for table `pmboxes`
--

CREATE TABLE IF NOT EXISTS `pmboxes` (
  `id` int(11) NOT NULL auto_increment,
  `userid` int(11) NOT NULL,
  `boxnumber` tinyint(4) NOT NULL default '2',
  `name` varchar(15) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `pmboxes`
--


-- --------------------------------------------------------

--
-- Table structure for table `pollanswers`
--

CREATE TABLE IF NOT EXISTS `pollanswers` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `pollid` int(10) unsigned NOT NULL default '0',
  `userid` int(10) unsigned NOT NULL default '0',
  `selection` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `pollid` (`pollid`),
  KEY `selection` (`selection`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `pollanswers`
--


-- --------------------------------------------------------

--
-- Table structure for table `polls`
--

CREATE TABLE IF NOT EXISTS `polls` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `question` varchar(255) NOT NULL default '',
  `option0` varchar(40) NOT NULL default '',
  `option1` varchar(40) NOT NULL default '',
  `option2` varchar(40) NOT NULL default '',
  `option3` varchar(40) NOT NULL default '',
  `option4` varchar(40) NOT NULL default '',
  `option5` varchar(40) NOT NULL default '',
  `option6` varchar(40) NOT NULL default '',
  `option7` varchar(40) NOT NULL default '',
  `option8` varchar(40) NOT NULL default '',
  `option9` varchar(40) NOT NULL default '',
  `option10` varchar(40) NOT NULL default '',
  `option11` varchar(40) NOT NULL default '',
  `option12` varchar(40) NOT NULL default '',
  `option13` varchar(40) NOT NULL default '',
  `option14` varchar(40) NOT NULL default '',
  `option15` varchar(40) NOT NULL default '',
  `option16` varchar(40) NOT NULL default '',
  `option17` varchar(40) NOT NULL default '',
  `option18` varchar(40) NOT NULL default '',
  `option19` varchar(40) NOT NULL default '',
  `sort` enum('yes','no') NOT NULL default 'yes',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `polls`
--


-- --------------------------------------------------------

--
-- Table structure for table `posts`
--

CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `topicid` int(10) unsigned NOT NULL default '0',
  `userid` int(10) unsigned NOT NULL default '0',
  `added` datetime default NULL,
  `body` text,
  `editedby` int(10) unsigned NOT NULL default '0',
  `editdate` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY `topicid` (`topicid`),
  KEY `userid` (`userid`),
  FULLTEXT KEY `body` (`body`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `posts`
--


-- --------------------------------------------------------

--
-- Table structure for table `processings`
--

CREATE TABLE IF NOT EXISTS `processings` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_index` int(10) unsigned NOT NULL default '0',
  `processing_desc` varchar(30) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `processings`
--

INSERT INTO `processings` (`id`, `name`, `image`, `sort_index`, `processing_desc`) VALUES
(1, 'Raw/Remux', '', 0, ''),
(2, 'Re-encode/Rip', '', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE IF NOT EXISTS `ratings` (
  `torrent` int(10) unsigned NOT NULL default '0',
  `user` int(10) unsigned NOT NULL default '0',
  `rating` tinyint(3) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`torrent`,`user`),
  KEY `user` (`user`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `ratings`
--


-- --------------------------------------------------------

--
-- Table structure for table `readposts`
--

CREATE TABLE IF NOT EXISTS `readposts` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` int(10) unsigned NOT NULL default '0',
  `topicid` int(10) unsigned NOT NULL default '0',
  `lastpostread` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `userid` (`id`),
  KEY `topicid` (`topicid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `readposts`
--


-- --------------------------------------------------------

--
-- Table structure for table `regimages`
--

CREATE TABLE IF NOT EXISTS `regimages` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `imagehash` varchar(32) NOT NULL default '',
  `imagestring` varchar(8) NOT NULL default '',
  `dateline` bigint(30) NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `regimages`
--


-- --------------------------------------------------------

--
-- Table structure for table `reports`
--

CREATE TABLE IF NOT EXISTS `reports` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `addedby` int(10) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `reportid` int(10) unsigned NOT NULL default '0',
  `type` enum('torrent','user','offer','request','post','comment','subtitle') NOT NULL default 'torrent',
  `reason` varchar(255) NOT NULL default '',
  `dealtby` int(10) unsigned NOT NULL default '0',
  `dealtwith` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `reports`
--


-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE IF NOT EXISTS `requests` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` int(10) unsigned NOT NULL default '0',
  `request` varchar(225) default NULL,
  `descr` text NOT NULL,
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `hits` int(10) unsigned NOT NULL default '0',
  `cat` int(10) unsigned NOT NULL default '0',
  `filledby` int(10) unsigned NOT NULL default '0',
  `filledurl` varchar(70) default NULL,
  `filled` enum('yes','no') NOT NULL default 'no',
  `comments` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`),
  KEY `id_added` (`id`,`added`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `requests`
--


-- --------------------------------------------------------

--
-- Table structure for table `reviews`
--

CREATE TABLE IF NOT EXISTS `reviews` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user` int(10) unsigned NOT NULL default '0',
  `torrent` int(10) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `text` text NOT NULL,
  `ori_text` text NOT NULL,
  `editedby` int(10) unsigned NOT NULL default '0',
  `editdate` datetime NOT NULL default '0000-00-00 00:00:00',
  `imdb_id` varchar(255) NOT NULL,
  `imdb_name` varchar(255) NOT NULL,
  `douban_id` varchar(255) NOT NULL,
  `douban_name` varchar(255) NOT NULL,
  `lastfm_artist` varchar(255) NOT NULL,
  `lastfm_album` varchar(255) NOT NULL,
  `bonus_change` int(10) NOT NULL default '0',
  `reason` varchar(255) NOT NULL,
  `markedby` int(10) NOT NULL,
  `markdate` datetime NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `user` (`user`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `reviews`
--


-- --------------------------------------------------------

--
-- Table structure for table `rules`
--

CREATE TABLE IF NOT EXISTS `rules` (
  `id` int(11) NOT NULL auto_increment,
  `lang_id` int(10) unsigned NOT NULL default '6',
  `title` varchar(255) NOT NULL,
  `text` text NOT NULL,
  `public` enum('yes','no') NOT NULL default 'yes',
  `class` int(11) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=29 ;

--
-- Dumping data for table `rules`
--

INSERT INTO `rules` (`id`, `lang_id`, `title`, `text`, `public`, `class`) VALUES
(1, 25, '总则 - <font class=striking>不遵守这些将导致帐号被封！</font>', '[*]请不要做管理员明文禁止的事情。\r\n[*]不允许发送垃圾信息。\r\n[*]账号保留规则：\r\n              1.[b]Veteran User[/b]及以上等级用户会永远保留；\r\n              2.[b]Elite User[/b]及以上等级用户封存账号（在[url=usercp.php?action=personal]控制面板[/url]）后不会被删除帐号；\r\n              3.封存账号的用户连续400天不登录将被删除帐号；\r\n              4.未封存账号的用户连续150天不登录将被删除帐号；\r\n              5.没有流量的用户（即上传/下载数据都为0）连续100天不登录将被删除帐号。\r\n[*]一切作弊的帐号会被封，请勿心存侥幸。\r\n[*]注册多个[site]账号的用户将被禁止。\r\n[*]不要把本站的种子文件上传到其他Tracker！(具体请看[url=faq.php#38][b]常见问题[/b][/url])\r\n[*]第一次在论坛或服务器中的捣乱行为会受到警告，第二次您将永远无缘[site] 。', 'yes', 0),
(2, 25, '下载规则 - <font class=striking>违规将会失去下载权限！</font>', '[*]过低的分享率会导致严重的后果，包括禁止帐号。详见[url=faq.php#22]常见问题[/url]。\r\n[*]关于促销种子的标准：\r\n            [*]随机促销（种子上传后系统自动随机设为促销）：\r\n                        [*]2%的概率成为[color=yellow]免费[/color]；\r\n                        [*]2%的概率成为[color=grey]2X上传[/color]；\r\n                        [*]1%的概率成为[color=green]免费且2X上传[/color]。\r\n            [*]电视剧每季的第一集将成为[color=yellow]免费[/color]。\r\n            [*]关注度高的种子（由管理员定夺）将成为[color=yellow]免费[/color]。\r\n            [*]Blu-ray Disk，HD DVD原盘将成为[color=green]免费且2X上传[/color]。\r\n            [*]我们也将不定期开启全站[color=yellow]免费[/color]，届时尽情狂欢吧~:mml:  :mml:  :mml:\r\n[*]你只能使用允许的BT客户端下载本站资源。详见[url=faq.php#29]常见问题[/url]。', 'yes', 0),
(4, 25, '论坛总则 - <font class=striking>请遵循以下的守则，违规会受到警告！</font>', '[*]禁止攻击、挑动他人的言辞。\r\n[*]禁止恶意灌水或发布垃圾信息。请勿在论坛非Water Jar版块发布无意义主题或回复（如纯表情）等。\r\n[*]不要为了获取魔力值而大肆灌水。\r\n[*]禁止在标题或正文使用脏话。\r\n[*]不要讨论禁忌、政治敏感或当地法律禁止的话题。\r\n[*]禁止任何基于种族、国家、民族、肤色、宗教、性别、年龄、性取向、身体或精神障碍的歧视性言辞。违规将导致账号永久性禁用。\r\n[*]禁止挖坟（所有挖坟帖都要被删掉）。\r\n[*]禁止重复发帖。\r\n[*]请确保问题发布在相对应的板块。\r\n[*]365天无新回复的主题将被系统自动锁定.\r\n', 'yes', 0),
(6, 25, '头像使用规定 - <font class=striking>请尽量遵守以下规则</font>', '[*]允许的格式为.gif， .jpg， 和.png。\r\n[*]图片大小不能超过150KB，为了统一，系统会调整头像宽度到150像素大小（浏览器会把图片调整成合适的大小，小图片将被拉伸，而过大的图片只会浪费带宽和CPU) 。\r\n[*]请不要使用可能引起别人反感的图片，包括色情、宗教、血腥的动物/人类、宣扬某种意识形态的图片。如果你不确定某张图片是否合适，请站短管理员。', 'yes', 0),
(3, 25, '上传规则 - <font class=striking> 谨记: 违规的种子将不经提醒而直接删除 </font>', '[*]上传者必须对上传的文件拥有合法的传播权。\r\n[*]发布者必须在做种时间达到24小时且有至少3个做种者后方可撤种。\r\n[*]违规的种子将不经提醒而直接删除。\r\n[*]如果你有一些违规但却有价值的资源，请将详细情况[url=contactstaff.php]告知管理组[/url]，我们可能破例允许其发布。\r\n[*][b]哪些人能上传资源？[/b]\r\n            [*]任何人都能上传。不过，有些用户发种前需要先经过[b]候选[/b]区。详见[url=faq.php#36]常见问题[/url]。\r\n            [*]目前，只有[b]上传员[/b]及以上等级的用户，或者是管理组特别指定的用户才能自由上传游戏资源。其它所有用户都需先经过[b]候选[/b]区。\r\n[*][b]我能上传哪些资源？[/b]\r\n            [*][b]允许[/b]\r\n                        [*]高清（HD）视频文件，包括完整高清媒介（如Blu-ray Disk, HD DVD）， HDTV录制，高清重编码（re-encode）；\r\n                        [*]标清（SD）视频文件，只能是DVDR、来源为高清的重编码（如480p）或DVDRip、CNDVDRip；\r\n                        [*]无损或多声道音乐文件（如FLAC，DTS，Monkey''s Audio）；\r\n                        [*]包含评论、配音、原声等的音轨文件；\r\n                        [*]PC游戏；\r\n                        [*]7日内发布的高清预告片；\r\n                        [*]高清相关的软件和文档。\r\n            [*][b]不允许[/b]\r\n                        [*]总文件小于100MB的内容（软件和文档除外）；\r\n                        [*]Dupe的版本（但已发的Dupe版本会被保留）；\r\n                        [*]由标清视频经过重灌制/制造而成的upscaled/部分upscaled视频文件；\r\n                        [*]属于标清级别但低画质的视频文件，包括CAM, TS, SCR, DVDSRC, R5, HalfCD；\r\n                        [*]RealVideo文件（通常封装于RMVB或RM）；\r\n                        [*]无准确对应cue sheet的原始或重编码（如FLAC，Monkey''s Audio）的CD映像文件；\r\n                        [*]使用RAR分卷压缩的内容（请解压后再上传，软件、字幕、游戏补丁例外）；\r\n                        [*]包含病毒、木马、垃圾文件、广告或其它无关文件的内容。\r\n            [*][b]Dupe规则[/b]\r\n                        [*]当前最佳画质的来源经重编码而成的DVD5大小（即4.3 GB左右）的版本永远都允许发布。\r\n                        [*]符合以下情况的新版本可以发布（旧版本将被视为Dupe）：\r\n                                   [*]旧版本已连续断种7日以上；\r\n                                   [*]新版本没有旧版本中已确认的错误/画质问题，或新版本的来源有更好的画质；\r\n                                   [*]旧版本已发布18个月以上。\r\n                        [*]高清版本将使得标清版本成为Dupe。\r\n                        [*]来自其它区域、包含不同配音和/或字幕的Blu-ray Disk/HD DVD版本不被视为Dupe。\r\n[*][b]种子信息[/b]\r\n            [*][b]不要[/b]去除或改变管理员对种子的修改。\r\n            [*][b]种子标题命名[/b]\r\n                        [*]电影：\r\n                                    [i][中文名].名称.[剪辑版本].[年份].[发布说明].分辨率.来源.视频编码.[音频编码]-制作者信息[/i]\r\n                                    如：[i]蝙蝠侠:黑暗骑士.The.Dark.Knight.2008.PROPER.720p.BluRay.x264-SiNNERS[/i]\r\n                        [*]电视剧：\r\n                                    [i][中文名].名称.[剪辑版本].S**E**.[年份].[发布说明].分辨率.来源.视频编码.[音频编码]-制作者信息[/i]\r\n                                    如：[i]越狱.Prison.Break.S04E01.PROPER.720p.HDTV.x264-CTU[/i]\r\n                        [*]PC游戏：\r\n                                   [i][中文名].名称.[版本].[年份].[发布说明]-制作者信息[/i]\r\n                                   如：[i]失落的星球：殖民地.Lost.Planet.Extreme.Condition.Colonies.MULTi9-PROPHET[/i]\r\n                        [*]音乐：\r\n                                    [i][中文艺术家名].-.[中文专辑名].艺术家名.-.专辑名.[版本].年份.[发布说明].音频编码-[制作者信息][/i]\r\n                                    如：[i]恩雅.-.冬季降临.Enya.-.And.Winter.Came.2008.FLAC[/i]\r\n            [*][b]副标题[/b]\r\n                        [*]不要包含广告或求种/续种请求。\r\n            [*][b]简介[/b]\r\n                        [*]NFO图请写入到NFO文件里，不要粘贴到简介里。\r\n                        [*]电影、电视剧：\r\n                                    [*]必须包含海报、横幅或BD/HDDVD/DVD封面（如果存在的话）； \r\n                                    [*]方便的话，请包含画面截图或其缩略图和链接；\r\n                                    [*]方便的话，请包含文件的详细情况，包括格式、时长、编码、码率、分辨率、语言、字幕等；\r\n                                    [*]方便的话，请包含剧情概要。\r\n                        [*]PC游戏：\r\n                                    [*]必须包含海报或BD/HDDVD/DVD封面（如果存在的话）。\r\n                                    [*]方便的话，请包含画面截图或其缩略图和链接。\r\n                        [*]体育节目：\r\n                                    [*]不要在文字介绍或通过截图/文件名/文件大小/时长泄漏比赛结果。\r\n                        [*]音乐：\r\n                                    [*]必须包含CD封面（如果存在的话）；\r\n                                    [*]方便的话，请包含专辑的曲目列表。\r\n            [*][b]外部信息[/b]\r\n                        [*]电影和电视剧必须包含外部信息链接地址（如果存在的话）。\r\n            [*][b]其它[/b]\r\n                        [*]请确保选择正确的类型和质量。', 'yes', 0),
(8, 25, '管理守则 - <font class=striking>请慎用你的权限！</font>', '[*]最重要的一条：慎用你手中的权限！\r\n[*]对于违规行为不要怕说“不”！\r\n[*]不要公开和其他管理员冲突，一切通过私下沟通解决。\r\n[*]不要太绝情，给违规者一个改过的机会。\r\n[*]不要试图“打预防针”，等到人们犯错了再去纠正。\r\n[*]尝试去改正一个不适当的帖而不是简单的关闭它。\r\n[*]多尝试移动帖子到适合的版面而不是简单地锁帖。\r\n[*]当处理版聊帖的时候要宽容适度。\r\n[*]锁帖的时候请给予简单的操作理由。\r\n[*]在屏蔽某个用户前请先站短通知他/她, 如果有所积极回应可以考虑再给2周观察期。\r\n[*]不要禁用一个注册尚未满4周的帐户。\r\n[*]永远记得以理服人。', 'no', 11),
(12, 28, '下載規則 - <font class=striking>違規將會失去下載權限！</font> ', '[*]過低的分享率會導致嚴重的后果，包括禁止帳號。詳見[url=faq.php#22]常見問題[/url]。\r\n[*]關于促銷種子的標准：\r\n            [*]隨機促銷（種子上傳后系統自動隨機設為促銷）：\r\n                        [*]2%的概率成為[color=yellow]免費[/color]；\r\n                        [*]2%的概率成為[color=grey]2X上傳[/color]；\r\n                        [*]1%的概率成為[color=green]免費且2X上傳[/color]。\r\n            [*]電視劇每季的第一集將成為[color=yellow]免費[/color]。\r\n            [*]關注度高的種子（由管理員定奪）將成為[color=yellow]免費[/color]。\r\n            [*]Blu-ray Disk，HD DVD原槃將成為[color=green]免費且2X上傳[/color]。\r\n            [*]我們也將不定期開啟全站[color=yellow]免費[/color]，屆時盡情狂歡吧~:mml:  :mml:  :mml:\r\n[*]你只能使用允許的BT客戶端下載本站資源。詳見[url=faq.php#29]常見問題[/url]。', 'yes', 0),
(14, 28, '論壇總則 - <font class=striking>請遵循以下的守則，違規會受到警告！</font> ', '[*]禁止攻擊、挑動他人的言辭。\r\n[*]禁止惡意灌水或發布垃圾信息。請勿在論壇非Water Jar版塊發布無意義主題或回復（如純表情）等。\r\n[*]不要為了獲取魔力值而大肆灌水。\r\n[*]禁止在標題或正文使用臟話。\r\n[*]不要討論禁忌、政治敏感或當地法律禁止的話題。\r\n[*]禁止任何基于種族、國家、民族、膚色、宗教、性別、年齡、性取向、身體或精神障礙的歧視性言辭。違規將導致賬號永久性禁用。\r\n[*]禁止挖墳（所有挖墳帖都要被刪掉）。\r\n[*]禁止重復發帖。\r\n[*]請確保問題發布在相對應的板塊。\r\n[*]365天無新回復的主題將被系統自動鎖定。', 'yes', 0),
(5, 25, '评论总则 - <font class=striking>永远尊重上传者！</font>', '[*]无论如何，请尊重上传者！\r\n[*]所有论坛发帖的规则同样适用于评论。\r\n[*]如果你没有下载的意向，请不要随便发表否定性的评论。', 'yes', 0),
(16, 28, '頭像使用規定 - <font class=striking>請盡量遵守以下規則</font> ', '[*]允許的格式為.gif， .jpg， 和.png。\r\n[*]圖片大小不能超過150KB，為了統一，系統會調整頭像寬度到150像素大小（瀏覽器會把圖片調整成合適的大小，小圖片將被拉伸，而過大的圖片只會浪費帶寬和CPU) 。\r\n[*]請不要使用可能引起別人反感的圖片，包括色情、宗教、血腥的動物/人類、宣揚某種意識形態的圖片。如果你不確定某張圖片是否合適，請站短管理員。\r\n', 'yes', 0),
(7, 25, '趣味盒规则 - <font class=striking>在娱乐中赚分</font>', '[*]任何用户都可在趣味盒中投放笑话、趣图、搞笑视频、Flash等有趣的内容，除了色情、禁忌、政治敏感和当地法律禁止的内容。\r\n[*]正常情况下，一条趣味内容在发布24小时后过期。然而，如果获得的投票数超过20且其中“有趣”的比例低于25%，趣味内容将提前过期。\r\n[*]新的趣味内容[b]只有[/b]在旧的内容过期后才能提交。\r\n[*]若趣味内容被多数用户投票认为有趣，其发布者将得到以下奖励：\r\n           [*]票数超过25，其中认为“有趣”比例超过50%，发布者得到50个魔力值。\r\n           [*]票数超过50，其中认为“有趣”比例超过50%，发布者得到另外的50个魔力值。\r\n           [*]票数超过100，其中认为“有趣”比例超过50%，发布者得到另外的50个魔力值。\r\n           [*]票数超过200，其中认为“有趣”比例超过50%，发布者得到另外的50个魔力值。\r\n           [*]票数超过25，其中认为“有趣”比例超过75%，发布者得到100个魔力值。\r\n           [*]票数超过50，其中认为“有趣”比例超过75%，发布者得到另外的100个魔力值。\r\n           [*]票数超过100，其中认为“有趣”比例超过75%，发布者得到另外的100个魔力值。\r\n           [*]票数超过200，其中认为“有趣”比例超过75%，发布者得到另外的100个魔力值。', 'yes', 0),
(11, 28, '總則 - <font class=striking>不遵守這些將導致帳號被封！</font> ', '[*]請不要做管理員明文禁止的事情。\r\n[*]不允許發送垃圾信息。\r\n[*]賬號保留規則：\r\n              1.[b]Veteran User[/b]及以上等級用戶會永遠保留；\r\n              2.[b]Elite User[/b]及以上等級用戶封存賬號（在[url=usercp.php?action=personal]控制面板[/url]）后不會被刪除帳號；\r\n              3.封存賬號的用戶連續400天不登錄將被刪除帳號；\r\n              4.未封存賬號的用戶連續150天不登錄將被刪除帳號；\r\n              5.沒有流量的用戶（即上傳/下載數據都為0）連續100天不登錄將被刪除帳號。\r\n[*]一切作弊的帳號會被封，請勿心存僥幸。\r\n[*]注冊多個[site]賬號的用戶將匾被禁止。\r\n[*]不要把本站的種子文件上傳到其他Tracker！(具體請看 [url=faq.php#38][b]常見問題[/b][/url])\r\n[*]第一次在論壇或服務器中的搗亂行為會受到警告，第二次您將永遠無緣[site] 。', 'yes', 0),
(13, 28, '上傳規則 - <font class=striking> 謹記: 違規的種子將不經提醒而直接刪除 </font> ', '[*]上傳者必須對上傳的文件擁有合法的傳播權。\r\n[*]發布者必須在做種時間達到24小時且有至少3個做種者后方可撤種。\r\n[*]違規的種子將不經提醒而直接刪除。\r\n[*]如果你有一些違規但卻有價值的資源，請將詳細情況[url=contactstaff.php]告知管理組[/url]，我們可能破例允許其發布。\r\n[*][b]哪些人能上傳資源？[/b]\r\n            [*]任何人都能上傳。不過，有些用戶發種前需要先經過[b]候選[/b]區。詳見[url=faq.php#36]常見問題[/url]。\r\n            [*]目前，只有[b]上傳員[/b]及以上等級的用戶，或者是管理組特別指定的用戶才能自由上傳游戲資源。其它所有用戶都需先經過[b]候選[/b]區。\r\n[*][b]我能上傳哪些資源？[/b]\r\n            [*][b]允許[/b]\r\n                        [*]高清（HD）視頻文件，包括完整高清媒介（如Blu-ray Disk, HD DVD）， HDTV錄制，高清重編碼（re-encode）；\r\n                        [*]標清（SD）視頻文件，只能是DVDR、來源為高清的重編碼（如480p）或DVDRip、CNDVDRip；\r\n                        [*]無損或多聲道音樂文件（如FLAC，DTS，Monkey''s Audio）；\r\n                        [*]包含評論、配音、原聲等的音軌文件；\r\n                        [*]PC游戲；\r\n                        [*]7日內發布的高清預告片；\r\n                        [*]高清相關的軟件和文檔。\r\n            [*][b]不允許[/b]\r\n                        [*]總文件小于100MB的內容（軟件和文檔除外）；\r\n                        [*]Dupe的版本（但已發的Dupe版本會被保留）；\r\n                        [*]由標清視頻經過重灌制/制造而成的upscaled/部分upscaled視頻文件；\r\n                        [*]屬于標清級別但低畫質的視頻文件，包括CAM, TS, SCR, DVDSRC, R5, HalfCD；\r\n                        [*]RealVideo文件（通常封裝于RMVB或RM）；\r\n                        [*]無准確對應cue sheet的原始或重編碼（如FLAC，Monkey''s Audio）的CD映像文件；\r\n                        [*]使用RAR分卷壓縮的內容（請解壓后再上傳，軟件、字幕、游戲補丁例外）；\r\n                        [*]包含病毒、木馬、垃圾文件、廣告或其它無關文件的內容。\r\n            [*][b]Dupe規則[/b]\r\n                        [*]當前最佳畫質的來源經重編碼而成的DVD5大小（即4.3 GB左右）的版本永遠都允許發布。\r\n                        [*]符合以下情況的新版本可以發布（舊版本將被視為Dupe）：\r\n                                   [*]舊版本已連續斷種7日以上；\r\n                                   [*]新版本沒有舊版本中已確認的錯誤/畫質問題，或新版本的來源有更好的畫質；\r\n                                   [*]舊版本已發布18個月以上。\r\n                        [*]高清版本將使得標清版本成為Dupe。\r\n                        [*]來自其它區域、包含不同配音和/或字幕的Blu-ray Disk/HD DVD版本不被視為Dupe。\r\n[*][b]種子信息[/b]\r\n            [*][b]不要[/b]去除或改變管理員對種子的修改。\r\n            [*][b]種子標題命名[/b]\r\n                        [*]電影：\r\n                                    [i][中文名].名稱.[剪輯版本].[年份].[發布說明].分辨率.來源.視頻編碼.[音頻編碼]-制作者信息[/i]\r\n                                    如：[i]蝙蝠俠:黑暗騎士.The.Dark.Knight.2008.PROPER.720p.BluRay.x264-SiNNERS[/i]\r\n                        [*]電視劇：\r\n                                    [i][中文名].名稱.[剪輯版本].S**E**.[年份].[發布說明].分辨率.來源.視頻編碼.[音頻編碼]-制作者信息[/i]\r\n                                    如：[i]越獄.Prison.Break.S04E01.PROPER.720p.HDTV.x264-CTU[/i]\r\n                        [*]PC游戲：\r\n                                   [i][中文名].名稱.[版本].[年份].[發布說明]-制作者信息[/i]\r\n                                   如：[i]失落的星球：殖民地.Lost.Planet.Extreme.Condition.Colonies.MULTi9-PROPHET[/i]\r\n                        [*]音樂：\r\n                                    [i][中文藝朮家名].-.[中文專輯名].藝朮家名.-.專輯名.[版本].年份.[發布說明].音頻編碼-[制作者信息][/i]\r\n                                    如：[i]恩雅.-.冬季降臨.Enya.-.And.Winter.Came.2008.FLAC[/i]\r\n            [*][b]副標題[/b]\r\n                        [*]不要包含廣告或求種/續種請求。\r\n            [*][b]簡介[/b]\r\n                        [*]NFO圖請寫入到NFO文件里，不要粘貼到簡介里。\r\n                        [*]電影、電視劇：\r\n                                    [*]必須包含海報、橫幅或BD/HDDVD/DVD封面（如果存在的話）； \r\n                                    [*]方便的話，請包含畫面截圖或其縮略圖和鏈接；\r\n                                    [*]方便的話，請包含文件的詳細情況，包括格式、時長、編碼、碼率、分辨率、語言、字幕等；\r\n                                    [*]方便的話，請包含劇情概要。\r\n                        [*]PC游戲：\r\n                                    [*]必須包含海報或BD/HDDVD/DVD封面（如果存在的話）。\r\n                                    [*]方便的話，請包含畫面截圖或其縮略圖和鏈接。\r\n                        [*]體育節目：\r\n                                    [*]不要在文字介紹或通過截圖/文件名/文件大小/時長泄漏比賽結果。\r\n                        [*]音樂：\r\n                                    [*]必須包含CD封面（如果存在的話）；\r\n                                    [*]方便的話，請包含專輯的曲目列表。\r\n            [*][b]外部信息[/b]\r\n                        [*]電影和電視劇必須包含外部信息鏈接地址（如果存在的話）。\r\n            [*][b]其它[/b]\r\n                        [*]請確保選擇正確的類型和質量。', 'yes', 0),
(18, 28, '管理守則 - <font class=striking>請慎用你的權限！</font> ', '[*]最重要的一條：慎用你手中的權限！\r\n[*]對于違規行為不要怕說“不”！\r\n[*]不要公開和其他管理員沖突，一切通過私下溝通解決。\r\n[*]不要太絕情，給違規者一個改過的機會。\r\n[*]不要試圖“打預防針”，等到人們犯錯了再去糾正。\r\n[*]嘗試去改正一個不適當的帖而不是簡單的關閉它。\r\n[*]多嘗試移動帖子到適合的版面而不是簡單地鎖帖。\r\n[*]當處理版聊帖的時候要寬容適度。\r\n[*]鎖帖的時候請給予簡單的操作理由。\r\n[*]在屏蔽某個用戶前請先站短通知他/她, 如果有所積極回應可以考慮再給2周觀察期。\r\n[*]不要禁用一個注冊尚未滿4周的帳戶。\r\n[*]永遠記得以理服人。\r\n', 'no', 11),
(17, 28, '趣味盒規則 - <font class=striking>在娛樂中賺分</font> ', '[*]任何用戶都可在趣味盒中投放笑話、趣圖、搞笑視頻、Flash等有趣的內容，除了色情、禁忌、政治敏感和當地法律禁止的內容。\r\n[*]正常情況下，一條趣味內容在發布24小時后過期。然而，如果獲得的投票數超過20且其中“有趣”的比例低于25%，趣味內容將提前過期。\r\n[*]新的趣味內容[b]只有[/b]在舊的內容過期后才能提交。\r\n[*]若趣味內容被多數用戶投票認為有趣，其發布者將得到以下獎勵：\r\n           [*]票數超過25，其中認為“有趣”比例超過50%，發布者得到50個魔力值。\r\n           [*]票數超過50，其中認為“有趣”比例超過50%，發布者得到另外的50個魔力值。\r\n           [*]票數超過100，其中認為“有趣”比例超過50%，發布者得到另外的50個魔力值。\r\n           [*]票數超過200，其中認為“有趣”比例超過50%，發布者得到另外的50個魔力值。\r\n           [*]票數超過25，其中認為“有趣”比例超過75%，發布者得到100個魔力值。\r\n           [*]票數超過50，其中認為“有趣”比例超過75%，發布者得到另外的100個魔力值。\r\n           [*]票數超過100，其中認為“有趣”比例超過75%，發布者得到另外的100個魔力值。\r\n           [*]票數超過200，其中認為“有趣”比例超過75%，發布者得到另外的100個魔力值。', 'yes', 0),
(21, 6, 'General rules - <font class=striking>Breaking these rules can and will get you banned!</font>', '[*]Do not do things we forbid.\r\n[*]Do not spam.\r\n[*]Cherish your user account. Inactive accounts would be deleted based on the following rules:\r\n              1.[b]Veteran User[/b] or above would never be deleted.\r\n              2.[b]Elite User[/b] or above would never be deleted if packed (at [url=usercp.php?action=personal]User CP[/url]).\r\n              3.Packed accounts would be deleted if users have not logged in for more than 400 days in a row.\r\n              4.Unpacked accounts would be deleted if users have not logged in for more than 150 days in a row.\r\n              5.Accounts with both uploaded and downloaded amount being 0 would be deleted if users have not logged in for more than 100 days in a row.\r\n[*]User found cheating would be deleted. Don''t take chances!\r\n[*]Possession of multiple [site] accounts will result in a ban!\r\n[*]Do not upload our torrents to other trackers! (See the [url=faq.php#38]FAQ[/url] for details.)\r\n[*]Disruptive behavior in the forums or on the server will result in a warning. You will only get [b]one[/b] warning! After that it''s bye bye Kansas!', 'yes', 0),
(15, 28, '評論總則 - <font class=striking>永遠尊重上傳者！</font> ', '[*]無論如何，請尊重上傳者！\r\n[*]所有論壇發帖的規則同樣適用于評論。\r\n[*]如果你沒有下載的意向，請不要隨便發表否定性的評論。', 'yes', 0),
(25, 6, 'Commenting Guidelines - <font class=striking>Always respect uploaders no matter what!</font>', '[*]Always respect uploaders no matter what!\r\n[*]All rules of forum posting apply to commenting, too.\r\n[*]Do not post negative comments about torrents that you don''t plan to download.', 'yes', 0),
(27, 6, 'Funbox Rules - <font class=striking>Get bonus with fun!</font>', '[*]Users can submit anything funny (e.g. stories, pictures, flash, video) except things that is pornographic, taboo, political sensitive or forbidden by local laws.\r\n[*]Normally a newly-submitted funbox item would be outdated after 24 hours. However, if there are 20 or more votes on a funbox item, among which votes for ''funny'' is less than 25%, the funbox item would be outdated ahead of its due time.\r\n[*]New funbox item can be submitted [b]only[/b] when the old one is outdated.\r\n[*]User, whose funbox item is voted as [b]funny[/b], would be rewarded based on the following rules:\r\n           [*]More than 25 votes, among which votes for [i]funny[/i] exceed 50%. User gets 50 bonus.\r\n           [*]More than 50 votes, among which votes for [i]funny[/i] exceed 50%. User gets another 50 bonus.\r\n           [*]More than 100 votes, among which votes for [i]funny[/i] exceed 50%. User gets another 50 bonus.\r\n           [*]More than 200 votes, among which votes for [i]funny[/i] exceed 50%. User gets another 50 bonus.\r\n           [*]More than 25 votes, among which votes for [i]funny[/i] exceed 75%. User gets 100 bonus.\r\n           [*]More than 50 votes, among which votes for [i]funny[/i] exceed 75%. User gets another 100 bonus.\r\n           [*]More than 100 votes, among which votes for [i]funny[/i] exceed 75%. User gets another 100 bonus.\r\n           [*]More than 200 votes, among which votes for [i]funny[/i] exceed 75%. User gets another 100 bonus.', 'yes', 0),
(22, 6, 'Downloading rules - <font class=striking>By not following these rules you will lose download privileges!</font>', '[*]Low ratios may result in severe consequences, including banning accounts. See [url=faq.php#22]FAQ[/url].\r\n[*]Rules for torrent promotion:\r\n            [*]Random promotion (torrents promoted randomly by system upon uploading):\r\n                        [*]2% chance becoming [color=yellow]Free Leech[/color].\r\n                        [*]2% chance becoming [color=grey]2X up[/color].\r\n                        [*]1% chance becoming [color=green]Free Leech and 2X up[/color].\r\n            [*]First episode of every season of TV Series would be [color=yellow]Free Leech[/color].\r\n            [*]Raw Blu-ray Disk, HD DVD would be [color=green]Free Leech and 2X up[/color].\r\n            [*]Highly popular torrents (decided by admins) would be [color=yellow]Free Leech[/color].\r\n            [*]On special occasions, we would set the whole site [color=yellow]Free Leech[/color]. Grab as much as you can. :mml:  :mml:  :mml:\r\n[*]You may [b]only[/b] use allowed bittorrent clients at [site]. See [url=faq.php#29]FAQ[/url].', 'yes', 0),
(24, 6, 'General Forum Guidelines - <font class=stiking>Please follow these guidelines or else you might end up with a warning!</font>', '[*]No aggressive behavior or flaming in the forums.\r\n[*]No trashing of any topics (i.e. SPAM). Do not submit meaningless topics or posts (e.g. smiley only) in any forum except Water Jar.\r\n[*]Do not flood any forum in order to get bonus.\r\n[*]No foul language on title or text.\r\n[*]Do not discuss topics that are taboo, political sensitive or forbidden by local laws.\r\n[*]No language of discrimination based on race, national or ethnic origin, color, religion, gender, age, sexual preference or mental or physical disability. Violating this rule would result in permanent ban.\r\n[*]No bumping... (All bumped threads will be deleted.)\r\n[*]No double posting. \r\n[*]Please ensure all questions are posted in the correct section!\r\n[*]Topics without new reply in 365 days would be locked automatically by system.', 'yes', 0),
(26, 6, 'Avatar Guidelines - <font class=striking>Please try to follow these guidelines</font>', '[*]The allowed formats are .gif, .jpg and .png. \r\n[*]Be considerate. Resize your images to a width of 150 px and a size of no more than 150 KB. (Browsers will rescale them anyway: smaller images will be expanded and will not look good; larger images will just waste bandwidth and CPU cycles.)\r\n[*]Do not use potentially offensive material involving porn, religious material, animal / human cruelty or ideologically charged images. Staff members have wide discretion on what is acceptable. If in doubt PM one. ', 'yes', 0),
(23, 6, 'Uploading rules - <font class=striking>Torrents violating these rules may be deleted without notice</font>', '[*]You must have legal rights to the file you uploaded.\r\n[*]Make sure your torrents are well-seeded for at least 24 hours and until 3 seeders are on the torrent.\r\n[*]Torrents violating rules may be deleted without notice.\r\n[*]If you have something interesting that somehow violates these rules, [url=contactstaff.php]ask the staff[/url] with a detailed description and we might make an exception.\r\n[*][b]Who can upload?[/b]\r\n            [*]Everyone can upload. However, some must go through the [b]Offers[/b] section. See [url=faq.php#36]FAQ[/url].\r\n            [*]Currently only [b]uploaders[/b] and above (or users specified by staff members) can upload games without going through the [b]Offers[/b] section.\r\n[*][b]What content can I upload?[/b]\r\n            [*][b]Allowed[/b]\r\n                        [*]High Definition video files, including complete HD media (e.g. Blu-ray Disk, HD DVD), HDTV-captured, re-encodes in HD resolution.\r\n                        [*]Standard Definition video files, only DVDR, re-encodes from HD source (e.g. 480p) and DVDRip, CN-DVDRip.\r\n                        [*]Lossless or multi-channel music files (e.g. FLAC, DTS, Monkey''s Audio).\r\n                        [*]Audio tracks containing commentaries, dubs, soundtracks, etc.\r\n                        [*]PC games.\r\n                        [*]HD Trailers released within 7 days.\r\n                        [*]HD related software and documents.\r\n            [*][b]Not allowed[/b]\r\n                        [*]Files of size no more than 100 MB (Exception: software and documents).\r\n                        [*]Dupe releases (dupe releases already uploaded will be kept).\r\n                        [*]Upscaled/partial upscaled in Standard Definition mastered/produced content.\r\n                        [*]Standard Definition video files with low quality, including CAM, TS, SCR, DVDSCR, R5, HalfCD.\r\n                        [*]RealVideo files (usually contained in RMVB or RM).\r\n                        [*]Raw or re-encoded (e.g. FLAC, Monkey''s Audio) CD image files without proper cue sheet.\r\n                        [*]Multi-volume RAR''ed content (Unrar it before uploading. Exception: software, subtitles, patches of games).\r\n                        [*]Content containing virus, trojan, trash, advertisement or any other unrelated file.\r\n            [*][b]Dupe Rules[/b]\r\n                        [*]One DVD5 sized (i.e. 4.3 GB) release from the best available source will always be allowed.\r\n                        [*]Under following conditions a new release can dupe an old release:\r\n                                   [*]Old release is dead for 7 days or longer;\r\n                                   [*]New release doesn''t contain the confirmed errors/glitches/problems of the old release or is based on a better source;\r\n                                   [*]Old release exists already 18 months or longer.\r\n                        [*]Releases in High Definition can dupe releases in Standard Definition.\r\n                        [*]Blu-ray Disk/HD DVD releases from another region containing different dubbing and/or subtitle aren''t considered to be dupe.\r\n[*][b]The Torrent[/b]\r\n            [*]Do [b]NOT[/b] remove or alter changes done by the staff.\r\n            [*][b]Naming/Title[/b]\r\n                        [*]For Movies:\r\n                                    [i][Chinese Name].Name.[Cut].[Year].[Release Info].Resolution.Source.Video Codec.[Audio Codec]-Tag[/i]\r\n                                    e.g. [i]蝙蝠侠:黑暗骑士.The.Dark.Knight.2008.PROPER.720p.BluRay.x264-SiNNERS[/i]\r\n                        [*]For TV Series/Mini-series:\r\n                                    [i][Chinese Name].Name.[Cut].S**E**.[Year].[Release Info].Resolution.Source.Video Codec.[Audio Codec]-Tag[/i]\r\n                                    e.g. [i]越狱.Prison.Break.S04E01.PROPER.720p.HDTV.x264-CTU[/i]\r\n                        [*]For PC Games:\r\n                                   [i][Chinese Name].Name.[Version].[Year].[Release Info]-Tag[/i]\r\n                                   e.g. [i]失落的星球：殖民地.Lost.Planet.Extreme.Condition.Colonies.MULTi9-PROPHET[/i]\r\n                        [*]For Music:\r\n                                    [i][Chinese Artist Name].-.[Chinese Album Name].Artist.-.Album Name.[Version].Year.[Release Info].Audio Codec-[Tag][/i]\r\n                                    e.g. [i]恩雅.-.冬季降临.Enya.-.And.Winter.Came.2008.FLAC[/i]\r\n            [*][b]Small description[/b]\r\n                        [*]No advertisements or asking for reseeding/requests.\r\n            [*][b]Description[/b]\r\n                        [*]Do not use the description for your NFO-artwork! Limit those artistic expressions to the NFO only.\r\n                        [*]For Movies, TV Series/Mini-series:\r\n                                    [*]Poster, banner or BD/HDDVD/DVD cover is required (If available).\r\n                                    [*]If convenient, add screenshots or thumbnail and link to screenshots.\r\n                                    [*]If convenient, add detailed file information regarding format, runtime, codec, bitrate, resolution, language, subtitle, etc.\r\n                                    [*]If convenient, add plot outline.\r\n                        [*]For PC Games:\r\n                                    [*]Poster or BD/HDDVD/DVD cover is required (If available).\r\n                                    [*]If convenient, add screenshots or thumbnail and link to screenshots.\r\n                        [*]For Sports:\r\n                                    [*]Don''t spoil the results with text or through screenshots/filename/obvious filesize/detailed runtime.\r\n                        [*]For Music:\r\n                                    [*]CD cover is required (If available).\r\n                                    [*]If convenient, add track list of an album.\r\n            [*][b]External Info[/b]\r\n                        [*]URL of external info for Movies and TV Series is required (if available).\r\n            [*][b]Misc[/b]\r\n                        [*]Please ensure category and quality info are selected correctly.', 'yes', 1),
(28, 6, 'Moderating Rules - <font class=striking>Use your better judgement!</font>', '[*]The most important rule: Use your better judgment!\r\n[*]Don''t be afraid to say [b]NO[/b]!\r\n[*]Don''t defy another staff member in public, instead send a PM or through IM.\r\n[*]Be tolerant! Give the user(s) a chance to reform.\r\n[*]Don''t act prematurely, let the users make their mistakes and THEN correct them.\r\n[*]Try correcting any "off topics" rather then closing a thread.\r\n[*]Move topics rather than locking them.\r\n[*]Be tolerant when moderating the chat section (give them some slack).\r\n[*]If you lock a topic, give a brief explanation as to why you''re locking it.\r\n[*]Before you disable a user account, send him/her a PM and if they reply, put them on a 2 week trial.\r\n[*]Don''t disable a user account until he or she has been a member for at least 4 weeks.\r\n[*]Convince people by reasoning rather than authority.', 'no', 11);

-- --------------------------------------------------------

--
-- Table structure for table `schools`
--

CREATE TABLE IF NOT EXISTS `schools` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `logo` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=101 ;

--
-- Dumping data for table `schools`
--

INSERT INTO `schools` (`id`, `name`, `logo`) VALUES
(1, '南京农业大学', NULL),
(2, '中山大学', NULL),
(3, '中国石油大学', NULL),
(4, '云南大学', NULL),
(5, '河海大学', NULL),
(6, '南开大学', NULL),
(7, '兰州大学', NULL),
(8, '合肥工业大学', NULL),
(9, '上海大学', NULL),
(10, '安徽大学', NULL),
(11, '中国海洋大学', NULL),
(12, '复旦大学', NULL),
(13, '西北大学', NULL),
(14, '郑州大学', NULL),
(15, '四川大学', NULL),
(16, '华中科技大学', NULL),
(17, '天津大学', NULL),
(18, '山东大学', NULL),
(19, '中央民族大学', NULL),
(20, '苏州大学', NULL),
(21, '重庆大学', NULL),
(22, '东北农业大学', NULL),
(23, '北京工业大学', NULL),
(24, '湖南师范大学', NULL),
(25, '东北大学', NULL),
(26, '电子科技大学', NULL),
(27, '西安电子科技大学', NULL),
(28, '北京化工大学', NULL),
(29, '南京航空航天大学', NULL),
(30, '南京理工大学', NULL),
(31, '西北工业大学', NULL),
(32, '天津医科大学', NULL),
(33, '北京林业大学', NULL),
(34, '华南师范大学', NULL),
(35, '浙江大学', NULL),
(36, '长安大学', NULL),
(37, '武汉理工大学', NULL),
(38, '河北工业大学', NULL),
(39, '南京师范大学', NULL),
(40, '中国农业大学', NULL),
(41, '厦门大学', NULL),
(42, '第二军医大学', NULL),
(43, '北京理工大学', NULL),
(44, '北京大学', NULL),
(45, '上海外国语大学', NULL),
(46, '北京科技大学', NULL),
(47, '西北农林科技大学', NULL),
(48, '中南大学', NULL),
(49, '华南理工大学', NULL),
(50, '武汉大学', NULL),
(51, '福州大学', NULL),
(52, '同济大学', NULL),
(53, '中国传媒大学', NULL),
(54, '湖南大学', NULL),
(55, '上海财经大学', NULL),
(56, '国防科学技术大学', NULL),
(57, '吉林大学', NULL),
(58, '大连理工大学', NULL),
(59, '中国人民大学', NULL),
(60, '上海交通大学', NULL),
(61, '西安交通大学', NULL),
(62, '江南大学', NULL),
(63, '南京大学', NULL),
(64, '南昌大学', NULL),
(65, '太原理工大学', NULL),
(66, '中国地质大学', NULL),
(67, '清华大学', NULL),
(68, '广西大学', NULL),
(69, '中国矿业大学', NULL),
(70, '四川农业大学', NULL),
(71, '东北师范大学', NULL),
(72, '哈尔滨工业大学', NULL),
(73, '北京航空航天大学', NULL),
(74, '北京交通大学', NULL),
(75, '西南交通大学', NULL),
(76, '中国科学技术大学', NULL),
(77, '北京外国语大学', NULL),
(78, '北京邮电大学', NULL),
(79, '西安建筑科技大学', NULL),
(80, '新疆大学', NULL),
(81, '东南大学', NULL),
(82, '对外经济贸易大学', NULL),
(83, '北京中医药大学', NULL),
(84, '暨南大学', NULL),
(85, '北京语言大学', NULL),
(86, '华中师范大学', NULL),
(87, '北京师范大学', NULL),
(88, '哈尔滨工程大学', NULL),
(89, '内蒙古大学', NULL),
(90, '东华大学', NULL),
(91, '解放军信息工程大学', NULL),
(92, '上海交通大学医学院 ', NULL),
(93, '华东理工大学', NULL),
(94, '第四军医大学', NULL),
(95, '大连海事大学', NULL),
(96, '华东师范大学', NULL),
(97, '辽宁大学', NULL),
(98, '深圳大学', NULL),
(99, '中央音乐学院', NULL),
(100, '中国协和医科大学', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `searchbox`
--

CREATE TABLE IF NOT EXISTS `searchbox` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(30) character set utf8 default NULL,
  `showsubcat` tinyint(1) NOT NULL default '0',
  `showsource` tinyint(1) NOT NULL default '0',
  `showmedium` tinyint(1) NOT NULL default '0',
  `showcodec` tinyint(1) NOT NULL default '0',
  `showstandard` tinyint(1) NOT NULL default '0',
  `showprocessing` tinyint(1) NOT NULL default '0',
  `showteam` tinyint(1) NOT NULL default '0',
  `showaudiocodec` tinyint(1) NOT NULL default '0',
  `catsperrow` int(10) unsigned NOT NULL default '7',
  `catpadding` int(10) unsigned NOT NULL default '25',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `searchbox`
--

INSERT INTO `searchbox` (`id`, `name`, `showsubcat`, `showsource`, `showmedium`, `showcodec`, `showstandard`, `showprocessing`, `showteam`, `showaudiocodec`, `catsperrow`, `catpadding`) VALUES
(4, 'chd', 1, 0, 1, 1, 1, 0, 0, 0, 10, 3);

-- --------------------------------------------------------

--
-- Table structure for table `secondicons`
--

CREATE TABLE IF NOT EXISTS `secondicons` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `medium` int(10) unsigned NOT NULL default '0',
  `codec` int(10) unsigned NOT NULL default '0',
  `name` varchar(30) NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

--
-- Dumping data for table `secondicons`
--

INSERT INTO `secondicons` (`id`, `medium`, `codec`, `name`, `image`) VALUES
(1, 1, 1, 'Blu-ray/H.264', 'bdh264.png'),
(2, 1, 2, 'Blu-ray/VC-1', 'bdvc1.png'),
(3, 1, 4, 'Blu-ray/MPEG-2', 'bdmpeg2.png'),
(4, 2, 1, 'HD DVD/H.264', 'hddvdh264.png'),
(5, 2, 2, 'HD DVD/VC-1', 'hddvdvc1.png'),
(6, 2, 4, 'HD DVD/MPEG-2', 'hddvdmpeg2.png'),
(7, 3, 1, 'Remux/H.264', 'remuxh264.png'),
(8, 3, 2, 'Remux/VC-1', 'remuxvc1.png'),
(9, 3, 4, 'Remux/MPEG-2', 'remuxmpeg2.png'),
(10, 4, 0, 'AVCHD', 'avchd.png'),
(11, 5, 1, 'HDTV/H.264', 'hdtvh264.png'),
(12, 5, 4, 'HDTV/MPEG-2', 'hdtvmpeg2.png'),
(13, 6, 0, 'DVDR', 'dvdr.png'),
(14, 7, 1, 'Rip/H.264', 'riph264.png'),
(15, 7, 3, 'Rip/Xvid', 'ripxvid.png'),
(16, 8, 5, 'CD/FLAC', 'cdflac.png'),
(17, 8, 6, 'CD/APE', 'cdape.png'),
(18, 8, 7, 'CD/DTS', 'cddts.png'),
(19, 8, 9, 'CD/Other', 'cdother.png'),
(20, 9, 5, 'Extract/FLAC', 'extractflac.png'),
(21, 9, 7, 'Extract/DTS', 'extractdts.png'),
(22, 9, 8, 'Extract/AC-3', 'extractac3.png');

-- --------------------------------------------------------

--
-- Table structure for table `shoutbox`
--

CREATE TABLE IF NOT EXISTS `shoutbox` (
  `id` int(10) NOT NULL auto_increment,
  `userid` smallint(6) NOT NULL default '0',
  `date` int(11) NOT NULL default '0',
  `text` text NOT NULL,
  `type` enum('sb','hb','fun') NOT NULL default 'sb',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `shoutbox`
--


-- --------------------------------------------------------

--
-- Table structure for table `sitelog`
--

CREATE TABLE IF NOT EXISTS `sitelog` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `added` datetime default NULL,
  `txt` text,
  `security_level` enum('normal','mod') NOT NULL default 'normal',
  PRIMARY KEY  (`id`),
  KEY `added` (`added`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `sitelog`
--


-- --------------------------------------------------------

--
-- Table structure for table `snatched`
--

CREATE TABLE IF NOT EXISTS `snatched` (
  `id` int(10) NOT NULL auto_increment,
  `torrentid` int(10) default '0',
  `userid` int(10) default '0',
  `ip` varchar(15) NOT NULL,
  `port` smallint(5) unsigned NOT NULL default '0',
  `uploaded` bigint(20) unsigned NOT NULL default '0',
  `upspeed` bigint(20) unsigned NOT NULL default '0',
  `downloaded` bigint(20) unsigned NOT NULL default '0',
  `downspeed` bigint(20) unsigned NOT NULL default '0',
  `to_go` bigint(20) unsigned NOT NULL default '0',
  `seeder` enum('yes','no') NOT NULL default 'no',
  `seedtime` int(10) unsigned NOT NULL default '0',
  `leechtime` int(10) unsigned NOT NULL default '0',
  `last_action` datetime NOT NULL default '0000-00-00 00:00:00',
  `startdat` datetime NOT NULL default '0000-00-00 00:00:00',
  `completedat` datetime NOT NULL default '0000-00-00 00:00:00',
  `connectable` enum('yes','no') NOT NULL default 'yes',
  `agent` varchar(60) NOT NULL default '',
  `finished` enum('yes','no') NOT NULL default 'no',
  PRIMARY KEY  (`id`),
  KEY `finished` (`torrentid`),
  KEY `torrentid` (`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `snatched`
--


-- --------------------------------------------------------

--
-- Table structure for table `sources`
--

CREATE TABLE IF NOT EXISTS `sources` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_index` int(10) unsigned NOT NULL default '0',
  `source_desc` varchar(30) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=7 ;

--
-- Dumping data for table `sources`
--

INSERT INTO `sources` (`id`, `name`, `image`, `sort_index`, `source_desc`) VALUES
(1, 'Blu-ray', '', 0, ''),
(2, 'HD DVD', '', 0, ''),
(3, 'DVD', '', 0, ''),
(4, 'HDTV', '', 0, ''),
(5, 'TV', '', 0, ''),
(6, 'Other', '', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `staffmessages`
--

CREATE TABLE IF NOT EXISTS `staffmessages` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `sender` int(10) unsigned NOT NULL default '0',
  `added` datetime default NULL,
  `msg` text,
  `subject` varchar(100) NOT NULL default '',
  `answeredby` int(10) unsigned NOT NULL default '0',
  `answered` tinyint(1) NOT NULL default '0',
  `answer` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `staffmessages`
--


-- --------------------------------------------------------

--
-- Table structure for table `standards`
--

CREATE TABLE IF NOT EXISTS `standards` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_index` int(10) unsigned NOT NULL default '0',
  `standard_desc` varchar(30) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `standards`
--

INSERT INTO `standards` (`id`, `name`, `image`, `sort_index`, `standard_desc`) VALUES
(1, '1080p', '', 0, ''),
(2, '1080i', '', 0, ''),
(3, '720p', '', 0, ''),
(4, 'SD', '', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `stats`
--

CREATE TABLE IF NOT EXISTS `stats` (
  `recordonline24` varchar(255) NOT NULL default '0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `stats`
--


-- --------------------------------------------------------

--
-- Table structure for table `stylesheets`
--

CREATE TABLE IF NOT EXISTS `stylesheets` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `uri` varchar(255) NOT NULL default '',
  `name` varchar(64) NOT NULL default '',
  `addicode` text NOT NULL,
  `designer` varchar(50) default NULL,
  `comment` varchar(255) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

--
-- Dumping data for table `stylesheets`
--

INSERT INTO `stylesheets` (`id`, `uri`, `name`, `addicode`, `designer`, `comment`) VALUES
(3, 'styles/BlasphemyOrange/', 'Blasphemy Orange', '', 'Zantetsu', 'Bit-HDTV clone'),
(4, 'styles/Classic/', 'Classic', '', 'Zantetsu', 'TBSource original mod'),
(6, 'styles/DarkPassion/', 'Dark Passion', '', 'Zantetsu', NULL),
(7, 'styles/BambooGreen/', 'Bamboo Green', '', 'Xia Zuojie', 'Baidu Hi clone'),
(11, 'styles/WoodAge/', 'Wood Age', '', 'Xia Zuojie', 'Gazelle clone');

-- --------------------------------------------------------

--
-- Table structure for table `subs`
--

CREATE TABLE IF NOT EXISTS `subs` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `torrent_id` int(10) unsigned NOT NULL,
  `lang_id` int(10) unsigned NOT NULL,
  `title` varchar(255) NOT NULL default '',
  `filename` varchar(255) NOT NULL default '',
  `added` datetime default NULL,
  `size` int(10) unsigned NOT NULL default '0',
  `uppedby` int(10) unsigned NOT NULL default '0',
  `anonymous` enum('yes','no') NOT NULL default 'no',
  `hits` int(10) unsigned NOT NULL default '0',
  `ext` varchar(10) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `subs`
--


-- --------------------------------------------------------

--
-- Table structure for table `suggest`
--

CREATE TABLE IF NOT EXISTS `suggest` (
  `suggest_id` int(10) NOT NULL auto_increment,
  `keywords` varchar(255) character set utf8 NOT NULL,
  `userid` int(10) unsigned NOT NULL default '0',
  `adddate` datetime NOT NULL default '0000-00-00 00:00:00',
  `location` enum('torrents','forum') character set utf8 NOT NULL default 'torrents',
  PRIMARY KEY  (`suggest_id`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `suggest`
--


-- --------------------------------------------------------

--
-- Table structure for table `sysoppanel`
--

CREATE TABLE IF NOT EXISTS `sysoppanel` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  `url` varchar(50) default NULL,
  `info` varchar(100) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3027 ;

--
-- Dumping data for table `sysoppanel`
--

INSERT INTO `sysoppanel` (`id`, `name`, `url`, `info`) VALUES
(3000, 'Manage Tracker Categories', 'category.php', 'Edit/Delete tracker categories'),
(3001, 'Manage Tracker Countries', 'country.php', 'Edit/Delete tracker countries'),
(3002, 'Manage tracker forum', 'forummanage.php', 'Edit/Delete forum'),
(3005, 'MySQL Stats', 'mysql_stats.php', 'See MySql stats'),
(3006, 'Mass mailer', 'massmail.php', 'Send e-mail to all users on the tracker'),
(3007, 'Do cleanup', 'docleanup.php', 'Do cleanup functions'),
(3012, 'Ban System', 'bans.php', 'Ban / Unban IP'),
(3013, 'Change E-Mail', 'changemail.php', 'Change User Email Address'),
(3014, 'Change Username', 'changeusername.php', 'Change UserName'),
(3015, 'Reports', 'reports.php', 'Show Reports!'),
(3016, 'Spam', 'spam.php', 'Check Spam Pms'),
(3017, 'Failed Logins', 'maxlogin.php', 'Show Failed Login Attempts'),
(3018, 'Agent Ban', 'agentban.php', 'User Agent Ban'),
(3021, 'Bitbucket', 'bitbucketlog.php', 'Bitbucket Log'),
(3022, 'Ban EMAIL address', 'bannedemails.php', 'Ban EMAILs stop registration.'),
(3023, 'Allow EMAIL address', 'allowedemails.php', 'Allow EMAIL registration.'),
(3024, 'Location', 'location.php', 'Manage location and location speed'),
(3025, 'Add Upload', 'amountupload.php', 'Add upload to certain classes');

-- --------------------------------------------------------

--
-- Table structure for table `teams`
--

CREATE TABLE IF NOT EXISTS `teams` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(30) character set utf8 NOT NULL,
  `image` varchar(30) character set utf8 NOT NULL,
  `sort_index` int(10) unsigned NOT NULL default '0',
  `team_desc` varchar(30) character set utf8 NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=6 ;

--
-- Dumping data for table `teams`
--

INSERT INTO `teams` (`id`, `name`, `image`, `sort_index`, `team_desc`) VALUES
(1, 'HDS', '', 0, ''),
(2, 'CHD', '', 0, ''),
(3, 'MySiLU', '', 0, ''),
(4, 'WiKi', '', 0, ''),
(5, 'Other', '', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `thanks`
--

CREATE TABLE IF NOT EXISTS `thanks` (
  `torrentid` int(11) NOT NULL default '0',
  `userid` int(11) NOT NULL default '0',
  `id` int(11) NOT NULL auto_increment,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `thanks`
--


-- --------------------------------------------------------

--
-- Table structure for table `topics`
--

CREATE TABLE IF NOT EXISTS `topics` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` int(10) unsigned NOT NULL default '0',
  `subject` varchar(100) default NULL,
  `locked` enum('yes','no') NOT NULL default 'no',
  `forumid` int(10) unsigned NOT NULL default '0',
  `firstpost` int(10) unsigned NOT NULL default '0',
  `lastpost` int(10) unsigned NOT NULL default '0',
  `sticky` enum('yes','no') NOT NULL default 'no',
  `hlcolor` int(10) NOT NULL default '0',
  `views` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`),
  KEY `subject` (`subject`),
  KEY `lastpost` (`lastpost`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `topics`
--


-- --------------------------------------------------------

--
-- Table structure for table `torrents`
--

CREATE TABLE IF NOT EXISTS `torrents` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `info_hash` varbinary(20) NOT NULL,
  `name` varchar(255) NOT NULL default '',
  `filename` varchar(255) NOT NULL default '',
  `save_as` varchar(255) NOT NULL default '',
  `search_text` text NOT NULL,
  `descr` text NOT NULL,
  `small_descr` varchar(255) NOT NULL,
  `ori_descr` text NOT NULL,
  `category` int(10) unsigned NOT NULL default '0',
  `source` int(10) unsigned NOT NULL default '0',
  `medium` int(10) unsigned NOT NULL default '0',
  `codec` int(10) unsigned NOT NULL default '0',
  `standard` int(10) unsigned NOT NULL default '0',
  `processing` int(10) unsigned NOT NULL default '0',
  `team` int(10) unsigned NOT NULL default '0',
  `audiocodec` int(10) unsigned NOT NULL default '0',
  `size` bigint(20) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `type` enum('single','multi') NOT NULL default 'single',
  `numfiles` int(10) unsigned NOT NULL default '0',
  `comments` int(10) unsigned NOT NULL default '0',
  `views` int(10) unsigned NOT NULL default '0',
  `hits` int(10) unsigned NOT NULL default '0',
  `times_completed` int(10) unsigned NOT NULL default '0',
  `leechers` int(10) unsigned NOT NULL default '0',
  `seeders` int(10) unsigned NOT NULL default '0',
  `last_action` datetime NOT NULL default '0000-00-00 00:00:00',
  `visible` enum('yes','no') NOT NULL default 'yes',
  `banned` enum('yes','no') NOT NULL default 'no',
  `owner` int(10) unsigned NOT NULL default '0',
  `numratings` int(10) unsigned NOT NULL default '0',
  `ratingsum` int(10) unsigned NOT NULL default '0',
  `nfo` blob NOT NULL,
  `sp_state` int(10) NOT NULL default '1',
  `seen` blob NOT NULL,
  `anonymous` enum('yes','no') NOT NULL default 'no',
  `url` varchar(80) default NULL,
  `pos_state` enum('normal','sticky') NOT NULL default 'normal',
  `cache_stamp` int(10) unsigned NOT NULL default '0',
  `picktype` enum('hot','classic','recommended','normal') NOT NULL default 'normal',
  `picktime` datetime NOT NULL default '0000-00-00 00:00:00',
  `lastfm_url` varchar(250) NOT NULL,
  `lastfm_artist` varchar(50) NOT NULL,
  `lastfm_album` varchar(200) NOT NULL,
  `lastfm_cache_stamp` int(10) unsigned NOT NULL default '0',
  `douban_url` varchar(250) NOT NULL,
  `douban_cache_stamp` int(10) unsigned NOT NULL default '0',
  `sp_state_temp` enum('2up_free','2up','free','half_down','normal') NOT NULL default 'normal',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `info_hash` (`info_hash`),
  KEY `owner` (`owner`),
  KEY `visible` (`visible`),
  KEY `category_visible` (`category`,`visible`),
  FULLTEXT KEY `ft_search` (`search_text`,`ori_descr`),
  FULLTEXT KEY `name` (`name`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `torrents`
--


-- --------------------------------------------------------

--
-- Table structure for table `torrents_state`
--

CREATE TABLE IF NOT EXISTS `torrents_state` (
  `global_sp_state` int(10) NOT NULL default '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

--
-- Dumping data for table `torrents_state`
--

INSERT INTO `torrents_state` (`global_sp_state`) VALUES
(1);

-- --------------------------------------------------------

--
-- Table structure for table `uploadspeed`
--

CREATE TABLE IF NOT EXISTS `uploadspeed` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

--
-- Dumping data for table `uploadspeed`
--

INSERT INTO `uploadspeed` (`id`, `name`) VALUES
(1, '64kbps'),
(2, '128kbps'),
(3, '256kbps'),
(4, '512kbps'),
(5, '768kbps'),
(6, '1Mbps'),
(7, '1.5Mbps'),
(8, '2Mbps'),
(9, '3Mbps'),
(10, '4Mbps'),
(11, '5Mbps'),
(12, '6Mbps'),
(13, '7Mbps'),
(14, '8Mbps'),
(15, '9Mbps'),
(16, '10Mbps'),
(17, '48Mbps'),
(18, '100Mbit');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `username` varchar(40) NOT NULL default '',
  `old_password` varchar(40) NOT NULL default '',
  `passhash` varchar(32) NOT NULL default '',
  `secret` varbinary(20) NOT NULL,
  `email` varchar(80) NOT NULL default '',
  `status` enum('pending','confirmed') NOT NULL default 'pending',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_login` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_access` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_home` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_offer` datetime NOT NULL default '0000-00-00 00:00:00',
  `forum_access` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_staffmsg` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_pm` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_comment` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_post` datetime NOT NULL default '0000-00-00 00:00:00',
  `editsecret` varbinary(20) NOT NULL,
  `privacy` enum('strong','normal','low') NOT NULL default 'normal',
  `stylesheet` int(10) NOT NULL default '9',
  `caticon` int(10) NOT NULL default '1',
  `fontsize` enum('small','medium','large') NOT NULL default 'medium',
  `info` text,
  `acceptpms` enum('yes','friends','no') NOT NULL default 'yes',
  `commentpm` enum('yes','no') NOT NULL default 'yes',
  `ip` varchar(64) NOT NULL,
  `class` tinyint(3) unsigned NOT NULL default '1',
  `max_class_once` tinyint(3) NOT NULL default '1',
  `avatar` varchar(100) NOT NULL default '',
  `uploaded` bigint(20) unsigned NOT NULL default '0',
  `downloaded` bigint(20) unsigned NOT NULL default '0',
  `seedtime` int(10) unsigned NOT NULL default '0',
  `leechtime` int(10) unsigned NOT NULL default '0',
  `title` varchar(30) NOT NULL default '',
  `country` int(10) unsigned NOT NULL default '107',
  `notifs` varchar(500) default NULL,
  `defspecial` varchar(300) default NULL,
  `modcomment` text NOT NULL,
  `enabled` enum('yes','no') NOT NULL default 'yes',
  `avatars` enum('yes','no') NOT NULL default 'yes',
  `donor` enum('yes','no') NOT NULL default 'no',
  `donated` decimal(8,2) NOT NULL default '0.00',
  `donated_cny` decimal(8,2) NOT NULL default '0.00',
  `donoruntil` datetime NOT NULL default '0000-00-00 00:00:00',
  `warned` enum('yes','no') NOT NULL default 'no',
  `warneduntil` datetime NOT NULL default '0000-00-00 00:00:00',
  `torrentsperpage` int(3) unsigned NOT NULL default '0',
  `topicsperpage` int(3) unsigned NOT NULL default '0',
  `postsperpage` int(3) unsigned NOT NULL default '0',
  `clicktopic` enum('firstpage','lastpage') NOT NULL default 'firstpage',
  `deletepms` enum('yes','no') NOT NULL default 'yes',
  `savepms` enum('yes','no') NOT NULL default 'no',
  `showhot` enum('yes','no') NOT NULL default 'yes',
  `showhot_withreview` enum('yes','no') NOT NULL default 'yes',
  `showclassic` enum('yes','no') NOT NULL default 'yes',
  `showclassic_withreview` enum('yes','no') NOT NULL default 'yes',
  `support` enum('yes','no') NOT NULL default 'no',
  `picker` enum('yes','no') NOT NULL default 'no',
  `stafffor` varchar(255) NOT NULL,
  `supportfor` varchar(255) NOT NULL,
  `pickfor` varchar(255) NOT NULL,
  `supportlang` varchar(50) NOT NULL,
  `passkey` varchar(32) NOT NULL default '',
  `permban` enum('yes','no') NOT NULL default 'no',
  `last_browse` int(11) NOT NULL default '0',
  `last_music` int(11) NOT NULL default '0',
  `uploadpos` enum('yes','no') NOT NULL default 'yes',
  `forumpost` enum('yes','no') NOT NULL default 'yes',
  `downloadpos` enum('yes','no') NOT NULL default 'yes',
  `clientselect` int(10) unsigned default '0',
  `signatures` enum('yes','no') NOT NULL default 'yes',
  `signature` varchar(800) NOT NULL,
  `usessl` enum('yes','no') NOT NULL default 'no',
  `lang` int(10) NOT NULL default '6',
  `tzoffset` int(10) NOT NULL default '0',
  `cheat` smallint(6) NOT NULL default '0',
  `download` int(10) unsigned NOT NULL default '0',
  `upload` int(10) unsigned NOT NULL default '0',
  `invites` int(10) NOT NULL default '0',
  `invited_by` int(10) NOT NULL default '0',
  `gender` enum('Male','Female','N/A') NOT NULL default 'N/A',
  `vip_added` enum('yes','no') NOT NULL default 'no',
  `vip_until` datetime NOT NULL default '0000-00-00 00:00:00',
  `seedbonus` decimal(10,1) NOT NULL default '0.0',
  `bonuscomment` text NOT NULL,
  `parked` enum('yes','no') NOT NULL default 'no',
  `leechwarn` enum('yes','no') NOT NULL default 'no',
  `leechwarnuntil` datetime NOT NULL default '0000-00-00 00:00:00',
  `lastwarned` datetime NOT NULL default '0000-00-00 00:00:00',
  `timeswarned` int(10) NOT NULL default '0',
  `warnedby` varchar(40) NOT NULL default '',
  `page` text NOT NULL,
  `passhint` text,
  `hintanswer` text,
  `sbnum` int(3) default '70',
  `sbrefresh` int(4) default '120',
  `hidehb` enum('yes','no') default 'no',
  `showimdb` enum('yes','no') default 'yes',
  `showdouban` enum('yes','no') default 'yes',
  `showlastfm` enum('yes','no') default 'yes',
  `showdescription` enum('yes','no') default 'yes',
  `showreview` enum('yes','no') default 'no',
  `showcomment` enum('yes','no') default 'yes',
  `tooltip` enum('minorimdb','medianimdb','off') NOT NULL default 'medianimdb',
  `shownfo` enum('yes','no') default 'yes',
  `timetype` enum('timeadded','timealive') default 'timealive',
  `appendsticky` enum('yes','no') default 'yes',
  `appendnew` enum('yes','no') default 'yes',
  `appendpromotion` enum('highlight','word','icon','off') default 'word',
  `appendpicked` enum('yes','no') default 'yes',
  `dlicon` enum('yes','no') default 'yes',
  `bmicon` enum('yes','no') default 'yes',
  `showcomnum` enum('yes','no') default 'yes',
  `showlastcom` enum('yes','no') default 'yes',
  `showrevnum` enum('yes','no') default 'no',
  `lftooltip` enum('yes','no') default 'no',
  `pmnum` int(3) NOT NULL default '10',
  `school` int(10) default '35',
  `showfb` enum('yes','no') NOT NULL default 'yes',
  `total_donated` decimal(8,2) NOT NULL default '0.00',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `username` (`username`),
  KEY `status_added` (`status`,`added`),
  KEY `ip` (`ip`),
  KEY `uploaded` (`uploaded`),
  KEY `downloaded` (`downloaded`),
  KEY `country` (`country`),
  KEY `last_access` (`last_access`),
  KEY `enabled` (`enabled`),
  KEY `warned` (`warned`),
  KEY `cheat` (`cheat`),
  KEY `showcomment` (`showcomment`),
  KEY `showreview` (`showreview`),
  KEY `showdescription` (`showdescription`),
  KEY `showlastfm` (`showlastfm`),
  KEY `showdouban` (`showdouban`),
  KEY `hidehb` (`hidehb`),
  KEY `sbrefresh` (`sbrefresh`),
  KEY `sbnum` (`sbnum`),
  KEY `tooltip` (`tooltip`),
  KEY `shownfo` (`shownfo`),
  KEY `timetype` (`timetype`),
  KEY `appendsticky` (`appendsticky`),
  KEY `appendnew` (`appendnew`),
  KEY `appendpromotion` (`appendpromotion`),
  KEY `appendpicked` (`appendpicked`),
  KEY `dlicon` (`dlicon`),
  KEY `bmicon` (`bmicon`),
  KEY `showcomnum` (`showcomnum`),
  KEY `showlastcom` (`showlastcom`),
  KEY `showrevnum` (`showrevnum`),
  KEY `lftooltip` (`lftooltip`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `users`
--

