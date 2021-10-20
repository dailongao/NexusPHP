<?php
require_once("include/bittorrent.php");
dbconn();
loggedinorreturn();

// �û���Դ
$res = get_user_resource($CURUSER['id']);
$res_delete = $res['delete'];

if (!mkglobal("id"))
	show_error($res_delete['delete_failed_title'], $res_delete['error_missing_form_data']);

$id = 0 + $id;
if (!$id)
	die();

$res = sql_query("SELECT name,owner,seeders,anonymous FROM torrents WHERE id = ".sqlesc($id));
$row = mysql_fetch_array($res);
if (!$row)
	die();

if ($CURUSER["id"] != $row["owner"] && get_user_class() < $torrentmanage_class)
	show_error($res_delete['delete_failed_title'], $res_delete['error_not_owner']);

$rt = 0 + $_POST["reasontype"];

if (!is_int($rt) || $rt < 1 || $rt > 5)
	show_error($res_delete['delete_failed_title'],$res_delete['error_invalid_data']);

$r = $_POST["r"];
$reason = $_POST["reason"];

// ϵͳ��־��ԭ��˵����
$reason_str_log = generate_delete_reason(null, $rt, $reason);

$deletesubs = (bool)$_POST['deletesubs'];

// �Ƿ�����ɾ����
$is_anonymous = $row['anonymous'] == 'yes' && $CURUSER["id"] == $row["owner"];

// ��Ļ ID �б�
$subtitle_id_list = deletetorrent($id, $row['name'], $is_anonymous, $rt, $reason, $deletesubs);

// �����صĵ�����Ļ��Ϣ���Ϊ�ַ����ķ�����
$generate_subtitle_info = function($item) {
		return MessageFormatter::formatMessage("", "{0} ({1})", array($item['id'], $item['name']));
};

// ɾ����Ļ�������б��ַ�����
$deleted_sub_title_text = join(", ", array_map($generate_subtitle_info, $subtitle_id_list));

// ɾ�����ַ�����
$deleter = $is_anonymous ? "its anonymous uploader" : $CURUSER[username];

// д��ɾ����Ϣ��
$message_format = empty($subtitle_id_list) ? "Torrent {0} ({1}) was deleted by {2}: {4}" : "Torrent {0} ({1}) and its subtitles {3} were deleted by {2}: {4}";
write_log(MessageFormatter::formatMessage("", $message_format, array($id, $row['name'], $deleter, $deleted_sub_title_text, $reason_str_log)), "normal");


//===remove karma
KPS("-",$uploadtorrent_bonus, $row["owner"]);

//Send pm to torrent uploader
if ($CURUSER["id"] != $row["owner"]){
	
	// ��������
	$owner_lang = get_fix_user_lang($row["owner"]);
	
	// ɾ��������ص���Դ��
	$owner_delete_res = get_user_resource($row["owner"])['delete_torrent_target'];
	
	// ���ظ��������ߵ�ԭ��˵��
	$reason_str = generate_delete_reason($row["owner"], $rt, $reason);
	
	// �����û����ӵ��û���Ϣ��
	$deleter_info = MessageFormatter::formatMessage("", "[url=userdetails.php?id={0}]{1}[/url]", array($CURUSER['id'], $CURUSER['username']));
	
	// ɾ����Ϣ���⡣
	$subject = $owner_delete_res['msg_torrent_deleted'];

	// ɾ����Ϣ���ġ�
	$msg = MessageFormatter::formatMessage($owner_lang, $owner_delete_res['msg_torrent_deleted_format'], array($id, $row['name'], $deleter_info, $reason_str)); 
	
	
	// ʱ�䡣
	$dt = (string)date("Y-m-d H:i:s");
	
	$sql = new_mysqli();
	
	$query = $sql->prepare("INSERT INTO `messages` (`sender`, `receiver`, `subject`, `added`, `msg`) VALUES (0, ?, ?, ?, ?)");
	$query->bind_param("isss", $row['owner'], $subject, $dt, $msg);

	$query->execute() or sqlerr(__FILE__, __LINE__);
	
	$sql->close();
}


stdhead($res_delete['torrent_deleted_title']);

if (isset($_POST["returnto"]))
	$ret = "<a href=\"" . htmlspecialchars($_POST["returnto"]) . "\">".$lang_delete['text_go_back']."</a>";
else
	$ret = "<a href=\"index.php\">".$lang_delete['text_back_to_index']."</a>";

?>
<h1><?= $res_delete['text_torrent_deleted'] ?></h1>
<p>
	<?php if (isset($_POST["returnto"])) { ?>
	<a href="<?= htmlspecialchars($_POST["returnto"]) ?>"><?= $res_delete['text_go_back'] ?></a>
	<?php } else { ?>
	<a href="/"><?= $res_delete['text_back_to_index'] ?></a>
	<?php }
		  
		  stdfoot();
