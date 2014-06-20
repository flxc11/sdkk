<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
	Action=ReplaceBadChar(Trim(Request("Action")))
	Select Case Action
Case "DeleteStu"
	Conn.Execute("delete from sorce")
	Conn.Execute("ALTER TABLE sorce")
	Conn.Execute("ALTER COLUMN OrderId COUNTER (1,1)")
End Select
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
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：清空数据</td>
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
<td colspan="2" align="left" valign="middle"><input type="button" value="返回" class="Button" onclick="history.back();" /></td>
</tr>
<tr>
  <th colspan="2">清空数据：</th>
</tr>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td width="20%" align="center" class="Right">学生打分记录</td>
  <td width="20%" align="center" class="Right"><a href="?Action=DeleteStu" onclick="if(!confirm('是否清空学生打分记录?')) return false;">清空</a></td>
  </tr>
  <tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td width="20%" align="center" class="Right">家长打分记录</td>
  <td width="20%" align="center" class="Right"><a href="?Action=DeleteParent" onclick="if(!confirm('是否清空家长打分记录?')) return false;">清空</a></td>
  </tr>
  <tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td width="20%" align="center" class="Right">师德考核打分记录</td>
  <td width="20%" align="center" class="Right"><a href="?Action=Deletetec" onclick="if(!confirm('是否清空师德考核打分记录?')) return false;">清空</a></td>
  </tr>
  <tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td width="20%" align="center" class="Right">专技考核打分记录</td>
  <td width="20%" align="center" class="Right"><a href="?Action=DeleteZjkh" onclick="if(!confirm('是否清空专技考核打分记录?')) return false;">清空</a></td>
  </tr>
</table>
</form>
</td>
</tr>
</table>

</body>
</html>