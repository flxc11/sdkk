<!--#include file="Config/Conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<!--#include file="checktec.asp" -->
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%=SiteKeysTitle("教师登录")%>
<link rel="stylesheet" href="css/Global.css" />
<link rel="stylesheet" href="css/Base.css" />
</head>

<body>
<!--#include file="top.asp" -->
<table width="980" border="0" align="center" cellpadding="0" cellspacing="0">
  <tr>
    <td align="center"><%if(ISChecked("Sorcetec",CodeID)="True") then %><img src="images/imgrcsb.jpg" width="310" height="113" /><br /><span style="color:red;">师德考核（已打分）</span><% else %><a href="teacher.asp"><img src="images/imgrcsb.jpg" width="310" height="113" /><br /><span>点击进入</span></a>
    <%end if%></td>
    <td height="500" align="center"><%if(ISChecked("Sorcezjkh",CodeID)="True") then %><img src="images/imgsbcx.jpg" width="310" height="113" /><br /><span style="color:red;">专技年度考核（已打分）</span><% else %><a href="zjkh.asp"><img src="images/imgsbcx.jpg" width="310" height="113" /><br /><span>点击进入</span></a><%end if%></td>
  </tr>
</table>
<div class="footer">
  <div class="footer_cnt">温州市籀园小学 版权所有 Copyright © 2012-2013 wzssx.net All rights reserved</div>
</div>
</body>
</html>
