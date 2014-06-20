<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"Pro_ContentAdd")
Action=ReplaceBadChar(Trim(Request("Action")))
ClassID=ReplaceBadChar(Trim(Request("ClassID")))
If ClassID="" Then
	ClassID="0"
End If
If Action="Save" Then
	ShopName=ReplaceBadChar(Trim(Request("ShopName")))
	ClassID=ReplaceBadChar(Trim(Request("ClassID")))
	ShopSPic=Trim(Request("ShopSPic"))
	newnum=Trim(Request("newnum"))
	specifi=Request("specifi")
	unit=ReplaceBadChar(Trim(Request("unit")))
	numb1=Trim(Request("numb1"))
	numb2=Trim(Request("numb2"))
	price=ReplaceBadChar(Trim(Request("price")))
	ShopContent=Trim(Request("ShopContent"))
	ShopLock=ReplaceBadChar(Trim(Request("ShopLock")))	
	ShopVisit=ReplaceBadChar(Trim(Request("ShopVisit")))
	shopposi=Request("shopposi")
	'获取导航条的排序值
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select ShopOrder From ShopInfo Order By ShopOrder Desc"
	Rs.Open Sql,Conn,1,1
	If Not (Rs.Eof Or Rs.Bof) Then
		ShopOrder=Cstr(Trim(Rs("ShopOrder")))+1
	Else
		ShopOrder=1
	End If
	Rs.Close
	Set Rs=Nothing
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From ShopInfo"
	Rs.Open Sql,Conn,1,3
	Rs.AddNew
	Rs("ShopName")=ShopName
	Rs("ClassID")=ClassID
	Rs("ShopSPic")=ShopSPic
	Rs("newnum")=newnum
	Rs("specifi")=specifi
	Rs("unit")=unit
	Rs("numb1")=numb1
	Rs("numb2")=numb2
	Rs("price")=price
	Rs("ShopContent")=ShopContent
	Rs("ShopClick")=1
	Rs("ShopLock")=0
	Rs("ShopOrder")=ShopOrder
	Rs("ShopVisit")=0
	Rs("ShopIndex")=0
	Rs("shopposi")=shopposi
	Rs("PostTime")=Now()
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	if len(Trim(Request.Cookies("CNVP_CMS2")("attributeValue")))>0 then
		Set Rs2=Server.CreateObject("Adodb.RecordSet")
		Sql2="Select top 1 ID From ShopInfo Order By ID Desc"
		Rs2.Open Sql2,Conn,1,1
		if not Rs2.eof then
			Set Rs=Server.CreateObject("Adodb.RecordSet")
			Sql="Select * From ShopAttribute"
			Rs.Open Sql,Conn,1,3
			Rs.AddNew
			Aryfieldname=Split(Trim(Request.Cookies("CNVP_CMS2")("fieldname")),",")
			AryValue=Split(Trim(Request.Cookies("CNVP_CMS2")("attributeValue")),",")
			For i = LBound(AryValue) To UBound(AryValue)
				if Request(AryValue(i))<>"" then
					Rs(Aryfieldname(i))=Request(AryValue(i))
				else
					Rs(Aryfieldname(i))=0
				end if
			Next
			Rs("ProID")=Rs2("ID")
			Rs.Update
			Rs.Close
			Set Rs=Nothing
		end if
		Rs2.Close
		Set Rs2=Nothing
	end if
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('添加成功!');window.location.href='Pro_ContentAdd.asp?classid="&ClassID&"';</script>")
	Response.End()
End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/Jquery.js"></script>
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#ClassID").val("<%=ClassID%>");
	var zl = $("#numb1").val();
	var dj = $("#price").val();
	$("#pricecount").val(zl*dj);
});
</script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：仪器管理 >> 添加仪器</td>
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
<script language="javascript" type="text/javascript">
function aa() {
	var zl = $("#numb1").val();
	var dj = $("#price").val();
	$("#pricecount").val(zl*dj);
}
function CheckForm()
{
	if ($("#ShopName").val()=="")
	{
		alert("仪器名称不能为空");
		$("#ShopName").focus();
		return false;
	}
	if ($("#ClassID").val()==0)
	{
		alert("\u8bf7\u9009\u62e9\u680f\u76ee\u0021");
		$("#ClassID").focus();
		return false;
	}
	return true;	
}
</script>
<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
  <tr>
<td colspan="4" align="left" valign="middle"><input type="submit" value="保 存" class="Button"> <input type="button" value="返回" class="Button" onClick="history.back();"></td>
</tr>
<tr>
<th colspan="4">添加仪器</th>
</tr>
<tr>
  <td class="Right" align="right" width="10%">仪器名称：</td>
  <td class="Right"> 
    <div class="float_left_210txt">
      <input type="text" id="ShopName" name="ShopName" class="Input200px"/>
      </div>
  </td>
  <td class="Right" width="9%" align="right">仪器类别：</td>
  <td width="43%">
    <select id="ClassID" name="ClassID" style="width:200px;">
  <option value="0">|--请选择栏目</option>
  <%=GetSelect32("ShopClass",0,request("ClassID"))%>
  </select>
  </td>
</tr>
<tr>
  <td class="Right" align="right">编号：</td>
  <td><span class="float_left_210txt">
    <input type="text" id="newnum" name="newnum" class="Input200px"/>
  </span></td>
  <td align="right">单位：</td>
  <td><span class="float_left_210txt">
    <input type="text" id="unit" name="unit" class="Input200px"/>
  </span></td>
</tr>
<tr>
  <td class="Right" align="right">总量：</td>
  <td><span class="float_left_210txt">
    <input type="text" id="numb1" name="numb1" value="0" onchange="aa()" class="Input200px"/>
  </span></td>
  <td align="right">库存：</td>
  <td><span class="float_left_210txt">
    <input type="text" id="numb2" name="numb2" value="0" class="Input200px"/>
  </span></td>
</tr>
<tr>
  <td class="Right" align="right">规格：</td>
  <td><span class="float_left_210txt">
    <input type="text" id="specifi" name="specifi" class="Input200px"/>
  </span></td>
  <td align="right">单价：</td>
  <td><span class="float_left_210txt">
    <input type="text" id="price" name="price" onchange="aa()" class="Input200px"/>
  </span></td>
</tr>
<tr>
  <td class="Right" align="right">位置：</td>
  <td><span class="float_left_210txt">
    <input type="text" id="shopposi" name="shopposi" class="Input200px"/>
  </span></td>
  <td align="right">总价：</td>
  <td><span class="float_left_210txt">
    <input type="text" id="pricecount" name="pricecount" value="" class="Input200px"/>
  </span></td>
</tr>
<tr>
<td class="Right" align="right" valign="top">描述：</td>
<td colspan="3">
  <%=Editor2("ShopContent","")%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&FrameName=ShopContent&EnFrameName=EnShopContent"></script>
  
</td>
</tr>
<tr>
<td class="Right" align="right">&nbsp;</td>
<td colspan="3"><input type="submit" value="保 存" class="Button"> <input type="button" value="返回" class="Button" onClick="history.back();"></td>
</tr>
</table>
</form>
</td>
</tr>
</table>
</body>
</html>