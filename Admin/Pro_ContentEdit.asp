<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#Include File="../Editor/fckeditor.asp"-->
<%
Call ISPopedom(UserName,"Pro_ContentAdd")
Action=ReplaceBadChar(Trim(Request("Action")))
ID=ReplaceBadChar(Trim(Request("ID")))
Page=ReplaceBadChar(Trim(Request("Page")))
ClassID=ReplaceBadChar(Trim(Request("ClassID")))
FileName=ReplaceBadChar(Trim(Request("FileName")))
ShowType=ReplaceBadChar(Trim(Request("ShowType")))
If Action="Save" Then
	ShopName=ReplaceBadChar(Trim(Request("ShopName")))
	
	ShopName=ReplaceBadChar(Trim(Request("ShopName")))
	ClassID=ReplaceBadChar(Trim(Request("ClassID")))
	ShopSPic=Trim(Request("ShopSPic"))
	newnum=Trim(Request("newnum"))
	specifi=ReplaceBadChar(Trim(Request("specifi")))
	unit=ReplaceBadChar(Trim(Request("unit")))
	numb1=Trim(Request("numb1"))
	numb2=Trim(Request("numb2"))
	price=Trim(Request("price"))
	ShopContent=Trim(Request("ShopContent"))
	ShopLock=ReplaceBadChar(Trim(Request("ShopLock")))	
	ShopVisit=ReplaceBadChar(Trim(Request("ShopVisit")))
	shopposi=Request("shopposi")

	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From ShopInfo Where ID="&ID&""
	Rs.Open Sql,Conn,1,3
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
	Rs("shopposi")=shopposi
	Rs("ShopLock")=0
	Rs("ShopVisit")=0
	Rs.Update
	Rs.Close
	Set Rs=Nothing
	if len(Trim(Request.Cookies("CNVP_CMS2")("attributeValue2")))>0 then
		Set Rs=Server.CreateObject("Adodb.RecordSet")
		Sql="Select * From ShopAttribute where ProID="&ID
		Rs.Open Sql,Conn,1,3
		Aryfieldname=Split(Trim(Request.Cookies("CNVP_CMS2")("fieldname2")),",")
		AryValue=Split(Trim(Request.Cookies("CNVP_CMS2")("attributeValue2")),",")
		For i = LBound(AryValue) To UBound(AryValue)
			if Request(AryValue(i))<>"" then
				Rs(Aryfieldname(i))=Request(AryValue(i))
			else
				Rs(Aryfieldname(i))=0
			end if
		Next
		Rs.Update
		Rs.Close
		Set Rs=Nothing
	end if
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('修改成功!');window.location.href='"&FileName&".asp?ClassID="&ClassID&"&Edit=ename&Page="&Page&"&ShowType="&ShowType&"&ShopName="&Request("Keyword")&"';</script>")
	Response.End()
End If
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/jquery180min.js"></script>
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
<script language="javascript" type="text/javascript">
$(function(){
	$("#ClassID").val("<%=ClassID%>");
	var zl = $("#numb1").val();
	var dj = $("#price").val();
	$("#pricecount").val(zl*dj);
});
function aa() {
	var zl = $("#numb1").val();
	var dj = $("#price").val();
	$("#pricecount").val(zl*dj);
}
function CheckForm()
{
	if ($("#ShopName").val()=="")
	{
		alert("\u5546\u54c1\u540d\u79f0\u4e0d\u80fd\u4e3a\u7a7a\u3002");
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
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：仪器管理 >> 编辑仪器</td>
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
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql="Select * From ShopInfo Where ID="&ID&""
Rs.Open Sql,Conn,1,1
If Not (Rs.Bof Or Rs.Eof) Then
	ClassID=Rs("ClassID")
	ShopName=Rs("ShopName")
	newnum=Rs("newnum")
	specifi=Rs("specifi")
	ShopsPic=Rs("ShopsPic")
	unit=Rs("unit")
	numb1=Rs("numb1")
	numb2=Rs("numb2")
	price=Rs("price")
	ShopContent=Rs("ShopContent")
	ShopLock=Rs("ShopLock")
	ShopVisit=Rs("ShopVisit")
	shopposi=Rs("shopposi")
End If
Rs.Close
Set Rs=Nothing
%>

<form id="form1" name="form1" method="post" action="?Action=Save" onSubmit="return CheckForm();">
<input type="hidden" id="ID" name="ID" value="<%=ID%>"/>
<input type="hidden" id="Page" name="Page" value="<%=Page%>"/>
<input type="hidden" id="FileName" name="FileName" value="<%=FileName%>"/>
<input type="hidden" id="ShowType" name="ShowType" value="<%=ShowType%>"/>
<input type="hidden" id="Keyword" name="Keyword" value="<%=Request("ShopName")%>"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<td colspan="4" align="left" valign="middle"><input type="submit" value="保 存" class="Button"> <input type="button" value="返回" class="Button" onClick="history.back();"></td>
</tr>
<tr>
<th colspan="4">编辑商品</th>
</tr>
<tr>
  <td class="Right" align="right" width="10%">仪器名称：</td>
  <td class="Right"> 
    <div class="float_left_210txt">
      <input type="text" id="ShopName" name="ShopName" value="<%=ShopName%>" class="Input200px"/>
      </div>
  </td>
  <td class="Right" width="9%" align="right">仪器类别：</td>
  <td width="43%">
    <div class="float_left_210">
      <select id="ClassID" name="ClassID" style="width:200px;">
        <option value="0">|--请选择栏目</option>
        <%=GetSelect("ShopClass",0)%>
        </select>
      </div> 
  </td>
</tr>
<tr>
  <td class="Right" align="right">编号：</td>
  <td><span class="float_left_210txt">
    <input type="text" id="newnum" name="newnum" value="<%=newnum%>" class="Input200px"/>
  </span></td>
  <td align="right">单位：</td>
  <td><span class="float_left_210txt">
    <input type="text" id="unit" name="unit" value="<%=unit%>" class="Input200px"/>
  </span></td>
</tr>
<tr>
  <td class="Right" align="right">总量：</td>
  <td><span class="float_left_210txt">
    <input type="text" id="numb1" name="numb1" value="<%=numb1%>" onchange="aa()" class="Input200px"/>
  </span></td>
  <td align="right">库存：</td>
  <td><span class="float_left_210txt">
    <input type="text" id="numb2" name="numb2" value="<%=numb2%>" class="Input200px"/>
  </span></td>
</tr>
<tr>
  <td class="Right" align="right">规格：</td>
  <td><span class="float_left_210txt">
    <input type="text" id="specifi" name="specifi" value="<%=specifi%>" class="Input200px"/>
  </span></td>
  <td align="right">单价：</td>
  <td><span class="float_left_210txt">
    <input type="text" id="price" name="price" value="<%=price%>" onchange="aa()" class="Input200px"/>
  </span></td>
</tr>
<tr>
  <td class="Right" align="right">位置：</td>
  <td><span class="float_left_210txt">
    <input type="text" id="shopposi" name="shopposi" value="<%=shopposi%>" class="Input200px"/>
  </span></td>
  <td align="right">总价</td>
  <td><span class="float_left_210txt">
    <input type="text" id="pricecount" name="pricecount" value="" class="Input200px"/>
  </span></td>
</tr>
<tr>
<td class="Right" align="right" valign="top">备注：</td>
<td colspan="3">
  <%=Editor2("ShopContent",ShopContent)%><span id="timemsg"></span><span id="msg2"></span><span id="msg"></span><script src="AutoSave.asp?Action=AutoSave&FrameName=ShopContent&EnFrameName=EnShopContent"></script>
  
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