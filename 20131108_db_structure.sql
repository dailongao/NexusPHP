SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";

-- --------------------------------------------------------

--
-- 表的结构 `adclicks`
--

CREATE TABLE IF NOT EXISTS `adclicks` (
  `id` int(11) unsigned NOT NULL auto_increment,
  `adid` int(11) unsigned default NULL,
  `userid` int(11) unsigned default NULL,
  `added` datetime default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4794 ;

-- --------------------------------------------------------

--
-- 表的结构 `adminpanel`
--

CREATE TABLE IF NOT EXISTS `adminpanel` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `url` varchar(256) NOT NULL default '',
  `info` varchar(256) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

--
-- 表的结构 `advertisements`
--

CREATE TABLE IF NOT EXISTS `advertisements` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `enabled` tinyint(1) NOT NULL default '0',
  `type` enum('bbcodes','xhtml','text','image','flash') NOT NULL,
  `position` enum('header','footer','belownav','belowsearchbox','torrentdetail','comment','interoverforums','forumpost','popup') NOT NULL,
  `displayorder` tinyint(3) NOT NULL default '0',
  `name` varchar(255) NOT NULL default '',
  `parameters` text NOT NULL,
  `code` text NOT NULL,
  `starttime` datetime NOT NULL,
  `endtime` datetime NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

-- --------------------------------------------------------

--
-- 表的结构 `agent_allowed_exception`
--

CREATE TABLE IF NOT EXISTS `agent_allowed_exception` (
  `family_id` tinyint(3) unsigned NOT NULL,
  `name` varchar(100) NOT NULL default '',
  `peer_id` varchar(20) NOT NULL,
  `agent` varchar(100) NOT NULL,
  `comment` varchar(200) NOT NULL default '',
  KEY `family_id` (`family_id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `agent_allowed_family`
--

CREATE TABLE IF NOT EXISTS `agent_allowed_family` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `family` varchar(50) NOT NULL default '',
  `start_name` varchar(100) NOT NULL default '',
  `peer_id_pattern` varchar(200) NOT NULL,
  `peer_id_match_num` tinyint(3) unsigned NOT NULL,
  `peer_id_matchtype` enum('dec','hex') NOT NULL default 'dec',
  `peer_id_start` varchar(20) NOT NULL,
  `agent_pattern` varchar(200) NOT NULL,
  `agent_match_num` tinyint(3) unsigned NOT NULL,
  `agent_matchtype` enum('dec','hex') NOT NULL default 'dec',
  `agent_start` varchar(100) NOT NULL,
  `exception` enum('yes','no') NOT NULL default 'no',
  `allowhttps` enum('yes','no') NOT NULL default 'no',
  `comment` varchar(200) NOT NULL default '',
  `hits` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=25 ;

-- --------------------------------------------------------

--
-- 表的结构 `allowedemails`
--

CREATE TABLE IF NOT EXISTS `allowedemails` (
  `id` int(10) NOT NULL auto_increment,
  `value` mediumtext NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- 表的结构 `attachments`
--

CREATE TABLE IF NOT EXISTS `attachments` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `width` smallint(6) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `filename` varchar(256) NOT NULL default '',
  `dlkey` char(32) NOT NULL,
  `filetype` varchar(50) NOT NULL default '',
  `filesize` bigint(20) unsigned NOT NULL default '0',
  `location` varchar(256) NOT NULL,
  `downloads` mediumint(8) NOT NULL default '0',
  `isimage` tinyint(1) unsigned NOT NULL default '0',
  `thumb` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `pid` (`userid`,`id`),
  KEY `dateline` (`added`,`isimage`,`downloads`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=95341 ;

-- --------------------------------------------------------

--
-- 表的结构 `audiocodecs`
--

CREATE TABLE IF NOT EXISTS `audiocodecs` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `sort_index` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- 表的结构 `avps`
--

CREATE TABLE IF NOT EXISTS `avps` (
  `arg` varchar(20) NOT NULL default '',
  `value_s` text NOT NULL,
  `value_i` int(11) NOT NULL default '0',
  `value_u` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`arg`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `bannedemails`
--

CREATE TABLE IF NOT EXISTS `bannedemails` (
  `id` int(10) NOT NULL auto_increment,
  `value` mediumtext NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2 ;

-- --------------------------------------------------------

--
-- 表的结构 `bans`
--

CREATE TABLE IF NOT EXISTS `bans` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `addedby` mediumint(8) unsigned NOT NULL default '0',
  `comment` varchar(255) NOT NULL default '',
  `first` bigint(20) NOT NULL,
  `last` bigint(20) NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `first_last` (`first`,`last`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- 表的结构 `bitbucket`
--

CREATE TABLE IF NOT EXISTS `bitbucket` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `owner` mediumint(8) unsigned NOT NULL default '0',
  `name` varchar(256) NOT NULL,
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `public` enum('0','1') NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6511 ;

-- --------------------------------------------------------

--
-- 表的结构 `blocks`
--

CREATE TABLE IF NOT EXISTS `blocks` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `blockid` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  UNIQUE KEY `userfriend` (`userid`,`blockid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=439 ;

-- --------------------------------------------------------

--
-- 表的结构 `bookmarks`
--

CREATE TABLE IF NOT EXISTS `bookmarks` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `torrentid` mediumint(8) unsigned NOT NULL default '0',
  `userid` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `userid_torrentid` (`userid`,`torrentid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=217400 ;

-- --------------------------------------------------------

--
-- 表的结构 `casino`
--

CREATE TABLE IF NOT EXISTS `casino` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `title` varchar(255) NOT NULL,
  `descr` text NOT NULL,
  `added_by` varchar(40) NOT NULL,
  `added_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `end_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `paid_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `state` tinyint(1) unsigned NOT NULL default '1',
  `win` int(2) NOT NULL default '0',
  `total_count` int(5) NOT NULL default '0',
  `winner_count` int(5) NOT NULL default '0',
  `comment` varchar(255) NOT NULL,
  `op1_descr` varchar(255) default NULL,
  `op1_odds` decimal(3,1) default NULL,
  `op2_descr` varchar(255) default NULL,
  `op2_odds` decimal(3,1) default NULL,
  `op3_descr` varchar(255) default NULL,
  `op3_odds` decimal(3,1) default NULL,
  `op4_descr` varchar(255) default NULL,
  `op4_odds` decimal(3,1) default NULL,
  `op5_descr` varchar(255) default NULL,
  `op5_odds` decimal(3,1) default NULL,
  `op6_descr` varchar(255) default NULL,
  `op6_odds` decimal(3,1) default NULL,
  `op7_descr` varchar(255) default NULL,
  `op7_odds` decimal(3,1) default NULL,
  `op8_descr` varchar(255) default NULL,
  `op8_odds` decimal(3,1) default NULL,
  `op9_descr` varchar(255) default NULL,
  `op9_odds` decimal(3,1) default NULL,
  PRIMARY KEY  (`id`),
  KEY `paid_time` (`paid_time`),
  KEY `state` (`state`),
  KEY `added_time` (`added_time`),
  KEY `end_time` (`end_time`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2377 ;

-- --------------------------------------------------------

--
-- 表的结构 `casinolog`
--

CREATE TABLE IF NOT EXISTS `casinolog` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user_id` int(10) unsigned NOT NULL default '0',
  `added_time` datetime NOT NULL default '0000-00-00 00:00:00',
  `paid_num` decimal(8,1) NOT NULL default '0.0',
  `choice` int(2) unsigned NOT NULL default '0',
  `stake` int(5) unsigned NOT NULL default '0',
  `odds` decimal(3,1) NOT NULL default '0.0',
  `result` tinyint(1) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`,`user_id`),
  KEY `added_time` (`added_time`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2377 ;

-- --------------------------------------------------------

--
-- 表的结构 `casinorank`
--

CREATE TABLE IF NOT EXISTS `casinorank` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `bonus` decimal(10,1) NOT NULL default '0.0',
  `lotterycount` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=69086 ;

-- --------------------------------------------------------

--
-- 表的结构 `categories`
--

CREATE TABLE IF NOT EXISTS `categories` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `mode` tinyint(3) unsigned NOT NULL default '1',
  `class_name` varchar(255) NOT NULL default '',
  `name` varchar(30) NOT NULL,
  `image` varchar(255) NOT NULL,
  `sort_index` smallint(5) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `mode_sort` (`mode`,`sort_index`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=538 ;

-- --------------------------------------------------------

--
-- 表的结构 `caticons`
--

CREATE TABLE IF NOT EXISTS `caticons` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(64) NOT NULL default '',
  `folder` varchar(256) NOT NULL,
  `cssfile` varchar(255) NOT NULL default '',
  `multilang` enum('yes','no') NOT NULL default 'no',
  `secondicon` enum('yes','no') NOT NULL default 'no',
  `designer` varchar(50) NOT NULL default '',
  `comment` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=5 ;

-- --------------------------------------------------------

--
-- 表的结构 `cheaters`
--

CREATE TABLE IF NOT EXISTS `cheaters` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `torrentid` mediumint(8) unsigned NOT NULL default '0',
  `uploaded` bigint(20) unsigned NOT NULL default '0',
  `downloaded` bigint(20) unsigned NOT NULL default '0',
  `anctime` mediumint(8) unsigned NOT NULL default '0',
  `seeders` mediumint(8) unsigned NOT NULL default '0',
  `leechers` mediumint(8) unsigned NOT NULL default '0',
  `hit` tinyint(3) unsigned NOT NULL default '0',
  `dealtby` mediumint(8) unsigned NOT NULL default '0',
  `dealtwith` tinyint(1) NOT NULL default '0',
  `comment` varchar(256) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=348 ;

-- --------------------------------------------------------

--
-- 表的结构 `chronicle`
--

CREATE TABLE IF NOT EXISTS `chronicle` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `txt` text,
  PRIMARY KEY  (`id`),
  KEY `added` (`added`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=105 ;

-- --------------------------------------------------------

--
-- 表的结构 `codecs`
--

CREATE TABLE IF NOT EXISTS `codecs` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `sort_index` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=12 ;

-- --------------------------------------------------------

--
-- 表的结构 `comments`
--

CREATE TABLE IF NOT EXISTS `comments` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `user` mediumint(8) unsigned NOT NULL default '0',
  `torrent` mediumint(8) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `text` text,
  `ori_text` text,
  `editedby` mediumint(8) unsigned NOT NULL default '0',
  `editdate` datetime NOT NULL default '0000-00-00 00:00:00',
  `offer` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `user` (`user`),
  KEY `torrent_id` (`torrent`,`id`),
  KEY `offer_id` (`offer`,`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=304452 ;

-- --------------------------------------------------------

--
-- 表的结构 `countries`
--

CREATE TABLE IF NOT EXISTS `countries` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  `flagpic` varchar(256) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=108 ;

-- --------------------------------------------------------

--
-- 表的结构 `downloadspeed`
--

CREATE TABLE IF NOT EXISTS `downloadspeed` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(50) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

-- --------------------------------------------------------

--
-- 表的结构 `faq`
--

CREATE TABLE IF NOT EXISTS `faq` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `link_id` smallint(5) unsigned NOT NULL,
  `lang_id` smallint(5) unsigned NOT NULL default '6',
  `type` enum('categ','item') NOT NULL default 'item',
  `question` text NOT NULL,
  `answer` text NOT NULL,
  `flag` tinyint(3) unsigned NOT NULL default '1',
  `categ` smallint(5) unsigned NOT NULL default '0',
  `order` smallint(5) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=476 ;

-- --------------------------------------------------------

--
-- 表的结构 `files`
--

CREATE TABLE IF NOT EXISTS `files` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `torrent` mediumint(8) unsigned NOT NULL default '0',
  `filename` varchar(255) NOT NULL default '',
  `size` bigint(20) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `torrent` (`torrent`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1540636 ;

-- --------------------------------------------------------

--
-- 表的结构 `forummods`
--

CREATE TABLE IF NOT EXISTS `forummods` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `forumid` smallint(5) unsigned NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `forumid` (`forumid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=294 ;

-- --------------------------------------------------------

--
-- 表的结构 `forums`
--

CREATE TABLE IF NOT EXISTS `forums` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `sort` smallint(5) unsigned NOT NULL default '0',
  `name` varchar(60) NOT NULL,
  `description` varchar(256) NOT NULL default '',
  `minclassread` tinyint(3) unsigned NOT NULL default '0',
  `minclasswrite` tinyint(3) unsigned NOT NULL default '0',
  `postcount` int(10) unsigned NOT NULL default '0',
  `topiccount` int(10) unsigned NOT NULL default '0',
  `minclasscreate` tinyint(3) unsigned NOT NULL default '0',
  `forid` smallint(5) unsigned NOT NULL default '0',
  `casinomode` tinyint(1) NOT NULL default '0',
  `casinoclass` tinyint(3) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=54 ;

-- --------------------------------------------------------

--
-- 表的结构 `friends`
--

CREATE TABLE IF NOT EXISTS `friends` (
  `id` int(12) unsigned NOT NULL auto_increment,
  `userid` mediumint(8) unsigned NOT NULL,
  `friendid` mediumint(8) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `userfriend` (`userid`,`friendid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9556 ;

-- --------------------------------------------------------

--
-- 表的结构 `fun`
--

CREATE TABLE IF NOT EXISTS `fun` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `body` text,
  `title` varchar(256) NOT NULL default '',
  `status` enum('normal','dull','notfunny','funny','veryfunny','banned') NOT NULL default 'normal',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1344 ;

-- --------------------------------------------------------

--
-- 表的结构 `funds`
--

CREATE TABLE IF NOT EXISTS `funds` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `usd` decimal(8,2) NOT NULL default '0.00',
  `cny` decimal(8,2) NOT NULL default '0.00',
  `user` mediumint(8) unsigned NOT NULL,
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `memo` varchar(256) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- 表的结构 `funvotes`
--

CREATE TABLE IF NOT EXISTS `funvotes` (
  `funid` mediumint(8) unsigned NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL,
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `vote` enum('fun','dull') NOT NULL default 'fun',
  PRIMARY KEY  (`funid`,`userid`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `invites`
--

CREATE TABLE IF NOT EXISTS `invites` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `inviter` mediumint(8) unsigned NOT NULL default '0',
  `invitee` varchar(80) NOT NULL default '',
  `hash` char(32) NOT NULL,
  `time_invited` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY `hash` (`hash`(3))
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1411 ;

-- --------------------------------------------------------

--
-- 表的结构 `iplog`
--

CREATE TABLE IF NOT EXISTS `iplog` (
  `id` bigint(20) unsigned NOT NULL auto_increment,
  `ip` varchar(64) NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL,
  `access` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4001209 ;

-- --------------------------------------------------------

--
-- 表的结构 `isp`
--

CREATE TABLE IF NOT EXISTS `isp` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=21 ;

-- --------------------------------------------------------

--
-- 表的结构 `language`
--

CREATE TABLE IF NOT EXISTS `language` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `lang_name` varchar(50) NOT NULL,
  `flagpic` varchar(256) NOT NULL default '',
  `sub_lang` tinyint(3) unsigned NOT NULL default '1',
  `rule_lang` tinyint(3) unsigned NOT NULL default '0',
  `site_lang` tinyint(3) unsigned NOT NULL default '0',
  `site_lang_folder` varchar(256) NOT NULL default '',
  `trans_state` enum('up-to-date','outdate','incomplete','need-new','unavailable') NOT NULL default 'unavailable',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=32 ;

-- --------------------------------------------------------

--
-- 表的结构 `links`
--

CREATE TABLE IF NOT EXISTS `links` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `url` varchar(256) NOT NULL,
  `title` varchar(50) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=15 ;

-- --------------------------------------------------------

--
-- 表的结构 `locations`
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
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2000 ;

-- --------------------------------------------------------

--
-- 表的结构 `loginattempts`
--

CREATE TABLE IF NOT EXISTS `loginattempts` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `ip` varchar(64) NOT NULL default '',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `banned` enum('yes','no') NOT NULL default 'no',
  `attempts` smallint(5) unsigned NOT NULL default '0',
  `type` enum('login','recover') NOT NULL default 'login',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=114897 ;

-- --------------------------------------------------------

--
-- 表的结构 `magiclog`
--

CREATE TABLE IF NOT EXISTS `magiclog` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `torrentid` int(10) unsigned NOT NULL,
  `userid` int(10) unsigned NOT NULL default '0',
  `endtime` datetime NOT NULL default '0000-00-00 00:00:00',
  `promotion_type` tinyint(3) unsigned NOT NULL default '0',
  `modsetting` int(2) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=16 ;

-- --------------------------------------------------------

--
-- 表的结构 `media`
--

CREATE TABLE IF NOT EXISTS `media` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `sort_index` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- 表的结构 `messages`
--

CREATE TABLE IF NOT EXISTS `messages` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `sender` mediumint(8) unsigned NOT NULL default '0',
  `receiver` mediumint(8) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `subject` varchar(128) NOT NULL default '',
  `msg` text,
  `unread` enum('yes','no') NOT NULL default 'yes',
  `location` smallint(6) NOT NULL default '1',
  `saved` enum('no','yes') NOT NULL default 'no',
  PRIMARY KEY  (`id`),
  KEY `receiver` (`receiver`),
  KEY `sender` (`sender`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=2252178 ;

-- --------------------------------------------------------

--
-- 表的结构 `midautumn`
--

CREATE TABLE IF NOT EXISTS `midautumn` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=270 ;

-- --------------------------------------------------------

--
-- 表的结构 `modpanel`
--

CREATE TABLE IF NOT EXISTS `modpanel` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `url` varchar(256) NOT NULL default '',
  `info` varchar(256) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10 ;

-- --------------------------------------------------------

--
-- 表的结构 `news`
--

CREATE TABLE IF NOT EXISTS `news` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `body` text,
  `title` varchar(255) NOT NULL default '',
  `notify` enum('yes','no') NOT NULL default 'no',
  PRIMARY KEY  (`id`),
  KEY `added` (`added`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=166 ;

-- --------------------------------------------------------

--
-- 表的结构 `offers`
--

CREATE TABLE IF NOT EXISTS `offers` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `name` varchar(225) NOT NULL,
  `descr` text,
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `allowedtime` datetime NOT NULL default '0000-00-00 00:00:00',
  `yeah` smallint(5) unsigned NOT NULL default '0',
  `against` smallint(5) unsigned NOT NULL default '0',
  `category` smallint(5) unsigned NOT NULL default '0',
  `comments` mediumint(8) unsigned NOT NULL default '0',
  `allowed` enum('allowed','pending','denied') NOT NULL default 'pending',
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=4920 ;

-- --------------------------------------------------------

--
-- 表的结构 `offervotes`
--

CREATE TABLE IF NOT EXISTS `offervotes` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `offerid` mediumint(8) unsigned NOT NULL default '0',
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `vote` enum('yeah','against') NOT NULL default 'yeah',
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=91236 ;

-- --------------------------------------------------------

--
-- 表的结构 `overforums`
--

CREATE TABLE IF NOT EXISTS `overforums` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `name` varchar(60) NOT NULL,
  `description` varchar(256) NOT NULL default '',
  `minclassview` tinyint(3) unsigned NOT NULL default '0',
  `sort` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=8 ;

-- --------------------------------------------------------

--
-- 表的结构 `peers`
--

CREATE TABLE IF NOT EXISTS `peers` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `torrent` mediumint(8) unsigned NOT NULL default '0',
  `peer_id` binary(20) NOT NULL,
  `ip` varchar(64) NOT NULL default '',
  `port` smallint(5) unsigned NOT NULL default '0',
  `uploaded` bigint(20) unsigned NOT NULL default '0',
  `downloaded` bigint(20) unsigned NOT NULL default '0',
  `to_go` bigint(20) unsigned NOT NULL default '0',
  `seeder` enum('yes','no') NOT NULL default 'no',
  `started` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_action` datetime NOT NULL default '0000-00-00 00:00:00',
  `prev_action` datetime NOT NULL default '0000-00-00 00:00:00',
  `connectable` enum('yes','no') NOT NULL default 'yes',
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `agent` varchar(60) NOT NULL default '',
  `finishedat` int(10) unsigned NOT NULL default '0',
  `downloadoffset` bigint(20) unsigned NOT NULL default '0',
  `uploadoffset` bigint(20) unsigned NOT NULL default '0',
  `passkey` char(32) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`),
  KEY `torrent` (`torrent`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=FIXED AUTO_INCREMENT=117239457 ;

-- --------------------------------------------------------

--
-- 表的结构 `pmboxes`
--

CREATE TABLE IF NOT EXISTS `pmboxes` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `userid` mediumint(8) unsigned NOT NULL,
  `boxnumber` tinyint(3) unsigned NOT NULL default '2',
  `name` varchar(15) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=97 ;

-- --------------------------------------------------------

--
-- 表的结构 `pollanswers`
--

CREATE TABLE IF NOT EXISTS `pollanswers` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `pollid` mediumint(8) unsigned NOT NULL,
  `userid` mediumint(8) unsigned NOT NULL,
  `selection` tinyint(3) unsigned NOT NULL,
  PRIMARY KEY  (`id`),
  KEY `pollid` (`pollid`),
  KEY `selection` (`selection`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=52623 ;

-- --------------------------------------------------------

--
-- 表的结构 `polls`
--

CREATE TABLE IF NOT EXISTS `polls` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
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
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=64 ;

-- --------------------------------------------------------

--
-- 表的结构 `posts`
--

CREATE TABLE IF NOT EXISTS `posts` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `topicid` mediumint(8) unsigned NOT NULL default '0',
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `body` text,
  `ori_body` text,
  `editedby` mediumint(8) unsigned NOT NULL default '0',
  `editdate` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`),
  KEY `topicid_id` (`topicid`,`id`),
  KEY `added` (`added`),
  FULLTEXT KEY `body` (`body`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=952802 ;

-- --------------------------------------------------------

--
-- 表的结构 `processings`
--

CREATE TABLE IF NOT EXISTS `processings` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `sort_index` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3 ;

-- --------------------------------------------------------

--
-- 表的结构 `prolinkclicks`
--

CREATE TABLE IF NOT EXISTS `prolinkclicks` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `ip` varchar(64) NOT NULL default '',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=10943 ;

-- --------------------------------------------------------

--
-- 表的结构 `readposts`
--

CREATE TABLE IF NOT EXISTS `readposts` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `topicid` mediumint(8) unsigned NOT NULL default '0',
  `lastpostread` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `topicid` (`topicid`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=1888489 ;

-- --------------------------------------------------------

--
-- 表的结构 `regimages`
--

CREATE TABLE IF NOT EXISTS `regimages` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `imagehash` varchar(32) NOT NULL default '',
  `imagestring` varchar(8) NOT NULL default '',
  `dateline` int(10) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8 AUTO_INCREMENT=1 ;

-- --------------------------------------------------------

--
-- 表的结构 `reports`
--

CREATE TABLE IF NOT EXISTS `reports` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `addedby` mediumint(8) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `reportid` int(10) unsigned NOT NULL default '0',
  `type` enum('torrent','user','offer','request','post','comment','subtitle') NOT NULL default 'torrent',
  `reason` varchar(255) NOT NULL default '',
  `dealtby` mediumint(8) unsigned NOT NULL default '0',
  `dealtwith` tinyint(1) NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3583 ;

-- --------------------------------------------------------

--
-- 表的结构 `rules`
--

CREATE TABLE IF NOT EXISTS `rules` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `lang_id` smallint(5) unsigned NOT NULL default '6',
  `title` varchar(255) NOT NULL,
  `text` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=56 ;

-- --------------------------------------------------------

--
-- 表的结构 `schools`
--

CREATE TABLE IF NOT EXISTS `schools` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=101 ;

-- --------------------------------------------------------

--
-- 表的结构 `searchbox`
--

CREATE TABLE IF NOT EXISTS `searchbox` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `name` varchar(30) default NULL,
  `showsubcat` tinyint(1) NOT NULL default '0',
  `showsource` tinyint(1) NOT NULL default '0',
  `showmedium` tinyint(1) NOT NULL default '0',
  `showcodec` tinyint(1) NOT NULL default '0',
  `showstandard` tinyint(1) NOT NULL default '0',
  `showprocessing` tinyint(1) NOT NULL default '0',
  `showteam` tinyint(1) NOT NULL default '0',
  `showaudiocodec` tinyint(1) NOT NULL default '0',
  `catsperrow` smallint(5) unsigned NOT NULL default '7',
  `catpadding` smallint(5) unsigned NOT NULL default '25',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- 表的结构 `secondicons`
--

CREATE TABLE IF NOT EXISTS `secondicons` (
  `id` smallint(5) unsigned NOT NULL auto_increment,
  `source` tinyint(3) unsigned NOT NULL default '0',
  `medium` tinyint(3) unsigned NOT NULL default '0',
  `codec` tinyint(3) unsigned NOT NULL default '0',
  `standard` tinyint(3) unsigned NOT NULL default '0',
  `processing` tinyint(3) unsigned NOT NULL default '0',
  `team` tinyint(3) unsigned NOT NULL default '0',
  `audiocodec` tinyint(3) unsigned NOT NULL default '0',
  `name` varchar(30) NOT NULL,
  `class_name` varchar(255) default NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=23 ;

-- --------------------------------------------------------

--
-- 表的结构 `shoutbox`
--

CREATE TABLE IF NOT EXISTS `shoutbox` (
  `id` int(10) NOT NULL auto_increment,
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `date` int(10) unsigned NOT NULL default '0',
  `text` text NOT NULL,
  `type` enum('sb','hb') NOT NULL default 'sb',
  `ip` varchar(64) default NULL,
  `robotmsg` enum('yes','no') NOT NULL default 'no',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=109464 ;

-- --------------------------------------------------------

--
-- 表的结构 `sitelog`
--

CREATE TABLE IF NOT EXISTS `sitelog` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `txt` text NOT NULL,
  `security_level` enum('normal','mod') NOT NULL default 'normal',
  PRIMARY KEY  (`id`),
  KEY `added` (`added`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=416208 ;

-- --------------------------------------------------------

--
-- 表的结构 `snatched`
--

CREATE TABLE IF NOT EXISTS `snatched` (
  `id` int(10) NOT NULL auto_increment,
  `torrentid` mediumint(8) unsigned NOT NULL default '0',
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `ip` varchar(64) NOT NULL default '',
  `port` smallint(5) unsigned NOT NULL default '0',
  `uploaded` bigint(20) unsigned NOT NULL default '0',
  `downloaded` bigint(20) unsigned NOT NULL default '0',
  `to_go` bigint(20) unsigned NOT NULL default '0',
  `seedtime` int(10) unsigned NOT NULL default '0',
  `leechtime` int(10) unsigned NOT NULL default '0',
  `last_action` datetime NOT NULL default '0000-00-00 00:00:00',
  `startdat` datetime NOT NULL default '0000-00-00 00:00:00',
  `completedat` datetime NOT NULL default '0000-00-00 00:00:00',
  `finished` enum('yes','no') NOT NULL default 'no',
  PRIMARY KEY  (`id`),
  KEY `torrentid_userid` (`torrentid`,`userid`),
  KEY `userid` (`userid`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3887947 ;

-- --------------------------------------------------------

--
-- 表的结构 `sources`
--

CREATE TABLE IF NOT EXISTS `sources` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `sort_index` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=9 ;

-- --------------------------------------------------------

--
-- 表的结构 `staffmessages`
--

CREATE TABLE IF NOT EXISTS `staffmessages` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `sender` mediumint(8) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `msg` text,
  `subject` varchar(128) NOT NULL default '',
  `answeredby` mediumint(8) unsigned NOT NULL default '0',
  `answered` tinyint(1) NOT NULL default '0',
  `answer` text,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=351 ;

-- --------------------------------------------------------

--
-- 表的结构 `standards`
--

CREATE TABLE IF NOT EXISTS `standards` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `sort_index` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- 表的结构 `stylesheets`
--

CREATE TABLE IF NOT EXISTS `stylesheets` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `uri` varchar(255) NOT NULL default '',
  `name` varchar(64) NOT NULL default '',
  `addicode` text,
  `designer` varchar(50) NOT NULL default '',
  `comment` varchar(255) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=14 ;

-- --------------------------------------------------------

--
-- 表的结构 `subs`
--

CREATE TABLE IF NOT EXISTS `subs` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `torrent_id` mediumint(8) unsigned NOT NULL,
  `lang_id` smallint(5) unsigned NOT NULL,
  `title` varchar(255) NOT NULL default '',
  `filename` varchar(255) NOT NULL default '',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `size` bigint(20) unsigned NOT NULL default '0',
  `uppedby` mediumint(8) unsigned NOT NULL default '0',
  `anonymous` enum('yes','no') NOT NULL default 'no',
  `hits` mediumint(8) unsigned NOT NULL default '0',
  `ext` varchar(10) NOT NULL default '',
  PRIMARY KEY  (`id`),
  KEY `torrentid_langid` (`torrent_id`,`lang_id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=43964 ;

-- --------------------------------------------------------

--
-- 表的结构 `suggest`
--

CREATE TABLE IF NOT EXISTS `suggest` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `keywords` varchar(255) NOT NULL default '',
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `adddate` datetime NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`id`),
  KEY `keywords` (`keywords`(4)),
  KEY `adddate` (`adddate`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=3953900 ;

-- --------------------------------------------------------

--
-- 表的结构 `sysoppanel`
--

CREATE TABLE IF NOT EXISTS `sysoppanel` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(128) NOT NULL default '',
  `url` varchar(256) NOT NULL default '',
  `info` varchar(256) NOT NULL default '',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=13 ;

-- --------------------------------------------------------

--
-- 表的结构 `teams`
--

CREATE TABLE IF NOT EXISTS `teams` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(30) NOT NULL,
  `sort_index` tinyint(3) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC AUTO_INCREMENT=6 ;

-- --------------------------------------------------------

--
-- 表的结构 `thanks`
--

CREATE TABLE IF NOT EXISTS `thanks` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `torrentid` mediumint(8) unsigned NOT NULL default '0',
  `userid` mediumint(8) unsigned NOT NULL default '0',
  PRIMARY KEY  (`id`),
  KEY `torrentid_userid` (`torrentid`,`userid`),
  KEY `torrentid_id` (`torrentid`,`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24213761 ;

-- --------------------------------------------------------

--
-- 表的结构 `topics`
--

CREATE TABLE IF NOT EXISTS `topics` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `userid` mediumint(8) unsigned NOT NULL default '0',
  `subject` varchar(128) NOT NULL,
  `locked` enum('yes','no') NOT NULL default 'no',
  `forumid` smallint(5) unsigned NOT NULL default '0',
  `firstpost` int(10) unsigned NOT NULL default '0',
  `lastpost` int(10) unsigned NOT NULL default '0',
  `sticky` enum('no','yes') NOT NULL default 'no',
  `hlcolor` tinyint(3) unsigned NOT NULL default '0',
  `views` int(10) unsigned NOT NULL default '0',
  `casinomode` enum('yes','no') NOT NULL default 'no',
  PRIMARY KEY  (`id`),
  KEY `userid` (`userid`),
  KEY `subject` (`subject`),
  KEY `forumid_lastpost` (`forumid`,`lastpost`),
  KEY `forumid_sticky_lastpost` (`forumid`,`sticky`,`lastpost`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=24077 ;

-- --------------------------------------------------------

--
-- 表的结构 `torrents`
--

CREATE TABLE IF NOT EXISTS `torrents` (
  `id` mediumint(8) unsigned NOT NULL auto_increment,
  `info_hash` binary(20) NOT NULL,
  `name` varchar(255) NOT NULL default '',
  `filename` varchar(255) NOT NULL default '',
  `save_as` varchar(255) NOT NULL default '',
  `descr` text,
  `small_descr` varchar(255) NOT NULL default '',
  `ori_descr` text,
  `category` smallint(5) unsigned NOT NULL default '0',
  `source` tinyint(3) unsigned NOT NULL default '0',
  `medium` tinyint(3) unsigned NOT NULL default '0',
  `codec` tinyint(3) unsigned NOT NULL default '0',
  `standard` tinyint(3) unsigned NOT NULL default '0',
  `processing` tinyint(3) unsigned NOT NULL default '0',
  `team` tinyint(3) unsigned NOT NULL default '0',
  `audiocodec` tinyint(3) unsigned NOT NULL default '0',
  `size` bigint(20) unsigned NOT NULL default '0',
  `added` datetime NOT NULL default '0000-00-00 00:00:00',
  `type` enum('single','multi') NOT NULL default 'single',
  `numfiles` smallint(5) unsigned NOT NULL default '0',
  `comments` mediumint(8) unsigned NOT NULL default '0',
  `views` int(10) unsigned NOT NULL default '0',
  `hits` int(10) unsigned NOT NULL default '0',
  `times_completed` mediumint(8) unsigned NOT NULL default '0',
  `leechers` mediumint(8) unsigned NOT NULL default '0',
  `seeders` mediumint(8) unsigned NOT NULL default '0',
  `last_action` datetime NOT NULL default '0000-00-00 00:00:00',
  `visible` enum('yes','no') NOT NULL default 'yes',
  `banned` enum('yes','no') NOT NULL default 'no',
  `owner` mediumint(8) unsigned NOT NULL default '0',
  `nfo` blob,
  `sp_state` tinyint(3) unsigned NOT NULL default '1',
  `anonymous` enum('yes','no') NOT NULL default 'no',
  `url` int(10) unsigned default NULL,
  `pos_state` enum('normal','sticky') NOT NULL default 'normal',
  `cache_stamp` tinyint(3) unsigned NOT NULL default '0',
  `douban_cache_stamp` tinyint(3) unsigned NOT NULL default '0',
  `picktype` enum('hot','classic','recommended','normal') NOT NULL default 'normal',
  `picktime` datetime NOT NULL default '0000-00-00 00:00:00',
  `promotion_time_type` tinyint(3) unsigned NOT NULL default '0',
  `promotion_until` datetime NOT NULL default '0000-00-00 00:00:00',
  `last_reseed` datetime NOT NULL default '0000-00-00 00:00:00',
  `douban_url` varchar(80) default NULL,
  PRIMARY KEY  (`id`),
  UNIQUE KEY `info_hash` (`info_hash`),
  KEY `owner` (`owner`),
  KEY `visible_pos_id` (`visible`,`pos_state`,`id`),
  KEY `url` (`url`),
  KEY `category_visible_banned` (`category`,`visible`,`banned`),
  KEY `visible_banned_pos_id` (`visible`,`banned`,`pos_state`,`id`),
  FULLTEXT KEY `name` (`name`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=95332 ;

-- --------------------------------------------------------

--
-- 表的结构 `torrents_state`
--

CREATE TABLE IF NOT EXISTS `torrents_state` (
  `global_sp_state` tinyint(3) unsigned NOT NULL default '1'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- 表的结构 `uploadspeed`
--

CREATE TABLE IF NOT EXISTS `uploadspeed` (
  `id` tinyint(3) unsigned NOT NULL auto_increment,
  `name` varchar(50) default NULL,
  PRIMARY KEY  (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=19 ;

-- --------------------------------------------------------

--
-- 表的结构 `users`
--

CREATE TABLE IF NOT EXISTS `users` (
  `id` int(10) unsigned NOT NULL auto_increment,
  `username` varchar(40) NOT NULL default '',
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
  `last_browse` int(10) unsigned NOT NULL default '0',
  `last_music` int(10) unsigned NOT NULL default '0',
  `last_catchup` int(10) unsigned NOT NULL default '0',
  `editsecret` varbinary(20) NOT NULL,
  `privacy` enum('strong','normal','low') NOT NULL default 'normal',
  `stylesheet` tinyint(3) unsigned NOT NULL default '1',
  `caticon` tinyint(3) unsigned NOT NULL default '1',
  `fontsize` enum('small','medium','large') NOT NULL default 'medium',
  `info` text,
  `acceptpms` enum('yes','friends','no') NOT NULL default 'yes',
  `commentpm` enum('yes','no') NOT NULL default 'yes',
  `ip` varchar(64) NOT NULL default '',
  `class` tinyint(3) unsigned NOT NULL default '1',
  `max_class_once` tinyint(3) NOT NULL default '1',
  `avatar` varchar(256) NOT NULL default '',
  `uploaded` bigint(20) unsigned NOT NULL default '0',
  `downloaded` bigint(20) unsigned NOT NULL default '0',
  `seedtime` bigint(19) unsigned NOT NULL default '0',
  `leechtime` bigint(19) unsigned NOT NULL default '0',
  `title` varchar(30) NOT NULL default '',
  `country` smallint(5) unsigned NOT NULL default '107',
  `notifs` varchar(500) default NULL,
  `modcomment` text,
  `enabled` enum('yes','no') NOT NULL default 'yes',
  `avatars` enum('yes','no') NOT NULL default 'yes',
  `donor` enum('yes','no') NOT NULL default 'no',
  `donated` decimal(8,2) NOT NULL default '0.00',
  `donated_cny` decimal(8,2) NOT NULL default '0.00',
  `donoruntil` datetime NOT NULL default '0000-00-00 00:00:00',
  `warned` enum('yes','no') NOT NULL default 'no',
  `warneduntil` datetime NOT NULL default '0000-00-00 00:00:00',
  `noad` enum('yes','no') NOT NULL default 'no',
  `noaduntil` datetime NOT NULL default '0000-00-00 00:00:00',
  `torrentsperpage` tinyint(3) unsigned NOT NULL default '0',
  `topicsperpage` tinyint(3) unsigned NOT NULL default '0',
  `postsperpage` tinyint(3) unsigned NOT NULL default '0',
  `clicktopic` enum('firstpage','lastpage') NOT NULL default 'firstpage',
  `deletepms` enum('yes','no') NOT NULL default 'yes',
  `savepms` enum('yes','no') NOT NULL default 'no',
  `showhot` enum('yes','no') NOT NULL default 'yes',
  `showclassic` enum('yes','no') NOT NULL default 'yes',
  `support` enum('yes','no') NOT NULL default 'no',
  `picker` enum('yes','no') NOT NULL default 'no',
  `stafffor` varchar(255) NOT NULL,
  `supportfor` varchar(255) NOT NULL,
  `pickfor` varchar(255) NOT NULL,
  `supportlang` varchar(50) NOT NULL,
  `passkey` varchar(32) NOT NULL default '',
  `promotion_link` varchar(32) default NULL,
  `uploadpos` enum('yes','no') NOT NULL default 'yes',
  `forumpost` enum('yes','no') NOT NULL default 'yes',
  `downloadpos` enum('yes','no') NOT NULL default 'yes',
  `clientselect` tinyint(3) unsigned NOT NULL default '0',
  `signatures` enum('yes','no') NOT NULL default 'yes',
  `signature` varchar(800) NOT NULL default '',
  `lang` smallint(5) unsigned NOT NULL default '6',
  `cheat` smallint(6) NOT NULL default '0',
  `download` int(10) unsigned NOT NULL default '0',
  `upload` int(10) unsigned NOT NULL default '0',
  `isp` tinyint(3) unsigned NOT NULL default '0',
  `invites` smallint(5) unsigned NOT NULL default '0',
  `invited_by` mediumint(8) unsigned NOT NULL default '0',
  `gender` enum('Male','Female','N/A') NOT NULL default 'N/A',
  `vip_added` enum('yes','no') NOT NULL default 'no',
  `vip_until` datetime NOT NULL default '0000-00-00 00:00:00',
  `seedbonus` decimal(10,1) NOT NULL default '0.0',
  `charity` decimal(10,1) NOT NULL default '0.0',
  `bonuscomment` text,
  `parked` enum('yes','no') NOT NULL default 'no',
  `leechwarn` enum('yes','no') NOT NULL default 'no',
  `leechwarnuntil` datetime NOT NULL default '0000-00-00 00:00:00',
  `lastwarned` datetime NOT NULL default '0000-00-00 00:00:00',
  `timeswarned` tinyint(3) unsigned NOT NULL default '0',
  `warnedby` mediumint(8) unsigned NOT NULL default '0',
  `sbnum` smallint(5) unsigned NOT NULL default '70',
  `sbrefresh` smallint(5) unsigned NOT NULL default '120',
  `hidehb` enum('yes','no') default 'no',
  `showimdb` enum('yes','no') default 'yes',
  `showdouban` enum('yes','no') default 'yes',
  `showdescription` enum('yes','no') default 'yes',
  `showcomment` enum('yes','no') default 'yes',
  `showclienterror` enum('yes','no') NOT NULL default 'no',
  `showdlnotice` tinyint(1) NOT NULL default '1',
  `tooltip` enum('minorimdb','medianimdb','minordouban','mediandouban','off') NOT NULL default 'off',
  `shownfo` enum('yes','no') default 'yes',
  `timetype` enum('timeadded','timealive') default 'timealive',
  `appendsticky` enum('yes','no') default 'yes',
  `appendnew` enum('yes','no') default 'yes',
  `appendpromotion` enum('highlight','word','icon','off') default 'highlight',
  `appendpicked` enum('yes','no') default 'yes',
  `dlicon` enum('yes','no') default 'yes',
  `bmicon` enum('yes','no') default 'yes',
  `showsmalldescr` enum('yes','no') NOT NULL default 'yes',
  `showcomnum` enum('yes','no') default 'yes',
  `showlastcom` enum('yes','no') default 'no',
  `showlastpost` enum('yes','no') NOT NULL default 'no',
  `pmnum` tinyint(3) unsigned NOT NULL default '10',
  `school` smallint(5) unsigned NOT NULL default '35',
  `showfb` enum('yes','no') NOT NULL default 'yes',
  `helpstraw` int(10) NOT NULL default '0',
  `stylesheet_temp` int(10) NOT NULL default '5',
  `showonline` enum('yes','no') NOT NULL default 'yes',
  `shownhdrobot` enum('yes','no') NOT NULL default 'yes',
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
  KEY `class` (`class`),
  KEY `passkey` (`passkey`(8))
) ENGINE=MyISAM  DEFAULT CHARSET=utf8 AUTO_INCREMENT=70626 ;
