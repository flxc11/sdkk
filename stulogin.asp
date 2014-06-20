<!--#include file="Config/Conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<!--#include File="Include/Class_Md5.asp"-->
<%
If Request("Action")="Login" Then

UserName=ReplaceBadChar(Trim(Request("UserName")))
UserPass=ReplaceBadChar(Trim(request("UserPass")))

If UserName="" Or UserPass="" Then
Response.Write("<Script>alert('\u767b\u5f55\u5e10\u53f7\u53ca\u767b\u5f55\u5bc6\u7801\u4e0d\u80fd\u4e3a\u7a7a');history.go(-1);</Script>")
Response.End()
End If
Set Rsq = Server.CreateObject("Adodb.RecordSet")
Sqlq = "select * from sorce where StuCode='"&UserName&"'"
Rsq.Open Sqlq,Conn,1,1
if not (Rsq.eof or Rsq.bof) then
Response.Write("<Script>alert('你已评分，无需再次评分！');top.window.location.href='stulogin.asp';</Script>")
Response.End()
end if
Rsq.Close:Set Rsq=Nothing
'UserPass=MD5(UserPass,32)
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From SetsExperiments Where ExperiType='"&UserName&"' And UserPass='"&UserPass&"'"
Rs.Open Sql,Conn,1,1
If Not (Rs.Eof And Rs.Bof) Then
Response.Cookies("CNVP_CMS2")("ExperiType") = UserName

Response.Write("<script>top.window.location.href='student.asp';</script>")
Else
Response.Write("<Script>alert('\u767b\u5f55\u5931\u8d25\uff0c\u767b\u5f55\u5e10\u53f7\u6216\u8005\u5bc6\u7801\u9519\u8bef');history.go(-1);</Script>")
Response.End()
End If
Rs.Close
Set Rs=Nothing
Conn.Close
Set Conn=Nothing
End If
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%=SiteKeysTitle("学生登录")%>
<link rel="stylesheet" href="css/Global.css" />
<link rel="stylesheet" href="css/Base.css" />
<script type="text/javascript" src="js/jquery.js"></script>
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#UserName").val()=="")
	{
		alert("学号不能为空");
		$("#UserName").focus();
		return false;
	}
	if ($("#UserPass").val()=="")
	{
		alert("\u5bc6\u7801\u4e0d\u80fd\u4e3a\u7a7a\uff0c\u8bf7\u8f93\u5165\u540e\u91cd\u65b0\u767b\u5f55\u7cfb\u7edf\u3002");
		$("#UserPass").focus();
		return false;
		
	}
	return true;
}
$(document).ready(function(){
	$("#UserName").focus();
});
</script>
<style type="text/css">
body {
	background:#0083db;
}
</style>
</head>

<body>
<div class="container">
  <div class="container_left">
   	  <form id="form1" name="form1" action="?Action=Login" method="post" onsubmit="return CheckForm();">
   	  <div class="login">
        	<h2>&nbsp;</h2>
        <table width="250" border="0" cellspacing="0" cellpadding="0" style="margin-top:80px; color:#fff" align="center">
            <tr>
              <td width="50" height="30" align="center">学　号：</td>
              <td width="200">
              <input type="text" name="UserName" id="UserName" class="loginput" /></td>
            </tr>
            <tr>
              <td height="30" align="center">密　码：</td>
              <td><input type="password" name="UserPass" id="UserPass" class="loginput" /></td>
            </tr>
            <tr>
              <td height="56">&nbsp;</td>
              <td align="center"><input type="submit" name="button" id="button" value=" " style="width:80px;height:28px;background:url(images/btnsubmit1.jpg);border:0;cursor:pointer;" /></td>
            </tr>
        </table>
        <table width="250" border="0" cellspacing="0" cellpadding="0" style="margin-top:22px; color:#fff" align="center">
          <tr>
            <td width="50">&nbsp;</td>
            <td width="200" align="center">学生登录</td>
          </tr>
        </table>

      </div>
    </form>
  </div>
</div>
<div class="footer">
	<div class="footer_cnt">温州市实验小学 温州市籀园小学 版权所有 Copyright © 2012-2013 wzssx.net All rights reserved</div>
</div>
</body>
</html>
