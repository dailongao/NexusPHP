<?php
require_once("include/bittorrent.php");
require_once("specialip.php");

dbconn();

$langid = 0 + $_GET['sitelanguage'];
if ($langid)
{
	$lang_folder = validlang($langid);
	if(get_langfolder_cookie() != $lang_folder)
	{
		set_langfolder_cookie($lang_folder);
		header("Location: " . $_SERVER['PHP_SELF']);
	}
}
require_once(get_langfile_path("", false, $CURLANGDIR));

failedloginscheck ();
cur_user_check () ;
stdhead($lang_login['head_login']);

$s = "<select name=\"sitelanguage\" onchange='submit()'>\n";

$langs = langlist("site_lang");

foreach ($langs as $row)
{
	if ($row["site_lang_folder"] == get_langfolder_cookie()) $se = "selected=\"selected\""; else $se = "";
	$s .= "<option value=\"". $row["id"] ."\" ". $se. ">" . htmlspecialchars($row["lang_name"]) . "</option>\n";
}
$s .= "\n</select>";
?>
<form method="get" action="<?= $_SERVER['PHP_SELF'] ?>">
	<div align="right"><?= $lang_login['text_select_lang'] ?></div>
</form>
<?php

unset($returnto);
if (!empty($_GET["returnto"])) {
	$returnto = $_GET["returnto"];
	if (!$_GET["nowarn"]) { 
?>

<h1><?= $lang_login['h1_not_logged_in'] ?></h1>
<p><b><?= $lang_login['p_error'] ?></b><?= $lang_login['p_after_logged_in'] ?></p>

<?php
	}
}
?>
<form method="post" action="takelogin.php">
	<p
		<?= $lang_login['p_need_cookies_enables'] ?>
		<br />

		<?php if (!is_special_ip()) { ?>
		[<b><?= $maxloginattempts;?></b>] <?= $lang_login['p_fail_ban'] ?>
		<?php } ?>

	</p>

	<?php if (!is_special_ip()) { ?>
	<p><?= MessageFormatter::formatMessage("", $lang_login['p_login_remaing_tries_format'], array(remaining())) ?>
		<?php } ?>

	</p>
	<table border="0" cellpadding="5">
		<tr>
			<td class="rowhead"><?= $lang_login['rowhead_username']?></td>
			<td class="rowfollow" align="left">
				<input type="text" name="username" style="width: 180px; border: 1px solid gray" /></td>
		</tr>
		<tr>
			<td class="rowhead"><?= $lang_login['rowhead_password']?></td>
			<td class="rowfollow" align="left">
				<input type="password" name="password" style="width: 180px; border: 1px solid gray" /></td>
		</tr>
		<?php
		show_image_code ();
		if ($securelogin == "yes") 
			$sec = "checked=\"checked\" disabled=\"disabled\"";
		elseif ($securelogin == "no")
			$sec = "disabled=\"disabled\"";
		elseif ($securelogin == "op")
			$sec = "";

		if ($securetracker == "yes") 
			$sectra = "checked=\"checked\" disabled=\"disabled\"";
		elseif ($securetracker == "no")
			$sectra = "disabled=\"disabled\"";
		elseif ($securetracker == "op")
			$sectra = "";
		?>
		<tr>
			<td class="toolbox" colspan="2" align="left"><?= $lang_login['text_advanced_options']?></td>
		</tr>
		<tr>
			<td class="rowhead"><?= $lang_login['text_auto_logout']?></td>
			<td class="rowfollow" align="left">
				<input class="checkbox" type="checkbox" name="logout" value="yes" /><?= $lang_login['checkbox_auto_logout']?></td>
		</tr>
		<tr>
			<td class="rowhead"><?= $lang_login['text_restrict_ip']?></td>
			<td class="rowfollow" align="left">
				<input class="checkbox" type="checkbox" name="securelogin" value="yes" /><?= $lang_login['checkbox_restrict_ip']?></td>
		</tr>
		<tr>
			<td class="rowhead"><?= $lang_login['text_ssl']?></td>
			<td class="rowfollow" align="left">
				<input class="checkbox" type="checkbox" name="ssl" value="yes" <?= $sec?> /><?= $lang_login['checkbox_ssl']?><br />
				<input class="checkbox" type="checkbox" name="trackerssl" value="yes" <?= $sectra?> /><?= $lang_login['checkbox_ssl_tracker']?></td>
		</tr>
		<tr>
			<td class="toolbox" colspan="2" align="right">
				<button type="submit" class="btn"><?= $lang_login['button_login']?></button>
				<button type="reset" class="btn"><?= $lang_login['button_reset']?></button></td>
		</tr>
	</table>
	<?php

	if (isset($returnto)) { ?>
	<input type="hidden" name="returnto" value="<?= htmlspecialchars($returnto) ?>" />
	<?php } ?>
</form>
<p><?= $lang_login['p_no_account_signup']?></p>
<?php
if ($smtptype != 'none'){
?>
<p><?= $lang_login['p_forget_pass_recover']?></p>
<p><?= $lang_login['p_resend_confirm']?></p>
<?php
}
if ($showhelpbox_main != 'no'){?>
<table width="700" class="main" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="embedded">
			<h2><?= $lang_login['text_helpbox'] ?><font class="small"> - <?= $lang_login['text_helpbox_note'] ?><font id= "waittime" color="red"></font></h2>
			<table width='100%' border='1' cellspacing='0' cellpadding='1'>
				<tr>
					<td class="text">
						<iframe src="/shoutbox.php?type=helpbox" width='650' height='180' frameborder='0' name='sbox' marginwidth='0' marginheight='0'></iframe>
						<br />
						<br />
						<form action="/shoutbox.php" id="helpbox" method='get' target='sbox' name='shbox'>
							<?= $lang_login['text_message'] ?>
							<input type='text' id="hbtext" name='shbox_text' autocomplete='off' style='width: 500px; border: 1px solid gray'>
							<button type='submit' id='hbsubmit' class='btn' name='shout'><?= $lang_login['sumbit_shout'] ?></button>
							<button type='reset' class='btn'><?= $lang_login['submit_clear'] ?></button>
							<input type='hidden' name='sent' value='yes'><input type='hidden' name='type' value='helpbox' />
							<div id="sbword" style="display: none"><?= $lang_login['sumbit_shout'] ?></div>
						<?php print(smile_row("shbox","shbox_text")); ?>
					</td>
				</tr>
			</table>
			</form></td>
	</tr>
</table>

<?php
}
stdfoot();
