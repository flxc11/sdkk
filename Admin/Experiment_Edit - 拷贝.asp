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
<script language="javascript" type="text/javascript" src="Common/jquery162min.js"></script>
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
<link href="Style/PopCalender.css" rel="stylesheet" type="text/css" />
<script type="text/javascript">
$(function(){
	$("#instru_table tr").bind({
	  mouseenter:function(){$(this).css("background-color","#bdbdbd");},  
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
  
  <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0">
    <tr>
  <td class="Right" align="right" width="11%">年级：</td>
  <td width="33%" align="left" valign="middle" class="Right">
      <select id="ExperiGrade" name="ExperiGrade" style="width:100px;height:22px;float:left;"></select>
      <select id="ExperiUnit" name="ExperiUnit" style="width:100px;height:22px;float:left;"></select>
    
    
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
      <input type="checkbox" name="ExperiType" id="" value="1" /> 学生实验
      <input type="checkbox" name="ExperiType" id="" value="2" /> 分组实验
      </td>
    </tr>
    <tr>
      <td class="Right" align="right">课题：</td>
      <td colspan="3" class="Right"><input type="text" id="ExperiTitle" name="ExperiTitle" value="" class="Input200px" /></td>
    </tr>
    <tr>
      <td class="Right" align="right">实验内容：</td>
      <td colspan="3" class="Right"><input type="text" id="ExperiCnt" name="ExperiCnt" value="" class="Input200px" /></td>
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
<TD width="15%">实验套数:</TD>
<TD width="35%" colSpan=2><%=Rs("ExperiSats")%> 套</TD>
<TD width="20%" colSpan=2>&nbsp;</TD>
<TD width="20%">&nbsp;</TD></TR>
<TR>
<TD>申请人姓名:</TD>
<TD width="35%" colSpan=2><%=GetUserInfo(Rs("UserName"),"RealName")%></TD>
<TD width="20%" colSpan=2>联系方式:</TD>
<TD><%=GetUserInfo(Rs("UserName"),"TelPhone")%></TD></TR>
<TR>
<TD>申请单确认:</TD>
<TD colSpan=5>
<%
	if Rs("ExperiStatus")=0 then
	Response.Write("准备中")
	elseif Rs("ExperiStatus")=1 then
	Response.Write("已准备")
	elseif Rs("ExperiStatus")=2 then
	Response.Write("已完成")
	end if
%><%
	  if UserGroup<>3 then
	%>
<table width="300" border="0" align="right" cellpadding="0" cellspacing="0">
  <tr>
    <td width="78">修改状态：</td>
    <td width="222"><p>
    
        <label><input type="radio" name="ExperiStatus" value="0" <% if Rs("ExperiStatus")=0 then%> checked="checked" <% end if %> />
        准备中</label>
        <label><input type="radio" name="ExperiStatus" value="1" <% if Rs("ExperiStatus")=1 then%> checked="checked" <% end if %> />
        已准备</label>
      <label>
        <input type="radio" name="ExperiStatus" value="2" <% if Rs("ExperiStatus")=2 then%> checked="checked" <% end if %> />
        已完成</label>
      <br />
    </p>
    
    </td>
  </tr>
</table><% end if %></TD></TR></TBODY>
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