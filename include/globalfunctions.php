<?php
if(!defined('IN_TRACKER'))
die('Hacking attempt!');

function get_global_sp_state()
{
	global $Cache;
	static $global_promotion_state;
	if (!$global_promotion_state){
		if (!$global_promotion_state = $Cache->get_value('global_promotion_state')){
			$res = mysql_query("SELECT * FROM torrents_state");
			$row = mysql_fetch_assoc($res);
			$global_promotion_state = $row["global_sp_state"];
			$Cache->cache_value('global_promotion_state', $global_promotion_state, 57226);
		}
	}
	return $global_promotion_state;
}

/**
 * 将 IPv4 地址转换为整数。
 * @param string $ip 要转换的 IP 地址。
 * @return integer 转换后的整数值。
 */
function convert_ipv4_to_integer($ip) {

	// 分割 IP 为数组。
	$ip_seg = explode(".", $ip);
	
	// 长度不对则直接返回。
	if (count($ip_seg) !== 4) {
		return null;
	}
	
	// 使用位运算获得最终结果。
	return ((int)$ip_seg[0] << 24) | ((int)$ip_seg[1] << 16) | ((int)$ip_seg[2] << 8) | (int)$ip_seg[3];
}


// 如果有必要，将 IP 字符串转换为整数的函数。
function check_ip_str($value) {
		
	// 整数时后不需要任何处理
	if (is_int($value)) {
		return $value;
	// 字符串时进行转换
	} elseif (is_string($value)) {
		return convert_ipv4_to_integer($value);
	// 其他类型将引发异常
	} else {
		throw new InvalidArgumentException('Type of the argument should be either int or string.');
	}
}
	
/**
 * 判断 IP 地址是否位于给定的子网内。
 * @param mixed $ip 要判断的 IP 地址。可以是整数或者字符串。
 * @param mixed $subnet_start 目标子网的起始地址。可以是整数或者字符串。
 * @param integer $subnet_prefex_length 目标子网的前缀长度。
 * @return boolean 如果 IP 地址位于子网内，返回 true；否则返回 false。
 */
function ip_is_in_subnet($ip, $subnet_start, $subnet_perfex_length) {

	// 转换参数。
	$real_ip = check_ip_str($ip);
	$real_subnet_start = check_ip_str($subnet_start);
	
	if ($subnet_perfex_length < 0 || $subnet_perfex_length > 32) {
		throw new OutOfRangeException('Subnet prefex length must between 0 and 32.');
	}

	// 掩码值，应该是一个 32 位整数，其中前面给定位数为 1，后面为 0
	$mask = ~((1 << (32 - $subnet_perfex_length)) - 1);
		
	// 子网起始地址有效性检测。如果子网起始地址在掩码后包含非零位则表示无效。
	if (($real_subnet_start & ~$mask) !== 0) {
		throw new InvalidArgumentException('Subnet start address and mask is not valid.');
	}
	
	// 有效性判断：两个网址在掩码作用后相同。
	return ($real_subnet_start & $mask) === ($real_ip & $mask);
}


/**
 * 判断 IP 地址是否位于给定的子网内。
 * @param string $ip 要判断的 IP 地址字符串。
 * @param string $subnet_string 目标子网，使用“起始地址/前缀长度”表示法的字符串。
 * @return boolean 如果 IP 地址位于子网内，返回 true；否则返回 false。
 */
function ip_is_in_subnet_str($ip, $subnet_string) {
	
	// 空白忽略。
	if (!$subnet_string || strlen(trim($subnet_string)) === 0) {
		return false;
	}
	
	$sub_arr = explode("/", $subnet_string);
	
	if (count($sub_arr) !== 2) {
		throw new InvalidArgumentException('The format of parameter $subnet_string is invalid.');
	}
	
	return ip_is_in_subnet($ip, $sub_arr[0], (int)$sub_arr[1]);
}


// IP Validation
function validip($ip)
{
	if (!ip2long($ip)) //IPv6
		return true;
	if (!empty($ip) && $ip == long2ip(ip2long($ip)))
	{
		// reserved IANA IPv4 addresses
		// http://www.iana.org/assignments/ipv4-address-space
		$reserved_ips = array (
		array('192.0.2.0','192.0.2.255'),
		array('192.168.0.0','192.168.255.255'),
		array('255.255.255.0','255.255.255.255')
		);

		foreach ($reserved_ips as $r)
		{
			$min = ip2long($r[0]);
			$max = ip2long($r[1]);
			if ((ip2long($ip) >= $min) && (ip2long($ip) <= $max)) return false;
		}
		return true;
	}
	else return false;
}

function get_ip_from_proxy_string($ip) {
	
	/*
		The Forward Header maybe: IP1:Port1, IP2:Port2, ...
	*/

	$items = explode(",", $ip);
	$first_ip = trim($items[0]);

	// Brackets IPv6
	if (preg_match('/^\[(.*)\]$/i', $first_ip, $matches)) {
		$host_name = $matches[1];
	} elseif (substr_count($first_ip, ":") > 1) { // IPV6
		$host_name = $first_ip;
	} else {
		$host_name = parse_url("http://" . $first_ip, PHP_URL_HOST);
	}

	return $host_name;
}

function getip() {
	if (isset($_SERVER)) {
		if (isset($_SERVER['HTTP_X_FORWARDED_FOR']) && validip($_SERVER['HTTP_X_FORWARDED_FOR'])) {
			$ip = $_SERVER['HTTP_X_FORWARDED_FOR'];
		} elseif (isset($_SERVER['HTTP_CLIENT_IP']) && validip($_SERVER['HTTP_CLIENT_IP'])) {
			$ip = $_SERVER['HTTP_CLIENT_IP'];
		} else {
			$ip = $_SERVER['REMOTE_ADDR'];
		}
	} else {
		if (getenv('HTTP_X_FORWARDED_FOR') && validip(getenv('HTTP_X_FORWARDED_FOR'))) {
			$ip = getenv('HTTP_X_FORWARDED_FOR');
		} elseif (getenv('HTTP_CLIENT_IP') && validip(getenv('HTTP_CLIENT_IP'))) {
			$ip = getenv('HTTP_CLIENT_IP');
		} else {
			$ip = getenv('REMOTE_ADDR');
		}
	}

	return get_ip_from_proxy_string($ip);
}

function sql_query($query)
{
	global $query_name;
	$query_name[] = $query;
	return mysql_query($query);
}

function sqlesc($value) {
	// Stripslashes
	if (get_magic_quotes_gpc()) {
		$value = stripslashes($value);
	}
	// Quote if not a number or a numeric string
	if (!is_numeric($value)) {
		$value = "'" . mysql_real_escape_string($value) . "'";
	}
	return $value;
}

function hash_pad($hash) {
    return str_pad($hash, 20);
}

function hash_where($name, $hash) {
	$shhash = preg_replace('/ *$/s', "", $hash);
	return "($name = " . sqlesc($hash) . " OR $name = " . sqlesc($shhash) . ")";
}
?>
