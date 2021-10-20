<?php
ob_start();
require_once("include/bittorrent.php");
dbconn();

function get_year_count(){
	$res = sql_query("select users.username as us, count(*) as ct from torrents left join users on users.id=torrents.owner where torrents.added >= '2018-12-24 20:00' and torrents.added <= '2019-01-03 20:00' group by users.username order by ct desc;") or sqlerr(__FILE__, __LINE__);
	
	
	if(mysql_num_rows($res) > 0){
		while($arr = mysql_fetch_assoc($res)){
			printf("%s&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;%s<br/>",$arr['us'], $arr['ct']);
		}
		
		print "Total count: " . $tot;
	}
}

if (get_user_class() <= UC_NEXUS_MASTER) {
die('forbidden');
}
echo "<html><head><title>Year Activity Count</title></head><body>";
echo "<p>";
echo "In progress...please wait<br />";
ob_flush();
flush();
$tstart = getmicrotime();
//update_casino_ranking();
get_year_count();
$tend = getmicrotime();
$totaltime = ($tend - $tstart);
printf ("Time consumed:  %f sec<br />", $totaltime);
echo "Done<br />";
echo "</body></html>";
?>

