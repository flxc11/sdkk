<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
	Action=ReplaceBadChar(Trim(Request("Action")))
	ID=ReplaceBadChar(Trim(Request("ID")))
	Page=ReplaceBadChar(Trim(Request("Page")))
	If Action="Save" Then
		ExperiStatus = Request("ExperiStatus")
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql = "Select * From Experiment where ID="&ID
		Rs.Open Sql,Conn,1,3
		if not (Rs.Eof or Rs.Bof) then
		Rs("ExperiStatus") = ExperiStatus
		Rs.Update
		end if
		Rs.Close:Set Rs=Nothing
		Response.Write("<script>alert('状态修改成功');window.location.href='experiment_List.asp?&Page="&Page&"';</script>")
	Response.End()
	end if
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://www.jqueryajax.com/wp-content/uploads/2009/03/jquery-132min2.js"></script>
<script type="text/javascript" src="Common/doubleselect.js"></script>
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
<link href="Style/PopCalender.css" rel="stylesheet" type="text/css" />


</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：实验管理 >> 实验详情</td>
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
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td colspan="4" align="left" valign="middle"><input type="button" value="返回" class="Button" onclick="history.back();" /></td>
</tr>
<tr>
<th colspan="4">实验器材准备单：</th>
</tr>
<tr>
  <td colspan="4" class="Right">
  <%
  	ID = ReplaceBadChar(Trim(Request("ID")))
  	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * From setsexperiments where ID="&ID
	Rs.Open Sql,Conn,1,1
	if not (Rs.Eof or Rs.Bof) then
  %>
  <script type="text/javascript">
