﻿<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_MD5.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
'Call ISPopedom(UserName,"Member_Add")
If Request("Action")="Save" Then
UserName=ReplaceBadChar(Trim(Request("UserName")))
UserPass=ReplaceBadChar(Trim(Request("UserPass")))
RealName=ReplaceBadChar(Trim(Request("RealName")))
Group=ReplaceBadChar(Trim(Request("Group")))
subject=ReplaceBadChar(Trim(Request("subject")))
TelPhone=ReplaceBadChar(Trim(Request("TelPhone")))
CellPhone=ReplaceBadChar(Trim(Request("CellPhone")))
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From UserReg Where UserName='"&UserName&"'"
Rs.Open Sql,Conn,1,3
If Not (Rs.Eof Or Rs.Bof) Then
Response.Write("<script>alert('\u8be5\u8d26\u53f7\u5df2\u5b58\u5728\uff0c\u8bf7\u66f4\u6362\u65b0\u7684\u8d26\u53f7\u518d\u8fdb\u884c\u672c\u64cd\u4f5c\u3002');window.history.back();</script>")
Else
Rs.Addnew
Rs("UserName")=UserName
Rs("UserPass")=MD5(UserPass,32)
Rs("RealName")=RealName
Rs("Group")=Group
Rs("subject")=subject
Rs("TelPhone")=TelPhone
Rs("CellPhone")=CellPhone
Rs("flg")=false
Rs("PostTime")=Now()
Rs.Update
Response.Write("<script>alert('\u4f1a\u5458\u8d26\u53f7\u521b\u5efa\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='Member_Add.asp';</script>")
End If
Rs.Update
Rs.Close
Set Rs=Nothing
Conn.Close
Set Conn=Nothing
Response.End()
End If
%>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<link href="Style/PopCalender.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/Jquery.js"></script>
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>

<style type="text/css">
.pwd-strength {width:180px;height:20px;line-height:20px}
.pwd-strength-box,.pwd-strength-box-low,.pwd-strength-box-med,.pwd-strength-box-hi{color: #464646;text-align: center;
width: 30%; float:left; border:solid 1px #CCCCCC}
.pwd-strength-box-low{color: #FF0000;background-color:#F00F00;color:#FFFFFF}
.pwd-strength-box-med{color: #FF0000;background-color: #CCCCCC;}
.pwd-strength-box-hi{color: #FF0000;background-color: #FF9900;}
</style>
<script language="javascript" type="text/javascript">
function checkPassword(pwd){
var objLow=document.getElementById("pwdLow");
var objMed=document.getElementById("pwdMed");
var objHi=document.getElementById("pwdHi");
objLow.className="pwd-strength-box";
objMed.className="pwd-strength-box";
objHi.className="pwd-strength-box";
if(pwd.length<6){
objLow.className="pwd-strength-box-low";
}else{
var p1= (pwd.search(/[a-zA-Z]/)!=-1) ? 1 : 0;
var p2= (pwd.search(/[0-9]/)!=-1) ? 1 : 0;
var p3= (pwd.search(/[^A-Za-z0-9_]/)!=-1) ? 1 : 0;
var pa=p1+p2+p3;
if(pa==1){
objLow.className="pwd-strength-box-low";
}else if(pa==2){
objMed.className="pwd-strength-box-med";
}else if(pa==3){
objHi.className="pwd-strength-box-hi";
}
}
}
</script>
<script>
//这段脚本如果你的页面里有，就可以去掉它们了
//欢迎访问我的网站queyang.com
var ie =navigator.appName=="Microsoft Internet Explorer"?true:false;
function $(objID){
	return document.getElementById(objID);
}
</script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px">当前位置：添加会员</td>
</tr>
<tr>
<td height="80">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top">以下各项信息请准确真实的填写，保存之后立即生效。<br>
注意：管理员可对会员账号进行锁定操作。</td>
</tr>
</table></td>
</tr>
<tr>
<td valign="top">
<script language="javascript" type="text/javascript">
function CheckForm()
{
	var rst = true;
	if ($("#UserName").val()=="")
	{
		alert("\u767b\u5f55\u8d26\u53f7\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#UserName").focus();
		return false;
		rst = false;
	}
	if ($("#UserPass").val()=="")
	{
		alert("\u767b\u5f55\u5bc6\u7801\u4e0d\u80fd\u4e3a\u7a7a\u3002");
		$("#UserPass").focus();
		return false;
		rst = false;
	}
	return rst;
}
</script>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<form id="form1" name="form1" method="post" action="?action=Save" onSubmit="return CheckForm();">
<tr>
<th colspan="2">添加用户</th>
</tr>
<tr>
<td class="Right" align="right">用户名：</td>
<td><input type="text" id="UserName" name="UserName" class="Input300px"></td>
</tr>
<tr>
<td width="25%" class="Right" align="right">登录密码：</td>
<td width="75%"><input type="password" id="UserPass" name="UserPass" class="Input300px" onKeyUp="checkPassword(this.value);"></td>
</tr>
<tr>
<td class="Right" align="right">密码强度(越高越好)：</td>
<td>
<div class="pwd-strength FCK__ShowTableBorders">
<div class="pwd-strength-box" id="pwdLow">低</div>
<div class="pwd-strength-box" id="pwdMed">等</div>
<div class="pwd-strength-box" id="pwdHi">高</div>
</div>
</td>
</tr>
<tr>
<td class="Right" align="right">姓 名：</td>
<td><input type="text" id="RealName" name="RealName" class="Input300px"></td>
</tr>
<tr>
<td class="Right" align="right">用户组：</td>
<td><input type="radio" name="Group" id="Group" value="1">
  超级管理员
    <input type="radio" name="Group" id="Group" value="2">
    实验管理员
    <input name="Group" type="radio" id="Group" value="3" checked>
    普通老师</td>
</tr>
<tr>
  <td class="Right" align="right">任教学科：</td>
  <td><input name="subject" type="radio" id="subject" value="s1" checked>
    物理
    <input type="radio" name="subject" id="subject" value="s2">
    化学
    <input type="radio" name="subject" id="subject" value="s3">
    生物
    </td>
</tr>
<tr>
  <td class="Right" align="right">手机短号：</td>
  <td><input type="text" id="TelPhone" name="TelPhone" class="Input300px"></td>
</tr>
<tr>
  <td class="Right" align="right">联系电话：</td>
  <td><input type="text" id="CellPhone" name="CellPhone" class="Input300px"></td>
</tr>
<tr>
  <td class="Right" align="right">&nbsp;</td>
  <td><input type="submit" value="保 存" class="Button"> <input type="button" value="关闭窗口" class="Button" onClick="top.DeleteTabTitle('Member_Add')"></td>
</tr>
</form>
</table>
</td>
</tr>
</table>
<script language="javascript" type="text/javascript" src="Common/PopCalender.js"></script>
</body>
</html>