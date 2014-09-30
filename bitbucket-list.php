<?php
/* 
		Bitbucket List V1.2
	 By Dai, 2012.12 - 2013.2
	 Supports show attachment.
   Supports users delete his file.	
*/
require "include/bittorrent.php";
dbconn();
require_once(get_langfile_path());
loggedinorreturn();

stdhead($lang_bitlt['head_bitlt']);

//check id
if($_GET["id"]){
	//check level
	if(get_user_class() < UC_MODERATOR){
		stdmsg("Error", "Access denied!!!");
		stdfoot();
		exit;
	}
	$id = 0 + $_GET["id"];
	$modmode = 1;
}else{
	$id = 0 + $CURUSER['id'];
	$modmode = 0;
}

//control mode
$showmode = 0 + $_GET["mode"];

if(!is_numeric($showmode) && ($showmode == 0 || $showmode == 1))
	die();

//check delete
if($_GET["del"]){
	$delid = 0 + $_GET["del"];
	if($showmode == 0){
		$res = sql_query("SELECT * FROM bitbucket WHERE id = $delid") or die(mysql_error());
		if(mysql_num_rows($res) == 0){
			die();
		}
		$arr = mysql_fetch_assoc($res);
		if(($arr['owner'] != $CURUSER['id']) && (get_user_class() < UC_MODERATOR)){
			stdmsg("Error", "Access denied!!!");
			stdfoot();
			exit;
		}
		$name = $arr['name'];
		if (!unlink("$bitbucket/$name")){
			stdmsg("Error", "Unable to unlink files. Please contact administrator.");
			stdfoot();
			exit;
		}
		sql_query("DELETE FROM bitbucket WHERE id = $delid") or die(mysql_error());
	}else{
		$res = sql_query("SELECT * FROM attachments WHERE id = $delid") or die(mysql_error());
		if(mysql_num_rows($res) == 0){
			die();
		}
		$arr = mysql_fetch_assoc($res);
		if(($arr['userid'] != $CURUSER['id']) && (get_user_class() < UC_MODERATOR)){
			stdmsg("Error", "Access denied!!!");
			stdfoot();
			exit;
		}
		$name = $arr['location'];
		//$url = str_replace(" ", "%20", htmlspecialchars("attachments/$name"));
		if (!unlink("attachments/$name")){
			stdmsg("Error", "Unable to unlink files. Please contact administrator.");
			stdfoot();
			exit;
		}
		sql_query("DELETE FROM attachments WHERE id = $delid") or die(mysql_error());
	}
}

int_check($id);
if (!isset($id) || !$id)
	die();

