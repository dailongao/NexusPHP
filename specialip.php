<?php

require_once("include/bittorrent.php");


/**
 * 特殊 IP 列表。
 */
global $special_ip_list;

$special_ip_list = array(
	"10.15.173.174",
	);

/**
 * 判断当前 IP 是否是特殊 IP。
 * @return 如果当前 IP 是特殊 IP 返回 true；否则返回 false。
 */
function is_special_ip(){
	
	global $special_ip_list;
	$ip = getip();
	return in_array($ip, $special_ip_list);
}

?>