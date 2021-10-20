<?php
require "include/bittorrent.php";
dbconn();
require_once(get_langfile_path());
loggedinorreturn();

$listpage = 0+$_GET['listpage'];
$winnerpage = 0+$_GET['winnerpage'];
$modpage = 0+$_GET['modpage'];
$mypage = 0+$_GET['mypage'];

if ($casino_tweak == "no")
	stderr($lang_casino['std_error'], $lang_casino['std_casino_disabled']);
else if (!isset($CURUSER))
	stderr($lang_casino['std_error'], $lang_casino['std_must_login_to_play']);
else if (get_user_class() < $casino_class)
	stderr($lang_casino['std_sorry'],$lang_casino['std_permission_denied'].get_user_class_name($casino_class,false,true,true).$lang_casino['std_or_above_can_view'],false);
else if ($CURUSER['seedbonus'] < $casino_min_bonus_tweak && get_user_class() < UC_MODERATOR )
	stderr($lang_casino['std_sorry'], $lang_casino['std_bonus_not_enough']);
else
{
	stdhead($lang_casino['head_casino']);
	begin_main_frame();
	
	/*	Lottery state:
	 *	1: active
	 *	2: ended
	 *	3: frozen
	 *	4: cleared
	 *	5: push
	 */

	/* 	tab1: intro
	 * 	tab2: casino list
	 * 	tab3: winner
	 * 	tab4: my casino
	 * 	tab5: mod panel
	 */
?>
	<div id="tabs">
		<ul id="casino_tabs_head">
			<li><a href="#tabs-1"><?php echo $lang_casino['tab_intro']; ?></a></li>
			<li><a href="#tabs-2"><?php echo $lang_casino['tab_game_name']; ?></a></li>
			<li><a href="#tabs-3"><?php echo $lang_casino['tab_winner']; ?></a></li>
			<li><a href="#tabs-4"><?php echo $lang_casino['tab_my_casino']; ?></a></li>
			<?php 	if(get_user_class() > UC_MODERATOR) { ?><li><a href="#tabs-5"><?php echo $lang_casino['tab_mod']; ?></a></li> <?php } ?>
			<li><a href="#tabs-6"><?php echo $lang_casino['tab_ranking']; ?></a></li>
		</ul>
		<div id="casino-msg" align="center"></div>
		<div id="tabs-1">
			<p><?php echo $lang_casino['text_intro']; ?></p>
		</div>
		<div id="tabs-2">
			<table class="casino-list" align="center">
				<thead>
					<tr>
						<td><?php echo $lang_casino['col_add_time'] ?></td>
						<td><?php echo $lang_casino['col_title'] ?></td>
						<td><?php echo $lang_casino['col_remaining_time'] ?></td>
						<td width="60"><?php echo $lang_casino['col_state'] ?></td>
						<td><?php echo $lang_casino['col_added_by'] ?></td>
					</tr>
				</thead>
<?php

	$res = sql_query("SELECT c.id AS id FROM casino AS c, casinolog AS log WHERE c.id=log.id AND c.state=1 AND log.user_id=".sqlesc($CURUSER['id'])." ORDER BY c.id DESC") or sqlerr(__FILE__, __LINE__);
	$bet_laid = array();
	while( $arr = mysql_fetch_assoc($res) )
	{
		$bet_laid[] = $arr['id'];
	}
	
	// 10 records in one page
	$res = sql_query("SELECT * FROM (SELECT id, title, added_by, added_time, end_time, state FROM casino WHERE state=1 or state=2 ORDER BY state ASC, id DESC) as c1 UNION SELECT * FROM (SELECT id, title, added_by, added_time, end_time, state FROM casino WHERE state!=1 and state!=2 ORDER BY id DESC ) as c2 LIMIT ".( sqlesc($listpage)*10 ).", 10"); //state: 0 => bet laid, 1 => active, 2 => ended, 3 => stopped, 4 => paid, 5 => push
	$i = 0 + $listpage * 10;
	$is_empty_list = 0;
	
	if(mysql_num_rows($res) > 0)
	{
		while ( $arr = mysql_fetch_assoc($res) )
		{
			$id = $arr['id'];
			$title = $arr['title'];
			$end_time = strtotime($arr['end_time']);
			$added_time = strtotime($arr['added_time']);
			$added_time = date("Y-m-d H:i", $added_time);
			$diff = $end_time - time();
			$remain = ((int)($diff/3600))."h ".((int)($diff/60)-((int)($diff/3600))*60)."min";
			$added_by = $arr['added_by'];
			$state = $arr['state'];
			
			if($end_time <= time() && $state == 1)	//update ended lottery
			{
				sql_query("UPDATE casino SET state = 2 WHERE id = ".sqlesc($id)) or sqlerr(__FILE__, __LINE__);
				print "<tr><td>".$added_time."</td><td align=\"left\"><a class=\"betting\" href=\"#\"value=".$id.">".$title."</a></td><td class=\"bet-ended\">".$lang_casino['text_ended']."</td><td class=\"bet-ended\">".$lang_casino['text_ended']."</td><td>".$added_by."</td></tr>";
			}
			else if( $bet_laid[$i] == $id )
			{
				$i = $i + 1;
				print "<tr><td>".$added_time."</td><td align=\"left\"><a class=\"betting\" href=\"#\"value=".$id.">".$title."</a></td><td>".$remain."</td><td class=\"bet-bets_laid\">".$lang_casino['text_bets_laid']."</td><td>".$added_by."</td></tr>";
			}
			else if( $state == 1 )
			{
				print "<tr><td>".$added_time."</td><td align=\"left\"><a class=\"betting\" href=\"#\"value=".$id.">".$title."</a></td><td>".$remain."</td><td class=\"bet-active\">".$lang_casino['text_active']."</td><td>".$added_by."</td></tr>";
			}
			else if( $state == 2 )
			{
				print "<tr><td>".$added_time."</td><td align=\"left\"><a class=\"betting\" href=\"#\"value=".$id.">".$title."</a></td><td class=\"bet-ended\">".$lang_casino['text_ended']."</td><td class=\"bet-ended\">".$lang_casino['text_ended']."</td><td>".$added_by."</td></tr>";
			}
			else if( $state == 3 )
			{
				print "<tr><td>".$added_time."</td><td align=\"left\"><a class=\"betting\" href=\"#\"value=".$id.">".$title."</a></td><td class=\"bet-ended\">".$lang_casino['text_ended']."</td><td class=\"bet-stopped\">".$lang_casino['text_stopped']."</td><td>".$added_by."</td></tr>";
			}
			else if( $state == 4 || $state == 5)
			{
				print "<tr><td>".$added_time."</td><td align=\"left\"><a class=\"betting\" href=\"#\"value=".$id.">".$title."</a></td><td class=\"bet-ended\">".$lang_casino['text_ended']."</td><td class=\"bet-paid\">".$lang_casino['text_paid']."</td><td>".$added_by."</td></tr>";
			}
		}
	}
	else
	{
		$is_empty_list = 1;
		print "<tr><td colspan=\"8\" align=\"center\"><span>".$lang_casino['text_no_record']."</span></td></tr>";
	}
	
?>
			</table>
			<div class="casino-pager">
				<?php if($listpage > 0) {?><a class="casino-page-button" href="casino.php?listpage=<?php echo $listpage-1; ?>#tabs-2"><?php echo $lang_casino['pre_page']; ?></a><?php } ?>
					<input type="hidden" value= name="page" />
				<?php if($is_empty_list == 0) { ?><a class="casino-page-button" href="casino.php?listpage=<?php echo $listpage+1; ?>#tabs-2"><?php echo $lang_casino['next_page']; ?></a><?php } ?>
			</div>
		</div>
		<div id="tabs-3">
			<table class="casino-list" align="center">
				<thead>
					<tr>
						<td><?php echo $lang_casino['col_add_time'] ?></td>
						<td><?php echo $lang_casino['col_title'] ?></td>
						<td><?php echo $lang_casino['col_paid_time'] ?></td>
						<td width="60"><?php echo $lang_casino['col_state'] ?></td>
						<td><?php echo $lang_casino['col_winner_count'] ?></td>
						<td><?php echo $lang_casino['col_total_count'] ?></td>
						<td><?php echo $lang_casino['col_added_by'] ?></td>
					</tr>
				</thead>
<?php
	$res = sql_query("SELECT id, title, added_by, added_time, end_time, paid_time, state, total_count, winner_count FROM casino WHERE state=4 OR state=5 ORDER BY paid_time DESC LIMIT ".(sqlesc($winnerpage*10)).",10");
	$is_empty_winner = 0;
	
	if(mysql_num_rows($res) > 0)
	{
		while ($arr = mysql_fetch_assoc($res))
		{
			$id = $arr['id'];
			$title = $arr['title'];
			$added_time = strtotime($arr['added_time']);
			$added_time = date("Y-m-d H:i", $added_time);
			$end_time = strtotime($arr['end_time']);
			$end_time = date("Y-m-d H:i", $end_time);
			$paid_time = strtotime($arr['paid_time']);
			$paid_time = date("Y-m-d H:i", $paid_time);
			$winner_count = $arr['winner_count'];
			$total_count = $arr['total_count'];
			$added_by = $arr['added_by'];
			if($arr['state'] == 4)
				$state = "<td class=\"bet-paid\">".$lang_casino['text_paid']."</td>";
			else if($arr['state'] == 5)
				$state = "<td class=\"bet-push\">".$lang_casino['text_push']."</td>";
			
			print "<tr><td>".$added_time."</td><td align=\"left\"><a class=\"winner\" href=\"#\"value=".$id.">".$title."</a></td><td>".$paid_time."</td>".$state."<td>".$winner_count."</td><td>".$total_count."</td><td>".$added_by."</td></tr>";
		}
	}
	else
	{
		$is_empty_winner = 1;
		print "<tr><td colspan=\"8\" align=\"center\"><span>".$lang_casino['text_no_record']."</span></td></tr>";
	}
?>
			</table>
			<div class="casino-pager">
				<?php if($winnerpage > 0) {?><a class="casino-page-button" href="casino.php?winnerpage=<?php echo $winnerpage-1; ?>#tabs-3"><?php echo $lang_casino['pre_page']; ?></a><?php } ?>
					<input type="hidden" value= name="page" />
				<?php if($is_empty_winner == 0) { ?><a class="casino-page-button" href="casino.php?winnerpage=<?php echo $winnerpage+1; ?>#tabs-3"><?php echo $lang_casino['next_page']; ?></a><?php } ?>
			</div>
		</div>
		
		<div id="tabs-4">
<?php
	//calculate user's win bonus
	$win_bonus = 0;
	$res = sql_query("SELECT stake, odds FROM casino AS c, casinolog AS log WHERE c.win = log.choice AND c.id = log.id AND c.state=4 AND log.user_id =".sqlesc($CURUSER['id']) ) or sqlerr(__FILE__, __LINE__);
	while($arr = mysql_fetch_assoc($res))
	{
		$win_bonus += $arr['stake']*$arr['odds'] - $arr['stake'];
	}
	
	$res = sql_query("SELECT stake FROM casino AS c, casinolog AS log WHERE c.win != log.choice AND c.id = log.id AND c.state=4 AND log.user_id =".sqlesc($CURUSER['id']) ) or sqlerr(__FILE__, __LINE__);
	while($arr = mysql_fetch_assoc($res))
	{
		$win_bonus -= $arr['stake'];
	}
?>
			<div align="center">
				<?php echo $lang_casino['text_win_bonus']; ?> : &nbsp; <?php echo $win_bonus; ?>
			</div><br />
<?php
	
	//print list
	$res = sql_query("SELECT * FROM casino AS c, casinolog AS log WHERE c.id=log.id AND log.user_id=".sqlesc($CURUSER['id'])." ORDER BY c.id DESC LIMIT ".(sqlesc($mypage)*10).",10") or sqlerr(__FILE__, __LINE__);
	$is_empty_my = 0;
	
	print "<table class=\"casino-list\" align=\"center\">";
	print "<thead><tr><td width=\"30\">".$lang_casino['col_id']."</td><td width=\"60\">".$lang_casino['col_state']."</td><td>".$lang_casino['col_title']."</td><td>".$lang_casino['col_end_time']."</td><td width=\"30\">".$lang_casino['col_stake']."</td><td>".$lang_casino['col_option']."</td><td width=\"30\">".$lang_casino['col_result']."</td><td>".$lang_casino['col_bonus_count']."</td><td>".$lang_casino['col_added_by']."</td></tr></thead>";
	
	if(mysql_num_rows($res) > 0)
	{
		while ($arr = mysql_fetch_assoc($res))
		{
			$id = $arr['id'];
			$title = $arr['title'];
			$end_time = strtotime($arr['end_time']);
			$end_time = date("Y-m-d H:i", $end_time);
			$added_by = $arr['added_by'];
			$choice = $arr['choice'];
			$state = $arr['state'];
			$stake = $arr['stake'];
			$odds = $arr['odds'];
			$bonus_count = "<td></td>";
			
			if($arr['state'] == 5)
			{
				$result = "<td class=\"bet-push\">".$lang_casino['text_push']."</td>";
				$bonus_count = "<td>0</td>";
			}
			else if($arr['state'] != 4)
			{
				$result = "<td class=\"bet-uncleared\">".$lang_casino['text_uncleared']."</td>";
			}
			else if($arr['win'] == $arr['choice'])
			{
				$result = "<td class=\"bet-win\">".$lang_casino['text_win']."</td>";
				$bonus_count = "<td class=\"bet-win\">+".($stake*$odds-$stake)."</td>";
			}
			else
			{
				$result = "<td class=\"bet-lose\">".$lang_casino['text_lose']."</td>";
				$bonus_count = "<td class=\"bet-lose\">".(-$stake)."</td>";
			}
			
			if($state == 1) $state = '<td class="bet-bets_laid">'.$lang_casino['text_bets_laid'].'</td>';
			else if($state == 2) $state = '<td class="bet-ended">'.$lang_casino['text_ended'].'</td>';
			else if($state == 3) $state = '<td class="bet-stopped">'.$lang_casino['text_stopped'].'</td>';
			else if($state == 4 || $state == 5) $state = '<td class="bet-paid">'.$lang_casino['text_paid'].'</td>';

			print "<tr><td>".$id."</td>".$state."<td  align=\"left\"><a class=\"betting\" href=\"#\"value=".$id.">".$title."</a></td><td>".$end_time."</td><td>".$stake."</td><td>".$choice."</td>".$result.$bonus_count."<td>".$added_by."</td></tr>";
		}
	}
	else
	{
		$is_empty_my = 1;
		print "<tr><td colspan=\"8\" align=\"center\"><span>".$lang_casino['text_no_record']."</span></td></tr>";
	}
	
?>
			</table>
			<div class="casino-pager">
				<?php if($mypage > 0) { ?><a class="casino-page-button" href="casino.php?mypage=<?php echo $mypage-1; ?>#tabs-4"><?php echo $lang_casino['pre_page']; ?></a><?php } ?>
				<?php if($is_empty_my == 0) { ?><a class="casino-page-button" href="casino.php?mypage=<?php echo $mypage+1; ?>#tabs-4"><?php echo $lang_casino['next_page']; ?></a><?php } ?>
			</div>
		</div>
<?php
	if(get_user_class() >= UC_MODERATOR)
	{
		print "<div id=\"tabs-5\">";
		print "<div align=\"left\">";
		print "<h3><a class=\"add_new_bet\" href=\"#\">".$lang_casino['text_new_bet']."</a></h3>";
		print "</div>";
	
		$res = sql_query("SELECT * FROM casino WHERE state=2 ORDER BY id DESC");
		
		if(mysql_num_rows($res) != 0)
		{
			print "<h3>".$lang_casino['col_padding']."</h3>";
			print "<table class=\"casino-list\" align=\"center\">";
			print "<thead><tr><td>".$lang_casino['col_id']."</td><td width=\"60\">".$lang_casino['col_state']."</td><td>".$lang_casino['col_title']."</td><td>".$lang_casino['col_add_time']."</td><td>".$lang_casino['col_end_time']."</td><td>".$lang_casino['col_winner_count']."</td><td>".$lang_casino['col_total_count']."</td><td>".$lang_casino['col_added_by']."</td></tr></thead>";
			
			while ($arr = mysql_fetch_assoc($res))
			{
				$id = $arr['id'];
				$title = $arr['title'];
				$added_time = strtotime($arr['added_time']);
				$added_time = date("Y-m-d H:i", $added_time);
				$end_time = strtotime($arr['end_time']);
				$end_time = date("Y-m-d H:i", $end_time);
				$winner_count = $arr['winner_count'];
				$total_count = $arr['total_count'];
				$added_by = $arr['added_by'];

			print "<tr><td>".$id."</td><td class=\"bet-ended\">".$lang_casino['text_ended']."</td><td align=\"left\"><a class=\"casino-pedding\" href=\"#\"value=".$id.">".$title."</a></td><td>".$added_time."</td><td>".$end_time."</td><td>".$winner_count."</td><td>".$total_count."</td><td>".$added_by."</td></tr>";			}
			print "</table>";
		}
		
		print "<h3>".$lang_casino['col_mod']."</h3>";
		print "<table class=\"casino-list\" align=\"center\">";
		print "<thead><tr><td width=\"30\">".$lang_casino['col_id']."</td><td width=\"60\">".$lang_casino['col_state']."</td><td>".$lang_casino['col_title']."</td><td>".$lang_casino['col_add_time']."</td><td>".$lang_casino['col_end_time']."</td><td>".$lang_casino['col_winner_count']."</td><td>".$lang_casino['col_total_count']."</td><td>".$lang_casino['col_added_by']."</td><td width=\"30\"></td></tr></thead>";
		
		$res = sql_query("SELECT id, title, added_by, added_time, end_time, winner_count, total_count, state FROM casino ORDER BY id DESC LIMIT ".(sqlesc($modpage)*10).",10");
		$is_empty_mod = 0;
		
		if(mysql_num_rows($res) > 0)
		{
			while ($arr = mysql_fetch_assoc($res))
			{
				$id = $arr['id'];
				$title = $arr['title'];
				$added_time = strtotime($arr['added_time']);
				$added_time = date("Y-m-d H:i", $added_time);
				$end_time = strtotime($arr['end_time']);
				$end_time = date("Y-m-d H:i", $end_time);
				$winner_count = $arr['winner_count'];
				$total_count = $arr['total_count'];
				$added_by = $arr['added_by'];
				$state = $arr['state'];
				
				if($state == 1) $state = '<td class="bet-active">'.$lang_casino['text_active'].'</td>';
				else if($state == 2) $state = '<td class="bet-ended">'.$lang_casino['text_ended'].'</td>';
				else if($state == 3) $state = '<td class="bet-stopped">'.$lang_casino['text_stopped'].'</td>';
				else if($state == 4 || $state == 5) $state = '<td class="bet-paid">'.$lang_casino['text_paid'].'</td>';
				
				if($arr['state'] == 4 || $arr['state'] == 5) $t = $title;
				else $t = "<a class=\"casino-mod\" href=\"#\"value=".$id.">".$title."</a>";

				print "<tr><td>".$id."</td>".$state."<td align=\"left\">".$t."</td><td>".$added_time."</td><td>".$end_time."</td><td>".$winner_count."</td><td>".$total_count."</td><td>".$added_by."</td><td><a class=\"casino-view\" href=\"#\"value=".$id.">".$lang_casino['text_view']."</a></td></tr>";

			}
		}
		else
		{
			$is_empty_mod = 1;
			print "<tr><td colspan=\"8\" align=\"center\"><span>".$lang_casino['text_no_record']."</span></td></tr>";
		}
		
		print "</table>"
		?>
			<div class="casino-pager">
				<?php if($modpage > 0) { ?><a class="casino-page-button" href="casino.php?modpage=<?php echo $modpage-1; ?>#tabs-5"><?php echo $lang_casino['pre_page']; ?></a><?php } ?>
					<input type="hidden" value= name="page" />
				<?php if($is_empty_mod == 0) { ?><a class="casino-page-button" href="casino.php?modpage=<?php echo $modpage+1; ?>#tabs-5"><?php echo $lang_casino['next_page']; ?></a><?php } ?>
			</div>
		</div>
		<?php
		}
		?>
		<div id="tabs-6">
	
			<div align="center">
				<?php echo $lang_casino['text_ranking_desc']; ?>
			</div>
			
<?php
		$cachename = "casino_ranking";
		$cachetime = 60 * 60;
		// START CACHE
		$Cache->new_page($cachename, $cachetime, true);
		if (!$Cache->get_page()){
			$Cache->add_whole_row();
			print("<table class=\"casino-list\" align=\"center\"><thead><tr><td>".$lang_casino['col_ranking']."</td><td>".$lang_casino['col_username']."</td><td>".$lang_casino['col_bonus_count']."</td><td>".$lang_casino['col_takecount']."</td></tr></thead>");
			$showlimit = 20;
			$res = sql_query("SELECT * FROM casinorank ORDER by bonus DESC LIMIT $showlimit") or sqlerr(__FILE__, __LINE__);
					if(mysql_num_rows($res) > 0){		
						$nowuser = 0;
						while($arr = mysql_fetch_assoc($res)){
							$nowuser++;
							$twname = get_username($arr['id']);
							$twbonus = $arr['bonus'];
							$twcount = $arr['lotterycount'];
							print "<tr><td>$nowuser</td><td>$twname</td><td>$twbonus</td><td>$twcount</td></tr>";
						}
					
						print("</table>");
				
						print("<table class=\"casino-list\" align=\"center\"><thead><tr><td>".$lang_casino['col_ranking']."</td><td>".$lang_casino['col_username']."</td><td>".$lang_casino['col_bonus_count']."</td><td>".$lang_casino['col_takecount']."</td></tr></thead>");
						
						$res = sql_query("SELECT * FROM casinorank ORDER by bonus LIMIT $showlimit") or sqlerr(__FILE__, __LINE__);
						$nowuser = 0;
						while($arr = mysql_fetch_assoc($res)){
							$nowuser++;
							$twname = get_username($arr['id']);
							$twbonus = $arr['bonus'];
							$twcount = $arr['lotterycount'];
							print "<tr><td>$nowuser</td><td>$twname</td><td>$twbonus</td><td>$twcount</td></tr>";
						}
						
						print("</table>");
					} else {
						print "<tr><td colspan=\"8\" align=\"center\"><span>".$lang_casino['text_no_record']."</span></td></tr>";
						print "</table>";
					}
			$Cache->end_whole_row();
			$Cache->cache_page();
		}
		echo $Cache->next_row();
?>
		<?php
		print "</div></div>";
	
	end_main_frame();

	stdfoot();
}
?>
