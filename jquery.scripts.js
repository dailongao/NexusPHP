$.noConflict();
jQuery(document).ready(function($) {

$(function() {
	
	// jquery.boxy init
	$(".boxy").boxy();
	
	// jquery.ui.tabs init
	$("#tabs").tabs({ fx: { opacity: 'toggle', duration:'fast' } });
	
	// jquery.ui.button init
	$(".casino-page-button").button();

	// in mybonus.php
	$("#no_ad_confirm").click(function() { 
		var msg = "你确定要花费魔力值15天不显示广告么?";
		
		Boxy.confirm( msg, function() { 
            $("#no_ad_confirm").siblings("#bonus_cost").click(); 
		});
		
		return false;
	}); 
		
	$("#charity_give_confirm").click(function() { 
		var msg = "你确定要慈善捐赠么?";
		
		Boxy.confirm( msg, function() { 
            $("#charity_give_confirm").siblings("#bonus_cost").click(); 
		});
		
		return false;
	}); 
	
	// in casino.php
	$(".betting").click(function() {
		var id = $(this).attr("value");
		var bets_laid = $(this).parent().siblings(".bet-bets_laid");
		
		$.post(
		    'getbetajax.php',
		    {
				id:		id,
				type:	"info"
		    },
			function(data)
		    {
				var result = eval("("+data+")");
				var content = "";
				var option_html = "";
				
				content += "<div class=\"bet-info-window\" align=\"center\"><a class=\"bet-descr\">"+result.descr+"</a><br /><br />";
				content += "<table class=\"casino-list casino-window\" width=\"80%\"><thead><tr><td>选项</td><td>赔率</td></tr></thead>";
				if(result.op1_odds != null) {	content += "<tr><td>"+result.op1_descr+"</td><td>"+result.op1_odds+"</td></tr>"; option_html += "<option value=1>"+result.op1_descr+"</option>"; }
				if(result.op2_odds != null) {	content += "<tr><td>"+result.op2_descr+"</td><td>"+result.op2_odds+"</td></tr>"; option_html += "<option value=2>"+result.op2_descr+"</option>"; }
				if(result.op3_odds != null) {	content += "<tr><td>"+result.op3_descr+"</td><td>"+result.op3_odds+"</td></tr>"; option_html += "<option value=3>"+result.op3_descr+"</option>"; }
				if(result.op4_odds != null) {	content += "<tr><td>"+result.op4_descr+"</td><td>"+result.op4_odds+"</td></tr>"; option_html += "<option value=4>"+result.op4_descr+"</option>"; }
				if(result.op5_odds != null) {	content += "<tr><td>"+result.op5_descr+"</td><td>"+result.op5_odds+"</td></tr>"; option_html += "<option value=5>"+result.op5_descr+"</option>"; }
				if(result.op6_odds != null) {	content += "<tr><td>"+result.op6_descr+"</td><td>"+result.op6_odds+"</td></tr>"; option_html += "<option value=6>"+result.op6_descr+"</option>"; }
				if(result.op7_odds != null) {	content += "<tr><td>"+result.op7_descr+"</td><td>"+result.op7_odds+"</td></tr>"; option_html += "<option value=7>"+result.op7_descr+"</option>"; }
				if(result.op8_odds != null) {	content += "<tr><td>"+result.op8_descr+"</td><td>"+result.op8_odds+"</td></tr>"; option_html += "<option value=8>"+result.op8_descr+"</option>"; }
				if(result.op9_odds != null) {	content += "<tr><td>"+result.op9_descr+"</td><td>"+result.op9_odds+"</td></tr>"; option_html += "<option value=9>"+result.op9_descr+"</option>"; }
				content += "</table>";
				
				if(bets_laid.length == 1)
				{
					content += "<table width=\"80%\"><tr align=\"right\" class=\"bet-bets_laid\">已下注</tr></table>";
				}
				else if(result.state == 1)
				{
					content += "<table width=\"80%\" style=\"background: none !important\"><tr align=\"right\"><select class=\"bet-choice\" style=\"width: 150px\">"+option_html+"</select>&nbsp<input class=\"bet-stake\" type\"text\" size=\"5\"/>&nbsp<input class=\"bet-submit\" type=\"button\" value=\"Bet!\" /></tr></table>";
				}
				else if(result.state == 2)
				{
					content += "<table width=\"80%\"><tr align=\"right\" class=\"bet-ended\">已结束</tr></table>";
				}
				else if(result.state == 3)
				{
					content += "<table width=\"80%\"><tr align=\"right\" class=\"bet-stopped\">被管理员冻结</tr></table>";
				}
				else if(result.state == 4)
				{
					content += "<table width=\"80%\"><tr align=\"right\" class=\"bet-paid\">已支付</tr></table></div>";
				}
				else if(result.state == 5)
				{
					content += "<table width=\"80%\"><tr align=\"right\" class=\"bet-push\">走水</tr></table></div>";
				}
				
				var dialog = new Boxy(content, {title: result.title, modal: true, unloadOnHide: true} );
					
				$(".bet-submit").live('click', function() { 
					var choice = $(this).siblings(".bet-choice").val();
					var stake = $(this).siblings(".bet-stake").val();
					
					if( choice >= 1 && choice <= 9 && stake >= 100 )
					{
						$.post(
							'getbetajax.php',
							{
								id: 		id,
								choice:		choice,
								stake:		stake,
								type:		"bet"
							},
							function(data)
							{
								$(".bet-submit").attr("disabled","true");
								$(".bet-submit").die();
								dialog.hide();
								
								var pattern = /\d+/;
								data=pattern.exec(data);
								data=data[0];
																
								switch(data)
								{
									case '403':
									{
										$("#casino-msg").html("<p>请输入合法的数据!\n赌注只能为100到下注限额间的一个数,并且请确认你有足够的魔力值下注.</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
									}
									case '200':
									{
										$("#casino-msg").html("<p>下注成功!</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
									}
									case '301':
									{
										$("#casino-msg").html("<p class=\"bet-error\">你已经下过注!</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
									}
									case '404':
									{
										$("#casino-msg").html("<p class=\"bet-error\">不存在的盘口!</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
									}
									default:
									{
										$("#casino-msg").html("<p class=\"bet-error\">操作失败!</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
									}
								}
							}
						);
					}
					else
					{
						alert("请输入合法的数据!\n赌注至少需要100.");
					}
				});
				$(".close").click( function() { $(".bet-submit").die(); });
			}
		);
		
		return false;
	});
	
	$(".winner").click(function() {
		var id = $(this).attr("value");
		
		$.post(
		    'getbetajax.php',
		    {
				id:		id,
				type:	"winner"
		    },
		    function(data)
		    {
				var result = eval("("+data+")");
				var content = "";
				var option_html = "";
				
				content += "<div class=\"bet-result-window\" align=\"center\"><a class=\"bet-descr\">"+result.descr+"</a><br /><br />";
				content += "<table class=\"casino-list casino-window\" width=\"80%\"><tr><td width=\"50\">结果</td><td>"+result.win_descr+'&nbsp;('+result.comment+')'+"</td></tr>";
				content += "<tr><td width=\"50\">获胜者</td><td  align=\"left\">";
								
				for( var i=0; i < result.winner.length; i++)
				{
					content += "<a href=\"userdetails.php?id="+result.winner[i].user_id+"\">"+result.winner[i].username+"</a>("+result.winner[i].stake+") ";
				}
				content += "</td></tr></table></div>";
				
				var dialog = new Boxy(content, {title: result.title, modal: true, unloadOnHide: true } );
			}
		);
		return false;
	});
	
	$(".add_new_bet, .casino-mod").click(function() {
		var id = $(this).attr("value");
		
		if( id == null )	//add new bet
		{
			var content = "";
			var now = new Date();
			var intYear = now.getYear()+1900;
			var intMonth = now.getMonth()+1;
			var intDate = now.getDate();
			var intHours = now.getHours();
			var intMinutes = now.getMinutes();
			
			if( intMonth < 10) intMonth = '0'+intMonth;
			if( intDate < 10) intDate = '0'+intDate;
			intHours = 23;
			intMinutes = 59;
			var defaultEndTime = intYear+'-'+intMonth+'-'+intDate+' '+intHours+':'+intMinutes;
			
			content += "<div class=\"bet-add-window\" align=\"center\"><table class=\"casino-list casino-window\" style=\"text-align: left !important\" width=\"80%\">";
			content += "<tr><td colspan=\"2\">标题&nbsp;&nbsp;<input type=\"text\" maxlength=\"255\" size=\"60\" id=\"bet-name\"></td></tr>";
			content += "<tr><td colspan=\"2\">简介&nbsp;&nbsp;<input type=\"text\" maxlength=\"255\" size=\"60\" id=\"bet-descr\"></td></tr>";
			content += "<tr><td colspan=\"2\">结束时间&nbsp;&nbsp;<input type=\"text\" id=\"bet-end-time\" value=\""+defaultEndTime+"\" autocomplete=\"off\" maxlength=\"40\" size=\"25\" ></td></tr>";
			content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.1 <input type=\"text\" id=\"op1\" maxlength=\"255\" size=\"35\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op1-odds\"></td></tr>";
			content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.2 <input type=\"text\" id=\"op2\" maxlength=\"255\" size=\"35\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op2-odds\"></td></tr>";
			content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.3 <input type=\"text\" id=\"op3\" maxlength=\"255\" size=\"35\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op3-odds\"></td></tr>";
			content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.4 <input type=\"text\" id=\"op4\" maxlength=\"255\" size=\"35\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op4-odds\"></td></tr>";
			content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.5 <input type=\"text\" id=\"op5\" maxlength=\"255\" size=\"35\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op5-odds\"></td></tr>";
			content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.6 <input type=\"text\" id=\"op6\" maxlength=\"255\" size=\"35\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op6-odds\"></td></tr>";
			content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.7 <input type=\"text\" id=\"op7\" maxlength=\"255\" size=\"35\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op7-odds\"></td></tr>";
			content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.8 <input type=\"text\" id=\"op8\" maxlength=\"255\" size=\"35\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op8-odds\"></td></tr>";
			content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.9 <input type=\"text\" id=\"op9\" maxlength=\"255\" size=\"35\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op9-odds\"></td></tr>";
			content += "<tr><td></td><td><input class=\"add-bet\" type=\"button\" value=\"Add\" /></td></tr>";
			content += "</table></div>";
			
			var dialog = new Boxy(content, {title: "添加盘口", modal: true, unloadOnHide: true, afterHide: function(){ window.location.href='casino.php#tabs-5'; window.location.reload(); }} );
			
			$(".add-bet").live('click', function() {
			
				var title = $("#bet-name").val();
				var descr = $("#bet-descr").val();
				var end_time = $("#bet-end-time").val();
				var op1 = $("#op1").val();
				var op1_odds = $("#op1-odds").val();
				var op2 = $("#op2").val();
				var op2_odds = $("#op2-odds").val();
				var op3 = $("#op3").val();
				var op3_odds = $("#op3-odds").val();
				var op4 = $("#op4").val();
				var op4_odds = $("#op4-odds").val();
				var op5 = $("#op5").val();
				var op5_odds = $("#op5-odds").val();
				var op6 = $("#op6").val();
				var op6_odds = $("#op6-odds").val();
				var op7 = $("#op7").val();
				var op7_odds = $("#op7-odds").val();
				var op8 = $("#op8").val();
				var op8_odds = $("#op8-odds").val();
				var op9 = $("#op9").val();
				var op9_odds = $("#op9-odds").val();
				
				$.post(
					'getbetajax.php',
					{
						type:		"add",
						title:		title,
						descr:		descr,
						end_time:	end_time,
						op1:		op1,
						op1_odds:	op1_odds,
						op2:		op2,
						op2_odds:	op2_odds,
						op3:		op3,
						op3_odds:	op3_odds,
						op4:		op4,
						op4_odds:	op4_odds,
						op5:		op5,
						op5_odds:	op5_odds,
						op6:		op6,
						op6_odds:	op6_odds,
						op7:		op7,
						op7_odds:	op7_odds,
						op8:		op8,
						op8_odds:	op8_odds,
						op9:		op9,
						op9_odds:	op9_odds
					},
					function(data)
					{
						$(".add-bet").attr("disabled","true");
						$(".add-bet").die();
						dialog.hide();
						
						var pattern = /\d+/;
						data=pattern.exec(data);
						data=data[0];
						
						switch(data)
						{
							case '200':
							{
								$("#casino-msg").html("<p>添加成功!</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
							}
							default:
							{
								$("#casino-msg").html("<p class=\"bet-error\">操作失败!</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
							}
						}
						
					}
				);
			});
		}
		else	// mod existed lottery
		{
			$.post(
				'getbetajax.php',
				{
					id:		id,
					type:	"info"
				},
				function(data)
				{
					var content = "";
					var result = eval("("+data+")");
					var checked = "";
					
					if( result.state == 3 )
					{
						checked = "checked=\"checked\"";
					}
					
					content += "<div class=\"bet-mod-window\" align=\"center\"><table class=\"casino-list casino-window\" style=\"text-align: left !important\" width=\"80%\">";
					content += "<tr><td colspan=\"2\">标题&nbsp;&nbsp;<input type=\"text\" maxlength=\"255\" size=\"60\" id=\"bet-name\" value=\""+result.title+"\"></td></tr>";
					content += "<tr><td colspan=\"2\">简介&nbsp;&nbsp;<input type=\"text\" maxlength=\"255\" size=\"60\" id=\"bet-descr\" value=\""+result.descr+"\"></td></tr>";
					content += "<tr><td colspan=\"2\">冻结&nbsp;&nbsp;<input type=\"checkbox\" maxlength=\"1\" size=\"2\" id=\"bet-stop\" "+checked+"></td></tr>";
					content += "<tr><td colspan=\"2\">清盘消息&nbsp;&nbsp;<input type=\"text\" maxlength=\"255\" size=\"56\" id=\"bet-comment\" value=\""+result.comment+"\"></td></tr>";
					content += "<tr><td colspan=\"2\">结束时间&nbsp;&nbsp;<input type=\"text\" id=\"bet-end-time\" value=\""+result.end_time+"\" autocomplete=\"off\" maxlength=\"40\" size=\"25\" ></td></tr>";
					content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.1 <input type=\"text\" id=\"op1\" maxlength=\"255\" size=\"35\" value=\""+result.op1_descr+"\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op1-odds\" value=\""+result.op1_odds+"\"></td></tr>";
					content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.2 <input type=\"text\" id=\"op2\" maxlength=\"255\" size=\"35\" value=\""+result.op2_descr+"\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op2-odds\" value=\""+result.op2_odds+"\"></td></tr>";
					content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.3 <input type=\"text\" id=\"op3\" maxlength=\"255\" size=\"35\" value=\""+result.op3_descr+"\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op3-odds\" value=\""+result.op3_odds+"\"></td></tr>";
					content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.4 <input type=\"text\" id=\"op4\" maxlength=\"255\" size=\"35\" value=\""+result.op4_descr+"\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op4-odds\" value=\""+result.op4_odds+"\"></td></tr>";
					content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.5 <input type=\"text\" id=\"op5\" maxlength=\"255\" size=\"35\" value=\""+result.op5_descr+"\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op5-odds\" value=\""+result.op5_odds+"\"></td></tr>";
					content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.6 <input type=\"text\" id=\"op6\" maxlength=\"255\" size=\"35\" value=\""+result.op6_descr+"\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op6-odds\" value=\""+result.op6_odds+"\"></td></tr>";
					content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.7 <input type=\"text\" id=\"op7\" maxlength=\"255\" size=\"35\" value=\""+result.op7_descr+"\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op7-odds\" value=\""+result.op7_odds+"\"></td></tr>";
					content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.8 <input type=\"text\" id=\"op8\" maxlength=\"255\" size=\"35\" value=\""+result.op8_descr+"\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op8-odds\" value=\""+result.op8_odds+"\"></td></tr>";
					content += "<tr><td class=\"bet-options\" width=\"75%\">选项 No.9 <input type=\"text\" id=\"op9\" maxlength=\"255\" size=\"35\" value=\""+result.op9_descr+"\"></td><td class=\"bet-options-odds\">赔率 <input type=\"text\" maxlength=\"4\" size=\"2\" id=\"op9-odds\" value=\""+result.op9_odds+"\"></td></tr>";
					content += "<tr align=\"right\"><td colspan=\"2\"><input class=\"delete-bet\" type=\"button\" value=\"Delete\" />&nbsp;&nbsp;&nbsp;<input class=\"update-bet\" type=\"button\" value=\"Update\" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td></tr>";
					content += "</table></div>";

					var dialog = new Boxy(content, {title: "修改盘口", modal: true, unloadOnHide: true, afterHide: function(){ window.location.href='casino.php#tabs-5'; window.location.reload(); }} );

					$(".delete-bet").live('click', function() {
						$.post(
							'getbetajax.php',
							{
								type:		"mod",
								id:			id,
								del:		id
							},
							function(data)
							{
								$(".delete-bet").attr("disabled","true");
								$(".delete-bet").die();
								dialog.hide();
								
								var pattern = /\d+/;
								data=pattern.exec(data);
								data=data[0];
								
								switch(data)
								{
									case '200':
									{
										$("#casino-msg").html("<p>删除成功!</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
									}
									case '403':
									{
										$("#casino-msg").html("<p class=\"bet-error\">不存在的盘口!</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
									}
									default:
									{
										$("#casino-msg").html("<p class=\"bet-error\">操作失败!</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
									}
								}	
							}
						);
					});
					
					$(".update-bet").live('click', function() {
					
						var title = $("#bet-name").val();
						var descr = $("#bet-descr").val();
						var end_time = $("#bet-end-time").val();
						var is_stop = $("#bet-stop").attr("checked");
						var comment = $("#bet-comment").val()
						var op1 = $("#op1").val();
						var op1_odds = $("#op1-odds").val();
						var op2 = $("#op2").val();
						var op2_odds = $("#op2-odds").val();
						var op3 = $("#op3").val();
						var op3_odds = $("#op3-odds").val();
						var op4 = $("#op4").val();
						var op4_odds = $("#op4-odds").val();
						var op5 = $("#op5").val();
						var op5_odds = $("#op5-odds").val();
						var op6 = $("#op6").val();
						var op6_odds = $("#op6-odds").val();
						var op7 = $("#op7").val();
						var op7_odds = $("#op7-odds").val();
						var op8 = $("#op8").val();
						var op8_odds = $("#op8-odds").val();
						var op9 = $("#op9").val();
						var op9_odds = $("#op9-odds").val();
						
						$.post(
							'getbetajax.php',
							{
								type:		"mod",
								id:			id,
								title:		title,
								descr:		descr,
								is_stop:	is_stop,
								end_time:	end_time,
								comment:	comment,
								op1:		op1,
								op1_odds:	op1_odds,
								op2:		op2,
								op2_odds:	op2_odds,
								op3:		op3,
								op3_odds:	op3_odds,
								op4:		op4,
								op4_odds:	op4_odds,
								op5:		op5,
								op5_odds:	op5_odds,
								op6:		op6,
								op6_odds:	op6_odds,
								op7:		op7,
								op7_odds:	op7_odds,
								op8:		op8,
								op8_odds:	op8_odds,
								op9:		op9,
								op9_odds:	op9_odds
							},
							function(data)
							{
								$(".update-bet").attr("disabled","true");
								$(".update-bet").die();
								dialog.hide();
								
								var pattern = /\d+/;
								data=pattern.exec(data);
								data=data[0];
																								
								switch(data)
								{
									case '200':
									{
										$("#casino-msg").html("<p>修改成功!</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
									}
									default:
									{
										$("#casino-msg").html("<p class=\"bet-error\">操作失败!</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
									}
								}
							}
						);
					});
				}
			);
		}
		
		$(".close").click( function() { $(".add-bet").die(); });
		$(".update-bet").die();
		$(".delete-bet").die();
		
		return false;
	});
	
	$(".casino-pedding").click(function() {
		var id = $(this).attr("value");
		
		$.post(
		    'getbetajax.php',
		    {
				id:		id,
				type:	"info"
		    },
			function(data)
		    {
				var result = eval("("+data+")");
				var content = "";
				var option_html = "";
				
				content += "<div class=\"bet-info-window\" align=\"center\"><a class=\"bet-descr\">"+result.descr+"</a><br /><br />";
				content += "<table class=\"casino-list casino-window\" width=\"80%\"><thead><tr><td>选项</td><td>赔率</td></tr></thead>";
				if(result.op1_odds != null) {	content += "<tr><td>"+result.op1_descr+"</td><td>"+result.op1_odds+"</td></tr>"; option_html += "<option value=1>"+result.op1_descr+"</option>"; }
				if(result.op2_odds != null) {	content += "<tr><td>"+result.op2_descr+"</td><td>"+result.op2_odds+"</td></tr>"; option_html += "<option value=2>"+result.op2_descr+"</option>"; }
				if(result.op3_odds != null) {	content += "<tr><td>"+result.op3_descr+"</td><td>"+result.op3_odds+"</td></tr>"; option_html += "<option value=3>"+result.op3_descr+"</option>"; }
				if(result.op4_odds != null) {	content += "<tr><td>"+result.op4_descr+"</td><td>"+result.op4_odds+"</td></tr>"; option_html += "<option value=4>"+result.op4_descr+"</option>"; }
				if(result.op5_odds != null) {	content += "<tr><td>"+result.op5_descr+"</td><td>"+result.op5_odds+"</td></tr>"; option_html += "<option value=5>"+result.op5_descr+"</option>"; }
				if(result.op6_odds != null) {	content += "<tr><td>"+result.op6_descr+"</td><td>"+result.op6_odds+"</td></tr>"; option_html += "<option value=6>"+result.op6_descr+"</option>"; }
				if(result.op7_odds != null) {	content += "<tr><td>"+result.op7_descr+"</td><td>"+result.op7_odds+"</td></tr>"; option_html += "<option value=7>"+result.op7_descr+"</option>"; }
				if(result.op8_odds != null) {	content += "<tr><td>"+result.op8_descr+"</td><td>"+result.op8_odds+"</td></tr>"; option_html += "<option value=8>"+result.op8_descr+"</option>"; }
				if(result.op9_odds != null) {	content += "<tr><td>"+result.op9_descr+"</td><td>"+result.op9_odds+"</td></tr>"; option_html += "<option value=9>"+result.op9_descr+"</option>"; }
				content += "</table>";
				content += "<table width=\"80%\"><tr align=\"right\"><select class=\"bet-win\" style=\"width: 100px\">"+option_html+"</select>&nbsp;<input class=\"bet-comment\" type=\"text\" size=\"15\" maxlength=\"255\"/>&nbsp;<input class=\"bet-clear\" type=\"button\" value=\"Clear!\" />&nbsp;<input class=\"bet-handicap-push\" type=\"button\" value=\"Push!\" /></tr></table></div>";
				
				var dialog = new Boxy(content, {title: result.title, modal: true, unloadOnHide: true, unloadOnHide: true, afterHide: function(){ window.location.href='casino.php#tabs-5'; window.location.reload(); }} );
								
				$(".bet-clear").live('click', function() { 
					var win = $(this).siblings(".bet-win").val();
					var comment = $(this).siblings(".bet-comment").val();
					
					$.post(
						'getbetajax.php',
						{
							id: 		id,
							win:		win,
							comment:	comment,
							type:		"pedding"
						},
						function(data)
						{
							$(".bet-clear").attr("disabled","true");
							$(".bet-clear").die();
							dialog.hide();
							
							var pattern = /\d+/;
							data=pattern.exec(data);
							data=data[0];
							
							switch(data)
							{
								case '200':
								{
									$("#casino-msg").html("<p>清盘成功!</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
								}
								default:
								{
									$("#casino-msg").html("<p class=\"bet-error\">操作失败!</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
								}
							}
						}
					);
				});
				
				$(".bet-handicap-push").live('click', function() {
					var comment = $(this).siblings(".bet-comment").val();
					
					$.post(
						'getbetajax.php',
						{
							id: 		id,
							push:		id,
							comment:	comment,
							type:		"pedding"
						},
						function(data)
						{
							$(".bet-push").attr("disabled","true");
							$(".bet-push").die();
							dialog.hide();
							
							var pattern = /\d+/;
							data=pattern.exec(data);
							data=data[0];
							
							switch(data)
							{
								case '200':
								{
									$("#casino-msg").html("<p>清盘成功!</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
								}
								default:
								{
									$("#casino-msg").html("<p class=\"bet-error\">操作失败!</p>").hide().slideToggle("slow").delay(2000).slideToggle("slow"); break;
								}
							}
						}
					);
				});
			}
		);
		
		$(".bet-clear").die();
		$(".bet-handicap-push").die();
		
		return false;
	});
	
	$(".casino-view").click(function() {
		var id = $(this).attr("value");
		
		$.post(
		    'getbetajax.php',
		    {
				id:		id,
				type:	"view"
		    },
		    function(data)
		    {
				var result = eval("("+data+")");
				var content = "<div class=\"bet-result-window\" align=\"center\">";
				var option_html = "";
				
				content += "<div><a class=\"bet-descr\">"+result.descr+"</a><br /><br />";
				content += "<table class=\"casino-list casino-window\"><tr><td colspan=\"2\"></td></tr><tr><td width=\"50\">下注者</td><td  align=\"left\">";
								
				for( var i=0; i < result.gambler.length; i++)
				{
					content += "<a href=\"userdetails.php?id="+result.gambler[i].user_id+"\">"+result.gambler[i].username+"</a>("+result.gambler[i].choice+", "+result.gambler[i].stake+", "+result.gambler[i].odds+") ";
				}
				content += "</td></tr></table></div>";
				
				var dialog = new Boxy(content, {title: result.title, modal: true, unloadOnHide: true } );
			}
		);
		
		return false;
	});
	return false;
}); 

});
