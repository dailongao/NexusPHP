<?php
require "include/bittorrent.php";
require_once ("douban/douban.class.php");
dbconn();
//Send some headers to keep the user's browser from caching the response.
header("Expires: Mon, 26 Jul 1997 05:00:00 GMT" ); 
header("Last-Modified: " . gmdate( "D, d M Y H:i:s" ) . "GMT" ); 
header("Cache-Control: no-cache, must-revalidate" ); 
header("Pragma: no-cache" );
header("Content-Type: text/xml; charset=utf-8");
$douban_url = $_GET['douban_url'];
$mode = $_GET['type'];
$cache_stamp = $_GET['cache'];
$douban_id = parse_douban_id($douban_url);
$douban_type = parse_douban_type($douban_url);

$Cache->new_page('douban_id_'.$douban_id.'_'.$mode, 1296000, true);
if (!$Cache->get_page())
{
	$infoblock = getdouban($douban_id, $douban_type, $cache_stamp, $mode);
	if ($infoblock)
	{
		$Cache->add_whole_row();
		print($infoblock);
		$Cache->end_whole_row();
		$Cache->cache_page();
		echo $Cache->next_row();
	}
}
else echo $Cache->next_row();
?>