<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Action=ReplaceBadChar(Trim(Request("Action")))
ExperiType=ReplaceBadChar(Trim(Request("ExperiType")))
If ExperiType="" Then
	ExperiType="0"
End If
If Action="Save" Then
	ExperiTitle=ReplaceBadChar(Trim(Request("ExperiTitle")))
	ExperiType=Trim(Request("ExperiType"))
	ExperiPlace=ReplaceBadChar(Trim(Request("ExperiPlace")))
	ExperiTime=Trim(Request("ExperiTime"))
	ExperiSats=Trim(Request("yqts"))
	If PostTime="" Or IsDate(PostTime)=false Then
		PostTime=Now()
	End If
	ExperiInstrument=Request("instru_check")
	ExperiNumber=Request("result_num")
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From SetsExperiments"
	Rs.Open Sql,Conn,1,3
	Rs.AddNew
	'Rs("UserName")=UserName
	Rs("ExperiTitle")=ExperiTitle
	Rs("ExperiType")=ExperiType
	Rs("ExperiPlace")=ExperiPlace
	Rs("ExperiTime")=ExperiTime
	Rs("ExperiInstrument")=ExperiInstrument
	Rs("ExperiNumber")=ExperiNumber
	Rs("ExperiSats")=1
	Rs("ExperiStatus")=0
	Rs("PostTime")=PostTime
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('成套实验添加成功');window.location.href='SetsExperiments.asp';</script>")
	Response.End()
End If
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
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：信息管理 >> 成套实验申请</td>
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
<script language="javascript" type="text/javascript">
function CheckForm()
{
	if ($("#ExperiTitle").val().length==0)
	{
		alert("实验名称不能为空");
		$("#ExperiTitle").focus();
		return false;
	}
	if ($("#ExperiType").val()==0)
	{
		alert("请选择实验类型");
		$("#ExperiType").focus();
		return false;
	}
	var strnum = "";
	$("input[name='instru_check']:checked").each(function(){
      strnum+=$(this).parent().next().children("input").val()+",";
	})
	$("[name='result_num']").attr("value",strnum);
	return true;	
}
$(function(){
	$(".Instrument h2").toggle(
		function(){
			$(this).next().animate({opacity:'show'},500);
		},
		function(){
			$(this).next().hide();
		}
	);
	$(".Instrument h3").toggle(
		function(){
			$(this).next().animate({opacity:'show'},500);
		},
		function(){
			$(this).next().hide();
		}
	);
	$("input[type='checkbox']").change(function(){
		if($(this).attr("checked") == "checked"){
			$(this).parent().next().children("input").attr("style","display:block");
		} else {
			$(this).parent().next().children("input").attr("style","display:none");
		}
	  	
	})
});
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<input type="hidden" name="result_num" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td colspan="4" align="left" valign="middle"><input type="submit" value="保 存" class="Button"> <input type="button" value="关闭窗口" class="Button" onClick="top.DeleteTabTitle('News_ContentAdd')"></td>
</tr>
<tr>
<th colspan="4">实验申请</th>
</tr>
<tr>
  <td class="Right" align="right" width="11%">实验名称：</td>
  <td class="Right" width="33%">
    
    <div class="float_left_210txt">
      <input type="text" id="ExperiTitle" name="ExperiTitle" value="" class="Input200px"/>
      </div>
    
    
  </td>
  <td width="24%" align="right" class="Right">实验类型：</td>
  <td width="32%">
    <div class="float_left_210">
      <select id="ExperiType" name="ExperiType" style="width:200px;">
        <option value="0">|--请选择实验类型</option>
        <option value="1">课堂演示实验</option>
        <option value="2">学生分组实验</option>
        </select>
      </div>
    </td>
</tr>


<tr>
<td class="Right" align="right">实验地点：</td>
<td class="Right"><input type="text" id="ExperiPlace" name="ExperiPlace" value="" class="Input200px"/></td>
<td colspan="2" align="left" valign="middle" class="Right"><div class="float_left_60">申请时间：</div>
  <div class="float_left_210"><input type="text" id="ExperiTime" name="ExperiTime" value="<%=FormatTime(Now(),1)%>" class="Input200px"/></div><div style="float:left; padding-top:8px;width:25px"><img src="Images/Calender.gif" align="absmiddle" onClick="showcalendar(event, $('PostTime'));" onFocus="showcalendar(event, $('PostTime'));if($('PostTime').value=='0000-00-00')$('PostTime').value=''"></div>
<div style="float:left">日期格式为2009-01-01</div></td>
</tr>

<tr>
  <td class="Right" align="right">仪器选择：</td>
  <td colspan="3" class="Right">
  <%
    Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * From shopclass where NavParent=0"
	Rs.Open Sql,Conn,1,1
	do while not Rs.Eof
  %>
  <div class="Instrument">
  <h2 style="cursor:pointer;"><%=Rs("NavTitle")%></h2>
  <%
  	Set Rst = Server.CreateObject("Adodb.RecordSet")
	Sqlt = "Select * From shopclass where NavParent="&Rs("ID")
	Rst.Open Sqlt,Conn,1,1
	if not (Rst.Eof or Rst.Bof) then
	Response.Write("<div class='second_instru'>")
	do while not Rst.Eof
  %>
  
  <h3 style="cursor:pointer; padding-left:15px;"><%=Rst("NavTitle")%></h3>
  <%
  	Set Rss = Server.CreateObject("Adodb.RecordSet")
	Sqls = "Select * from shopinfo where ClassID="&Rst("ID")
	Rss.Open Sqls,Conn,1,1
	Response.Write("<div class='third_instru'>")
	do while not Rss.Eof
  %>
  <div class="Instrument_div"><span><input type="checkbox" name="instru_check" value="<%=Rss("ID")%>" /><%=Rss("shopname")%></span><span><input type="text" name="instru_num" value="1" style="display:none;" class="value_text" /></span></div>
  <%
  	Rss.MoveNext
	loop
	Response.Write("</div>")
	Rss.Close:Set Rss=Nothing
  	Rst.MoveNext
	Loop
	Response.Write("</div>")
	else
	Set Rsa = Server.CreateObject("Adodb.RecordSet")
	Sqla = "Select * From shopinfo where ClassID="&Rs("ID")
	Rsa.Open Sqla,Conn,1,1
	Response.Write("<div class='second_instru'>")
	do while not Rsa.Eof
  %>
  	<div class="Instrument_div"><input type="checkbox" name="instru_check" value="<%=Rsa("ID")%>" /><%=Rsa("shopname")%></div>
  <%
	Rsa.MoveNext
	loop
	Response.Write("</div>")
	Rsa.Close:Set Rsa=Nothing
	end if
	Rst.Close:Set Rst=Nothing
  %>
  </div>
  <%
  	Rs.MoveNext
	Loop
	Rs.Close:Set Rs=Nothing
  %>
  </td>
</tr>
<!--<tr>
<td class="Right" align="right">仪器套数：</td>
<td class="Right"><input type="text" id="yqts" name="yqts" value="1" class="Input200px"/></td>
<td colspan="2" align="left" valign="middle" class="Right">&nbsp;</td>
</tr>-->
<tr>
<td class="Right" align="right">&nbsp;</td>
<td colspan="3"><input type="submit" value="保 存" class="Button"> <input type="button" value="关闭窗口" class="Button" onClick="top.DeleteTabTitle('News_ContentAdd')"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
<script language="javascript" type="text/javascript" src="Common/PopCalender.js"></script>
</body>
</html>