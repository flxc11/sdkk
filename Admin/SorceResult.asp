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
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：评分结果</td>
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
<td colspan="8" align="left" valign="middle"><input type="button" value="返回" class="Button" onclick="history.back();" /></td>
</tr>
<tr>
<th colspan="8">评分结果：</th>
</tr>
<tr>
  <td width="15%" align="center" class="Right">工号</td>
  <td width="10%" align="center" valign="middle" class="Right">姓名</td>
  <td width="10%" align="center" valign="middle" class="Right">年级</td>
  <td width="10%" align="center" valign="middle" class="Right">学科</td>
  <td width="10%" align="center" class="Right">家长评分</td>
  <td width="15%" align="center" class="Right">学生评分</td>
  <td width="15%" align="center" class="Right">老师评分</td>
  <td width="15%" align="center" class="Right">中层及以上评分</td>
  </tr>
  <!-- 行政组 -->
  <tr>
  <td colspan="8" align="left" class="Right pl10"><strong>行政组</strong></td>
  </tr>
  <%
  	Set Rs=Server.CreateObject("Adodb.RecordSet")
	'Sql = "select * from userreg1 where ISxz='是' order by ccount desc; select sum(TecSorce) as ccount from sorcetec where sorcetec.TecCode=userreg1.code"
	
	Sql = "select userreg1.* from userreg1 left join (select TecCode,sum(TecSorce) as sl from sorcetec group by TecCode)sorcetec on userreg1.code=sorcetec.teccode where userreg1.ISxz='是' order by iif(isnull(sorcetec.sl),0,sorcetec.sl) desc,userreg1.code asc"
 
	Rs.Open Sql,Conn,1,1
	do while not Rs.Eof
  %>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td class="Right" align="center"><%=Rs("Code")%></td>
  <td align="center" class="Right"><%=Rs("UserName")%></td>
  <td align="center" class="Right"><%=Rs("Grade")%></td>
  <td align="center" class="Right"><%=Rs("Subject")%></td>
  <td align="center" class="Right"><a href="lookparent.asp?TeCCode=<%=Rs("Code")%>"><%=left(GetSorce("SorceParent",Rs("Code"))/6,5)%></a></td>
  <td align="center" class="Right"><a href="lookStudent.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce("Sorce",Rs("Code"))%></td>
  <td align="center" class="Right"><a href="looktec.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce1("Sorcetec",Rs("Code"),"否")%></td>
  <td align="center" class="Right"><a href="looktec1.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce1("Sorcetec",Rs("Code"),"是")%></td>
</tr>
<%
	Rs.MoveNext
	Loop
	Rs.Close:Set Rs=Nothing
%>
	<!-- 语文组 -->
  <tr>
  <td colspan="8" align="left" class="Right pl10"><strong>语文组</strong></td>
  </tr>
  <%
  	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "select * from userreg1 where ISxz='否' and campus='九山' and Subject='语文' order by code"
	Rs.Open Sql,Conn,1,1
	do while not Rs.Eof
  %>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td class="Right" align="center"><%=Rs("Code")%></td>
  <td align="center" class="Right"><%=Rs("UserName")%></td>
  <td align="center" class="Right"><%=Rs("Grade")%></td>
  <td align="center" class="Right"><%=Rs("Subject")%></td>
  <td align="center" class="Right"><a href="lookparent.asp?TeCCode=<%=Rs("Code")%>"><%=left(GetSorce("SorceParent",Rs("Code"))/6,5)%></a></td>
  <td align="center" class="Right"><a href="lookStudent.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce("Sorce",Rs("Code"))%></td>
  <td align="center" class="Right"><a href="looktec.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce1("Sorcetec",Rs("Code"),"否")%></td>
  <td align="center" class="Right"><a href="looktec1.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce1("Sorcetec",Rs("Code"),"是")%></td>
</tr>
<%
	Rs.MoveNext
	Loop
	Rs.Close:Set Rs=Nothing
%>
<!-- 数学组 -->
  <tr>
  <td colspan="8" align="left" class="Right pl10"><strong>数学组</strong></td>
  </tr>
  <%
  	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "select * from userreg1 where ISxz='否' and campus='九山' and Subject='数学' order by code"
	Rs.Open Sql,Conn,1,1
	do while not Rs.Eof
  %>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td class="Right" align="center"><%=Rs("Code")%></td>
  <td align="center" class="Right"><%=Rs("UserName")%></td>
  <td align="center" class="Right"><%=Rs("Grade")%></td>
  <td align="center" class="Right"><%=Rs("Subject")%></td>
  <td align="center" class="Right"><a href="lookparent.asp?TeCCode=<%=Rs("Code")%>"><%=left(GetSorce("SorceParent",Rs("Code"))/6,5)%></a></td>
  <td align="center" class="Right"><a href="lookStudent.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce("Sorce",Rs("Code"))%></td>
  <td align="center" class="Right"><a href="looktec.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce1("Sorcetec",Rs("Code"),"否")%></td>
  <td align="center" class="Right"><a href="looktec1.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce1("Sorcetec",Rs("Code"),"是")%></td>
</tr>
<%
	Rs.MoveNext
	Loop
	Rs.Close:Set Rs=Nothing
