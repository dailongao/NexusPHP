<?php
ob_start();
require_once("include/bittorrent.php");
dbconn();

function add_egg($cnt){
	for($i = 0; $i < $cnt; $i++){
		$key = md5(mt_rand(0,3000000) . time() . mt_rand(0,3000000) . "easteregg");
		$sql = "INSERT INTO easteregg (eggkey, userid) VALUES (\"$key\", 0)";
		//echo $sql;
		sql_query($sql) or sqlerr(__FILE__, __LINE__);
	}
}

if (get_user_class() < UC_ADMINISTRATOR) {
	die('forbidden');
}

if(isset($_GET['cnt']))
	add_egg($_GET['cnt']);

?>
