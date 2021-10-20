<?php
require_once("include/bittorrent.php");
dbconn();
require_once(get_langfile_path());
require_once("include/ai.php"); #Load AI Library

function ai_response($content)
{
	# AI Module V0.1.20130409
	# Test only. 
	global $ai_library, $function_library;
	global $CURUSER;
	foreach ($ai_library as $value) {
		foreach ($value['keyword'] as $kw) {
			if (preg_match($kw, $content)) {
				$ret = $value['response'][array_rand($value['response'], 1)];
				if (preg_match("/function/", $ret)) {
					if ($ret == "function:date") { // date
						//check user level
						if (get_user_class() >= UC_INSANE_USER) {
							$ret = $function_library['date']['success'];
						} else {
							$ret = $function_library['date']['fail'];
						}
					}
					if ($ret == "function:midautumn") { // mid autumn
						$res = sql_query("SELECT * FROM midautumn WHERE userid = " . sqlesc($CURUSER['id'])) or sqlerr(__FILE__, __LINE__);
						if (mysql_num_rows($res) != 0) {
							$ret = $function_library['midautumn']['fail'];
						} else {
							$bscom = date("Y-m-d") . " - " . " 500 Points for Mid-autumn Festival.\n " . $CURUSER['bonuscomment'];
							sql_query("UPDATE users SET seedbonus = seedbonus + 500, bonuscomment = " . sqlesc($bscom) . " WHERE id = " . sqlesc($CURUSER['id'])) or sqlerr(__FILE__, __LINE__);
							sql_query("INSERT into midautumn (userid) VALUES (" . sqlesc($CURUSER['id']) . ")") or sqlerr(__FILE__, __LINE__);
							$ret = $function_library['midautumn']['success'];
						}
					}
					if ($ret == "function:closenhdrobot") { // close NHDRobot
						sql_query("UPDATE users SET shownhdrobot = 'no' WHERE id = " . sqlesc($CURUSER['id'])) or sqlerr(__FILE__, __LINE__);
						//$ret = $function_library['closenhdrobot'];
						$ret = "norep";
					}
					if ($ret == "function:opennhdrobot") { // open NHDRobot
						sql_query("UPDATE users SET shownhdrobot = 'yes' WHERE id = " . sqlesc($CURUSER['id'])) or sqlerr(__FILE__, __LINE__);
						//$ret = $function_library['opennhdrobot'];
						$ret = "norep";
					}
				}
				return $ret;
			}
		}
	}
	return "";
}

if (isset($_GET['del'])) {
	if (is_valid_id($_GET['del'])) {
		if ((get_user_class() >= $sbmanage_class)) {
			sql_query("DELETE FROM shoutbox WHERE id=" . mysql_real_escape_string($_GET['del']));
		}
	}
}
$where = $_GET["type"];
$refresh = ($CURUSER['sbrefresh'] ? $CURUSER['sbrefresh'] : 120)
?>
<html>

<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta http-equiv="Refresh" content="<?php echo $refresh ?>; url=<?php echo get_protocol_prefix() . $BASEURL ?>/shoutbox.php?type=<?php echo $where ?>">
	<link rel="stylesheet" href="<?php echo get_font_css_uri() ?>" type="text/css">
	<link rel="stylesheet" href="<?php echo get_css_uri() . "theme.css" ?>" type="text/css">
	<link rel="stylesheet" href="styles/curtain_imageresizer.css" type="text/css">
	<script src="curtain_imageresizer.js" type="text/javascript"></script>
	<style type="text/css">
		body {
			overflow-y: scroll;
			overflow-x: hidden
		}
	</style>
	<?php
	print(get_style_addicode());
	$startcountdown = "startcountdown(" . $CURUSER['sbrefresh'] . ")";
	?>
	<script type="text/javascript">
		//<![CDATA[
		var t;

		function startcountdown(time) {
			parent.document.getElementById('countdown').innerHTML = time;
			time = time - 1;
			t = setTimeout("startcountdown(" + time + ")", 1000);
		}

		function countdown(time) {
			if (time <= 0) {
				parent.document.getElementById("hbtext").disabled = false;
				parent.document.getElementById("hbsubmit").disabled = false;
				parent.document.getElementById("hbsubmit").value = parent.document.getElementById("sbword").innerHTML;
			} else {
				parent.document.getElementById("hbsubmit").value = time;
				time = time - 1;
				setTimeout("countdown(" + time + ")", 1000);
			}
		}

		function hbquota() {
			parent.document.getElementById("hbtext").disabled = true;
			parent.document.getElementById("hbsubmit").disabled = true;
			var time = 10;
			countdown(time);
			//]]>
		}
	</script>
</head>

