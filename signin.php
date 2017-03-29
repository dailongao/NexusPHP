<?php
// Sign-in for torrent promotion V2.0
// By Sakura, 2015/12/23

require "include/bittorrent.php";

// 资源对象
$res = get_current_user_resource()['sign_in'];

dbconn();
loggedinorreturn();
// //stdhead($lang_magic['head_magic']);
// if(get_user_class() < UC_SYSOP){
// 	stderr("Sorry", "Sorry, we are updating this module.");
// 	die();
// }

// 功能检测，如果没有设定奖励值也无法使用签到
if ($enable_sign_in == "no" || count($sign_in_reward) == 0) {
    stderr($res["feature_not_enabled_title"], $res["feature_not_enabled_description"]);
    die();
}

//get the user info
$my_id = $CURUSER["id"];
$my_sign_in_count = $CURUSER["signincount"];
$my_last_sign_in_time = new DateTime($CURUSER["lastsignintime"]);

stdhead($res["title"]);

// 提交操作
if($_POST['action']) {
    	
    $content = $_POST["content"];
    
    if(is_null($content) || $content == "") {
        stdmsg($res["error_title"], $res["error_no_content"]);
        die();
    }
    
    $now = new DateTime("now");
      
    // 日期差
    $day_diff = get_date_diff($now, $my_last_sign_in_time);

    // 已经签到
    if ($day_diff < 1) {
        stdmsg($res["error_title"], $res["error_already_signed_in"]);
        die();
    }
    
    // 连续签到计数，默认为 1
    $new_day_count = 1;
    
    // 如果紧接着上次签到日期，则计数增加。
    if ($day_diff == 1) {
        $new_day_count = $my_sign_in_count + 1;
    }
    
    // 奖励范围
    if ($new_day_count > count($sign_in_reward)) {
        $reward_range = $sign_in_reward[count($sign_in_reward) - 1];
    } else {
        $reward_range = $sign_in_reward[$new_day_count - 1];
    }
    
    // 奖励内容
    $bonus = rand($reward_range[0], $reward_range[1]);
    
    // 创建数据连接
    $sql = new_mysqli();
    
    // 增加魔力值
    $query = $sql->prepare("UPDATE `users` SET `seedbonus` = `seedbonus` + ?, `lastsignintime` = ?, `signincount` = ? WHERE `id` = ?");
    $query->bind_param("isii", $bonus, $now->format("Y-m-d H:i:s"), $new_day_count, $my_id);
    $query->execute();
    $query->close();

    // 追加日志记录
    if ($sign_in_bonus_record == "yes") {
       
        $append_message = MessageFormatter::formatMessage($user_lang, "{0} - {1} Points for Signing In.\n", array($now->format("Y-m-d"), $bonus));
        
        $query = $sql->prepare("UPDATE `users` SET `bonuscomment` = CONCAT(?, IFNULL(`bonuscomment`, \"\")) WHERE `id` = ?");
        $query->bind_param("si", $append_message, $id);
        $query->execute();
        $query->close();
    }
    
    $topic_exist = false;
    
    // 发帖
    if (!empty($sign_in_topic_id)) {
        
        // 查询帖子信息
        $query = $sql->prepare("SELECT `forumid` FROM `topics` WHERE `id` = ?");
        $query->bind_param("i", $sign_in_topic_id);
        $query->execute();
        $query->bind_result($forum_id);
        
        // 帖子是否存在
        $topic_exist =  $query->fetch();
        $query->close();
        
        if ($topic_exist) {
                
            // 增加发帖数
            $query = $sql->prepare("UPDATE `forums` SET `postcount` = `postcount` + 1 WHERE `id` = ?");
            $query->bind_param("i", $sign_in_topic_id);
            $query->execute();
            $query->close();
            
            // 构建内容
            $body = MessageFormatter::formatMessage($user_lang, $sign_in_template, array($my_id, $CURUSER["username"], $now->format("Y-m-d H:i:s"), $bonus, $new_day_count, $content));
                
            $query = $sql->prepare("INSERT INTO `posts` (`topicid`, `userid`, `added`, `body`, `ori_body`) VALUES (?, ?, ?, ?, ?)");
            $query->bind_param("iisss", $sign_in_topic_id, $my_id, $now->format("Y-m-d H:i:s"), $body, $body);
            $query->execute();
            $query->close();
            
            $today_date = date("Y-m-d", TIMENOW);
            
            // 删除缓存
            $Cache->delete_value('forum_'.$forum_id.'_post_'.$today_date.'_count');
            $Cache->delete_value('today_'.$today_date.'_posts_count');
            $Cache->delete_value('forum_'.$forum_id.'_last_replied_topic_content');
            $Cache->delete_value('topic_'.$sign_in_topic_id.'_post_count');
            $Cache->delete_value('user_'.$my_id.'_post_count');
            
        }      
    }
    
    // 回帖消息
    if ($topic_exist) {
        $message = MessageFormatter::formatMessage($user_lang, $res["success_descrption"], array($new_day_count, $bonus, $sign_in_topic_id));
    } else {
        $message = MessageFormatter::formatMessage($user_lang, $res["success_descrption_no_post"], array($new_day_count, $bonus));
    }
    
    stdmsg($res["success_title"], $message);
    die();
}

