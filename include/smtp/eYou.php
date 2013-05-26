<?php

/**
* Allows users to send email from eYou email system
* @package eYou
* @author Z.
*/

require_once ("HTTP/Request2.php");

/**
* @version 0.1
* @access public
* @todo 
*/
class eYou
{
    // email message related
    var $recipient_ = null;
    var $subject_ = null;
    var $content_ = null;
    
    // user set
    var $eYouAccount_ = null;
    var $eYouAccountDomain_ = null;
    var $eYouAccountPass_ = null;
    var $eYouUrl_ = null;
    
    // browser emulator
    var $req_emu_agent_ = "Mozilla/5.0 (Windows NT 6.1; WOW64; rv:16.0) Gecko/20100101 Firefox/16.0";
    var $req_emu_accept_ = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8";
    var $req_emu_accept_language_ = "zh-cn,zh;q=0.8,en-us;q=0.5,en;q=0.3";
    var $req_emu_accept_encoding_ = "gzip, deflate";
    var $req_emu_connection_ = "keep-alive";
    var $req_emu_content_type_ = "application/x-www-form-urlencoded";
    
    // composed info
    var $eYou_CNchar_urlencoded_login_ = "+%B5%C7%C2%BC+";
    var $eYou_CNchar_urlencoded_send_immediately_ = "%C1%A2%BC%B4%B7%A2%CB%CD";
        
    var $eYou_bot_url_login_ = null;
    var $eYou_bot_referer_login_ = null;
    var $eYou_bot_postdata_login_ = null;
    
    var $eYou_bot_url_send_ = null;
    var $eYou_bot_referer_send_ = null;
    var $eYou_bot_postdata_send_ = null;
    
    // cookie
    var $eYou_bot_cookie_string_ = null;
       
    function smtp()
    {
        
    }
    
    function set_account($eYouAccount, $eYouAccountDomain, $eYouAccountPass, $eYouUrl)
    {
        $this->eYouAccount_ = $eYouAccount;
        $this->eYouAccountDomain_ = $eYouAccountDomain;
        $this->eYouAccountPass_ = $eYouAccountPass;
        $this->eYouUrl_ = $eYouUrl;
    }
    
    function set_message($recipient, $subject, $content)
    {
        $this->recipient_ = $recipient;
        $this->subject_ = $subject;
        $this->content_ = $content;
    }
    
    function compose_info()
    {
        $eYou_bot_token = rand(0,9999) . rand(0,9999) . "." . rand(0,9999) . rand(0,9999); //emulate the js Math.random() * 100000000;
        
        $this->eYou_bot_url_login_ = $this->eYouUrl_ . "cgi-bin/login?token=" . $eYou_bot_token;
        $this->eYou_bot_referer_login_ = $this->eYouUrl_;

        $this->eYou_bot_url_send_ = $this->eYouUrl_ . "cgi-bin/email";
        $this->eYou_bot_referer_send_ = $this->eYouUrl_ . "cgi-bin/compose?uid=" . $this->eYouAccount_ . "&domain=" . $this->eYouAccountDomain_;
    }
    
    function do_login()
    {
        $req = new HTTP_Request2($this->eYou_bot_url_login_,HTTP_Request2::METHOD_POST);
        $req->setHeader("User-Agent", $this->req_emu_agent_);
        $req->setHeader("Accept", $this->req_emu_accept_);
        $req->setHeader("Accept-Language", $this->req_emu_accept_language_);
        $req->setHeader("Accept-Encoding", $this->req_emu_accept_encoding_);
        $req->setHeader("Connection", $this->req_emu_connection_);
        $req->setHeader("Content-Type", $this->req_emu_content_type_);
        $req->setHeader("Referer", $this->eYou_bot_referer_login_);
        $req->addPostParameter("LoginName",$this->eYouAccount_ . "@" . $this->eYouAccountDomain_);
        $req->addPostParameter("domain",$this->eYouAccountDomain_);
        $req->addPostParameter("Password",$this->eYouAccountPass_);
        $req->addPostParameter("log_in",$this->eYou_CNchar_urlencoded_login_);
        $response = $req->send();
        
        $response_cookie = $response->getCookies();
        
        if(count($response_cookie) != 0)
            $this->eYou_bot_cookie_string_ = $response_cookie[0]['name'] . "=" . $response_cookie[0]['value'] . "..";
        else
            return 1;
        
		/*
        echo "------------------------------------";
        echo $response->getBody();
        echo "------------------------------------";
        echo "------------------------------------";
        print print_r($response->getCookies());
        echo "------------------------------------";
		*/
    }
    
    function do_sendemail()
    {
        $req = new HTTP_Request2($this->eYou_bot_url_send_,HTTP_Request2::METHOD_POST);
        $req->setHeader("User-Agent", $this->req_emu_agent_);
        $req->setHeader("Accept", $this->req_emu_accept_);
        $req->setHeader("Accept-Language", $this->req_emu_accept_language_);
        $req->setHeader("Accept-Encoding", $this->req_emu_accept_encoding_);
        $req->setHeader("Connection", $this->req_emu_connection_);
        $req->setHeader("Content-Type", $this->req_emu_content_type_);
        $req->setHeader("Referer", $this->eYou_bot_referer_send_);
        $req->addCookie("Cookie",$this->eYou_bot_cookie_string_);
        $req->addPostParameter("Msg","");
        $req->addPostParameter("faint",$this->eYou_CNchar_urlencoded_send_immediately_);
        $req->addPostParameter("AttFiles","");
        $req->addPostParameter("html","yes");
        $req->addPostParameter("eyou_ctype","");
        $req->addPostParameter("content",$this->content_);
        $req->addPostParameter("recipient",$this->recipient_);
        $req->addPostParameter("subject",$this->subject_);
        $req->addPostParameter("ccopy","");
        $req->addPostParameter("bccopy","");
        $req->addPostParameter("priority",3);
        $req->addPostParameter("alter","");
        $req->addPostParameter("editcontent",$this->content_);
        $req->addPostParameter("signature","no_signum");
        $response = $req->send();
        
        if(strstr($response->getBody(), 'ABOUT_THIS_SUCCESS'))
            return 0;
        else
            return 2;
        
		/*
        echo "------------------------------------";
        echo $response->getBody();
        echo "------------------------------------";
		*/
    }
}

?>