<body class='inframe' <?php if ($_GET["type"] != "helpbox") { ?> onload="<?php echo $startcountdown ?>" <?php } else { ?> onload="hbquota()" <?php } ?>>
	<?php
	if ($_GET["sent"] == "yes") {
		if (!$_GET["shbox_text"]) {
			$userid = 0 + $CURUSER["id"];
		} else {
			if ($_GET["type"] == "helpbox") {
				if ($showhelpbox_main != 'yes') {
					write_log("Someone is hacking shoutbox. - IP : " . getip(), 'mod');
					die($lang_shoutbox['text_helpbox_disabled']);
				}
				$userid = 0;
				$type = 'hb';
			} elseif ($_GET["type"] == 'shoutbox') {
				$userid = 0 + $CURUSER["id"];
				if (!$userid) {
					write_log("Someone is hacking shoutbox. - IP : " . getip(), 'mod');
					die($lang_shoutbox['text_no_permission_to_shoutbox']);
				}
				if ($_GET["toguest"])
					$type = 'hb';
				else $type = 'sb';
			}
			$date = sqlesc(time());
			$text = trim($_GET["shbox_text"]);

			$ai_text = ai_response($text);
			if ($ai_text != "") {
				sql_query("INSERT INTO shoutbox (userid, date, text, type, ip, robotmsg) VALUES (" . sqlesc($userid) . ", $date, " . sqlesc($text) . ", " . sqlesc($type) . ", " . sqlesc(getip()) . ", " . sqlesc("yes") . ")") or sqlerr(__FILE__, __LINE__);
			} else {
				sql_query("INSERT INTO shoutbox (userid, date, text, type, ip) VALUES (" . sqlesc($userid) . ", $date, " . sqlesc($text) . ", " . sqlesc($type) . ", " . sqlesc(getip()) . ")") or sqlerr(__FILE__, __LINE__);
			}

			if ($ai_text != "" && $ai_text != "norep") {
				$aidate = $date + 1;
				sql_query("INSERT INTO shoutbox (userid, date, text, type, ip, robotmsg) VALUES (" . sqlesc($aiuserid) . ", $aidate, " . sqlesc($ai_text) . ", " . sqlesc($type) . ", " . sqlesc(getip()) . ", " . sqlesc("yes") . ")") or sqlerr(__FILE__, __LINE__);
			}
			print "<script type=\"text/javascript\">parent.document.forms['shbox'].shbox_text.value='';</script>";
		}
	}

	//Annoucement
	print($lang_shoutbox['announcement']);

	$limit = ($CURUSER['sbnum'] ? $CURUSER['sbnum'] : 70);

	if ($where == "helpbox") {
		$sql = "SELECT * FROM shoutbox WHERE type='hb' ORDER BY date DESC LIMIT " . $limit;
	} elseif ($CURUSER['hidehb'] == 'yes' || $showhelpbox_main != 'yes') {
		if ($CURUSER['shownhdrobot'] == "yes")
			$sql = "SELECT * FROM shoutbox WHERE type='sb' ORDER BY date DESC LIMIT " . $limit;
		else
			$sql = "SELECT * FROM shoutbox WHERE type='sb' AND robotmsg='no' ORDER BY date DESC LIMIT " . $limit;
	} elseif ($CURUSER) {
		if ($CURUSER['shownhdrobot'] == "yes")
			$sql = "SELECT * FROM shoutbox ORDER BY date DESC LIMIT " . $limit;
		else
			$sql = "SELECT * FROM shoutbox WHERE robotmsg='no' ORDER BY date DESC LIMIT " . $limit;
	} else {
		die("<h1>" . $lang_shoutbox['std_access_denied'] . "</h1>" . "<p>" . $lang_shoutbox['std_access_denied_note'] . "</p></body></html>");
	}
	$res = sql_query($sql) or sqlerr(__FILE__, __LINE__);
	if (mysql_num_rows($res) == 0)
		print("\n");
	else {
		print("<table border='0' cellspacing='0' cellpadding='2' width='100%' align='left'>\n");

		while ($arr = mysql_fetch_assoc($res)) {
			if (get_user_class() >= $sbmanage_class) {
				if (get_user_class() >= UC_ADMINISTRATOR)
					$del = "[<a href=\"shoutbox.php?del=" . $arr[id] . "\" title = \"" . $arr[ip] . "\">" . $lang_shoutbox['text_del'] . "</a>]";
				else
					$del = "[<a href=\"shoutbox.php?del=" . $arr[id] . "\">" . $lang_shoutbox['text_del'] . "</a>]";
			}
			if ($arr["userid"]) {
				if ($arr["userid"] == $aiuserid) {
					//if($CURUSER['shownhdrobot'] == "no") continue;
					$username = $lang_shoutbox['text_robot_name'];
				} else
					$username = get_username($arr["userid"], false, true, true, true, false, false, "", true);
				if ($_GET["type"] != 'helpbox' && $arr["type"] == 'hb')
					$username .= $lang_shoutbox['text_to_guest'];
			} else $username = $lang_shoutbox['text_guest'];
			if ($CURUSER['timetype'] != 'timealive')
				$time = strftime("%m.%d %H:%M", $arr["date"]);
			else $time = get_elapsed_time($arr["date"]) . $lang_shoutbox['text_ago'];
			if ($arr["type"] == 'hb')
				print("<tr><td class=\"shoutrow\"><span class='date'>[" . $time . "]</span> " . $del . " " . $username . " " . format_comment($arr["text"], true, false, true, true, 600, true, false) . "</td></tr>\n");
			else
				print("<tr><td class=\"shoutrow\"><span class='date'>[" . $time . "]</span> " . $del . " " . $username . " " . format_comment($arr["text"], true, false, true, true, 600, true, false) . "</td></tr>\n");
		}
		print("</table>");
	}
	?>
</body>

</html>