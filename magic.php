<?php
// Magic for torrent promotion V2.0
// By Dai, 2013.6

require "include/bittorrent.php";
dbconn();
require_once(get_langfile_path());
loggedinorreturn();
//stdhead($lang_magic['head_magic']);
if(get_user_class() < UC_SYSOP){
	stderr("Sorry", "Sorry, we are updating this module.");
	die();
}

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

//promotion type name get daze
function get_promotion_typename($promotion){
	global $lang_magic;
	if($promotion==2)
		return $lang_magic['text_free'];
	elseif($promotion==3)
		return $lang_magic['text_two_times_up'];
	elseif($promotion==4)
		return $lang_magic['text_free_two_times_up'];
	elseif($promotion==5)
		return $lang_magic['text_half_down'];
	elseif($promotion==6)
		return $lang_magic['text_half_down_two_up'];
	elseif($promotion==7)
		return $lang_magic['text_thirty_percent_down'];
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
	/*}else if($row['sp_state'] == 2 || $row['sp_state'] == 4){
		print("<h1>".$lang_magic['cannot_cover']."</h1>");*/
	}else{
		$usemagic = countmagic($prohr, $protype);
		$userid = $CURUSER["id"];
		if($CURUSER['seedbonus'] >= $usemagic){
			//cut bonus
			sql_query("UPDATE users SET seedbonus = seedbonus - $usemagic WHERE id = ".sqlesc($userid)) or sqlerr(__FILE__, __LINE__);
			//get actual promotion time
			$nowtime = date("Y-m-d H:i:s");
			$res = sql_query("SELECT * FROM magiclog WHERE torrentid = $id AND modsetting = 0 AND endtime >= \"$nowtime\" ORDER BY endtime DESC LIMIT 1") or sqlerr(__FILE__, __LINE__);
			if(mysql_num_rows($res) == 0){
				$protime = date("Y-m-d H:i:s", strtotime("+ ".$prohr." hour"));
			}else{
				$arr = mysql_fetch_assoc($res);
				$protime = date("Y-m-d H:i:s", strtotime($arr['endtime']) + $prohr * 3600);
			}
			//try to update
			$check1 = sql_query("SELECT * FROM magiclog WHERE torrentid = $id AND modsetting = 0 AND endtime >= \"$nowtime\"") or sqlerr(__FILE__, __LINE__);
			$check2 = sql_query("SELECT * FROM magiclog WHERE torrentid = $id AND modsetting != 0 AND (endtime >= \"$nowtime\" OR endtime = \"0000-00-00 00:00:00\")") or sqlerr(__FILE__, __LINE__);
			if(mysql_num_rows($check1) == 0 && (mysql_num_rows($check2) == 0 or $protype == 4))
				sql_query("UPDATE torrents SET sp_state = $protype WHERE id = ".sqlesc($id)) or sqlerr(__FILE__, __LINE__);
			//add promotion
			sql_query("INSERT INTO magiclog (torrentid, userid, endtime, promotion_type, modsetting) VALUES (" . sqlesc($id) . ", " . sqlesc($CURUSER['id']) . ", \"$protime\", $protype, 0)") or sqlerr(__FILE__, __LINE__);
			write_log("User " . $CURUSER["username"] ." use a magic on a torrent which id = ". $id .", promotion type = ". $protype . ", exp time = ". $protime .", usemagic = ". $usemagic, 'mod');
			print("<h1>".$lang_magic['use_magic_ok'].$protime."</h1>");
		}else{
			print("<h1>".$lang_magic['no_enough_magic']."</h1>");
		}
	}
}

//rule
begin_main_frame();
begin_frame($lang_magic['magic_rule_title'], true,10,"100%","center", "left");
print($lang_magic['magic_rule']);
end_frame();

//show promotion log
begin_frame($lang_magic['magic_log_title'], true,10,"100%","center", "left");
?>

	<table align="center">
		<thead>
			<tr>
				<td align="center" width="200"><b><?php echo $lang_magic['col_username'] ?></b></td>
				<td align="center" width="200"><b><?php echo $lang_magic['col_protype'] ?></b></td>
				<td align="center" width="200"><b><?php echo $lang_magic['col_protime'] ?></b></td>
			</tr>
		</thead>
		
<?php
	$res = sql_query("SELECT * FROM magiclog WHERE torrentid = $id AND modsetting = 0 ORDER BY endtime DESC") or sqlerr(__FILE__, __LINE__);
	if(mysql_num_rows($res) > 0){	
		while($arr = mysql_fetch_assoc($res)){
			$uname = get_username($arr['userid']);
			$utype = get_promotion_typename($arr['promotion_type']);
			$utime = strtotime($arr['endtime']);
			$utime = date("Y-m-d H:i", $utime);
			print("<tr><td align=\"center\">$uname</td><td align=\"center\">$utype</td><td align=\"center\">$utime</td>");
		}
	}else{
		print "<tr><td colspan=\"8\" align=\"center\"><span>".$lang_magic['text_no_record']."</span></td></tr>";
	}
?>
	</table>

<?php
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
print("<tr><td class=\"rowhead\">".$lang_magic['text_promotion_type']."</td><td class=\"rowfollow\"><select name=\"promotion\" class =\"med\" style=\"width: 100px;\"onchange=\"ShowHideCPromotion(this.value,'cp_fields');\"><option value=\"2\" class=\"free\">".$lang_magic['text_free']."</option><option value=\"4\" class=\"twoupfree\">".$lang_magic['text_free_two_times_up']."</option></td></tr>");
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
