<?php
require "include/bittorrent.php";
dbconn();
if (!$CURUSER)
{
	Header("Location: " . get_protocol_prefix() . "$BASEURL/");
	die;
}

$filename = $_GET["subid"];
$dirname = $_GET["torrentid"];

if (!$filename || !$dirname)
die("File name missing\n");

$filename = 0 + $filename;
$extendedDirname = (int)((0 + $dirname) / 10000);
$dirname = 0 + $dirname;

$res = sql_query("SELECT * FROM subs WHERE id=$filename") or sqlerr(__FILE__, __LINE__);
$arr = mysql_fetch_assoc($res);
if (!$arr)
die("Not found\n");

sql_query("UPDATE subs SET hits=hits+1 WHERE id=$filename") or sqlerr(__FILE__, __LINE__);
$file = "$SUBSPATH/$extendedDirname/$dirname/$filename.$arr[ext]";

if (!is_file($file))
die("File not found\n");
$f = fopen($file, "rb");
if (!$f)
die("Cannot open file\n");
header("Content-Length: " . filesize($file));
header("Content-Type: application/octet-stream");


if ( str_replace("Gecko", "", $_SERVER['HTTP_USER_AGENT']) != $_SERVER['HTTP_USER_AGENT'])
{
	header ("Content-Disposition: attachment; filename=\"$arr[filename]\"");
}
else if ( str_replace("Firefox", "", $_SERVER['HTTP_USER_AGENT']) != $_SERVER['HTTP_USER_AGENT'] )
{
	header ("Content-Disposition: attachment; filename=\"$arr[filename]\"");
}
else if ( str_replace("Opera", "", $_SERVER['HTTP_USER_AGENT']) != $_SERVER['HTTP_USER_AGENT'] )
{
	header ("Content-Disposition: attachment; filename=\"$arr[filename]\"");
}
else if ( str_replace("IE", "", $_SERVER['HTTP_USER_AGENT']) != $_SERVER['HTTP_USER_AGENT'] )
{
	header ("Content-Disposition: attachment; filename=".str_replace("+", "%20", rawurlencode($arr[filename])));
}
else
{
	header ("Content-Disposition: attachment; filename=\"$torrentnameprefix.".$row["save_as"].".torrent\"");
}

do
{
$s = fread($f, 4096);
print($s);
} while (!feof($f));
//closefile($f);
exit;
?>
