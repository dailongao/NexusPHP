<?php
require_once("include/bittorrent.php");
dbconn();
require_once(get_langfile_path());
require(get_langfile_path("", true));
loggedinorreturn();

if (get_user_class() < $askreseed_class) {
	permissiondenied();
}

$reseedid = 0 + $_GET["reseedid"];
$res = sql_query("SELECT seeders, added, last_reseed FROM torrents WHERE id=" . sqlesc($reseedid) . " LIMIT 1") or sqlerr(__FILE__, __LINE__);
$row = mysql_fetch_array($res);
// 做种人数多于 1，种子没有断种
if ($row['seeders'] > 1) {
	stderr($lang_takereseed['std_error'], $lang_takereseed['std_torrent_not_dead']);
}
// 种子是 24 小时内发布的
elseif (TIMENOW - strtotime($row['added']) <= 24 * 60 * 60) {
	stderr($lang_takereseed['std_error'], $lang_takereseed['std_torrent_just_uploaded']);
}
// 15 min 内刚刚通知过，不能频繁请求
elseif (TIMENOW - strtotime($row['last_reseed']) <= 15 * 60) {
	stderr($lang_takereseed['std_error'], $lang_takereseed['std_reseed_sent_recently']);
}
// 发送续种请求
else {
	$res = sql_query("SELECT snatched.userid, torrents.name AS torrent_name, torrents.owner AS torrent_owner FROM snatched INNER JOIN torrents ON snatched.torrentid = torrents.id WHERE snatched.finished = 'Yes' AND snatched.torrentid = $reseedid") or sqlerr();
	while ($row = mysql_fetch_assoc($res)) {
		$rs_subject = $lang_takereseed_target[get_user_lang($row["userid"])]['msg_reseed_request'];
		$pn_msg = $lang_takereseed_target[get_user_lang($row["userid"])]['msg_user'] . $CURUSER["username"] . $lang_takereseed_target[get_user_lang($row["userid"])]['msg_ask_reseed'] . "[url=/details.php?id=" . $reseedid . "]" . $row["torrent_name"] . "[/url]" . $lang_takereseed_target[get_user_lang($row["userid"])]['msg_thank_you'];
		sql_query("INSERT INTO messages (sender, receiver, added, subject, msg) VALUES(0, $row[userid], '" . date("Y-m-d H:i:s") . "'," . sqlesc($rs_subject) . ", " . sqlesc($pn_msg) . ")") or sqlerr(__FILE__, __LINE__);
	}
	sql_query("UPDATE torrents SET last_reseed = " . sqlesc(date("Y-m-d H:i:s")) . " WHERE id=" . sqlesc($reseedid));
	stdhead($lang_takereseed['head_reseed_request']);
	begin_main_frame();
	print("<center>" . $lang_takereseed['std_it_worked'] . "</center>");
	end_main_frame();
	stdfoot();
}
