<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"GuestBook")
ID=ReplaceBadChar(Trim(Request("ID")))
ParentID=ReplaceBadChar(Trim(Request("ParentID")))
Action=ReplaceBadChar(Trim(Request("Action")))

If Action="Save" Then
	flg=ReplaceBadChar(Trim(Request("flg")))
	PostTime=Trim(Request("PostTime"))
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From bookroom Where ID="&ID&""
	Rs.Open Sql,Conn,1,3
	Rs("flg")=flg
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('\u4fe1\u606f\u4fee\u6539\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='booking.asp';</script>")
	Response.End()
End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/Jquery.js"></script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="LookGuestBook.asp">留言内容维护</a> >>查看留言内容</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="61" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60" height="83"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下所有内容均为只读。</td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<%
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From bookroom Where ID="&ID&""
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
	bookname=Rs("bookname")
	booktel=Rs("booktel")
	bookfax=Rs("bookfax")
	bookemail=Rs("bookemail")
	bookaddress=Rs("bookaddress")
	intime=Rs("intime")
	outtime=Rs("outtime")
	bookContent=Rs("bookContent")
	roomtype=Rs("roomtype")
	roomquantity=Rs("roomquantity")
	adultquantity=Rs("adultquantity")
	childquantity=Rs("childquantity")
	PostTime=Rs("PostTime")
	flg=Rs("flg")
End If
Rs.Close
Set Rs=Nothing
%>
<form id="form1" name="form1" method="post" action="?Action=Save">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<input type="hidden" id="Page" name="Page" value="<%=Page%>"/>
<input type="hidden" id="ParentID" name="ParentID" value="<%=ParentID%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
  <th class="Right" colspan="2">编辑说明页</th>
</tr>
<tr>
  <td class="Right" width="25%" align="right">姓名：</td>
  <td width="75%"><input type="text" id="bookname" name="bookname" value="<%=bookname%>" readonly="readonly" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">联系电话：</td>
  <td width="75%"><input type="text" id="booktel" name="booktel" value="<%=booktel%>" readonly="readonly" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">地址：</td>
  <td width="75%"><input type="text" id="bookaddress" name="bookaddress" value="<%=bookaddress%>" readonly="readonly" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">邮箱：</td>
  <td width="75%"><input type="text" id="bookemail" name="bookemail" value="<%=bookemail%>" readonly="readonly" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">入住时间：</td>
  <td width="75%"><input type="text" id="intime" name="intime" value="<%=intime%>" readonly="readonly" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">离开时间：</td>
  <td width="75%"><input type="text" id="outtime" name="outtime" value="<%=outtime%>" readonly="readonly" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">客房类型：</td>
  <td width="75%"><input type="text" id="roomtype" name="roomtype" value="<%=roomtype%>" readonly="readonly" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">房间数：</td>
  <td width="75%"><input type="text" id="roomquantity" name="roomquantity" value="<%=roomquantity%>" readonly="readonly" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">成人：</td>
  <td width="75%"><input type="text" id="adultquantity" name="adultquantity" value="<%=adultquantity%>" readonly="readonly" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">小孩：</td>
  <td width="75%"><input type="text" id="childquantity" name="childquantity" value="<%=childquantity%>" readonly="readonly" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">备注：</td>
  <td width="75%"><input type="text" id="bookContent" name="bookContent" value="<%=bookContent%>" readonly="readonly" class="Input300px" style=" height:150px; width:450px;"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">预订时间：</td>
  <td width="75%"><input type="text" id="PostTime" name="PostTime" value="<%=PostTime%>" readonly="readonly" class="Input300px"/></td>
</tr>
<tr>
  <td class="Right" align="right" valign="top">处理情况：</td>
  <td width="75%"><input type="radio" name="flg" value="1" id="flg_0" <% if flg=true then%> checked="checked" <% end if %> />已处理<input type="radio" name="flg" value="0" id="flg_1" <% if flg<>true then%> checked="checked" <% end if %> />未处理</td>
</tr>
<!--<tr>
  <td class="Right" align="right" valign="top">管理员回复：</td>
  <td width="75%"><%=Editor("Reply",Reply)%><br /><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&FrameName=NavContent"></script></td>
</tr>-->
<tr>
<td class="Right" width="25%" align="right">&nbsp;</td>
<td width="75%"><input type="submit" value="提 交" class="Button"> <input type="button" value="返 回" class="Button" onClick="window.location.href='GuestBook.asp?ID=<%=ParentID%>&Page=<%=Page%>'"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>