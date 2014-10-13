<?php

# AI Module V0.1.20130409
# Test only. 

# The match priority is the position in array. Please notice about this.

$ai_library = array(
	array('keyword' => array("/NHD娘(.*)求米/", "/NHD娘(.*)我要米/"), 'response' => array("哼！人家才不知道什么叫米呢！", "呜呜，为什么你们这些人总是米米米的，人家弄不懂啦~", "求米什么的最讨厌了！烦死了烦死了烦死了！", "呵呵，你们不知道，我跟马爷谈笑风生，你们这些求米的人啊，naive！")),
	array('keyword' => array("/NHD娘(.*)求交往/"), 'response' => array("你是个好人，这张好人卡请收下吧~")),
	array('keyword' => array("/NHD娘(.*)求帮助/"), 'response' => array("如果需要帮助请去查看[url=rules.php]规则[/url]和[url=faq.php]常见问题[/url]，如果还不懂可以到论坛发帖求救哦~")),
	//array('keyword' => array("/NHD娘(.*)邮箱/"), 'response' => array("关于邮箱的问题请注意：1、对于10级以前（包括10级）的同学，本科生请使用[url=http://st.zju.edu.cn]学号@st.zju.edu.cn[/url]的邮箱注册，研究生请使用[url=http://gstu.zju.edu.cn]学号@gstu.zju.edu.cn[/url]后缀的邮箱注册；2、对于11级以后（包含11级）以后的同学，请使用[url=http://mail.zju.edu.cn]学号@zju.edu.cn[/url]的邮箱注册；3、对于教职工，请使用[url=http://fa.zju.edu.cn]@fa.zju.edu.cn[/url]后缀的邮箱注册。")),
	array('keyword' => array("/^NHD娘(.*)马爷(.*)/", "/^NHD娘(.*)sssdjay(.*)/"), 'response' => array("你说的是[url=http://www.nexushd.org/userdetails.php?id=22587]sssdjay[/url]吗？马爷可是永远的博士之光呢！NHD娘最喜欢他了！嗯嗯！")),
	array('keyword' => array("/^NHD娘(.*)你好(.*)/","/^NHD娘(.*)早上好(.*)/","/^NHD娘(.*)晚上好(.*)/","/^NHD娘(.*)下午好(.*)/"), 'response' => array("你好~今天NHD娘也是活力满满地在工作着呢！", "你好~这里是最勤劳最可爱的NHD娘~", "你……你好！呜！被看到没睡醒的样子了>_<", "你好，今天也是美好的一天呢！")),
	array('keyword' => array("/NHD娘(.*)晚安/", "/NHD娘(.*)睡觉/"), 'response' => array("晚安，愿你的梦跟以往一样美丽~", "晚安~愿你的明天又是美好的一天！")),
	array('keyword' => array("/NHD娘(.*)求约会/"), 'response' => array("function:date")),
	array('keyword' => array("/NHD娘(.*)我不想再见到你了/"), 'response' => array("function:closenhdrobot")),
	array('keyword' => array("/NHD娘(.*)你快回来/"), 'response' => array("function:opennhdrobot")),
	//array('keyword' => array("/中秋(.*)快乐/"), 'response' => array("function:midautumn")),
	//array('keyword' => array("/^NHD娘(.*)/"), 'response' => array("嗯？是你叫我么？可是我听不懂你在说什么呢……>_<", "呜呜！不要再欺负NHD娘了！NHD娘才不是天然呆萌妹子呢！", "你再欺负我我可就要叫马爷来保护我了啊！>_<", "？（头上冒出了巨大的问号）")),
	array('keyword' => array("/^NHD娘(.*)/"), 'response' => array("norep")),
);

$function_library = array(
	"date" => array('success' => ("好的" . $CURUSER["username"] . "，三分钟后来八舍楼下等我哦！"), 'fail' => ("才不要呢！约会什么的最讨厌了！")),
	"midautumn" => array('success' => ($CURUSER["username"] . "中秋快乐！我偷偷藏了点魔力值，就分你500好啦，记得给家里打个电话哦^-^"), 'fail' => ("呜呜我就藏了一点点，还不能被马爷发现，实在给不了你啦！不过还是祝你中秋快乐0w0")),
	"closenhdrobot" => "您已经成功关闭NHD娘了……不过好像你也看不见了呢……",
	"opennhdrobot" => "欢迎回来NHD娘的怀抱呢！",
);

$aiuserid = 65399; #AI's user id

?>