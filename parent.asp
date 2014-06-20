<!--#include file="Config/Conn.asp" -->
<!--#include file="Include/Class_Function.asp" -->
<!--#include file="checkparent.asp" -->

<%
	action=ReplaceBadChar(Trim(Request("action")))
	TecCode=ReplaceBadChar(Trim(Request("TecCode")))
	if action="submitup" then
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "select * from sorceparent"
	Rs.Open Sql,Conn,1,3
	TecCode = TecCode
	StuCode = StudentID
	TecSorce = Request("radiosum")
	Content = Request("textarea")
	Radio1 = ReplaceBadChar(Trim(Request("RadioGroup1")))
	Radio2 = ReplaceBadChar(Trim(Request("RadioGroup2")))
	Radio3 = ReplaceBadChar(Trim(Request("RadioGroup3")))
	Radio4 = ReplaceBadChar(Trim(Request("RadioGroup4")))
	Radio5 = ReplaceBadChar(Trim(Request("RadioGroup5")))
	Radio6 = ReplaceBadChar(Trim(Request("RadioGroup6")))
	
	Rs.Addnew
	Rs("TecCode")=TecCode
	Rs("StuCode")=StuCode
	Rs("TecSorce")=TecSorce
	Rs("Content")=Content
	Rs("TecCode")=TecCode
	Rs("SorceType")="2"
	Rs("Radio1")=Radio1
	Rs("Radio2")=Radio2
	Rs("Radio3")=Radio3
	Rs("Radio4")=Radio4
	Rs("Radio5")=Radio5
	Rs("Radio6")=Radio6
	Rs("PostTime")=now()
	Rs.Update
	Rs.Close:Set Rs=Nothing
	Response.Write("<script>alert('评分成功');window.location.href='parentlist.asp';</script>")
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
<style type="text/css">
u {
	color:red;
}
p {
	font-size:18px;
}
</style>
</head>

<body>
<!--#include file="top.asp" -->
<div class="container">
  <div>
  <form action="?action=submitup" name="form1" method="post" onsubmit="return check()">
  <%
    
  	Set Rs=server.CreateObject("adodb.recordset")
	sql = "select * from userreg1 where Code='"&TecCode&"'"
	Rs.Open Sql,Conn,1,1
	if not (Rs.Eof or Rs.Bof) then
  %>
  <p align="center" style="font-size:16px;font-weight:bold;">温州市中小学（幼儿园）教师师德考核家长问卷测评 </p>
  <p align="left">尊敬的家长： <br />
    　　您好！ <br />
    　　您的孩子<u> <%=StuName%> </u>就读<u> <%=GradeName%> </u> <u> <%=ClassName%> </u>，<u> <%=Rs("UserName")%> <input type="hidden" name="TecCode" value="<%=TecCode%>" /></u>老师是该班<u> <%=Rs("Subject")%> </u>课教师。 <br />
    　　为进一步了解该教师师德情况，为孩子营造良好的教育、学习氛围，请您本着实事求是的态度填写本问卷调查表，感谢您的参与帮助！ <br />
    1.该教师是否认真备课上课、认真批改作业、认真辅导学生。 <br />
    
    </p>
    <p><input type="radio" name="RadioGroup1" value="100" id="RadioGroup1_0" />
      是 <input type="radio" name="RadioGroup1" value="0" id="RadioGroup1_1" />
      否</p>
    <p>2. 该教师是否要求您的孩子参加有偿家教或补课？ </p>
   <p><input type="radio" name="RadioGroup2" value="0" id="RadioGroup1_0" />
      是 <input type="radio" name="RadioGroup2" value="100" id="RadioGroup1_1" />
      否</p>
    <p>3.该教师是否对您的孩子存在体罚或变相体罚或者其他歧视情况？</p>
    <p><input type="radio" name="RadioGroup3" value="0" id="RadioGroup1_0" />
      是 <input type="radio" name="RadioGroup3" value="100" id="RadioGroup1_1" />
      否</p>
    <p>4. 该教师是否存在利用职务之便接受或索取家长礼品、礼卡的情况？ </p>
    <p><input type="radio" name="RadioGroup4" value="0" id="RadioGroup1_0" />
      是 <input type="radio" name="RadioGroup4" value="100" id="RadioGroup1_1" />
      否</p>
    <p>5. 该教师是否存在向您的孩子销售或强制推销教辅资料的情况？</p>
    <p><input type="radio" name="RadioGroup5" value="0" id="RadioGroup1_0" />
      是 <input type="radio" name="RadioGroup5" value="100" id="RadioGroup1_1" />
      否</p>
    <p>6.您对该教师师德总体评价是</p>
    <p><input type="radio" name="RadioGroup6" value="100" id="RadioGroup1_0" />
      好 <input type="radio" name="RadioGroup6" value="80" id="RadioGroup1_1" />
      较好 <input type="radio" name="RadioGroup6" value="60" id="RadioGroup1_0" />
      一般 <input type="radio" name="RadioGroup6" value="50" id="RadioGroup1_1" />
      差</p>
<p>7.您对学校教师师德师风建设的意见建议。<br />
  <textarea name="textarea" id="textarea" cols="60" rows="8"></textarea>
  <input type="hidden" name="radiosum" id="radiosum" />
</p>
  <table width="892" border="0" cellspacing="0" cellpadding="0">
    <tr>
        <td height="40" align="center"><input type="submit" name="button" id="button" value="提交" style="width:60px;height:30px;cursor:pointer;" /></td>
      </tr>
</table>
<%
	end if
	Rs.Close:Set Rs=Nothing
%>
    </form>
  </div>
</div>
<div class="footer">
	<div class="footer_cnt">温州市籀园小学 版权所有 Copyright © 2012-2013 wzssx.net All rights reserved</div>
</div>
<script type="text/javascript">
function check() {
	if($("input[name*='RadioGroup']:checked").length != 6) {
		alert("请填写完调查选项之后再提交！");
		return false;
	}
	else {
		var sorcesum=0;
		$("input[name*='RadioGroup']:checked").each(function(i, v) {
            sorcesum += parseInt($(v).val());
        });
		$("#radiosum").attr("value",sorcesum);
		return true;
	}
	
}
</script>
</body>
</html>
