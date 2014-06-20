<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/Jquery.js"></script>
<style type="text/css">
span {
	color:#F00;
}
</style>
</head>
<body>
<%
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * from ShopClass"
	Rs.Open Sql,Conn,1,1
	classcount = Rs.RecordCount
	Rs.Close:Set Rs=Nothing
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * from shopinfo"
	Rs.Open Sql,Conn,1,1
	shopcount = Rs.RecordCount
	Rs.Close:Set Rs=Nothing
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select sum(numb2) as kcall from shopinfo"
	Rs.Open Sql,Conn,1,3
	kcall = Rs("kcall")
	Rs.Close:Set Rs=Nothing
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select sum(numb1) as ccall from shopinfo"
	Rs.Open Sql,Conn,1,3
	ccall = Rs("ccall")
	Rs.Close:Set Rs=Nothing
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select sum(price) as price1 from shopinfo"
	Rs.Open Sql,Conn,1,3
	price1 = Rs("price1")
	Rs.Close:Set Rs=Nothing
%>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="Pro_Class.asp">仪器管理</a> >>统计</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="90%" valign="top"><a href="Pro_Prolist.asp">返回仪器清单列表</a></td>
</tr>
</table></td>
</tr>
<tr>
<td colspan="2" valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<th colspan="2">统计</th>
</tr>
<tr>
  <td width="25%" align="right" class="Right">仪器种类：</td>
  <td>共有仪器类别 <span><%=classcount%></span> 大类</td>
  </tr>
<tr>
  <td class="Right" width="25%" align="right">仪器类别：</td>
  <td>共有仪器 <span><%=shopcount%></span> 种</td>
</tr>
<tr>
  <td class="Right" width="25%" align="right">仪器总数：</td>
  <td>共有仪器 <span><%=ccall%></span> 件</td>
</tr>
<tr>
  <td class="Right" width="25%" align="right">仪器库存：</td>
  <td>在库 <span><%=kcall%></span> 件</td>
</tr>
<tr>
  <td class="Right" align="right">价格总数：</td>
  <td>总价为 <span><%=price1%> 元</span></td>
</tr>
</table>
</td>
</tr>
</table>
</body>
</html>