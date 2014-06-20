<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
	Action=ReplaceBadChar(Trim(Request("Action")))
	ID=ReplaceBadChar(Trim(Request("ID")))
	Page=ReplaceBadChar(Trim(Request("Page")))
	If Action="Save" Then
		SetExperID=ReplaceBadChar(Trim(Request("ID")))
		SetExperiSats = ReplaceBadChar(Trim(Request("SetExperiSats")))
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql = "Select * From ctsy"
		Rs.Open Sql,Conn,1,3
		Rs.AddNew
		if not (Rs.Eof or Rs.Bof) then
		Rs("SetExperID")=SetExperID
		Rs("SetExperiStatus") = 0
		Rs("SetExperiSats") = SetExperiSats
		Rs("UserName") = UserName
		Rs("SetExperCount") = Rs("SetExperCount") + 1
		Rs("SetExperTime")=now()
		Rs.Update
		end if
		Rs.Close:Set Rs=Nothing
		Response.Write("<script>alert('申请成功');window.location.href='Setsexperiments_app.asp?&Page="&Page&"';</script>")
	Response.End()
	end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/jquery162min.js"></script>
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
<link href="Style/PopCalender.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(function(){
	$("#instru_table tr").bind({
	  mouseenter:function(){$(this).css("background-color","#bdbdbd");},  
	  mouseleave:function(){$(this).css("background-color","");}  
	});
	
	$("input[type='radio']").change(function(){
		var atype = $(this).val();
		var _ID = <%=ID%>;
		$.ajax({
		type:"POST",
		dataType: "html",
		url:"ajax.asp",
		data:"Action=" + atype + "&ID=" + _ID + "&Time=" + (new Date().getTime()),
		error: function(){
				alert("数据库链接错误");
			},
		success: function(d){
				
				}
		})
	})
})

</script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：实验管理 >> 成套实验详情</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">&nbsp;</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<form name="formsave" method="post" action="?action=Save">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td colspan="4" align="left" valign="middle"><input type="button" value="返回" class="Button" onclick="history.back();" /></td>
</tr>
<tr>
<th colspan="4">成套实验清单：</th>
</tr>
<tr>
  <td colspan="4" class="Right">
  <%
  	ID = ReplaceBadChar(Trim(Request("ID")))
  	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * From SetsExperiments where ID="&ID
	Rs.Open Sql,Conn,1,1
	if not (Rs.Eof or Rs.Bof) then
  %>
  
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
  <TBODY>
<TR>
  <TD colSpan=6>
  <DIV align=left>学科:
  <%
  	if GetUserInfo(UserName,"subject")="s1" then
	Response.Write("物理")
	elseif GetUserInfo(UserName,"subject")="s2" then
	Response.Write("化学")
	elseif GetUserInfo(UserName,"subject")="s3" then
	Response.Write("生物")
	end if
  %></DIV></TD></TR>
<TR>
<TD width="15%">实验名称:</TD>
<TD colSpan=3><%=Rs("ExperiTitle")%></TD>
<TD width="20%">实验类型:</TD>
<TD width="20%">
<% if Rs("ExperiType") ="1" then 
	Response.Write("课堂演示实验") 
	elseif Rs("ExperiType") ="2" then 
	Response.Write("学生分组实验")
   end if%></TD></TR>
<TR>
<TD colSpan=4>实验器材详单:</TD>
<TD>申请日期:</TD>
<TD><%=Right(Year(Rs("ExperiTime")),4)&"-"&Right("0"&Month(Rs("ExperiTime")),2)&"-"&Right("0"&Day(Rs("ExperiTime")),2)%></TD></TR>
<TR>
  <TD colSpan=6>
  <TABLE width="99%" id="instru_table">
  <TBODY>
  <%
	instru_char = split(Rs("ExperiInstrument"),",")
	num_char = split(left(Rs("ExperiNumber"),len(Rs("ExperiNumber"))-1),",")
	for i=LBound(instru_char) to UBound(instru_char)
	Set Rsw = Server.CreateObject("Adodb.RecordSet")
	Sqlw = "Select * From shopinfo where ID="&instru_char(i)
	Rsw.Open Sqlw,Conn,1,1
%>
  <TR>
  <TD height=22 width="11%">器材编号:</TD>
  <TD width="11%"><%=Rsw("newnum")%><TD>
  <TD width="15%">器材名称:</TD>
  <TD width="46%"><%=Rsw("ShopName")%></TD>
  <TD width="13%">器材数量:</TD>
  <TD width="11%"><%=num_char(i)%></TD></TR>
  <%
	Rsw.Close:Set Rsw=Nothing
	next
%>
  </TBODY>
  </TABLE>
</TD></TR>
<TR>
  <TD>申请人姓名:</TD>
  <TD width="35%" colSpan=2><input name="TUserName" type="text" class="Input200px" id="TUserName" value="<%=GetUserInfo(UserName,"RealName")%>" readonly="readonly" /></TD>
  <TD width="20%" colSpan=2>联系方式:</TD>
  <TD><input name="TelPhone" type="text" class="Input200px" id="TelPhone" value="<%=GetUserInfo(UserName,"TelPhone")%>" readonly="readonly" /></TD></TR>
<TR>
<TD>申请套数:</TD>
<TD colSpan=5><input name="SetExperiSats" type="text" class="Input200px" id="SetExperiSats" value="1" />
</TD></TR></TBODY>
</table>
<%
  end if
  Rs.Close:Set Rs=Nothing
%>
  
  </td>
</tr>

<tr>
  <td class="Right" align="right"><input type="submit" value="申 请" class="Button" /></td>
  <td colspan="3"><input type="button" value="返回" class="Button" onclick="history.back();" /></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>