<?php

/*
 * CC98 登录页面
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

global $cc98_client_id, $cc98_redirect_uri;

$state = array(
	'action' => 'logon',
	'returnto' => $_GET['returnto'],
	);

$state_str = protect_data($state);

$url = MessageFormatter::formatMessage('', 'https://login.cc98.org/OAuth/Authorize?client_id={0}&redirect_uri={1}&response_type=code&state={2}', array(urlencode($cc98_client_id), urlencode($cc98_redirect_uri), urlencode($state_str)));

// 重定向到登录页面。
header('Location: ' . $url, true);
exit();

?>