$(document).ready(function(){
	//$("#instru_table tr").bind({
//	  mouseenter:function(){$(this).css("background-color","#ddd");},  
//	  mouseleave:function(){$(this).css("background-color","");}  
//	});
	$("#ExperiRoom").val("<%=Rs("ExperiRoom")%>");
    //$("#ExperiGrade").selected(defaults);
	//$("#ExperiUnit").attr("option",<%=Rs("ExperiUnit")%>);
	
	
	var selectOption={
		"请选择年级":{
		"key":" ",
		"defaultvalue" : "",
		"values":{'请选择单元':'请选择单元'}
		},
	 	<%
			Set Rs2=Server.CreateObject("Adodb.RecordSet")
			Sql2 = "Select * From NewsClass where NavParent=0 order by navorder"
			Rs2.Open Sql2,Conn,1,1
			j=0
			do while not Rs2.Eof and j<Rs2.RecordCount
			subtitle=""
		%>
		<%
			if j< Rs2.RecordCount-1 then
		%>
		"<%=Rs2("NavTitle")%>":{
		"key":"<%=Rs2("NavTitle")%>",
		"values":{<%
						Set Rsa1 = Server.CreateObject("Adodb.RecordSet")
						Sql1 = "Select * From NewsClass Where NavParent="&Rs2("ID")&" order by navorder"
						Rsa1.Open Sql1,Conn,1,1
						i=0
						do while not Rsa1.eof and i<Rsa1.RecordCount
						if i< Rsa1.RecordCount-1 then
						subtitle = subtitle&""""&Rsa1("NavTitle")&""""&":"&""""&Rsa1("NavTitle")&""""&","
						else
						subtitle = subtitle&""""&Rsa1("NavTitle")&""""&":"&""""&Rsa1("NavTitle")&""""
						end if
						i=i+1
						Rsa1.MoveNext
						loop
						Response.Write(subtitle)
						Rsa1.Close:Set Rsa1=Nothing
					%>}
		},
		<%
			else
		%>
		"<%=Rs2("NavTitle")%>":{
		"key":"<%=Rs2("NavTitle")%>",
		"values":{<%
						Set Rsa2 = Server.CreateObject("Adodb.RecordSet")
						Sql2 = "Select * From NewsClass Where NavParent="&Rs2("ID")&" order by navorder"
						Rsa2.Open Sql2,Conn,1,1
						i=0
						do while not Rsa2.eof and i<Rsa2.RecordCount
						if i< Rsa2.RecordCount-1 then
						subtitle = subtitle&""""&Rsa2("NavTitle")&""""&":"&""""&Rsa2("NavTitle")&""""&","
						else
						subtitle = subtitle&""""&Rsa2("NavTitle")&""""&":"&""""&Rsa2("NavTitle")&""""
						end if
						i=i+1
						Rsa2.MoveNext
						loop
						Response.Write(subtitle)
						Rsa2.Close:Set Rsa2=Nothing
					%>}
		}
		<%
			end if
			j=j+1
			Rs2.MoveNext
			Loop
			Rs2.Close:Set Rs2=Nothing
		%>
	};
$("#ExperiGrade").doubleSelect("ExperiUnit",selectOption);
$("#ExperiGrade").val("<%=Rs("ExperiGrade")%>");
</script>
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
  <td class="Right" align="right" width="11%">年级：</td>
  <td width="33%" align="left" valign="middle" class="Right">
      <select id="ExperiGrade" name="ExperiGrade" style="width:100px;height:22px;float:left;">
      </select>
      <select id="ExperiUnit" name="ExperiUnit" style="width:100px;height:22px;float:left;">      </select>
    
    
  </td>
  <td width="24%" align="right" class="Right">实验教室：</td>
  <td width="32%">
      <!-- <select id="ExperiType" name="ExperiType" style="width:200px;">
        <option value="0">|--请选择实验类型</option>
        <option value="1">课堂演示实验</option>
        <option value="2">学生分组实验</option>
        </select> -->
        <select id="ExperiRoom" name="ExperiRoom" style="width:200px;height:22px;">
        <option value="0">请选择教室</option>
        <%=GetSelectGrade("RoomClass","1")%>
      </select>
    </td>
</tr>
    <tr>
      <td class="Right" align="right">实验类型：</td>
      <td colspan="3" class="Right">
      <input type="checkbox" name="ExperiType" value="1" <% if instr(Rs("ExperiType"),"1") then%>checked=checked <%end if%> /> 学生实验
      <input type="checkbox" name="ExperiType" value="2" <% if instr(Rs("ExperiType"),"2") then%>checked=checked <%end if%> /> 分组实验
      </td>
    </tr>
    <tr>
      <td class="Right" align="right">课题：</td>
      <td colspan="3" class="Right"><input type="text" id="ExperiTitle" name="ExperiTitle" value="<%=Rs("ExperiTitle")%>" class="Input200px" /></td>
    </tr>
    <tr>
      <td class="Right" align="right">实验内容：</td>
      <td colspan="3" class="Right"><input type="text" id="ExperiCnt" name="ExperiCnt" value="<%=Rs("ExperiCnt")%>" class="Input200px" /></td>
    </tr>
  </table>
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
  <TBODY>
<TR>
  <TD colSpan=6>
  <TABLE width="99%" id="instru_table">
  <TBODY>
  <%
	instru_char = split(Rs("ExperiInstrument"),",")
	num_char = split(left(Rs("ExperiNumber"),len(Rs("ExperiNumber"))-1),",")
	for i=LBound(instru_char) to UBound(instru_char)
	Set Rsw = Server.CreateObject("Adodb.RecordSet")
	Sqlw = "Select * From shopinfo where ID="&instru_char(i)
	Rsw.Open Sqlw,Conn,1,1
%>
  <TR>
  <TD height=22 width="11%">器材编号:</TD>
  <TD width="11%"><%=Rsw("newnum")%><TD>
  <TD width="15%">器材名称:</TD>
  <TD width="46%"><%=Rsw("ShopName")%></TD>
  <TD width="13%">器材数量:</TD>
  <TD width="11%"><%=num_char(i)%></TD></TR>
  <%
	Rsw.Close:Set Rsw=Nothing
	next
%>
  </TBODY>
  </TABLE>
</TD></TR>
<TR>
  <TD width="10%">实验套数:</TD>
  <TD colSpan=2>
    <input type="text" id="ExperiSats" name="ExperiSats" value="<%=Rs("ExperiSats")%>" class="Input200px" /></TD>
  <TD colSpan=2>&nbsp;</TD>
  <TD width="22%">&nbsp;</TD></TR>
</TBODY>
</table>
<%
  end if
  Rs.Close:Set Rs=Nothing
%>
  
  </td>
</tr>

<tr>
  <td class="Right" align="right"><%
	  if UserGroup<>3 then
	%><input type="submit" value="保 存" class="Button" /><% end if %></td>
  <td colspan="3"><input type="button" value="返回" class="Button" onclick="history.back();" /></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>