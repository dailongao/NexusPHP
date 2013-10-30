<?php
require "include/bittorrent.php";
dbconn();
require_once(get_langfile_path());
loggedinorreturn();

/*	Lottery state:
 *	1: active
 *	2: ended
 *	3: frozen
 *	4: cleared
 *	5: push
 */

/*	return code:
 *		200: query success
 *		301: has betted this game before
 *		400: wrong visit method, likely some guys are hacking the system
 *		401: not login or not reach access class
 *		403: wrong post param, likely some guys are hacking the system
 *		404: bet game don't exist or has ended
 */

$id = 0+$_POST['id'];
$type = $_POST['type'];


if ( !in_array($type,array('info', 'bet', 'winner', 'mod', 'add', 'pedding', 'view')) || $casino_tweak == "no")
{
	echo 400;
	write_log("User " . $CURUSER["username"] . "," . $CURUSER["ip"] . " is hacking casino system",'mod');
	die;
}
else if(!isset($CURUSER) || get_user_class() < $casino_class || ($CURUSER['seedbonus'] < $casino_min_bonus_tweak && get_user_class() < UC_MODERATOR))
{
	echo 401; 
	die;
}
else
{
	switch($type)
	{
		case('info'):
		{
			$res = sql_query("SELECT * FROM casino WHERE id=$id LIMIT 1") or sqlerr(__FILE__, __LINE__);
			
			if (mysql_num_rows($res) > 0)
			{
				$result = mysql_fetch_object($res);
				$encode = json_encode($result);
				echo $encode;
			}
			else 
			{
				echo 404;
			}
			break;
		}
		case('bet'):
		{
			$choice = 0+$_POST['choice'];
			$stake = 0+$_POST['stake'];
			
			//Different limit for different level
			$stakelimit = 0;
			$userclass = get_user_class();
			if($userclass == UC_POWER_USER) $stakelimit = 2000;
			elseif($userclass == UC_ELITE_USER || $userclass == UC_CRAZY_USER) $stakelimit = 3000;
			elseif($userclass == UC_INSANE_USER || $userclass == UC_VETERAN_USER) $stakelimit = 4000;
			elseif($userclass >= UC_EXTREME_USER) $stakelimit = 5000;
			
			if($choice < 1 || $choice > 9 || $stake > $stakelimit || $stake < 100)
			{
				echo 403; 
				//write_log("User " . $CURUSER["username"] . "," . $CURUSER["ip"] . " is hacking casino system",'mod');
				die;
			}
			
			$res = sql_query("SELECT seedbonus FROM users WHERE id = ".sqlesc($CURUSER['id'])) or sqlerr(__FILE__, __LINE__);
			$arr = mysql_fetch_assoc($res);
			$nowbonus = $arr['seedbonus'];
			if($nowbonus < $stake){
				echo 403;
				die;
			}
			
			$res = sql_query("SELECT * FROM casino WHERE id=".sqlesc($id)." LIMIT 1") or sqlerr(__FILE__, __LINE__);
			$arr = mysql_fetch_assoc($res);
			$odds = "op".$choice."_odds";
			$odds = $arr[$odds];
			
			if (mysql_num_rows($res) > 0 && $arr['state'] == 1)
			{
				$res = sql_query("SELECT * FROM casinolog WHERE id=".sqlesc($id)." AND user_id=".sqlesc($CURUSER['id'])." LIMIT 1") or sqlerr(__FILE__, __LINE__);
				if (mysql_num_rows($res) == 0)
				{
					sql_query("UPDATE users SET seedbonus = seedbonus - ".sqlesc($stake)." WHERE id = ".sqlesc($CURUSER['id'])) or sqlerr(__FILE__, __LINE__);
					sql_query("INSERT INTO casinolog (id, user_id, added_time, choice, stake, odds) VALUES(".sqlesc($id).", ".sqlesc($CURUSER['id']).", '". date("Y-m-d H:i:s") ."', ".sqlesc($choice).", ".sqlesc($stake).", ".sqlesc($odds).")") or sqlerr(__FILE__, __LINE__);
					sql_query("UPDATE casino SET total_count = total_count + 1 WHERE id = $id") or sqlerr(__FILE__, __LINE__);
					echo 200;
				}
				else 
				{
					echo 301;
				}
			}
			else
			{
				echo 404;
			}
			break;
		}
		case('winner'):
		{
			Class winner
			{
				public $title="";
				public $descr="";
				public $win_descr="";
				public $comment="";
				public $winner=array();
			};
			
			$res = sql_query("SELECT * FROM casino WHERE id=".sqlesc($id)." LIMIT 1");
			$arr = mysql_fetch_assoc($res);
			$w = "op".$arr['win']."_descr";
			$result = new winner;
			$result->title = $arr['title'];
			$result->descr = $arr['descr'];
			$result->win_descr = $arr[$w]." 赢盘";
			$result->comment = $arr['comment'];
			
			$res = sql_query("SELECT log.user_id, u.username, u.class, log.stake, log.odds FROM casinolog AS log, casino AS c, users AS u WHERE log.id=".sqlesc($id)." AND log.id = c.id AND log.choice=c.win AND log.user_id=u.id AND c.state=4");
			while( $obj = mysql_fetch_object($res) )
			{
				$result->winner[] = $obj;
			}
			echo json_encode($result);
			break;
		}
		case('add'):
		{
			if(get_user_class() < UC_MODERATOR)
			{
				echo 403; 
				write_log("User " . $CURUSER["username"] . "," . $CURUSER["ip"] . " is hacking casino system",'mod');
				die;			
			}
			else
			{
				$title = $_POST['title'];
				$descr = $_POST['descr'];
				$added_by = $CURUSER['username'];
				$added_time = date("Y-m-d H:i:s");
				$state = 1;
				$end_time = $_POST['end_time'];
				$list = "";
				$value = "";
				
				for( $i=1; $i<=9; $i++)
				{
					if( $_POST['op'.$i] != "" && $_POST['op'.$i.'_odds'] != "" )
					{
						$list .= ", op".$i."_descr, op".$i."_odds ";
						$value .= ", ".sqlesc($_POST['op'.$i]).", ".sqlesc($_POST['op'.$i.'_odds']);
					}
				}
				
				$query = "INSERT INTO casino (title, descr, added_by, added_time, state, end_time, comment".$list.") VALUES(". sqlesc($title) .",". sqlesc($descr) .", ". sqlesc($added_by) .", ". sqlesc($added_time) .", ".sqlesc($state).", ". sqlesc($end_time) .", ''".$value.")";
				$res = sql_query($query) or sqlerr(__FILE__, __LINE__);
				$id = mysql_insert_id();
				write_log("Lottery $id ($title) was added by ". $CURUSER["username"]);
				echo 200;
			}
			
			break;
		}
		case('mod'):
		{
			if(get_user_class() < UC_MODERATOR)
			{
				echo 403; 
				write_log("User " . $CURUSER["username"] . "," . $CURUSER["ip"] . " is hacking casino system",'mod');
				die;			
			}
			else
			{
				$id = 0+$_POST['id'];
				$title = $_POST['title'];
				$descr = $_POST['descr'];
				$end_time = $_POST['end_time'];
				$list = "";
				$delete = 0+$_POST['del'];
				$comment = $_POST['comment'];
				
				if( $id == $delete )
				{
					$res = sql_query("SELECT title FROM casino WHERE id=".sqlesc($id)) or sqlerr(__FILE__, __LINE__);

					if( mysql_num_rows($res) > 0 )
					{
						$arr = mysql_fetch_assoc($res);
						$title = $arr['title'];
						
						sql_query("DELETE FROM casino WHERE id=".sqlesc($delete)." LIMIT 1") or sqlerr(__FILE__, __LINE__);
						sql_query("DELETE FROM casinolog WHERE id=".sqlesc($delete)) or sqlerr(__FILE__, __LINE__);
						write_log("Lottery $id ($title) was deleted by ". sqlesc($CURUSER["username"]) );
						
						echo 200;
					}
					else
					{
						echo 403;
					}
					die;
				}
				
				$state = "state=1,";
				$is_stop =  $_POST['is_stop'];
				if($is_stop == "true")
				{	
					$state="state=3,";
				}
				
				for( $i=1; $i<=9; $i++)
				{
					if( $_POST['op'.$i] != "" && $_POST['op'.$i.'_odds'] != "" && $_POST['op'.$i] != "null" && $_POST['op'.$i.'_odds'] != "null" )
					{
						$list .= ", op".$i."_descr=".sqlesc($_POST['op'.$i]);
						$list .= ", op".$i."_odds=".sqlesc($_POST['op'.$i.'_odds']);
					}
					else
					{
						$list .= ", op".$i."_descr=NULL";
						$list .= ", op".$i."_odds=NULL";
					}
				}
				
				$query = "UPDATE casino SET title=".sqlesc($title).", descr=".sqlesc($descr).", ".$state." end_time=".sqlesc($end_time).", comment=".sqlesc($comment).$list." WHERE id=".sqlesc($id);
				$res = sql_query($query) or sqlerr(__FILE__, __LINE__);
				write_log("Lottery $id ($title) was updated by ".$CURUSER["username"]);
				echo 200;
			}
			
			break;
		}
		case('pedding'):
		{
			if(get_user_class() < UC_MODERATOR)
			{
				echo 403; 
				write_log("User " . $CURUSER["username"] . "," . $CURUSER["ip"] . " is hacking casino system",'mod');
				die;			
			}
			else
			{
				$id = 0+$_POST['id'];
				$win = 0+$_POST['win'];
				$comment = $_POST['comment'];
				$push = $_POST['push'];
				
				
				if($push == $id)	//push situation
				{
					$res = sql_query("UPDATE casino SET win=-1, comment=".sqlesc($comment)." WHERE id=".sqlesc($id)." AND state=2 LIMIT 1") or sqlerr(__FILE__, __LINE__);
					if($res)
					{
						$res = sql_query("SELECT * FROM casino WHERE id=".sqlesc($id)." AND state=2 LIMIT 1") or sqlerr(__FILE__, __LINE__);
						$arr = mysql_fetch_assoc($res);
						$title = $arr['title'];
						
						if(mysql_num_rows($res) > 0)
						{
							// update state
							sql_query("UPDATE casino SET winner_count=0, state=5, paid_time='".date("Y-m-d H:i:s")."' WHERE id=".sqlesc($id)." LIMIT 1") or sqlerr(__FILE__, __LINE__);
							// update users & casinolog
							sql_query("UPDATE users AS u, casinolog AS log, casino AS c SET u.seedbonus=u.seedbonus+log.stake, log.result=log.result+1  WHERE log.user_id=u.id AND log.id=c.id AND c.id=".sqlesc($id)) or sqlerr(__FILE__, __LINE__);

							// pm all
							$res = sql_query("SELECT * FROM casino AS c, casinolog AS log WHERE c.id=".sqlesc($id)." AND c.id=log.id") or sqlerr(__FILE__, __LINE__);
							while ($arr = mysql_fetch_assoc($res))
							{
								$push_bonus = $arr['stake'];
								$msg = $lang_getbetajax['text_pm_push'].$push_bonus.$lang_getbetajax['text_pm_bonus'].' '.$arr['title'].".";
								sql_query("INSERT INTO messages (sender, subject, receiver, msg, added) VALUES(0, '".$lang_getbetajax['text_pm_title']."', ".$arr['user_id'].",". sqlesc($msg) .", '".date("Y-m-d H:i:s")."')") or sqlerr(__FILE__, __LINE__);
							}

							write_log("Lottery ".$id." (".$title.") was cleared by ".$CURUSER["username"].", Push (".$comment.")");
							echo 200;
						}
					}
					else
					{
						echo 403;
					}
				}
				else	//not push
				{
					$res = sql_query("UPDATE casino SET win=".sqlesc($win).", comment=".sqlesc($comment)." WHERE id=".sqlesc($id)." AND state=2 LIMIT 1") or sqlerr(__FILE__, __LINE__);
					if($res)
					{
						$res = sql_query("SELECT * FROM casino WHERE id=".sqlesc($id)." AND state=2 LIMIT 1") or sqlerr(__FILE__, __LINE__);
						$arr = mysql_fetch_assoc($res);
						$title = $arr['title'];
						$w = "op".$win."_descr";
						$win_descr = " '".$arr[$w]."' win";
						
						if(mysql_num_rows($res) > 0)
						{
							// update winner count
							$res = sql_query("SELECT * FROM casino AS c, casinolog AS log WHERE c.id=".sqlesc($id)." AND c.id=log.id AND c.win=log.choice ") or sqlerr(__FILE__, __LINE__);
							$win_num = mysql_num_rows($res);
							sql_query("UPDATE casino SET winner_count=".sqlesc($win_num).", state=4, paid_time='".date("Y-m-d H:i:s")."' WHERE id=".sqlesc($id)." LIMIT 1") or sqlerr(__FILE__, __LINE__);
							// payout winners
							sql_query("UPDATE users AS u, casinolog AS log, casino AS c SET u.seedbonus=u.seedbonus+(log.odds*log.stake), log.result=log.result+1  WHERE log.user_id=u.id AND log.id=c.id AND c.id=".sqlesc($id)." AND log.choice=c.win") or sqlerr(__FILE__, __LINE__);
							// update losers
							sql_query("UPDATE casinolog AS log, casino AS c SET log.result=log.result+1 WHERE c.id=".sqlesc($id)." AND c.id=log.id AND log.choice!=c.win") or sqlerr(__FILE__, __LINE__);
							
							// pm winners
							while ($arr = mysql_fetch_assoc($res))
							{
								$win_bonus = $arr['odds']*$arr['stake'];
								$msg = $lang_getbetajax['text_pm_cong'].$win_bonus.$lang_getbetajax['text_pm_bonus'].' '.$arr['title'].".";
								sql_query("INSERT INTO messages (sender, subject, receiver, msg, added) VALUES(0, '".$lang_getbetajax['text_pm_title']."', ".$arr['user_id'].",". sqlesc($msg) .", '".date("Y-m-d H:i:s")."')") or sqlerr(__FILE__, __LINE__);
							}
							
							// PM losers
							$res = sql_query("SELECT * FROM casino AS c, casinolog AS log WHERE c.id=".sqlesc($id)." AND c.id=log.id AND log.choice!=".sqlesc($win)) or sqlerr(__FILE__, __LINE__);
							
							while ($arr = mysql_fetch_assoc($res))
							{
								$msg = $lang_getbetajax['text_pm_loss'].$arr['stake'].$lang_getbetajax['text_pm_bonus'].' '.$arr['title'].".";
								sql_query("INSERT INTO messages (sender, subject, receiver, msg, added) VALUES(0, '".$lang_getbetajax['text_pm_title']."', ".$arr['user_id'].", ".sqlesc($msg).", '".date("Y-m-d H:i:s")."')") or sqlerr(__FILE__, __LINE__);
							}
							
							write_log("Lottery ".$id." (".$title.") was cleared by ".$CURUSER["username"].", ".$win_descr." (".$comment.")");
							echo 200;
						}
					}
					else
					{
						echo 403;
					}
				}
				break;
			}
		}
		case('view'):
		{
			if(get_user_class() < UC_MODERATOR)
			{
				echo 403; 
				write_log("User " . $CURUSER["username"] . "," . $CURUSER["ip"] . " is hacking casino system",'mod');
				die;			
			}
			else
			{
				Class gambler
				{
					public $title="";
					public $descr="";
					public $gambler=array();
				};
				
				$res = sql_query("SELECT * FROM casino WHERE id=".sqlesc($id)." LIMIT 1");
				$arr = mysql_fetch_assoc($res);
				$w = "op".$arr['win']."_descr";
				$result = new gambler;
				$result->title = $arr['title'];
				$result->descr = $arr['descr'];
				
				$res = sql_query("SELECT log.user_id, u.username, u.class, log.stake, log.odds, log.choice FROM casinolog AS log, casino AS c, users AS u WHERE log.id=".sqlesc($id)." AND log.id = c.id AND log.user_id=u.id");
				while( $obj = mysql_fetch_object($res) )
				{
					$result->gambler[] = $obj;
				}
				echo json_encode($result);
			}
			break;
		}
	}
}
?>