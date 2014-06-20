<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/jquery162min.js"></script>
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
<link href="Style/PopCalender.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="Common/jquery_select.js"></script>

</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：师德考核备注列表</td>
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
<input type="hidden" id="Page" name="Page" value="<%=Page%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td colspan="3" align="left" valign="middle"><input type="button" value="返回" class="Button" onclick="history.back();" /></td>
</tr>
<tr>
<th colspan="3">师德考核备注列表：</th>
</tr>
<tr>
  <td  align="center" width="20%" class="Right">姓名</td>
  <td width="20%" align="center" valign="middle" class="Right">填写者</td>
  <td align="center" class="Right">备注</td>
  </tr>
  <%
  	TecCode=Request("TecCode")
  	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "select * from sorcetec where Content<>''"
	Rs.Open Sql,Conn,1,1
	do while not Rs.Eof
  %>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td class="Right" align="center"><%=GetTecName("userreg1",Rs("TecCode"))%></td>
  <td align="center" class="Right"><%=GetTecName("userreg1",Rs("StuCode"))%></td>
  <td align="center" class="Right"><%=Rs("Content")%></td>
  </tr>
<%
	Rs.MoveNext
	Loop
	Rs.Close:Set Rs=Nothing
%>
<%
  	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "select * from sorce where Content<>''"
	Rs.Open Sql,Conn,1,1
	do while not Rs.Eof
  %>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td class="Right" align="center"><%=GetTecName("userreg1",Rs("TecCode"))%></td>
  <td align="center" class="Right">
  <%
  	Set Rs1=Server.CreateObject("Adodb.RecordSet")
	Sql1 = "Select * from SetsExperiments where ExperiType ='"&Rs("StuCode")&"'"
	Rs1.Open Sql1,Conn,1,1
	if not (Rs1.Eof or Rs1.Bof) then
	GradeName = GetSubNavName("RoomClass",GetNavParent("RoomClass",Rs1("ExperiRoom")))
	ClassName = GetSubNavName("RoomClass",Rs1("ExperiRoom"))
	Campus = GetSubNavName("RoomClass",GetNavParent("RoomClass",GetNavParent("RoomClass",Rs1("ExperiRoom"))))
	StuName = Rs1("ExperiTitle")
	RoomID = Rs1("ExperiRoom")
	end if
	Rs1.Close:Set Rs1=Nothing
	Response.Write(Campus&"-"&GradeName&"-"&ClassName&"-"&StuName)
  %>
  </td>
  <td align="center" class="Right"><%=Rs("Content")%></td>
  </tr>
<%
	Rs.MoveNext
	Loop
	Rs.Close:Set Rs=Nothing
%>
<%
  	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "select * from sorceparent where Content<>''"
	Rs.Open Sql,Conn,1,1
	do while not Rs.Eof
  %>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td class="Right" align="center"><%=GetTecName("userreg1",Rs("TecCode"))%></td>
  <td align="center" class="Right">
  <%
  	Set Rs1=Server.CreateObject("Adodb.RecordSet")
	Sql1 = "Select * from SetsExperiments where ExperiType ='"&Rs("StuCode")&"'"
	Rs1.Open Sql1,Conn,1,1
	if not (Rs1.Eof or Rs1.Bof) then
	GradeName = GetSubNavName("RoomClass",GetNavParent("RoomClass",Rs1("ExperiRoom")))
	ClassName = GetSubNavName("RoomClass",Rs1("ExperiRoom"))
	Campus = GetSubNavName("RoomClass",GetNavParent("RoomClass",GetNavParent("RoomClass",Rs1("ExperiRoom"))))
	StuName = Rs1("ExperiTitle")
	RoomID = Rs1("ExperiRoom")
	end if
	Rs1.Close:Set Rs1=Nothing
	Response.Write(Campus&"-"&GradeName&"-"&ClassName&"-"&StuName&"(家长)")
  %>
  </td>
  <td align="center" class="Right"><%=Rs("Content")%></td>
  </tr>
<%
	Rs.MoveNext
	Loop
	Rs.Close:Set Rs=Nothing
%>
</table>
</form>
</td>
</tr>
</table>

</body>
</html>