<?php

/*
 * CC98 ID 相关功能页面
 * 
 * 版本：1.0
 * 作者：樱桃
 * 时间：2014-10-14
 * 
 * 修订记录：
 * 无
 * 
 */

require_once("include/bittorrent.php");
dbconn();
loggedinorreturn();

$user_lang = get_current_user_lang();
$res = get_current_user_resource()['cc98_logon'];

function generate_uri($state) {
	
	global $cc98_client_id, $cc98_client_secret, $cc98_redirect_uri;
	
	return MessageFormatter::formatMessage('', 'https://openid.cc98.org/connect/authorize?client_id={0}&redirect_uri={1}&response_type=code&state={2}&scope=openid', array(urlencode($cc98_client_id), urlencode($cc98_redirect_uri), urlencode($state)));

}

// 是否是 Post 协议。
if(!empty($_POST)) {
	switch($_POST['action']){
		case 'delete':
			dodelete();
			break;
	}
	// 异常处理。
	die();
}
else {
	switch($_GET['action']){
		
		case 'new':
			$title = $res['msg_create_association_title'];
			$state = array(
				'id' => $CURUSER['id'],
				'action' => 'new',
				'returnto' => $_POST['returnto'],
			);
			generate_action_link($title, $state);
			break;
		case 'edit':
			$title = $res['msg_edit_association_title'];
			$state = array(
				'id' => $CURUSER['id'],
				'action' => 'edit',
				'returnto' => $_POST['returnto'],
			);
			generate_action_link($title, $state);
			break;
		case 'delete':
			generate_delete_link();
			break;
	}
}


function generate_delete_link() {
	
	global $CURUSER, $user_lang, $res;
	
	stdhead($res['msg_delete_association_title']);
	
?>

<form method="post">
	<p><?= MessageFormatter::formatMessage($user_lang, $res['msg_delete_association_text'], array(htmlspecialchars($CURUSER['cc98id']))) ?></p>
	<input type="hidden" name="action" value="delete" />
	<button type="submit"><?= $res['msg_delete_association_button_text'] ?></button>
</form>

<?php

	stdfoot();
}

function generate_action_link($title, $state) {
	
	global $res;
	
	$state_str = protect_data($state);	
	stdhead($title);
?>
<h1><?= $title ?></h1>
<p><?= $res['msg_edit_association_text'] ?></p>
<a href="<?= generate_uri($state_str) ?>"><?= $res['msg_edit_association_link_text'] ?></a>
<?php
}

/**
 * 执行删除操作。
 */
function dodelete(){
	
	global $CURUSER, $res;
	
	$sql = new_mysqli();
	$query = $sql->prepare('UPDATE `users` SET `cc98id` = NULL WHERE `id` = ?');
	$query->bind_param('i', $CURUSER['id']);
	$query->execute();
	
?>
<meta http-equiv="refresh" content="3; url=/" />
<?php

	$title = $res['msg_delete_association_success_title'];
	$msg = $res['msg_delete_association_success_text'];
	
	stdhead($title);
	stdmsg($title, $msg);
	stdfoot();
	die();
}