%>
<!-- 英语组 -->
  <tr>
  <td colspan="8" align="left" class="Right pl10"><strong>英语组</strong></td>
  </tr>
  <%
  	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "select * from userreg1 where ISxz='否' and campus='九山' and Subject='英语' order by code"
	Rs.Open Sql,Conn,1,1
	do while not Rs.Eof
  %>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td class="Right" align="center"><%=Rs("Code")%></td>
  <td align="center" class="Right"><%=Rs("UserName")%></td>
  <td align="center" class="Right"><%=Rs("Grade")%></td>
  <td align="center" class="Right"><%=Rs("Subject")%></td>
  <td align="center" class="Right"><a href="lookparent.asp?TeCCode=<%=Rs("Code")%>"><%=left(GetSorce("SorceParent",Rs("Code"))/6,5)%></a></td>
  <td align="center" class="Right"><a href="lookStudent.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce("Sorce",Rs("Code"))%></td>
  <td align="center" class="Right"><a href="looktec.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce1("Sorcetec",Rs("Code"),"否")%></td>
  <td align="center" class="Right"><a href="looktec1.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce1("Sorcetec",Rs("Code"),"是")%></td>
</tr>
<%
	Rs.MoveNext
	Loop
	Rs.Close:Set Rs=Nothing
%>
<!-- 综合组 -->
  <tr>
  <td colspan="8" align="left" class="Right pl10"><strong>综合组</strong></td>
  </tr>
  <%
  	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "select * from userreg1 where ISxz='否' and campus='九山' and Subject in ('科学','音乐','美术','体育','心理健康','信息技术','网络管理','国际象棋') order by code"
	Rs.Open Sql,Conn,1,1
	do while not Rs.Eof
  %>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td class="Right" align="center"><%=Rs("Code")%></td>
  <td align="center" class="Right"><%=Rs("UserName")%></td>
  <td align="center" class="Right"><%=Rs("Grade")%></td>
  <td align="center" class="Right"><%=Rs("Subject")%></td>
  <td align="center" class="Right"><a href="lookparent.asp?TeCCode=<%=Rs("Code")%>"><%=left(GetSorce("SorceParent",Rs("Code"))/6,5)%></a></td>
  <td align="center" class="Right"><a href="lookStudent.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce("Sorce",Rs("Code"))%></td>
  <td align="center" class="Right"><a href="looktec.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce1("Sorcetec",Rs("Code"),"否")%></td>
  <td align="center" class="Right"><a href="looktec1.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce1("Sorcetec",Rs("Code"),"是")%></td>
</tr>
<%
	Rs.MoveNext
	Loop
	Rs.Close:Set Rs=Nothing
%>
<!-- 国际部 -->
  <tr>
  <td colspan="8" align="left" class="Right pl10"><strong>国际部</strong></td>
  </tr>
  <%
  	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "select * from userreg1 where ISxz='否' and campus='国际' order by code"
	Rs.Open Sql,Conn,1,1
	do while not Rs.Eof
  %>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td class="Right" align="center"><%=Rs("Code")%></td>
  <td align="center" class="Right"><%=Rs("UserName")%></td>
  <td align="center" class="Right"><%=Rs("Grade")%></td>
  <td align="center" class="Right"><%=Rs("Subject")%></td>
  <td align="center" class="Right"><a href="lookparent.asp?TeCCode=<%=Rs("Code")%>"><%=left(GetSorce("SorceParent",Rs("Code"))/6,5)%></a></td>
  <td align="center" class="Right"><a href="lookStudent.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce("Sorce",Rs("Code"))%></td>
  <td align="center" class="Right"><a href="looktec.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce1("Sorcetec",Rs("Code"),"否")%></td>
  <td align="center" class="Right"><a href="looktec1.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce1("Sorcetec",Rs("Code"),"是")%></td>
</tr>
<%
	Rs.MoveNext
	Loop
	Rs.Close:Set Rs=Nothing
%>
<!-- 后勤组 -->
  <tr>
  <td colspan="8" align="left" class="Right pl10"><strong>后勤组</strong></td>
  </tr>
  <%
  	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "select * from userreg1 where ISxz='否' and campus='九山' and Subject in ('文员','校医','档案管理','财务','图书馆','后勤') order by code"
	Rs.Open Sql,Conn,1,1
	do while not Rs.Eof
  %>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
  <td class="Right" align="center"><%=Rs("Code")%></td>
  <td align="center" class="Right"><%=Rs("UserName")%></td>
  <td align="center" class="Right"><%=Rs("Grade")%></td>
  <td align="center" class="Right"><%=Rs("Subject")%></td>
  <td align="center" class="Right"><a href="lookparent.asp?TeCCode=<%=Rs("Code")%>"><%=left(GetSorce("SorceParent",Rs("Code"))/6,5)%></a></td>
  <td align="center" class="Right"><a href="lookStudent.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce("Sorce",Rs("Code"))%></td>
  <td align="center" class="Right"><a href="looktec.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce1("Sorcetec",Rs("Code"),"否")%></td>
  <td align="center" class="Right"><a href="looktec1.asp?TeCCode=<%=Rs("Code")%>"><%=GetSorce1("Sorcetec",Rs("Code"),"是")%></td>
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