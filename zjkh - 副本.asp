<!--#include file="Config/Conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<!--#include file="checktec.asp" -->

<%
	Set Rsq = Server.CreateObject("Adodb.RecordSet")
	Sqlq = "select * from sorcezjkh where StuCode='"&CodeID&"'"
	Rsq.Open Sqlq,Conn,1,1
	if not (Rsq.eof or Rsq.bof) then
	Response.Write("<Script>alert('你已评分，无需再次评分！');top.window.location.href='teclogin.asp';</Script>")
	Response.End()
	end if
	Rsq.Close:Set Rsq=Nothing
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "select * from userreg1 where Code='"&CodeID&"'"
	Rs.Open Sql,Conn,1,1
	if not (Rs.Eof or Rs.Bof) then
	ISxz=Rs("ISxz")
	end if
	Rs.Close:Set Rs=Nothing
	
	action=Request("action")
	TecCount1 = cint(Request("teamCount0"))+cint(Request("teamCount1"))+cint(Request("teamCount2"))+cint(Request("teamCount3"))+cint(Request("teamCount4"))+cint(Request("teamCount5"))+cint(Request("teamCount6"))
	if action="submitup" then
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "select * from sorcezjkh"
	Rs.Open Sql,Conn,1,3
	for j=1 to cint(TecCount1)
	TecCode = Request("code"&j)
	StuCode = CodeID
	TecSorce = Request("radio"&j)
	Content = Request("textarea"&j)
	
	Rs.Addnew
	Rs("TecCode")=TecCode
	Rs("StuCode")=StuCode
	Rs("TecSorce")=TecSorce
	Rs("Content")=Content
	Rs("ISXZ")=ISxz
	Rs("SorceType")="3"
	Rs("PostTime")=now()
	Rs.Update
	next
	Rs.Close:Set Rs=Nothing
	Response.Write("<script>alert('提交成功');window.location.href='tecchoose.asp';</script>")
	Response.End()
	end if	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%=SiteKeysTitle("专技年度考核")%>
<link rel="stylesheet" href="css/Global.css" />
<link rel="stylesheet" href="css/Base.css" />
<script type="text/javascript" src="js/jquery180min.js"></script>

</head>

