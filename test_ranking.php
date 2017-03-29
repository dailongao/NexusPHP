<?php
ob_start();
require_once("include/bittorrent.php");
dbconn();

function update_casino_ranking(){
	$res = sql_query("SELECT stake, odds, user_id FROM casino AS c, casinolog AS log WHERE c.win = log.choice AND c.id = log.id AND c.state=4 AND log.added_time >= \"2015-12-24 20:00\" AND log.added_time <= \"2016-01-03 20:00\" ") or sqlerr(__FILE__, __LINE__);
	
	$tot = array();
	$tot2 = array();
	
	if(mysql_num_rows($res) > 0){
		while($arr = mysql_fetch_assoc($res)){
			$tot[$arr['user_id']] += $arr['stake']*$arr['odds'] - $arr['stake'];
			$tot2[$arr['user_id']] += 1;
		}
		$res = sql_query("SELECT stake, odds, user_id FROM casino AS c, casinolog AS log WHERE c.win != log.choice AND c.id = log.id AND c.state=4 AND log.added_time >= \"2015-12-24 20:00\" AND log.added_time <= \"2016-01-03 20:00\" ") or sqlerr(__FILE__, __LINE__);
		
		while($arr = mysql_fetch_assoc($res)){
			$tot[$arr['user_id']] -= $arr['stake'];
			$tot2[$arr['user_id']] -= 1;
		}
		
		arsort($tot); arsort($tot2);

		print_r($tot); print_r($tot2);
	}
}

function get_casino_total(){
	$res = sql_query("SELECT stake, odds, user_id FROM casino AS c, casinolog AS log WHERE c.win = log.choice AND c.id = log.id AND c.state=4") or sqlerr(__FILE__, __LINE__);
	
	$tot = 0;
	
	if(mysql_num_rows($res) > 0){
		while($arr = mysql_fetch_assoc($res)){
			$tot += $arr['stake']*$arr['odds'] - $arr['stake'];
		}
		$res = sql_query("SELECT stake, odds, user_id FROM casino AS c, casinolog AS log WHERE c.win != log.choice AND c.id = log.id AND c.state=4") or sqlerr(__FILE__, __LINE__);
		
		while($arr = mysql_fetch_assoc($res)){
			$tot -= $arr['stake'];
		}
		
		print "Total count: " . $tot;
	}
}

if (get_user_class() <= UC_NEXUS_MASTER) {
die('forbidden');
}
echo "<html><head><title>Count Casino</title></head><body>";
echo "<p>";
echo "In progress...please wait<br />";
ob_flush();
flush();
$tstart = getmicrotime();
//update_casino_ranking();
get_casino_total();
$tend = getmicrotime();
$totaltime = ($tend - $tstart);
printf ("Time consumed:  %f sec<br />", $totaltime);
echo "Done<br />";
echo "</body></html>";
?>

