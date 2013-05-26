<?php
// Magic for torrent promotion V1.0
// By Dai, 2012.12 - 2013.3

require "include/bittorrent.php";
dbconn();
require_once(get_langfile_path());
loggedinorreturn();
//stdhead($lang_magic['head_magic']);

//check id
$id = 0 + $_GET["id"];

int_check($id);
if (!isset($id) || !$id)
	die();

//get info of a id
$res = sql_query("SELECT torrents.name, torrents.size, torrents.owner, torrents.sp_state, torrents.anonymous FROM torrents WHERE torrents.id = $id LIMIT 1")
or sqlerr();
$row = mysql_fetch_array($res);

//get the user info
$myid = $CURUSER["id"];
$myreq = sql_query("SELECT users.class FROM users WHERE users.id = $myid LIMIT 1") or sqlerr();
$tmparr = mysql_fetch_array($myreq);
$myclass = $tmparr['class'];
$ownerid = $row['owner'];
$myreq = sql_query("SELECT users.class FROM users WHERE users.id = $ownerid LIMIT 1") or sqlerr();
$tmparr = mysql_fetch_array($myreq);
$ownerclass = $tmparr['class'];

//count the magic
function countmagic($hr, $type){
	global $row, $myclass, $cntclass;
	//A
	if($type == 2) $cntA = 100;
	else if($type == 4) $cntA = 150;
	//L
	if($myclass > $ownerclass) $cntclass = $myclass;
	else $cntclass = $ownerclass;
	if($cntclass == UC_PEASANT || $cntclass == UC_USER || $cntclass == UC_POWER_USER
		|| $cntclass == UC_ELITE_USER) $cntL = 1;
	else if($cntclass == UC_CRAZY_USER || $cntclass == UC_INSANE_USER) $cntL = 0.9;
	else if($cntclass == UC_VETEREN_USER || $cntclass == UC_EXTREME_USER) $cntL = 0.8;
	else if($cntclass == UC_ULTIMATE_USER) $cntL = 0.7;
	else if($cntclass == UC_NEXUS_MASTER) $cntL = 0.6;
	else $cntL = 0.5;
	//S
	$cntS = ceil($row['size'] / 1073741824);
	//T
	$cntT = $hr;

	$ret = $cntA * $cntL * $cntS * $cntT;
	return $ret;
}

//ajax
if($_GET['test']){
	$prohr = $_POST['hours'];
	$protype = $_POST['promotion'];
	if(!is_valid_protype($protype)){
		write_log("User " . $CURUSER["username"] . " try to use a illegal promotion type. ", 'mod');
		print($lang_magic['illegal_op']);
		die();
	}
	if(!is_valid_hours($prohr)){
		print($lang_magic['illegal_time']);
	}else{
		print(countmagic($prohr, $protype));
	}
	die();
}

stdhead("");

if($_POST['action']){
	$prohr = $_POST['hours'];
	$protype = $_POST['promotion'];
	if(!is_valid_protype($protype)){
		write_log("User " . $CURUSER["username"] . " try to use a illegal promotion type. ", 'mod');
		print($lang_magic['illegal_op']);
		die();
	}
	if(!is_valid_hours($prohr)){
		print("<h1>".$lang_magic['illegal_time']."</h1>");
	}else if($row['sp_state'] == 2 || $row['sp_state'] == 4){
		print("<h1>".$lang_magic['cannot_cover']."</h1>");
	}else{
		$usemagic = countmagic($prohr, $protype);
		$userid = $CURUSER["id"];
		if($CURUSER['seedbonus'] >= $usemagic){
			//cut bonus
			sql_query("UPDATE users SET seedbonus = seedbonus - $usemagic WHERE id = ".sqlesc($userid)) or sqlerr(__FILE__, __LINE__);
			//add promotion
			$protime = date("Y-m-d H:i:s", strtotime("+ ".$prohr." hour"));
			sql_query("UPDATE torrents SET sp_state = $protype, promotion_time_type = 2, promotion_until = \"$protime\" WHERE id = ".sqlesc($id)) or sqlerr(__FILE__, __LINE__);
			write_log("User " . $CURUSER["username"] ." use a magic on a torrent which id = ". $id .", promotion type = ". $protype . ", exp time = ". $protime .", usemagic = ". $usemagic, 'mod');
			print("<h1>".$lang_magic['use_magic_ok'].$protime."</h1>");
		}else{
			print("<h1>".$lang_magic['no_enough_magic']."</h1>");
		}
	}
}

begin_main_frame();
begin_frame($lang_magic['magic_rule_title'], true,10,"100%","center", "left");
print($lang_magic['magic_rule']);
end_frame();

begin_frame($lang_magic['set_magic_title'], true,10,"100%","center");

//print form
print("<form action=\"\" method=\"post\"><input type=\"hidden\" name=\"action\" value=\"magic\" />");
//action flag
print("<input type=\"hidden\" name=\"action\" value=\"magic\" />");
//table style
print("<table width=\"75%\" cellpadding=\"4\"><tbody align=\"left\">");
//print torrent ID and information
print("<tr><td class=\"rowhead\" width=\"10%\">".$lang_magic['torrent_uid']."</td><td class=\"rowfollow\"><input type=\"hidden\" name=\"torrentid\" value=".$id." />".$id."</td></tr>");
print("<tr><td class=\"rowhead\" width=\"10%\">".$lang_magic['torrent_name']."</td><td class=\"rowfollow\">".$row['name']."</td></tr>");
print("<tr><td class=\"rowhead\" width=\"10%\">".$lang_magic['torrent_size']."</td><td class=\"rowfollow\">".mksize($row['size'])."</td></tr>");
//print owner rank
print("<tr><td class=\"rowhead\" width=\"10%\">".$lang_magic['torrent_owner']."</td><td class=\"rowfollow\">"."<b><span class='".get_user_class_name($ownerclass,true) . "_Name'>".get_user_class_name($ownerclass,false,false,true)."</span></b></td></tr>");
//print limit text
print("<tr><td class=\"rowhead\">".$lang_magic['promotion_limit']."</td><td class=\"rowfollow\"><input type=\"text\" name=\"hours\" value=\"24\" /><br />".$lang_magic['limit_rule']."</td></tr>");
//show free choose
print("<tr><td class=\"rowhead\">".$lang_magic['text_promotion_type']."</td><td class=\"rowfollow\"><select name=\"promotion\" class =\"med\" style=\"width: 100px;\"onchange=\"ShowHideCPromotion(this.value,'cp_fields');\"><option value=\"2\" class=\"free\">".$lang_magic['text_free']."</option><option value=\"4\" class=\"twoupfree\">".$lang_magic['text_2xfree']."</option></td></tr>");
//show magic point view
print("<tr><td class=\"rowhead\">".$lang_magic['count_magic']."</td><td class=\"rowfollow\"><span id=\"MagicPoint\"><i>".$lang_magic['wait_to_count']."</i></span> <input type=\"button\" onclick=\"countmagic(".$id.",this.form)\" value=\"".$lang_magic['count_the_magic']."\" /></td></tr>");
//foot
print("</tbody></table>");
//print a button
print("<input type=\"submit\" value=\"".$lang_magic['do_the_magic']."\" />");
print("</form>");
end_frame();

end_main_frame();
stdfoot();
?>
