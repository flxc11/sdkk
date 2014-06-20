<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
	Action=ReplaceBadChar(Trim(Request("Action")))
	ID=ReplaceBadChar(Trim(Request("ID")))
	Page=ReplaceBadChar(Trim(Request("Page")))
	ClassID=ReplaceBadChar(Trim(Request("ClassID")))
	
	If Action="Save" Then
	ExperiTitle=Request("ExperiTitle")
	ExperiType=Trim(Request("ExperiType"))
	ExperiStatus=Trim(Request("ExperiStatus"))
	ExperiRoom=Trim(Request("ExperiRoom"))
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * From setsExperiments where ID="&ID
	Rs.Open Sql,Conn,1,3
	Rs("ExperiTitle")=ExperiTitle
	Rs("ExperiType")=ExperiType
	Rs("ExperiRoom")=ExperiRoom
	Rs("ExperiStatus")=ExperiStatus
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('修改成功！');window.location.href='experiment_List.asp?Page="&Page&"';</script>")
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
<script type="text/javascript" src="Common/jquery_select.js"></script>

</head>
<body>
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#ExperiTitle").val()=="")
	{
		alert("姓名不能为空");
		$("#ExperiTitle").focus();
		return false;
	}
	if ($("#ExperiRoom").val()==0)
	{
		alert("\u8bf7\u9009\u62e9\u680f\u76ee\u0021");
		$("#ExperiRoom").focus();
		return false;
	}
	return true;	
}
$(document).ready(function(){
	$("#ExperiRoom").val("<%=ClassID%>");
});
</script>
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From setsExperiments Where ID="&ID&""
Rs.Open Sql,Conn,1,1
If Not (Rs.Bof Or Rs.Eof) Then
	ExperiTitle=Rs("ExperiTitle")
	ExperiType=Rs("ExperiType")
	ExperiStatus=Rs("ExperiStatus")
End If
Rs.Close
Set Rs=Nothing
%>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：实验管理 >> 编辑学生</td>
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
<td colspan="4" align="left" valign="middle"><input type="button" value="返回" class="Button" onclick="history.back();" /></td>
</tr>
<tr>
<th colspan="4">编辑学生：</th>
</tr>
<tr>
  <td class="Right" align="right" width="11%">姓名：</td>
  <td width="33%" align="left" valign="middle" class="Right"><input type="text" id="ExperiTitle" name="ExperiTitle" value="<%=ExperiTitle%>" class="Input200px" /></td>
  <td width="24%" align="right" class="Right">班级：</td>
  <td width="32%">
    <select id="ExperiRoom" name="ExperiRoom" style="width:200px;height:22px;">
      <option value="0">请选择班级</option>
      <%=GetSelect("RoomClass",0)%>
      </select>
    </td>
</tr>
<tr>
  <td class="Right" align="right">学号：</td>
  <td class="Right"><input type="text" id="ExperiType" name="ExperiType" value="<%=ExperiType%>" class="Input200px" /></td>
  <td align="right" class="Right">性别：</td>
  <td class="Right">
  <input type="radio" name="ExperiStatus" value="1" id="StuSex_0" <% if ExperiStatus=1 then%> checked="checked" <%end if%> />
      男
      <input type="radio" name="ExperiStatus" value="0" id="StuSex_1" <% if ExperiStatus=0 then%> checked="checked" <%end if%> />女</td>
</tr>
<tr>
  <td class="Right" align="right">&nbsp;</td>
  <td colspan="3"><input type="submit" value="保 存" class="Button"> <input type="button" value="关闭窗口" class="Button" onClick="top.DeleteTabTitle('News_ContentAdd')"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>

</body>
</html>