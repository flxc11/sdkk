<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_MD5.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"Member_List")
ID=ReplaceBadChar(Trim(Request("ID")))
Page=ReplaceBadChar(Trim(Request("Page")))
If Request("Action")="Save" Then
UserName=Request("UserName")
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
  If UserPass<>"" Then
  	Rs("UserPass")=MD5(UserPass,32)
  End If
  Rs("RealName")=RealName
  Rs("Group")=Group
  Rs("subject")=subject
  Rs("TelPhone")=TelPhone
  Rs("CellPhone")=CellPhone
  Rs("flg")=false
  Rs("PostTime")=Now()
  Rs.Update
  Response.Write("<script>alert('\u4f1a\u5458\u8d26\u53f7\u4fe1\u606f\u4fee\u6539\u64cd\u4f5c\u6210\u529f\u3002');window.location.href='Member_List.asp?Page="&Page&"';</script>")
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
<td style="border-bottom:solid 1px #dde4e9;height:30px">当前位置：<a href="Member_list.asp">会员列表</a> >> 编辑会员</td>
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
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From UserReg1 Where ID="&ID&""
Rs.Open Sql,Conn,1,1
If Not (Rs.Eof Or Rs.Bof) Then
	Code=Rs("Code")
	UserName=Rs("UserName")
	Campus=Rs("Campus")
	ISxz=Rs("ISxz")
	Grade=Rs("Grade")
	ISGrade=Rs("ISGrade")
	Teach=Rs("Teach")
	ISTeach=Rs("ISTeach")
	Subject=Rs("Subject")
	Roomclass=Rs("Roomclass")
	TelPhone=Rs("TelPhone")
End If
Rs.Close
Set Rs=Nothing
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
  <form id="form1" name="form1" method="post" action="?action=Save" onSubmit="return CheckForm();">
<tr>
<th colspan="2">编辑用户</th>
</tr>
<tr>
  <td width="25%" align="right" class="Right">职工号：</td>
  <td width="75%"><input name="Code" type="text" class="Input300px" id="Code" value="<%=Code%>" readonly></td>
</tr>
<tr>
  <td class="Right" align="right">姓 名：</td>
  <td><input type="text" id="UserName" name="UserName" value="<%=UserName%>" class="Input300px"></td>
</tr>
<tr>
<td class="Right" align="right">校区：</td>
<td><input type="radio" name="Campus" id="Group" value="九山" <% if Campus="九山" then%> checked="checked" <% end if %>>
  九山
    <input type="radio" name="Campus" id="Group" value="国际" <% if Campus="国际" then%> checked="checked" <% end if %>>
    国际</td>
</tr>
<tr>
  <td class="Right" align="right">是否行政：</td>
  <td><input name="ISxz" type="radio" id="ISxz" value="是" <% if ISxz="是" then%> checked="checked" <% end if %>>
    是
    <input type="radio" name="ISxz" id="ISxz" value="" <% if ISxz<>"是" then%> checked="checked" <% end if %>>
    否
    </td>
</tr>
<tr>
  <td class="Right" align="right">年级组：</td>
  <td><input type="text" id="Grade" name="Grade" value="<%=Grade%>" class="Input300px"></td>
</tr>
<tr>
  <td class="Right" align="right">是否年级组长：</td>
  <td><input name="Grade" type="radio" id="Grade" value="是" <% if Grade="是" then%> checked="checked" <% end if %>>
是
  <input type="radio" name="Grade" id="Grade" value="" <% if Grade<>"是" then%> checked="checked" <% end if %>>
否 </td>
</tr>
<tr>
  <td class="Right" align="right">教研组：</td>
  <td><input type="text" id="Teach" name="Teach" value="<%=Teach%>" class="Input300px"></td>
</tr>
<tr>
<td class="Right" align="right">是否教研组长：</td>
<td><input name="ISTeach" type="radio" id="ISTeach" value="是" <% if ISTeach="是" then%> checked="checked" <% end if %>>
是
  <input type="radio" name="ISTeach" id="ISTeach" value="" <% if ISTeach <>"是" then%> checked="checked" <% end if %>>
否 </td>
</tr>
<tr>
  <td class="Right" align="right">任教学科：</td>
  <td><input type="text" id="Subject" name="Subject" value="<%=Subject%>" class="Input300px"></td>
</tr>
<tr>
  <td class="Right" align="right">班级：</td>
  <td><input type="text" id="TelPhone" name="TelPhone" value="<%=GetSubNavName("RoomClass",Roomclass)%>" class="Input300px"></td>
</tr>
<tr>
  <td class="Right" align="right">电话：</td>
  <td><input type="text" id="TelPhone" name="TelPhone" value="<%=TelPhone%>" class="Input300px"></td>
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