<body>
<!--#include file="top.asp" -->
<div class="container">
  <div class="class">
  <form action="?action=submitup" name="form1" method="post" onsubmit="return check()">
	
    <table width="892" border="1" cellpadding="0" cellspacing="0" id="teclist">
      <tr>
        <td width="36" rowspan="2" valign="middle" bgcolor="#FFFFFF"><p align="center">序号 </p></td>
        <td width="66" rowspan="2" valign="middle" bgcolor="#FFFFFF"><p align="center">姓名 </p></td>
        <td width="66" rowspan="2" valign="middle" bgcolor="#FFFFFF"><p align="center">任教年级 </p></td>
        <td width="135" rowspan="2" valign="middle" bgcolor="#FFFFFF"><p align="center">任教学科 （担任工作） </p></td>
        <td colspan="3" valign="top" bgcolor="#FFFFFF"><p align="center">专技年度考核 </p></td>
        <td width="220" rowspan="2" valign="middle" bgcolor="#FFFFFF"><p align="center">备注 </p></td>
      </tr>
      <tr>
        <td width="87" valign="top" bgcolor="#FFFFFF"><p align="center">优职<a href="javascript:checkall(100)">(全选)</a></p></td>
        <td width="87" valign="top" bgcolor="#FFFFFF"><p align="center">称职<a href="javascript:checkall(80)">(全选)</a></p></td>
        <td width="87" valign="top" bgcolor="#FFFFFF"><p align="center">不称职<a href="javascript:checkall(60)">(全选)</a></p></td>
        </tr>
      </table>
      
      <!-- 行政组 -->
      <table width="892" border="1" cellpadding="0" cellspacing="0" id="team0">
		<%
			Set Rs=server.CreateObject("adodb.recordset")
			sql = "select * from userreg1 where ISxz='是' order by code"
			Rs.Open Sql,Conn,1,1
			if not Rs.Eof then
			teamCount0 = Rs.RecordCount
        %>
      	<tr>
        <td colspan="8" align="left" valign="middle" class="pl10"><strong>行政组 </strong><span style="font:normal;font-size:16px;color:black">(必选“优职” <%=Round(teamCount0*0.2)%> 人)</span><input type="hidden" name="teamCount0" value="<%=teamCount0%>" /></td>
        </tr>
      <%
	  	i=1
		do while not Rs.Eof
	  %>
      <tr onmousemove="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
        <td width="36" align="center" valign="middle"><p><%=i%><input type="hidden" name="Code<%=i%>" value="<%=Rs("Code")%>" /></p></td>
        <td width="66" align="center" valign="middle"><p><%=Rs("UserName")%></p></td>
        <td width="66" align="center" valign="middle"><p><%=Rs("Grade")%>&nbsp;</p></td>
        <td width="135" align="center" valign="middle"><p><%=Rs("Subject")%>&nbsp;</p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa1<%=i%>" value="100" /></p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa2<%=i%>" value="80" /></p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa3<%=i%>" value="60" /></p></td>
        <td width="220" align="center" valign="middle"><textarea name="textarea<%=i%>" id="textarea" rows="3" style="width:219px;"></textarea></td>
      </tr>
      <%
	  	i=i+1
		Rs.MoveNext
		Loop
		end if
		Rs.Close:Set Rs=Nothing
	  %>
      </table>
      <!-- 语文组 -->
      <table width="892" border="1" cellpadding="0" cellspacing="0" id="team1">
      	<%
			Set Rs=server.CreateObject("adodb.recordset")
			sql = "select * from userreg1 where ISxz='否' and campus='九山' and Subject='语文' order by code"
			Rs.Open Sql,Conn,1,1
			if not Rs.Eof then
			teamCount1 = Rs.RecordCount
        %>
      	<tr>
        <td colspan="8" align="left" valign="middle" class="pl10"><strong>语文组 </strong><span style="font:normal;font-size:16px;color:black">(必选“优职” <%=Round(teamCount1*0.2)%> 人)</span><input type="hidden" name="teamCount1" value="<%=teamCount1%>" /></td>
        </tr>
      <%
		do while not Rs.Eof
	  %>
      <tr onmousemove="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
        <td width="36" align="center" valign="middle"><p><%=i%><input type="hidden" name="Code<%=i%>" value="<%=Rs("Code")%>" /></p></td>
        <td width="66" align="center" valign="middle"><p><%=Rs("UserName")%></p></td>
        <td width="66" align="center" valign="middle"><p><%=Rs("Grade")%>&nbsp;</p></td>
        <td width="135" align="center" valign="middle"><p><%=Rs("Subject")%>&nbsp;</p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa1<%=i%>" value="100" /></p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa2<%=i%>" value="80" /></p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa3<%=i%>" value="60" /></p></td>
        <td width="220" align="center" valign="middle"><textarea name="textarea<%=i%>" id="textarea" rows="3" style="width:219px;"></textarea></td>
      </tr>
      <%
	  	i=i+1
		Rs.MoveNext
		Loop
		end if
		Rs.Close:Set Rs=Nothing
	  %>
      </table>
      <!-- 数学组 -->
      <table width="892" border="1" cellpadding="0" cellspacing="0" id="team2">
      	<%
			Set Rs=server.CreateObject("adodb.recordset")
			sql = "select * from userreg1 where ISxz='否' and campus='九山' and Subject='数学' order by code"
			Rs.Open Sql,Conn,1,1
			if not Rs.Eof then
			teamCount2 = Rs.RecordCount
        %>
      	<tr>
        <td colspan="8" align="left" valign="middle" class="pl10"><strong>数学组 </strong><span style="font:normal;font-size:16px;color:black">(必选“优职” <%=Round(teamCount2*0.2)%> 人)</span><input type="hidden" name="teamCount2" value="<%=teamCount2%>" /></td>
        </tr>
      <%
		do while not Rs.Eof
	  %>
      <tr onmousemove="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
        <td width="36" align="center" valign="middle"><p><%=i%><input type="hidden" name="Code<%=i%>" value="<%=Rs("Code")%>" /></p></td>
        <td width="66" align="center" valign="middle"><p><%=Rs("UserName")%></p></td>
        <td width="66" align="center" valign="middle"><p><%=Rs("Grade")%>&nbsp;</p></td>
        <td width="135" align="center" valign="middle"><p><%=Rs("Subject")%>&nbsp;</p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa1<%=i%>" value="100" /></p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa2<%=i%>" value="80" /></p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa3<%=i%>" value="60" /></p></td>
        <td width="220" align="center" valign="middle"><textarea name="textarea<%=i%>" id="textarea" rows="3" style="width:219px;"></textarea></td>
      </tr>
      <%
	  	i=i+1
		Rs.MoveNext
		Loop
		end if
		Rs.Close:Set Rs=Nothing
	  %>
      </table>
      <!-- 英语组 -->
      <table width="892" border="1" cellpadding="0" cellspacing="0" id="team3">
      	<%
			Set Rs=server.CreateObject("adodb.recordset")
			sql = "select * from userreg1 where ISxz='否' and campus='九山' and Subject='英语' order by code"
			Rs.Open Sql,Conn,1,1
			if not Rs.Eof then
			teamCount3 = Rs.RecordCount
        %>
      	<tr>
        <td colspan="8" align="left" valign="middle" class="pl10"><strong>英语组 </strong><span style="font:normal;font-size:16px;color:black">(必选“优职” <%=Round(teamCount3*0.2)%> 人)</span><input type="hidden" name="teamCount3" value="<%=teamCount3%>" /></td>
        </tr>
      <%
		do while not Rs.Eof
	  %>
      <tr onmousemove="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
        <td width="36" align="center" valign="middle"><p><%=i%><input type="hidden" name="Code<%=i%>" value="<%=Rs("Code")%>" /></p></td>
        <td width="66" align="center" valign="middle"><p><%=Rs("UserName")%></p></td>
        <td width="66" align="center" valign="middle"><p><%=Rs("Grade")%>&nbsp;</p></td>
        <td width="135" align="center" valign="middle"><p><%=Rs("Subject")%>&nbsp;</p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa1<%=i%>" value="100" /></p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa2<%=i%>" value="80" /></p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa3<%=i%>" value="60" /></p></td>
        <td width="220" align="center" valign="middle"><textarea name="textarea<%=i%>" id="textarea" rows="3" style="width:219px;"></textarea></td>
      </tr>
      <%
	  	i=i+1
		Rs.MoveNext
		Loop
		end if
		Rs.Close:Set Rs=Nothing
	  %>
      </table>
      <!-- 综合组 -->
      <table width="892" border="1" cellpadding="0" cellspacing="0" id="team4">
      	<%
			Set Rs=server.CreateObject("adodb.recordset")
			sql = "select * from userreg1 where ISxz='否' and campus='九山' and Subject in ('科学','音乐','美术','体育','心理健康','信息技术','网络管理','国际象棋') order by Subject"
			Rs.Open Sql,Conn,1,1
			if not Rs.Eof then
			teamCount4 = Rs.RecordCount
        %>
      	<tr>
        <td colspan="8" align="left" valign="middle" class="pl10"><strong>综合组 </strong><span style="font:normal;font-size:16px;color:black">(必选“优职” <%=Round(teamCount4*0.2)%> 人)</span><input type="hidden" name="teamCount4" value="<%=teamCount4%>" /></td>
        </tr>
      <%
		do while not Rs.Eof
	  %>
      <tr onmousemove="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
        <td width="36" align="center" valign="middle"><p><%=i%><input type="hidden" name="Code<%=i%>" value="<%=Rs("Code")%>" /></p></td>
        <td width="66" align="center" valign="middle"><p><%=Rs("UserName")%></p></td>
        <td width="66" align="center" valign="middle"><p><%=Rs("Grade")%>&nbsp;</p></td>
        <td width="135" align="center" valign="middle"><p><%=Rs("Subject")%>&nbsp;</p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa1<%=i%>" value="100" /></p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa2<%=i%>" value="80" /></p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa3<%=i%>" value="60" /></p></td>
        <td width="220" align="center" valign="middle"><textarea name="textarea<%=i%>" id="textarea" rows="3" style="width:219px;"></textarea></td>
      </tr>
      <%
	  	i=i+1
		Rs.MoveNext
		Loop
		end if
		Rs.Close:Set Rs=Nothing
	  %>
      </table>
      <!-- 国际部 -->
      <table width="892" border="1" cellpadding="0" cellspacing="0" id="team5">
      	<%
			Set Rs=server.CreateObject("adodb.recordset")
			sql = "select * from userreg1 where ISxz='否' and campus='国际' order by code"
			Rs.Open Sql,Conn,1,1
			if not Rs.Eof then
			teamCount5 = Rs.RecordCount
        %>
      	<tr>
        <td colspan="8" align="left" valign="middle" class="pl10"><strong>国际部 </strong><span style="font:normal;font-size:16px;color:black">(必选“优职” <%=Round(teamCount5*0.2)%> 人)</span><input type="hidden" name="teamCount5" value="<%=teamCount5%>" /></td>
        </tr>
      <%
		do while not Rs.Eof
	  %>
      <tr onmousemove="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
        <td width="36" align="center" valign="middle"><p><%=i%><input type="hidden" name="Code<%=i%>" value="<%=Rs("Code")%>" /></p></td>
        <td width="66" align="center" valign="middle"><p><%=Rs("UserName")%></p></td>
        <td width="66" align="center" valign="middle"><p><%=Rs("Grade")%>&nbsp;</p></td>
        <td width="135" align="center" valign="middle"><p><%=Rs("Subject")%>&nbsp;</p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa1<%=i%>" value="100" /></p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa2<%=i%>" value="80" /></p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa3<%=i%>" value="60" /></p></td>
        <td width="220" align="center" valign="middle"><textarea name="textarea<%=i%>" id="textarea" rows="3" style="width:219px;"></textarea></td>
      </tr>
      <%
	  	i=i+1
		Rs.MoveNext
		Loop
		end if
		Rs.Close:Set Rs=Nothing
	  %>
      </table>
      
      <!-- 后勤组 -->
      <table width="892" border="1" cellpadding="0" cellspacing="0" id="team6">
      	<%
			Set Rs=server.CreateObject("adodb.recordset")
			sql = "select * from userreg1 where ISxz='否' and campus='九山' and Subject in ('文员','校医','档案管理','财务','图书馆','后勤') order by code"
			Rs.Open Sql,Conn,1,1
			if not Rs.Eof then
			teamCount6 = Rs.RecordCount
        %>
      	<tr>
        <td colspan="8" align="left" valign="middle" class="pl10"><strong>后勤组 </strong><span style="font:normal;font-size:16px;color:black">(必选“优职” <%=Round(teamCount6*0.2)%> 人)</span><input type="hidden" name="teamCount6" value="<%=teamCount6%>" /></td>
        </tr>
      <%
		do while not Rs.Eof
	  %>
      <tr onmousemove="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
        <td width="36" align="center" valign="middle"><p><%=i%><input type="hidden" name="Code<%=i%>" value="<%=Rs("Code")%>" /></p></td>
        <td width="66" align="center" valign="middle"><p><%=Rs("UserName")%></p></td>
        <td width="66" align="center" valign="middle"><p><%=Rs("Grade")%>&nbsp;</p></td>
        <td width="135" align="center" valign="middle"><p><%=Rs("Subject")%>&nbsp;</p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa1<%=i%>" value="100" /></p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa2<%=i%>" value="80" /></p></td>
        <td width="87" align="center" valign="middle"><p><input type="radio" name="radio<%=i%>" id="radioa3<%=i%>" value="60" /></p></td>
        <td width="220" align="center" valign="middle"><textarea name="textarea<%=i%>" id="textarea" rows="3" style="width:219px;"></textarea></td>
      </tr>
      <%
	  	i=i+1
		Rs.MoveNext
		Loop
		end if
		Rs.Close:Set Rs=Nothing
	  %>
    </table>
