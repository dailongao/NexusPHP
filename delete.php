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

// 作者语言
$owner_lang = get_user_lang($row["owner"]);
$owner_lang_target = $lang_delete_target[$owner_lang];

if ($rt == 1)
{
	$reasonstr = "Dead: 0 seeders, 0 leechers = 0 peers total)";
	$message_reason_str = $owner_lang_target['text_reasontype_dead'];
}
elseif ($rt == 2)
{
	if($reason[0]) 	{
		$reasonstr = MessageFormatter::formatMessage("", "Dupe: {0}" , array($reason[0]));
		$message_reason_str = MessageFormatter::formatMessage($owner_lang, $owner_lang_target['text_reasontype_dupe_reason'], array($reason[0]));
	} else {
		$reasonstr = "Dupe!";
		$message_reason_str = $owner_lang_target['text_reasontype_dupe'];
	}
}
elseif ($rt == 3) {
	if ($reason[1]) {
		$reasonstr = MessageFormatter::formatMessage("", "Nuked: {0}" , array($reason[1]));
		$message_reason_str = MessageFormatter::formatMessage($owner_lang, $owner_lang_target['text_reasontype_nuked_reason'], array($reason[1]));
	} else {
		$reasonstr = "Nuked!";
		$message_reason_str = $owner_lang_target['text_reasontype_nuked'];
	}
}
elseif ($rt == 4) {
	if ($reason[2])	{
		$reasonstr = MessageFormatter::formatMessage("", "{0} rules broken: {1}", array($SITENAME, $reason[2]));
		$message_reason_str =  MessageFormatter::formatMessage($owner_lang, $owner_lang_target['text_reasontype_rule_broken_reason'], array($reason[2]));
	} else {
		bark($lang_delete['std_describe_violated_rule']);
	}
	
}
else
{
	if ($reason[3]){
		$reasonstr = $reason[3];
		$message_reason_str = $reason[3];
	} else {
		bark($lang_delete['std_enter_reason']);
	}
}

$deletesubs = (bool)$_POST['deletesubs'];

// 是否匿名删除。
$is_anonymous = $row['anonymous'] == 'yes' && $CURUSER["id"] == $row["owner"];

// 字幕 ID 列表。
$subtitle_id_list = deletetorrent($id, $row['name'], $is_anonymous, $deletesubs);

// 将返回的单个字幕信息组合为字符串的方法。
$generate_subtitle_info = function($item) {
		return MessageFormatter::formatMessage("", "{0} ({1})", array($item['id'], $item['name']));
};

// 删除字幕的完整列表字符串。
$deleted_sub_title_text = join(", ", array_map($generate_subtitle_info, $subtitle_id_list));

// 删除者字符串。
$deleter = $is_anonymous ? "its anonymous uploader" : $CURUSER[username];

// 写入删除消息。
$message_format = empty($subtitle_id_list) ? "Torrent {0} ({1}) was deleted by {2} ({4})" : "Torrent {0} ({1}) and its subtitles {3} were deleted by {2} ({4})";
write_log(MessageFormatter::formatMessage("", $message_format, array($id, $row['name'], $deleter, $deleted_sub_title_text, $reasonstr)), "normal");


//===remove karma
KPS("-",$uploadtorrent_bonus,$row["owner"]);

//Send pm to torrent uploader
if ($CURUSER["id"] != $row["owner"]){
	
	
	// 带有用户链接的用户信息。
	$deleter_info = MessageFormatter::formatMessage("", "[url=userdetails.php?id={0}]{1}[/url]", array($CURUSER['id'], $CURUSER['username']));
	
	// 删除消息标题。
	$subject = $owner_lang_target['msg_torrent_deleted'];
	// 删除消息正文。
	$msg = MessageFormatter::formatMessage($owner_lang, $owner_lang_target['msg_torrrent_deleted_format'], array($row['name'], $deleter_info, $message_reason_str)); 
	
	// 时间。
	$dt = (string)date("Y-m-d H:i:s");
	
	$sql = new_mysqli();
	
	$query = $sql->prepare("INSERT INTO `messages` (`sender`, `receiver`, `subject`, `added`, `msg`) VALUES (0, ?, ?, ?, ?)");
	$query->bind_param("isss", $row['owner'], $subject, $dt, $msg);

	$query->execute() or sqlerr(__FILE__, __LINE__);
	
	$sql->close();
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
