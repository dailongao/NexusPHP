<?php

$lang_magic = array
(
	'head_magic' => "优惠购买",
	'magic_rule_title' => "优惠购买规则",
	'set_magic_title' => "优惠购买",
	'magic_rule' => "<ul>
	<li>种子优惠魔力值计算公式：<b>所需魔力值B = 优惠类型常数A × 用户等级常数C × 种子体积S × 优惠时间T</b>，其中：
	<ul>
		<li>优惠类型常数 A：<br />
			<ul><li>购买免费优惠时A = 100；</li><li>购买2X免费优惠时A = 150。</li></ul>
		</li>
		<li>用户等级常数 C：<br />	常数 C 由用户等级 Class 决定。Class 取购买种子优惠的用户和发布种子的用户两者中较低的等级。比如某个种子，购买种子优惠的用户为 <b class=\"InsaneUser_Name\">Insane User</b>，发布种子的用户为 <b class=\"EliteUser_Name\">Elite User</b>，由于 <b class=\"EliteUser_Name\">Elite User</b> 等级低于 <b class=\"InsaneUser_Name\">Insane User</b> ，Class 取 <b class=\"EliteUser_Name\">Elite User</b>。 <br/>
			C 和 Class 的对应关系如下：<br/>
			<ul>
				<li>当 Class 为 <b class=\"Peasant_Name\">Peasant</b> / <b class=\"User_Name
				\">User</b> / <b class=\"PowerUser_Name\">Power User</b> / <b class=\"EliteUser_Name\">Elite User</b> 时，C = 1；</li>
				<li>当 Class 为 <b class=\"CrazyUser_Name\">Crazy User</b> / <b class=\"InsaneUser_Name\">Insane User</b> 时，C = 0.9；</li>
				<li>当 Class 为 <b class=\"VeterenUser_Name\">Veteren User</b> / <b class=\"ExtremeUser_Name\">Extreme User</b> 时 ，C = 0.8；</li>
				<li>当 Class 为 <b class=\"UltimateUser_Name\">Ultimate User</b> 时，C = 0.7；</li>
				<li>当 Class 为 <b class=\"NexusMaster_Name\">Nexus Master</b> 时，C = 0.6；</li>
				<li>当 Class 为 <b class=\"VIP_Name\">VIP</b> / <b class=\"Retiree_Name\">Retiree</b> / <b class=\"Uploader_Name\">Uploader</b> / <b class=\"Moderator_Name\">Moderator</b> / <b class=\"Administrator_Name\">Administrator</b> / <b class=\"SysOp_Name\">SysOp</b> / <b class=\"StaffLeader_Name\">Staff Leader</b> 时，C = 0.5。</li>
			</ul>
		</li>
		<li>种子体积 S：<br />
		单位为 GB，不足 1GB 时向上取舍。比如 4.5GB 的种子S = 5
		</li>
		<li>优惠时间 T：<br />
		单位为小时。最少 24 小时，最大 168 小时（7天）
		</li>
	</ul>
	<li>优惠不能互相覆盖，即若当前种子已处于免费或2X免费优惠状态，则购买优惠将会失败。</li>
	<li>请不要忘记先计算魔力值再购买优惠，以免造成意外损失。</li>
</ul>",
	'torrent_uid' => "种子ID",
	'torrent_name' => "种子名称",
	'torrent_size' => "种子大小",
	'promotion_limit' => "优惠期限",
	'limit_rule' => "优惠持续时间（小时），必须为正整数，最少24小时，最大168小时（7天）",
	'count_magic' => "魔力值",
	'wait_to_count' => "等待计算",
	'count_the_magic' => "计算所需魔力值",
	'do_the_magic' => "购买优惠！",
	'illegal_time' => "时限不合法！",
	'no_enough_magic' => "魔力值不足够！",
	'use_magic_ok' => "优惠购买成功！有效期至：",
	'illegal_op' => "非法操作！已被记录！",
	'torrent_owner' => "发布者",
	'cannot_cover' => "优惠不能相互覆盖！",
	'text_promotion_type' => "优惠种类",
	'text_free' => "免费",
	'text_2xfree' => "2x免费",
);

?>
