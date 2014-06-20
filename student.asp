<!--#include file="Config/Conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<!--#include file="checkstu.asp" -->

<%
	action=Request("action")
	TecCount1 = Request("TecCount")
	if action="submitup" then
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "select * from sorce"
	Rs.Open Sql,Conn,1,3
	for j=1 to cint(TecCount1)
	TecCode = Request("code"&j)
	StuCode = StudentID
	TecSorce = Request("radio"&j)
	Content = Request("textarea"&j)
	
	Rs.Addnew
	Rs("TecCode")=TecCode
	Rs("StuCode")=StuCode
	Rs("TecSorce")=TecSorce
	Rs("Content")=Content
	Rs("TecCode")=TecCode
	Rs("SorceType")="1"
	Rs("PostTime")=now()
	Rs.Update
	next
	Rs.Close:Set Rs=Nothing
	Response.Write("<script>alert('评分成功');window.location.href='stulogin.asp';</script>")
	Response.End()
	end if	
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * from SetsExperiments where ExperiType ='"&StudentID&"'"
	Rs.Open Sql,Conn,1,1
	if not (Rs.Eof or Rs.Bof) then
	GradeName = GetSubNavName("RoomClass",GetNavParent("RoomClass",Rs("ExperiRoom")))
	ClassName = GetSubNavName("RoomClass",Rs("ExperiRoom"))
	StuName = Rs("ExperiTitle")
	RoomID = Rs("ExperiRoom")
	end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<%=SiteKeysTitle("学生登录")%>
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
        <td width="96" rowspan="2"><p align="center">序号 </p><input type="hidden" name="TecCount" value="<%=TecCount%>" /></td>
        <td width="96" rowspan="2"><p align="center">所任学科 </p></td>
        <td width="96" rowspan="2"><p align="center">姓名 </p></td>
        <td width="384" colspan="4"><p align="center">师德评价 </p></td>
        <td width="219" rowspan="2"><p align="center">其他问题和建议 </p></td>
      </tr>
      <tr>
        <td width="96"><p align="center">好 </p></td>
        <td width="96"><p align="center">较好 </p></td>
        <td width="96"><p align="center">一般 </p></td>
        <td width="96"><p align="center">差 </p></td>
      </tr>
      <%
		i=1
		do while not Rs.Eof
	  %>
      <tr onmousemove="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
        <td width="96" align="center" valign="middle"><p align="center"><%=i%></p></td>
        <td width="96" align="center" valign="middle"><p align="center"><%=Rs("Subject")%>&nbsp;</p></td>
        <td width="96" align="center" valign="middle"><p align="center"><%=Rs("UserName")%><input type="hidden" name="Code<%=i%>" value="<%=Rs("Code")%>" /></p></td>
        <td width="96" align="center" valign="middle"><p align="center">
          <input type="radio" name="radio<%=i%>" id="radioa1<%=i%>" value="100" />
        </p></td>
        <td width="96" align="center" valign="middle"><p align="center">
          <input type="radio" name="radio<%=i%>" id="radioa2<%=i%>" value="80" />
        </p></td>
        <td width="96" align="center" valign="middle"><p align="center">
          <input type="radio" name="radio<%=i%>" id="radioa3<%=i%>" value="60" />
        </p></td>
        <td width="96" align="center" valign="middle"><p align="center">
          <input type="radio" name="radio<%=i%>" id="radioa4<%=i%>" value="50" />
        </p></td>
        <td width="219" valign="top"><textarea name="textarea<%=i%>" id="textarea" rows="3" style="width:219px;"></textarea></td>
      </tr>
      <%
	  	i=i+1
		Rs.MoveNext
		Loop
		end if
		Rs.Close:Set Rs=Nothing
	  %>
    </table>
    <table width="892" border="0" cellspacing="0" cellpadding="0">
      <tr>
        <td height="40" align="center"><input type="submit" name="button" id="button" value="提交" style="width:60px;height:30px;cursor:pointer;" /></td>
      </tr>
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
