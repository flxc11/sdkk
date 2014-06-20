<!--#include file="Config/Conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<!--#include file="checkparent.asp" -->

<%	
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * from SetsExperiments where ExperiType ='"&StudentID&"'"
	Rs.Open Sql,Conn,1,1
	if not (Rs.Eof or Rs.Bof) then
	GradeName = GetSubNavName("RoomClass",GetNavParent("RoomClass",Rs("ExperiRoom")))
	ClassName = GetSubNavName("RoomClass",Rs("ExperiRoom"))
	StuName = Rs("ExperiTitle")
	RoomID = Rs("ExperiRoom")
	end if
	Rs.Close:Set Rs=Nothing
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%=SiteKeysTitle("家长登录")%>
<link rel="stylesheet" href="css/Global.css" />
<link rel="stylesheet" href="css/Base.css" />
<script type="text/javascript" src="js/jquery180min.js"></script>

</head>

<body>
<!--#include file="top.asp" -->
<div class="container">
  <div class="class"><%=GradeName%>-<%=ClassName%>-<%=StuName%>
  <form action="?action=submitup" name="form1" method="post" onsubmit="return check()">
  <%
  	Set Rs=server.CreateObject("adodb.recordset")
		sql = "select * from userreg1 where Roomclass='"&RoomID&"'"
		Rs.Open Sql,Conn,1,1
		if not Rs.Eof then
		TecCount = Rs.RecordCount
  %>
    <table border="1" cellspacing="0" cellpadding="0" width="892" id="teclist" bordercolor="#CCCCCC">
      <tr>
        <td width="163"><p align="center">序号 </p><input type="hidden" name="TecCount" value="<%=TecCount%>" /></td>
        <td width="336"><p align="center">所任学科 </p></td>
        <td width="385"><p align="center">教师姓名 </p></td>
        </tr>
      <%
		i=1
		do while not Rs.Eof
	  %>
      
      <tr onmousemove="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
        <td width="163" align="center" valign="middle"><p align="center"><%=i%></p></td>
        <td width="336" align="center" valign="middle"><p align="center"><%=Rs("Subject")%>&nbsp;</p></td>
        <td width="385" align="center" valign="middle"><p align="center" style="color:red"><% if ISParentSorce("SorceParent",StudentID,Rs("Code")) then%><%=Rs("UserName")%>(已评分)<% else %><a href="parent.asp?TecCode=<%=Rs("Code")%>"><%=Rs("UserName")%><font color="red">（点击进入）</font></a><% end if %></p></td>
        </tr>
      <%
	  	i=i+1
		Rs.MoveNext
		Loop
		end if
		Rs.Close:Set Rs=Nothing
	  %>
    </table>
    </form>
  </div>
</div>
<div class="footer">
	<div class="footer_cnt">温州市籀园小学 版权所有 Copyright © 2012-2013 wzssx.net All rights reserved</div>
</div>
<script type="text/javascript">
function check() {
	var tcount = $("#teclist tr").length-2;
	if($("input[name*='radio']:checked").length < tcount) {
		alert("请对所有的老师进行打分之后再提交！");
		return false;
	}
	return true;
}
</script>
</body>
</html>