<table width="892" border="0" cellspacing="0" cellpadding="0">
  <tr>
        <td height="40" align="center"><input type="submit" name="button" id="button" value="提交" style="width:60px;height:30px;cursor:pointer;" /></td>
      </tr>
  </table>
    </form>
  </div>
</div>
<div class="footer">
	<div class="footer_cnt">温州市籀园小学 版权所有 Copyright © 2012-2013 wzssx.net All rights reserved</div>
</div>
<script type="text/javascript">
$(function() {
	checkall(80);
	$(".class table[id^='team'] tr td").click(
		function(event){
		$(this).find(":radio").click(function(event){event.stopPropagation();}).trigger("click");
	});
})
function checkall(value) {
	$(".class input[type='radio']").each(function(i, v) {
        if ($(v).val() == value) {
			$(v).attr("checked","checked");
		}
    });
}
function check() {
	
	var rlt = true;
	var txt = "";
	var moretxt = "";
	$(".class table[id^='team']").each(function(i, v) {
		var tname = $(v).children().children("tr:eq(0)").find("strong").html();
        var tcount = $(v).children().children().length-1;
		var good_count1 = Math.round(tcount*0.2);
		var choose_c = $(v).find("input[name*='radio']:checked").length;
		var good_count2 = $(v).find("input[name*='radio'][value='100']:checked").length;
		if (good_count2 > good_count1) {
			moretxt = "多选了 " + (good_count2 - good_count1) + "人";
		}
		if (good_count2 < good_count1) {
			moretxt = "少选了 " + (good_count1 - good_count2) + "人";
		}
		//console.log(tcount + '-----' + good_count1 + '\n\n');
		if (choose_c < tcount || good_count2 != good_count1) {
			txt += tname + " 共 " + tcount + " 人 ,已选择 " + choose_c + " 人，应选择 '优职' " + good_count1 + " 人，实选 " + good_count2 + "人," + moretxt + "\n\n";
			rlt = false;
		}
    });
	if (rlt == false) {
		alert(txt);
		return rlt;
	}
	else {
		return rlt;
	}
}
</script>
</body>
</html>