if($showmode == 0){
	$res = sql_query("SELECT count(*) FROM bitbucket WHERE owner = $id") or die(mysql_error());	
	$row = mysql_fetch_array($res);	
	$count = $row[0];	
	$perpage = 10;		
	if(!$modmode)
		list($pagertop, $pagerbottom, $limit) = pager($perpage, $count, $_SERVER["PHP_SELF"] . "?mode=" . $_GET["mode"] . "&" );	
	else
		list($pagertop, $pagerbottom, $limit) = pager($perpage, $count, $_SERVER["PHP_SELF"] . "?mode=" . $_GET["mode"] . "&id=" . $id . "&" );	
	print("<h1>".$lang_bitlt['head_bitlt_bitbucket']."</h1>\n");	
	print($lang_bitlt['total_count_bitbucket'].$count."<br/>");	
	print("[<a href=?mode=0>".$lang_bitlt['notice_bitbucket']."</a> | <a href=?mode=1>".$lang_bitlt['notice_attachment']."</a>]");
	echo $pagertop;	
	$res = sql_query("SELECT * FROM bitbucket WHERE owner = $id ORDER BY added DESC $limit") or sqlerr(__FILE__, __LINE__);	
	if (mysql_num_rows($res) == 0)		
	print("<b>".$lang_bitlt['list_empty']."</b>\n");	
	else {		
		 print("<table align='center' border='0' cellspacing='0' cellpadding='5'>\n");		
		 while ($arr = mysql_fetch_assoc($res)) {
			 $aid = $arr['id'];
			 $date = substr($arr['added'], 0, strpos($arr['added'], " "));			
			 $time = substr($arr['added'], strpos($arr['added'], " ") + 1);			
			 $name = $arr["name"];
			 list($width, $height, $type, $attr) = getimagesize("" . get_protocol_prefix() . "$BASEURL/$bitbucket/$name");				 
			 $url = str_replace(" ", "%20", htmlspecialchars("$bitbucket/$name"));
			 print("<tr>");
			 print("<td><center><a href=$url><img src=\"".$url."\" border=0 onLoad='SetSize(this, 400)'></a></center>");			
			 print("Uploaded by:  " . get_username($arr[owner]). " [<a href=?mode=0&del=$aid>Delete</a>]" ."<br />");
			 print("(#$arr[id]) Filename: $name ($width&nbsp;x&nbsp;$height)");					
			 print("Added: $date $time");			
			 print("</tr>");		
			 }		
			 print("</table>");	
			 }	
			 echo 
			 $pagerbottom;	
}else{
	$res = sql_query("SELECT count(*) FROM attachments WHERE userid = $id") or die(mysql_error());	
	$row = mysql_fetch_array($res);	
	$count = $row[0];	
	$perpage = 10;		
	if(!$modmode)
		list($pagertop, $pagerbottom, $limit) = pager($perpage, $count, $_SERVER["PHP_SELF"] . "?mode=" . $_GET["mode"] . "&" );	
	else
		list($pagertop, $pagerbottom, $limit) = pager($perpage, $count, $_SERVER["PHP_SELF"] . "?mode=" . $_GET["mode"] . "&id=" . $id . "&" );	
	print("<h1>".$lang_bitlt['head_bitlt_attachment']."</h1>\n");	
	print($lang_bitlt['total_count_attachment'].$count."<br/>");	
	print("[<a href=?mode=0>".$lang_bitlt['notice_bitbucket']."</a> | <a href=?mode=1>".$lang_bitlt['notice_attachment']."</a>]");
	echo $pagertop;	
	$res = sql_query("SELECT * FROM attachments WHERE userid = $id ORDER BY added DESC $limit") or sqlerr(__FILE__, __LINE__);	
	if (mysql_num_rows($res) == 0)		
	print("<b>".$lang_bitlt['list_empty']."</b>\n");	
	else {		
		 print("<table align='center' border='0' cellspacing='0' cellpadding='5'>\n");		
		 while ($arr = mysql_fetch_assoc($res)) {
			 $aid = $arr['id'];
			 $date = substr($arr['added'], 0, strpos($arr['added'], " "));			
			 $time = substr($arr['added'], strpos($arr['added'], " ") + 1);			
			 $name = $arr['location'];
			 $origfilename = $arr['filename'];
			 $ext_l = strrpos($origfilename, ".");
			 $ext = strtolower(substr($origfilename, $ext_l+1, strlen($origfilename)-($ext_l+1)));
			 $img_ext = array('jpeg', 'jpg', 'png', 'gif');
			 if (in_array($ext, $img_ext))
				$isimage = true;
			 list($width, $height, $type, $attr) = getimagesize("" . get_protocol_prefix() . "$BASEURL/attachments/$name");				 
			 $url = str_replace(" ", "%20", htmlspecialchars("attachments/$name"));
			 print("<tr>");
			 print("<td>");
			 if($isimage)
				print("<center><a href=$url><img src=\"".$url."\" border=0 onLoad='SetSize(this, 400)'></a></center>");	
			 print("Uploaded by:  " . get_username($arr['userid']). " [<a href=?mode=1&del=$aid>Delete</a>]" . "<br />");
			 if($isimage)
				print("(#$arr[id]) Filename: $name ($width&nbsp;x&nbsp;$height)");	
			 else
				print("(#$arr[id]) Filename: <a href=$url>$name</a>");
			 print(" Added: $date $time");			
			 print("</tr>");		
			 }		
			 print("</table>");	
			 }	
			 echo 
			 $pagerbottom;	
}

stdfoot();
?>

