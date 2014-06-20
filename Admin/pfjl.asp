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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：投票记录</td>
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
<th colspan="3"><span style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">投票记录</span>：</th>
</tr>
<tr>
  <td  align="center" width="20%" class="Right">姓名</td>
  <td width="40%" align="center" valign="middle" class="Right">师德考核</td>
  <td width="40%" align="center" class="Right">专技年度考核</td>
  </tr>
  <%
  	TecCode=Request("TecCode")
  	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "select * from userreg1 order by code"
	Rs.Open Sql,Conn,1,1
	do while not Rs.Eof
  %>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td class="Right" align="center"><%=GetTecName("userreg1",Rs("code"))%></td>
  <td align="center" class="Right"><% if(ISChecked("sorcetec",Rs("code"))="True") then%> 已评 <%else%><span style="color:red;">未评</span><% end if%></td>
  <td align="center" class="Right"><% if(ISChecked("sorcezjkh",Rs("code"))="True") then%> 已评 <%else%><span style="color:red;">未评</span><% end if%></td>
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