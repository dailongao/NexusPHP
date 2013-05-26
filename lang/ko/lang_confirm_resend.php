<?php

$lang_confirm_resend = array
(
	'resend_confirmation_email_failed' => "인증 메일을 보내는데 실패했습니다.",
	'std_fields_blank' => "빈 칸을 채워주십시오.",
	'std_invalid_email_address' => "유효하지 않은 이메일 주소입니다!",
	'std_email_not_found' => "등록된 이메일 주소가 아닙니다.\n",
	'std_user_already_confirm' => "이 메일 주소를 사용하는 계정이 이미 인증되었습니다.\n",
	'std_passwords_unmatched' => "비밀번호가 일치하지 않습니다! 다시 시도해주세요.。",
	'std_password_too_short' => "비밀번호가 너무 짧습니다 (최소 6글자)",
	'std_password_too_long' => "비밀번호가 너무 깁니다 (최대 40글자)",
	'std_password_equals_username' => "죄송합니다. 비밀번호와 아이디가 같습니다.",
	'std_error' => "에러",
	'std_database_error' => "데이터 베이스 에러. 관리자와 상의해주세요 .",
	'text_resend_confirmation_mail_note' => "<h1>인증 메일을 다시 보냅니다. </h1><p>인증 메일을 다시 보내려면 아래 양식을 이용해주십시오</p><p>하루 안에 인증을 하지 못하면, <br />당신의 계정은 삭제되고, 재등록을 해야합니다.</p><p><b>확인:  </b> ".$maxloginattempts." 실패된 시도를 계속하게되면 IP 밴시킵니다!</p>",
	'row_registered_email' => "등록된 이메일주소: ",
	'row_new_password' => "새로운 비밀번호: ",
	'text_password_note' => "최소 6글자",
	'row_enter_password_again' => "비밀번호 재입력: ",
	'submit_send_it' => "보내기!",
	'text_you_have' => "당신은 ",
	'text_remaining_tries' => " 번의 시도가 남았습니다.",
	
	'mail_title' => " 계정 동록 인증(Re-Send)",
	'mail_this_link' => "링크",
	'mail_here' => "여기",
	'mail_one' => "반갑습니다 ",
	'mail_two' => ",<br /><br />당신은 ".$SITENAME." 의 확인 이메일을 받으셨습니다. <br /> 이 주소를 ",
	'mail_three' => " 연락처로 정하셨습니다. .<br /><br />만약 이런 걸 요청하신 적이 없으시다면 이 이메일 무시하시면 됩니다.. 요청한 사람의 이메일 주소와<br />IP 주소가 있습니다.  ",
	'mail_four' => ". 읽기 전용 이메일이므로 회신은 하지 말아주세요.<br /><br />등록 요청을 확인하시려면 아래 링크를 클릭하십세요. ",
	'mail_four_1' => "<br /><br />위의 링크가 깨져있거나 기간이 만료되었다면 새로 확인 메일을 요청하시기 바랍니다. ",
	'mail_five' => "<br /><br />위 링크를 클릭하시셔서 확인이 된 다음에야 비로서 새로운 계정을 이용하실 수 있습니다. <br />만약 확인을 하지 못하시면 24시간 안에 등록하신 계정은 삭제됩니다.  ".$SITENAME."를 이용하시기 전에 <br />규정과 FAQ를 꼭 읽어주세요.<br /><br />유의사항: ".$SITENAME."에 등록 신청하신 적이 없으시다면 ".$REPORTMAIL." 로 신고해주시기 바랍니다. <br /><br />------<br />감사합니다,<br />The ".$SITENAME." Team.",
	'text_select_lang' => "언어 선택: ",
	'std_need_admin_verification' => "Account needs manual verification from administrators."
);
?>
