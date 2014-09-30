<?php
require "include/bittorrent.php";
dbconn();
loggedinorreturn();
?><!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8" />
<title>临时回滚装置</title>
    </head>
<body>
<form name="input" action="getbetajax.php" method="post" >
    <input type="text" name="id" />
    <input type="hidden" value="undo" name="type"/>
    <input type="submit" value="提交（爆炸请反馈）" />
</form>
</body>