//rule
begin_main_frame();
begin_frame($res["help_title"], true,10,"100%","center", "left"); ?>

<p><?= $res["help_main_text"] ?></p>
<ul>
    <?php
    
    $index = 0;
    
    foreach ($sign_in_reward as $item) {
        $index++;
        
        // 魔力值文字
        if ($item[0] == $item[1]) {
            $valueText = MessageFormatter::formatMessage($user_lang, $res["help_bouns_one_value"], array($item[0]));   
        }
        else {
            $valueText = MessageFormatter::formatMessage($user_lang, $res["help_bouns_two_value"], array($item[0], $item[1]));   
        }
        
        // 最后一天特殊判断
        if ($index == count($sign_in_reward)) {
            $format = $res["help_day_description_last"];
        } else {
            $format = $res["help_day_description"];
        }
        
        $text =  MessageFormatter::formatMessage($user_lang, $format, array($index, $valueText)); 
        
        ?> <li><?= $text ?></li> <?php
    }
    ?>
</ul>

<?php 

    // 签到提示用户操作消息
    if (!empty($sign_in_topic_id)) {
        $user_action_message = MessageFormatter::formatMessage($user_lang, $res["help_user_action_tip"], array($sign_in_topic_id));   
    } else {
        $user_action_message = $res["help_user_action_tip_no_post"];
    }
?>

<p><?= $res["help_day_tip"] ?></p>
<p><?= $user_action_message ?></p>


<?php
end_frame();

begin_frame($res["my_title"], true,10,"100%", "center", "center")
?>

<?php 

    $can_sign_in = true;
        
   if ($my_sign_in_count == 0) {
       ?> <p><?= $res["my_last_sign_in_time_never"] ?></p> <?php
   } else {
       ?> 
       <p><?= MessageFormatter::formatMessage($user_lang, $res["my_last_sign_in_time"], array($my_last_sign_in_time->format('Y-m-d H:i:s'))) ?></p> 
       <?php
                  
       // 日期比较
       $now = new DateTime("now");
       $day_diff = get_date_diff($now, $my_last_sign_in_time);
       
       if( $day_diff < 1) {
           $can_sign_in = false;
           ?> <p><?= $res["my_sign_in_already_done"] ?></p> <?php
       } elseif ($day_diff == 1) {
           ?> <p><?= MessageFormatter::formatMessage($user_lang, $res["my_sign_in_continuing"], array($my_sign_in_count)) ?></p> <?php
       } else {
           ?> <p><?= MessageFormatter::formatMessage($user_lang, $res["my_sign_in_broken"], array($my_sign_in_count)) ?></p> <?php
       }
   }
   
   if ($can_sign_in) {
        ?>
        
        <table style='border:1px solid #000000;'>
            <tr>
                <td class="text" align="center">
                    <p><?= $res["my_sign_in_action_tip"] ?></p>
                    <form id="sign-in-form" name="sign-in-form" method="post" action="?" onsubmit="return postvalid(this);">
                        <input type="hidden" name="action" value="post" />
	                     <?= quickreply('sign-in-form', 'content', $res["my_sign_in_action_button"]) ?>
	                </form>
                </td>
            </tr>
        </table>
               
        <?
       
   }

?>


<?php
end_frame();

end_main_frame();

stdfoot();
?>
