<?php
require_once('include/bittorrent.php');
dbconn();
//require_once(get_langfile_path());
//require(get_langfile_path("",true));
loggedinorreturn();
parked();

/*	Easter Egg System
	Temporary for activity
	by Dai, 2013.12.24
	so sad... */

$user_perday_limitation = 5;

if(isset($_GET['key'])){
	/* Check user's limitation */
	$userid = (int)$CURUSER['id'];
	$nowday = date("Y-m-d");
	$sql = "SELECT * FROM easteregg WHERE userid = $userid AND eggdate = CURRENT_DATE()";
	$res = sql_query($sql) or sqlerr(__FILE__, __LINE__);
	if(mysql_num_rows($res) >= $user_perday_limitation){
		stderr("对不起", "您本日领取彩蛋数量已超限");
		die();
	}
	$sql = "SELECT * FROM easteregg WHERE eggkey = " . sqlesc($_GET['key']);
	$res = sql_query($sql) or sqlerr(__FILE__, __LINE__);
	if(mysql_num_rows($res) == 0){
		stderr("对不起", "您的提交参数不合法");
		die();
	}
	$arr = mysql_fetch_array($res);
	if($arr['userid'] != 0){
		stderr("对不起", "这个彩蛋已经被抢走啦~");
		die();
	}
	$bonus = rand(1, 200);
	$sql = "UPDATE easteregg SET userid = $userid, eggdate = CURRENT_DATE(), bonus = $bonus WHERE eggkey = " . sqlesc($_GET['key']);
	sql_query($sql) or sqlerr(__FILE__, __LINE__);
	$bonuscomment = date("Y-m-d") . " - " .$bonus. " Points for Easteregg.\n " .htmlspecialchars($CURUSER['bonuscomment']);
	sql_query("UPDATE users SET seedbonus = seedbonus + $bonus, bonuscomment = ".sqlesc($bonuscomment)." WHERE id = ".sqlesc($userid)) or sqlerr(__FILE__, __LINE__);
	stderr("恭喜", "您获得了一个 $bonus 的彩蛋！");
} else {
	stderr("对不起", "您的提交参数不合法。");
}

?>
