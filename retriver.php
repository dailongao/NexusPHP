<?php
require_once("include/bittorrent.php");
require ("imdb/imdb.class.php");
require ("douban/douban.class.php");
dbconn();
loggedinorreturn();

global $CURUSER;

$id = 0 + $_GET["id"];
$type = 0 + $_GET["type"];
$siteid = 0 + $_GET["siteid"]; // 1 for IMDb

if (!isset($id) || !$id || !is_numeric($id) || !isset($type) || !$type || !is_numeric($type) || !isset($siteid) || !$siteid || !is_numeric($siteid))
die();

$r = sql_query("SELECT * from torrents WHERE id = " . sqlesc($id)) or sqlerr(__FILE__, __LINE__);
if(mysql_num_rows($r) != 1)
die();

$row = mysql_fetch_assoc($r);

if (get_user_class() < $updateextinfo_class && $CURUSER["id"] != $row["owner"]) {
permissiondenied();
}

switch ($siteid)
{
	case 1 : 
	{
		$imdb_id = parse_imdb_id($row["url"]);
		if ($imdb_id)
		{
			$thenumbers = $imdb_id;
			#$movie = new imdb ($thenumbers);
			#$movieid = $thenumbers;
			#$movie->setid ($movieid);
			#$target = array('Title', 'Credits', 'Plot');
			#($type == 2 ? $movie->purge_single(true) : "");
			#set_cachetimestamp($id,"cache_stamp");
			#$movie->preparecache($target,true);
			unlink(__DIR__ . '/imdb/newcache/tt' . $thenumbers);
			$Cache->delete_value('imdb_id_'.$thenumbers.'_movie_name');
			$Cache->delete_value('imdb_id_'.$thenumbers.'_large', true);
			$Cache->delete_value('imdb_id_'.$thenumbers.'_median', true);
			$Cache->delete_value('imdb_id_'.$thenumbers.'_minor', true);
			header("Location: " . get_protocol_prefix() . "$BASEURL/details.php?id=".htmlspecialchars($id));
		}
		break;
	}
	case 2:
	{
		$douban_id = parse_douban_id($row["douban_url"]);
		$douban_type = parse_douban_type($row["douban_url"]);
		
		if ($douban_id)
		{
			$douban = "";
			if($douban_type == "movie")
				$douban = new douban_movie ($douban_id);
			else if ($douban_type == "music")
				$douban = new douban_music ($douban_id);
			
			($type == 2 ? $douban->purge(true) : "");
			set_cachetimestamp($id,"douban_cache_stamp");
			$douban->retrive();
			$douban->parse();
			$douban->get_image();
			$Cache->delete_value('douban_id_'.$douban_id.'_movie_name');
			$Cache->delete_value('douban_id_'.$douban_id.'_large', true);
			$Cache->delete_value('douban_id_'.$douban_id.'_median', true);
			$Cache->delete_value('douban_id_'.$douban_id.'_minor', true);
			header("Location: " . get_protocol_prefix() . "$BASEURL/details.php?id=".htmlspecialchars($id));
		}
		break;
	}
	default :
	{
		die("Error!");
		break;
	}
}

?>
