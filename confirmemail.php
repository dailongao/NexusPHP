<?php
require_once("include/bittorrent.php");


$id = $_GET["id"];
$md5 = $_GET["hash"];
$email = $_GET["mail"];
//print($email);
//die();

if (!$id)
	httperr();
dbconn();

$res = sql_query("SELECT editsecret FROM users WHERE id = $id");
$row = mysql_fetch_array($res);

if (!$row)
	httperr();

$sec = hash_pad($row["editsecret"]);
if (preg_match('/^ *$/s', $sec))
	httperr();
if ($md5 != md5($sec . $email . $sec))
	httperr();

sql_query("UPDATE users SET editsecret='', email=" . sqlesc($email) . " WHERE id=$id AND editsecret=" . sqlesc($row["editsecret"]));

if (!mysql_affected_rows())
	httperr();

header("Refresh: 0; url=" . get_protocol_prefix() . "$BASEURL/usercp.php?action=security&type=saved");
?>