<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
	ID=ReplaceBadChar(Trim(Request("ID")))
	Page=ReplaceBadChar(Trim(Request("Page")))
	Action=ReplaceBadChar(Trim(Request("Action")))
	If Action="Save" Then
	ExperiTec=Request("ExperiTec")
	ExperiTime=Request("ExperiTime")
	if UserGroup<>3 then
	ExperiStatus=Request("ExperiStatus")
	end if
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * From Experiment where ID="&ID&""
	Rs.Open Sql,Conn,1,3
	Rs("ExperiTec")=ExperiTec
	Rs("ExperiTime")=ExperiTime
	if UserGroup<>3 then
	Rs("ExperiStatus")=ExperiStatus
	end if
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('修改成功！');window.location.href='experimentApp_List.asp?Page="&Page&"';</script>")
	Response.End()
	end if
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
<input type="hidden" id="Page" name="Page" value="<%=Page%>"/>
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
	Set Rsa = Server.CreateObject("Adodb.RecordSet")
	Sqla = "select * from experiment where ID="&ID&""
	Rsa.Open Sqla,Conn,1,1
	if not (Rsa.Eof or Rsa.Bof) then
  	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * From setsexperiments where ID="&Rsa("ExperiID")
	Rs.Open Sql,Conn,1,1
	if not (Rs.Eof or Rs.Bof) then
  %>
  <script type="text/javascript">
$(function(){
	$("#instru_table tr").bind({
	  mouseenter:function(){$(this).css("background-color","#ddd");},  
	  mouseleave:function(){$(this).css("background-color","");}  
	});
	
	$("input[type='radio']").change(function(){
		var atype = $(this).val();
		var _ID = <%=ID%>;
		$.ajax({
		type:"POST",
		dataType: "html",
		url:"ajax.asp",
		data:"Action=" + atype + "&ID=" + _ID + "&Time=" + (new Date().getTime()),
		error: function(){
				alert("数据库链接错误");
			},
		success: function(d){
				
				}
		})
	})
})
</script>
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
  <td class="Right" align="right" width="11%">年级：</td>
  <td width="33%" align="left" valign="middle" class="Right"><%=Rs("ExperiGrade")%> - <%=Rs("ExperiUnit")%></td>
  <td width="24%" align="right" class="Right">实验教室：</td>
  <td width="32%"><%
  	Set rsr = server.CreateObject("adodb.recordset")
	sqlr = "select * from roomclass where id="&Rs("ExperiRoom")&""
	rsr.open sqlr,conn,1,1
	if not (rsr.eof or rsr.bof) then
	response.Write(rsr("NavTitle"))
	end if
	rsr.close:set rsr=nothing
  %></td>
</tr>
<tr>
  <td class="Right" align="right" width="11%">实验教师：</td>
  <td width="33%" align="left" valign="middle" class="Right"><input type="text" id="ExperiTec" name="ExperiTec" value="<%=Rsa("ExperiTec")%>" class="Input200px" /></td>
  <td width="24%" align="right" class="Right">实验时间：</td>
  <td width="32%"><input type="text" id="ExperiTime" name="ExperiTime" value="<%=Rsa("ExperiTime")%>" class="Input200px" /></td>
</tr>
    
    <tr>
      <td class="Right" align="right">课题：</td>
      <td colspan="3" class="Right"><input name="ExperiTitle" type="text" class="Input200px" id="ExperiTitle" value="<%=Rs("ExperiTitle")%>" readonly="readonly" /></td>
    </tr>
    <tr>
      <td class="Right" align="right">实验内容：</td>
      <td colspan="3" class="Right"><input name="ExperiCnt" type="text" class="Input200px" id="ExperiCnt" value="<%=Rs("ExperiCnt")%>" readonly="readonly" /></td>
    </tr>
    <tr>
      <td class="Right" align="right">实验类型：</td>
      <td colspan="3" class="Right">
      <% if instr(Rs("ExperiType"),"1") then%>演示实验,<%end if%>
      <% if instr(Rs("ExperiType"),"2") then%>分组实验<%end if%>
      </td>
    </tr>
  </table>
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
  <TBODY>
<TR>
  <TD colSpan=6>
  <TABLE width="99%" id="instru_table">
  <TBODY>
  <%
  	if(len(Rs("ExperiInstrument"))>0) then
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
  <TD width="15%">器材名称:<%=Rsw("ShopName")%></TD>
  <TD width="46%">器材位置：<%=Rsw("shopposi")%></TD>
  <TD width="13%">器材数量:</TD>
  <TD width="11%"><%=num_char(i)%></TD></TR>
  <%
	Rsw.Close:Set Rsw=Nothing
	next
%>
  <%
  	else
  %>
  <TR>
  <TD height=22 width="11%" align="right">器材编号:</TD>
  <TD height=22 width="89%" colspan="6">无需仪器。</TD>
  <%end if%>
  </TBODY>
  </TABLE>
</TD></TR>
<tr>
<td class="Right" align="right">材料备注：</td>
<td colspan="2" class="Right"><textarea name="ExperiBZ" readonly="readonly" class="Input200px" id="ExperiBZ" style="width:400px;height:100px;"><%=Rs("ExperiBZ")%></textarea></td><TD colSpan=2>&nbsp;</TD>
  <TD width="22%">&nbsp;</TD>
</tr>
<TR>
  <TD width="10%">实验套数:</TD>
  <TD colSpan=2>
    <input name="ExperiSats" type="text" class="Input200px" id="ExperiSats" value="<%=Rs("ExperiSats")%>" readonly="readonly" /></TD>
  <TD colSpan=2>&nbsp;</TD>
  <TD width="22%">&nbsp;</TD></TR>
  <TR>
<TD>申请单确认:</TD>
<TD colSpan=5>
<%
	if Rsa("ExperiStatus")=0 then
	Response.Write("准备中")
	elseif Rsa("ExperiStatus")=1 then
	Response.Write("已准备")
	elseif Rsa("ExperiStatus")=2 then
	Response.Write("已完成")
	end if
%><%
	  if UserGroup<>3 then
	%>
<table width="300" border="0" align="right" cellpadding="0" cellspacing="0">
  <tr>
    <td width="78">修改状态：</td>
    <td width="222"><p>
    
        <label><input type="radio" name="ExperiStatus" value="0" <% if Rsa("ExperiStatus")=0 then%> checked="checked" <% end if %> />
        准备中</label>
        <label><input type="radio" name="ExperiStatus" value="1" <% if Rsa("ExperiStatus")=1 then%> checked="checked" <% end if %> />
        已准备</label>
      <label>
        <input type="radio" name="ExperiStatus" value="2" <% if Rsa("ExperiStatus")=2 then%> checked="checked" <% end if %> />
        已完成</label>
      <br />
    </p>
    
    </td>
  </tr>
</table><% end if %></TD></TR>
</TBODY>
</table>
<%
  end if
  Rs.Close:Set Rs=Nothing
  end if
  Rsa.Close:Set Rsa=Nothing
%>
  
  </td>
</tr>

<tr>
  <td class="Right" align="right">
  <input type="submit" value="修 改" class="Button" /></td>
  <td colspan="3"><input type="button" value="返回" class="Button" onclick="history.back();" /></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>