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
'Set Rs=Server.CreateObject("Adodb.RecordSet")
'Sql="Select * From setsExperiments Where ID="&ID&""
'Rs.Open Sql,Conn,1,1
'If Not (Rs.Bof Or Rs.Eof) Then
'	ExperiTitle=Rs("ExperiTitle")
'	ExperiType=Rs("ExperiType")
'	ExperiStatus=Rs("ExperiStatus")
'End If
'Rs.Close
'Set Rs=Nothing
%>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：实验管理 >>评分设置</td>
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
<th colspan="4">评分设置：</th>
</tr>
<tr>
  <td class="Right" align="right" width="11%">校区：</td>
  <td width="33%" align="left" valign="middle" class="Right"><input type="radio" name="ExperiStatus" value="1" id="StuSex_2" <% if ExperiStatus=1 then%> checked="checked" <%end if%> />
    全部
    <input type="radio" name="ExperiStatus" value="0" id="StuSex_3" <% if ExperiStatus=0 then%> checked="checked" <%end if%> />
    九山
    <input type="radio" name="ExperiStatus" value="0" id="StuSex_4" <% if ExperiStatus=0 then%> checked="checked" <%end if%> />
    国际</td>
  <td width="24%" align="right" class="Right">是否行政：</td>
  <td width="32%"><span class="Right">
    <input type="radio" name="ISxz" value="1" id="ISxz_5" <% if ISxz=1 then%> checked="checked" <%end if%> />
    是
    <input type="radio" name="ISxz" value="0" id="ISxz_6" <% if ISxz=0 then%> checked="checked" <%end if%> />
    否
    <input type="radio" name="ISxz" value="2" id="ISxz_7" <% if ISxz=2 then%> checked="checked" <%end if%> />
    全部
  </span></td>
</tr>
<tr>
  <td class="Right" align="right">年级组：</td>
  <td class="Right">
    <label>
      <input type="checkbox" name="Grade" value="一年级" id="CheckboxGroup1_0" />
      一年级</label>
    <label>
      <input type="checkbox" name="Grade" value="二年级" id="CheckboxGroup1_1" />
      二年级</label>
    <label>
      <input type="checkbox" name="Grade" value="三年级" id="CheckboxGroup1_0" />
      三年级</label>
    <br />
    <label>
      <input type="checkbox" name="Grade" value="四年级" id="CheckboxGroup1_1" />
      四年级</label>
    <label>
      <input type="checkbox" name="Grade" value="五年级" id="CheckboxGroup1_0" />
      五年级</label>
    <label>
      <input type="checkbox" name="Grade" value="六年级" id="CheckboxGroup1_1" />
      六年级</label>
      </td>
  <td align="right" class="Right">是否年级组长：</td>
  <td class="Right">
  <input type="radio" name="ISGrade" value="1" id="StuSex_0" <% if ISGrade=1 then%> checked="checked" <%end if%> />
      是
      <input type="radio" name="ISGrade" value="0" id="StuSex_1" <% if ISGrade=0 then%> checked="checked" <%end if%> /> 
      否
      <input type="radio" name="ISGrade" value="2" id="StuSex_2" <% if ISGrade=0 then%> checked="checked" <%end if%> /> 
      全部
      </td>
</tr>
<tr>
  <td class="Right" align="right">教研组：</td>
  <td class="Right"><label>
    <input type="checkbox" name="Jyz" value="英语" id="CheckboxGroup1_2" />
    英语</label>
    <label>
      <input type="checkbox" name="Jyz" value="语文" id="CheckboxGroup1_3" />
      语文</label>
    <label>
      <input type="checkbox" name="Jyz" value="数学" id="CheckboxGroup1_2" />
      数学</label>
    <br />
    <label>
      <input type="checkbox" name="Jyz" value="科学" id="CheckboxGroup1_3" />
      科学</label>
    <label>
      <input type="checkbox" name="Jyz" value="音乐" id="CheckboxGroup1_2" />
      音乐</label>
      <input type="checkbox" name="Jyz" value="体育" id="CheckboxGroup1_3" />
      体育<br />
      <input type="checkbox" name="Jyz" value="美术" id="CheckboxGroup1_4" />
美术
<input type="checkbox" name="Jyz" value="信息技术" id="CheckboxGroup1_5" />
信息技术
<input type="checkbox" name="Jyz" value="心理健康" id="CheckboxGroup1_4" />
心理健康 <br />
<input type="checkbox" name="Jyz" value="财务" id="CheckboxGroup1_5" />
财务
<input type="checkbox" name="Jyz" value="图书馆" id="CheckboxGroup1_4" />
图书馆
<input type="checkbox" name="Jyz" value="后勤" id="CheckboxGroup1_5" />
后勤    <br />
<input type="checkbox" name="Jyz" value="网络管理" id="CheckboxGroup1_6" />
网络管理
<input type="checkbox" name="Jyz" value="校医" id="CheckboxGroup1_7" />
校医
<input type="checkbox" name="Jyz" value="文员" id="CheckboxGroup1_6" />
文员    <br />
<input type="checkbox" name="Jyz" value="档案管理" id="CheckboxGroup1_8" />
档案管理
<input type="checkbox" name="Jyz" value="国际象棋" id="CheckboxGroup1_9" />
国际象棋</td>
  <td align="right" class="Right">是否教研组长：</td>
  <td class="Right">
  <input type="radio" name="ISJyz" value="1" id="ISJyz_0" <% if ISJyz=1 then%> checked="checked" <%end if%> />
      是
      <input type="radio" name="ISJyz" value="0" id="ISJyz_1" <% if ISJyz=0 then%> checked="checked" <%end if%> />否
      <input type="radio" name="ISJyz" value="2" id="ISJyz_2" <% if ISJyz=2 then%> checked="checked" <%end if%> />全部</td>
</tr>
<tr>
  <td class="Right" align="right">任教学科：</td>
  <td class="Right">&nbsp;</td>
  <td align="right" class="Right">&nbsp;</td>
  <td class="Right">&nbsp;</td>
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