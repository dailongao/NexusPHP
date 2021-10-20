<?php

/*
 * CC98 登录回调页面
 * 
 * 版本：1.0
 * 作者：樱桃
 * 时间：2014-10-13
 * 
 * 修订记录：
 * 无
 * 
 */

require_once("include/bittorrent.php");
header("Content-Type: text/html; charset=utf-8");

dbconn();

// 资源对象。
$res = get_current_user_resource()['cc98_logon'];

// CC98 登录 APP 的客户端 ID 和机密。
global $cc98_client_id;
global $cc98_client_secret;

global $redirect_uri;

$code = $_GET['code'];
$state_str = $_GET['state'];

// 解密数据，如果解密失败则立即返回错误。
$state = unprotect_data($state_str);
if(!$state){
	show_system_error();
}


// 参数检查。
if(empty($code)) {
	show_system_error();
}

//// 发送到 Token 验证程序的字典。
//                var postDic = new Dictionary<string, string>
//                {
//                    {"client_id", Options.ClientId},
//                    {"client_secret", Options.ClientSecret},
//                    {"redirect_uri", RedirectUriBase},
//                    {"code", code},
//                    {"grant_type", "authorization_code"}
//                };

// 请求主体
$body = MessageFormatter::formatMessage('', 'client_id={0}&client_secret={1}&code={2}&grant_type=authorization_code&redirect_uri={3}', array (urlencode($cc98_client_id), urlencode($cc98_client_secret), urlencode($code), urlencode($cc98_redirect_uri)));

// URL 请求对象。
$request = curl_init('https://openid.cc98.org/connect/token');
curl_setopt($request, CURLOPT_POST, 1);
curl_setopt($request, CURLOPT_RETURNTRANSFER, 1);
curl_setopt($request, CURLOPT_POSTFIELDS, $body);

// 执行 URL 并返回结果。
$data = json_decode(curl_exec($request), true);

// 关闭连接。
curl_close($request);

// 获得授权令牌和授权类型。
$access_token = $data['access_token'];
$token_type = $data['token_type'];

$id_token = $data['id_token'];

$id_token_terms = explode('.', $id_token);
$id_token_header = base64_decode($id_token_terms[0]);
$id_token_payload = base64_decode($id_token_terms[1]);

$id_data = json_decode($id_token_payload, true);

// CC98 ID。
$cc98_id = $id_data['unique_name'];

// 如果无法获得 CC98 ID，则立即结束请求。
if(!$cc98_id) {
	show_system_error();
}

// 判断操作并执行对应的工作。
switch($state['action']){
	
	case "logon":
		dologon($cc98_id);
		break;
	case "new":
	case "edit":
		doedit($state, $cc98_id);
		break;
	default:
		break;
}

/**
 * 显示操作结果。
 */
function show_result(){
}

/**
 * 回到之前的页面地址。
 * @param string $returnto 要返回的页面。
 */
function goback($returnto) {
	
	$returnto = $returnto ? $returnto : "/";
	header("Location: " . $returnto);
	die();
}

/**
 * 追加返回到指定 URL 的 Meta 元素。
 * @param string $returnto 要返回的地址。 
 */
function goback_meta($returnto) {
	$returnto = $returnto ? $returnto : "/";
?>
<meta http-equiv="refresh" content="3; url=<?= $returnto ?>" />
<?php
}


/**
 * 编辑相关操作
 */
function doedit($state, $username){
	
	global $CURUSER;
	global $res;
	
	$user_lang = get_current_user_lang();
	
	// 防伪 ID。
	$xrsfid = $state['id'];
	
	// 如果防伪 ID 变化则失败。
	if($xrsfid != $CURUSER['id']) {
		show_system_error();
	}
	
	// 检查重复
	$sql = new_mysqli();
	$query = $sql->prepare('SELECT count(*) AS `total` FROM `users` WHERE `cc98id` = ? AND `id` <> ?');
	$query->bind_param("si", $username, $CURUSER['id']);
	$query->execute();
	$query->bind_result($count);
	
	$query->fetch();
	
	// 已经有账户关联。
	if($count <> 0) {
		stderr($res['msg_duplicated_association_title'], $res['msg_duplicated_association_text']);
		die();
	}
	
	$sql->close();
	
	// 执行数据库更新。
	$sql = new_mysqli();
	$query = $sql->prepare('UPDATE `users` SET `cc98id` = ? WHERE `id` = ?');
	$query->bind_param("si", $username, $CURUSER['id']);
	$query->execute();
	
	$sql->close();
	
	switch($state['action']){
		case "new":
			$title = $res['msg_create_association_success_title'];
			$msg = MessageFormatter::formatMessage($user_lang, $res['msg_create_association_success_text'], array($username));
			break;
		case "edit":
			$title = $res['msg_edit_association_success_title'];
			$msg = MessageFormatter::formatMessage($user_lang, $res['msg_edit_association_success_text'], array($username));
			break;
	}
	
	goback_meta($state['returnto']);
	stdhead($title);
	stdmsg($title, $msg);
	stdfoot();
	die();
}


/**
 * 登录相关操作。
 */
function dologon($cc98_id) {
	
	global $res;
	
	$user_lang = get_current_user_lang();
	
	$sql = new_mysqli();
	$query = $sql->prepare('SELECT `id`, `passhash`, `username` FROM `users` WHERE `cc98id` = ?');
	$query->bind_param('s', $cc98_id);
	$query->execute();
	$query->bind_result($id, $passhash, $username);

	// 是否匹配到结果。
	if ($query->fetch()){
		
		logincookie($id, md5($passhash));		
?>
<meta http-equiv="refresh" content="3; url=/" />
<?php

		$title = $res['msg_logon_success_title'];
		$msg = MessageFormatter::formatMessage($user_lang, $res['msg_logon_success_text'], array($username));
		stdhead($title);
		stdmsg($title, $msg);
		stdfoot();
		die();
		break;
		
		// 没有关联到账户
	} else {
		stderr($res['msg_no_associated_account_title'], $res['msg_no_associated_account_text']);
		die();
	}
}


/**
 * 显示错误并终止执行。
 */
function show_system_error(){
	
	global $res;
	stderr($res['msg_system_error_title'], $res['msg_system_error_text']);
	die();
}

?>
