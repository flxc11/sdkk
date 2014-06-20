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
<script language="javascript" type="text/javascript" src="Common/jquery-1.9.1.min.js"></script>
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
<script type="text/javascript" src="Common/jquery_select.js"></script>
<link href="Style/PopCalender.css" rel="stylesheet" type="text/css" />
  <style>
 #test select{
  width:200px;
  margin-left:20px;
  float:left;
 }
  </style>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：信息管理 >> 实验申请</td>
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
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td colspan="4" align="left" valign="middle">&nbsp;</td>
</tr>
<tr>
<th colspan="4">实验申请</th>
</tr>
<tr>
  <td colspan="4" align="center" class="Right">
  <div id="test">
  <select name="s1" id="s1" onchange="s1()">
  <option value="">请选择年级</option>
  <%
  	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * from newsclass where navparent=0 order by navorder"
	Rs.Open Sql,Conn,1,1
	do while not Rs.Eof
  %>
  <option value="<%=Rs("NavTitle")%>"><%=Rs("NavTitle")%></option>
  <%
  
  	Rs.MoveNext
	loop
	Rs.Close:Set Rs=Nothing
  %>
  </select>
  <select name="s2" id="s2" onchange="s2()">
  <option value="">请选择单元</option>
  </select>
  <select name="s3" id="s3" onchange="s3()">
  <option value="">请选择实验</option>
  </select>
  </div>
  </td>
</tr>
</table>
</td>
</tr>
</table>
</body>
</html>
<script type="text/javascript">
$(function(){

});
function s1(){
	var parentName=$("#s1").val();
	$.ajax({
		type:"POST",
		dataType: "json",
		url:"ajax.asp",
		data:"Action=APP&parentName=" + parentName + "&Time=" + (new Date().getTime()),
		error: function(){
				alert("数据库链接错误");
			},
		success: function(d){
			//var d = eval("(" + json.result + ")"); 
			var html="<option value=''>请选择单元</option>"
			$.each(d.Infolist, function (idx, item) {
				html+="<option value=" + item.SubName + ">" + item.SubName + "</option>";
			});
			$("#s2 option").remove();
			$("#s2").append(html);
		}
	})
}
function s2(){
	var Grade=$("#s1").val();
	var Unit=$("#s2").val();
	$.ajax({
		type:"POST",
		dataType: "json",
		url:"ajax.asp",
		data:"Action=Experi&Grade=" + Grade + "&Unit=" + Unit + "&Time=" + (new Date().getTime()),
		error: function(){
				alert("数据库链接错误");
			},
		success: function(d){
			//var d = eval("(" + json.result + ")"); 
			var html="<option value=''>请选择实验</option>"
			$.each(d.Infolist, function (idx, item) {
				html+="<option value=" + item.ID + ">" + item.ExperiTitle + "</option>";
			});
			$("#s3 option").remove();
			$("#s3").append(html);
		}
	})
}
function s3() {
	window.location.href='Experiment_app1.asp?ID=' + $("#s3").find('option:selected').val();
}
</script>
</body>
</html>