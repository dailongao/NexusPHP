<?php
// Send bonus in BBS
// By Dai, 2014.3
require "include/bittorrent.php";
dbconn();
require_once(get_langfile_path());
loggedinorreturn();

global $taxpercentage_bonus, $basictax_bonus;

// Use post and try to check outsite-submit
if(!isset($_POST['id']) || !isset($_POST['bonus'])){
	print("Error Post Value");
	die();
}

$website = "http://{$_SERVER['SERVER_NAME']}";
if(strpos($_SERVER['HTTP_REFERER'], $website) !== 0){
	print("Error source");
	die();
}

$userid = (int)$_POST['id'];
$points = (int)$_POST['bonus'];
$bonuscomment = $CURUSER['bonuscomment'];

$res = sql_query("SELECT username, bonuscomment FROM users WHERE id = " . $userid);
$arr = mysql_fetch_assoc($res);
$receiverbonuscomment = $arr['bonuscomment'];

if ($points < 25 || $points > 10000) {
	print($lang_sendbonus['bonus_amount_not_allowed']);
	die();
}

if($CURUSER['seedbonus'] >= $points) {
	$points2= number_format($points,1);
	$bonuscomment = date("Y-m-d") . " - " .$points2. " Points as gift to ".htmlspecialchars(trim($arr['username'])).".\n " .htmlspecialchars($bonuscomment);

	$aftertaxpoint = $points;
	if ($taxpercentage_bonus)
		$aftertaxpoint -= $aftertaxpoint * $taxpercentage_bonus * 0.01;
	if ($basictax_bonus)
		$aftertaxpoint -= $basictax_bonus;

	$points2receiver = number_format($aftertaxpoint,1);
	$newreceiverbonuscomment = date("Y-m-d") . " + " .$points2receiver. " Points (after tax) as a gift from ".($CURUSER["username"]).".\n " .htmlspecialchars($receiverbonuscomment);

	if ($userid==$CURUSER['id']){
		print($lang_sendbonus['text_karma_self_giving_warning']);
		die();
	}

	sql_query("UPDATE users SET seedbonus = seedbonus - $points, bonuscomment = ".sqlesc($bonuscomment)." WHERE id = ".sqlesc($CURUSER['id'])) or sqlerr(__FILE__, __LINE__);
	sql_query("UPDATE users SET seedbonus = seedbonus + $aftertaxpoint, bonuscomment = ".sqlesc($newreceiverbonuscomment)." WHERE id = ".sqlesc($userid));

	//===send message
	$subject = sqlesc($lang_sendbonus['msg_someone_loves_you']);
	$added = sqlesc(date("Y-m-d H:i:s"));
	$msg = $lang_sendbonus['msg_you_have_been_given'].$points2.$lang_sendbonus['msg_after_tax'].$points2receiver.$lang_sendbonus['msg_karma_points_by'].$CURUSER['username'];
	if ($message)
		$msg .= "\n".$lang_sendbonus['msg_personal_message_from'].$CURUSER['username'].$lang_sendbonus_target['msg_colon'].$message;
	$msg = sqlesc($msg);
	sql_query("INSERT INTO messages (sender, subject, receiver, msg, added) VALUES(0, $subject, $userid, $msg, $added)") or sqlerr(__FILE__, __LINE__);
	$usernamegift = unesc($arr["username"]);
	print $lang_sendbonus['text_ok'];
} else {
	print $lang_sendbonus['text_not_enough_karma'];
	die();
}
?>