<?php

/*
 * BBCode 源代码查看窗口 
 * 
 * 版本：1.0
 * 作者：樱桃
 * 时间：2014-10-01
 * 
 * 修订记录：
 * 无
 * 
 */ 


require_once("include/bittorrent.php");
require_once(get_langfile_path());

dbconn();

// 是否可以查看当前代码。
$can_view_bbcode = (get_user_class() >= $viewbbcode_class ||  $CURUSER["id"] == $row["owner"]);

// 如果当前用户没有权限，则显示权限不足并中止执行。
if(!$can_view_bbcode){  
    permissiondenied();
    die();
}

// 种子 ID。
$id = 0 + $_GET['id'];

// 查询种子信息。
$sql = new_mysqli();
$query = $sql->prepare("SELECT `name`, `descr`, `banned` FROM `torrents` WHERE `id` = ?");
$query->bind_param("i", $id);
$query->execute();
$query->bind_result($title, $descrption, $banned);

// 没有找到种子。
if (!$query->fetch()) {
    stderr($lang_details['std_error'], $lang_details['std_no_torrent_id']);
    die();
}

// Ban 项目的特殊权限检查。
if ($banned == 'yes' && get_user_class() < $seebanned_class){
    permissiondenied();
    die();
}

// 关闭数据库。
$sql->close();

// 当前用户的语言。
$user_lang = get_user_lang($CURUSER['id']);

?>

<h1><?= MessageFormatter::formatMessage($user_lang, $lang_bbcode['text_title_format'], $title) ?></h1>
<p><?= $lang_bbcode['text_instruction'] ?></p>

<table style="width: 95%; margin: 10px;">
	<thead>
		<tr>
			<th class="colhead" align="center"><?= MessageFormatter::formatMessage($user_lang, $lang_bbcode['text_title_format'], $title) ?></th>
		</tr>
	</thead>
	<tbody>
		<tr>
			<td>
				<blockquote style="white-space: pre-wrap; overflow:scroll; font-family: 'Segoe UI';">
					<?= htmlspecialchars($descrption) ?>
				</blockquote>
			</td>
		</tr>
	</tbody>
</table>


