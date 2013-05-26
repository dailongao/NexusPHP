<?php
set_include_path("G:/Server/php/5.2.6/pear;.:/php/includes");
//set_include_path("X:/exchange/4ZhongweiShen/php/5.4.9/pear;.:/php/includes");

require_once ('G:/Univ/Freq/Dev/nexusold/trunk\\' . 'include/smtp/eYou.php');

for($i = 1000; $i >= 0; --$i)
{
$mail_eYou = new eYou();

//$mail_eYou->set_account($eYouAccount, $eYouAccountDomain, $eYouAccountPass, $eYouUrl);
$mail_eYou->set_account("10821004", "gstu.zju.edu.cn", "110337", "http://st.zju.edu.cn/");
//$mail_eYou->set_message($recipient, $subject, $content);

$mail_eYou->set_message("zantetsu@zuaa.edu.cn", "thisissubject" . $i, "<b>thisiscontent</b>");
$mail_eYou->compose_info();
!$mail_eYou->do_login() or stderr($lang_functions['std_error'], $lang_functions['text_unable_to_send_mail']);
!$mail_eYou->do_sendemail() or stderr($lang_functions['std_error'], $lang_functions['text_unable_to_send_mail']);
echo $i . "\n";
}
?>