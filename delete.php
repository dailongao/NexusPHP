<?php
require_once("include/bittorrent.php");
dbconn();
require_once(get_langfile_path());
require_once(get_langfile_path("",true));
loggedinorreturn();

function bark($msg) {
    global $lang_delete;
    stdhead();
    stdmsg($lang_delete['std_delete_failed'], $msg);
    stdfoot();
    exit;
}

if (!mkglobal("id"))
	bark($lang_delete['std_missing_form_date']);

$id = 0 + $id;
if (!$id)
	die();

$res = sql_query("SELECT name,owner,seeders,anonymous FROM torrents WHERE id = ".sqlesc($id));
$row = mysql_fetch_array($res);
if (!$row)
	die();

if ($CURUSER["id"] != $row["owner"] && get_user_class() < $torrentmanage_class)
	bark($lang_delete['std_not_owner']);

$rt = 0 + $_POST["reasontype"];

if (!is_int($rt) || $rt < 1 || $rt > 5)
	bark($lang_delete['std_invalid_reason']."$rt.");

$r = $_POST["r"];
$reason = $_POST["reason"];

if ($rt == 1)
	$reasonstr = "Dead: 0 seeders, 0 leechers = 0 peers total";
elseif ($rt == 2)
	$reasonstr = "Dupe" . ($reason[0] ? (": " . trim($reason[0])) : "!");
elseif ($rt == 3)
	$reasonstr = "Nuked" . ($reason[1] ? (": " . trim($reason[1])) : "!");
elseif ($rt == 4)
{
	if (!$reason[2])
		bark($lang_delete['std_describe_violated_rule']);
    $reasonstr = $SITENAME." rules broken: " . trim($reason[2]);
}
else
{
	if (!$reason[3])
		bark($lang_delete['std_enter_reason']);
    $reasonstr = trim($reason[3]);
}

$deletesubs = (bool)$_POST['deletesubs'];

// 字幕 ID 列表。
$subtitle_id_list = deletetorrent($id, $deletesubs);

// 将返回的单个字幕信息组合为字符串的方法。
$generate_subtitle_info = function($item) {
    return MessageFormatter::formatMessage("", "{0} ({1} {2}.{3})", $item['id'], $item['lang_name'], $item['title'], $item['ext']);
};

// 删除字幕的完整列表字符串。
$deleted_sub_title_text = join(",", array_map($generate_subtitle_info, $subtitle_id_list));

// 删除者字符串。
$deleter = $row['anonymous'] == 'yes' && $CURUSER["id"] == $row["owner"] ? "anonymous uploader" : $CURUSER[username];

// 写入删除消息。
$message_format = empty($subtitle_id_list) ? "Torrent {0} ({1}) was deleted by {2}" : "Torrent {0} ({1}) and its subtitles ({3}) was deleted by {2}";
write_log(MessageFormatter::formatMessage("", $message_format, array($id, $row['name'], $deleter, $deleted_sub_title_text)), "normal");


//===remove karma
KPS("-",$uploadtorrent_bonus,$row["owner"]);

//Send pm to torrent uploader
if ($CURUSER["id"] != $row["owner"]){
	$dt = sqlesc(date("Y-m-d H:i:s"));
	$subject = sqlesc($lang_delete_target[get_user_lang($row["owner"])]['msg_torrent_deleted']);
	$msg = sqlesc($lang_delete_target[get_user_lang($row["owner"])]['msg_the_torrent_you_uploaded'].$row['name'].$lang_delete_target[get_user_lang($row["owner"])]['msg_was_deleted_by']."[url=userdetails.php?id=".$CURUSER['id']."]".$CURUSER['username']."[/url]".$lang_delete_target[get_user_lang($row["owner"])]['msg_reason_is'].$reasonstr);
	sql_query("INSERT INTO messages (sender, receiver, subject, added, msg) VALUES(0, $row[owner], $subject, $dt, $msg)") or sqlerr(__FILE__, __LINE__);
}
stdhead($lang_delete['head_torrent_deleted']);

if (isset($_POST["returnto"]))
	$ret = "<a href=\"" . htmlspecialchars($_POST["returnto"]) . "\">".$lang_delete['text_go_back']."</a>";
else
	$ret = "<a href=\"index.php\">".$lang_delete['text_back_to_index']."</a>";

?>
<h1><?php echo $lang_delete['text_torrent_deleted'] ?></h1>
<p><?php echo  $ret ?></p>
<?php
stdfoot();
