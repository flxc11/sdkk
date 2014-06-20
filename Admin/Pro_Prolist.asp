<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_MD5.asp"-->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/jquery180min.js"></script>
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
<style type="text/css">
span {
	color:#F00;
}
</style>
</head>

<body>
<%
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql="Select * From ShopInfo Where ShopLock=0 Order By ShopOrder Desc"
	Rs.Open Sql,Conn,1,1
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr>
    <td height="40"><a href="javascript:window.print();">打印仪器清单</a>&nbsp;┊&nbsp;<a href="Pro_SumAll.asp" style="font-weight:normal">汇总</a></td>
  </tr>
</table>

<table width="80%" border="0" align="center" cellpadding="0" cellspacing="0" class="Form" id="GridView1">
<tr>
<th width="10%" class="Right">仪器名称</th>
<th width="10%" class="Right">仪器类别</th>
<th width="5%" class="Right">仪器库存</th>
<th width="5%" class="Right">仪器总量</th>
<th width="5%" class="Right">单价</th>
<th width="5%" class="Right">总价</th>
<th width="40%">备注</th>
</tr>
<%Do While Not Rs.Eof%>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''" class="tr">
<td class="Right"><a href="Pro_ContentEdit.asp?ID=<%=Rs("ID")%>&Page=<%=Page%>&ClassID=<%=ClassID%>&FileName=Pro_ContentListIn&ShowType=<%=ShowType%>&ShopName=<%=Server.URLEncode(ShopName)%>">
  <%=Rs("ShopName")%>
</a></td>
<td class="Right">
<%=GetSubNavName("ShopClass",Rs("ClassID"))%>
</td>
<td class="Right"><%=Rs("numb2")%></td>
<td class="Right"><%=Rs("numb1")%></td>
<td class="Right"><%=Rs("price")%></td>
<td class="Right"><%=Rs("price")*Rs("numb2")%></td>
<td><%=Rs("shopcontent")%></td>
</tr>
<%
i=i+1
Rs.MoveNext
Loop
%>
</table>

<%
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * from ShopClass"
	Rs.Open Sql,Conn,1,1
	classcount = Rs.RecordCount
	Rs.Close:Set Rs=Nothing
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select * from shopinfo"
	Rs.Open Sql,Conn,1,1
	shopcount = Rs.RecordCount
	Rs.Close:Set Rs=Nothing
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select sum(numb2) as kcall from shopinfo"
	Rs.Open Sql,Conn,1,3
	kcall = Rs("kcall")
	Rs.Close:Set Rs=Nothing
	
	'dim kczj=""
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select sum(numb2*price) as kczj, sum(numb1*price) as zj from shopinfo"
	Rs.Open Sql,Conn,1,1
	'do while not Rs.eof
		'if(Rs("numb2")*Rs("price")="") then 
		'kczj=0
		'else
		'kczj = Rs("numb2")*Rs("price")
		'end if
		'kczj = kczj + kczj
		'Response.Write(kczj&"<br>")
	'Rs.MoveNext
	'loop
	kczj = Rs("kczj")
	zj = Rs("zj")
	Rs.Close:Set Rs=Nothing
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select sum(numb1) as ccall from shopinfo"
	Rs.Open Sql,Conn,1,3
	ccall = Rs("ccall")
	Rs.Close:Set Rs=Nothing
	
	Set Rs=Server.CreateObject("Adodb.RecordSet")
	Sql = "Select sum(price) as price1 from shopinfo"
	Rs.Open Sql,Conn,1,3
	price1 = Rs("price1")
	Rs.Close:Set Rs=Nothing
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form">
<tr>
<th colspan="2">统计</th>
</tr>
<tr>
  <td width="25%" align="right" class="Right">仪器种类：</td>
  <td>共有仪器类别 <span><%=classcount%></span> 大类</td>
  </tr>
<tr>
  <td class="Right" width="25%" align="right">仪器类别：</td>
  <td>共有仪器 <span><%=shopcount%></span> 种</td>
</tr>
<tr>
  <td class="Right" width="25%" align="right">仪器库存：</td>
  <td>在库 <span><%=kcall%></span> 件 库存总价：<span><%=kczj%></span> 元</td>
</tr>
<tr>
  <td class="Right" width="25%" align="right">仪器总数：</td>
  <td>共有仪器 <span><%=ccall%></span> 件 仪器总价：<span><%=zj%></span> 元</td>
</tr>
</table>
<script type="text/javascript">
//乘法函数，用来得到精确的乘法结果 
//说明：javascript的乘法结果会有误差，在两个浮点数相乘的时候会比较明显。这个函数返回较为精确的乘法结果。 
//调用：accMul(arg1,arg2) 
//返回值：arg1乘以arg2的精确结果 
function accMul(arg1,arg2) 
{ 
var m=0,s1=arg1.toString(),s2=arg2.toString(); 
try{m+=s1.split(".")[1].length}catch(e){} 
try{m+=s2.split(".")[1].length}catch(e){} 
return Number(s1.replace(".",""))*Number(s2.replace(".",""))/Math.pow(10,m) 
} 
//给Number类型增加一个mul方法，调用起来更加方便。 
Number.prototype.mul = function (arg){ 
return accMul(arg, this); 
} 
//加法函数，用来得到精确的加法结果 
//说明：javascript的加法结果会有误差，在两个浮点数相加的时候会比较明显。这个函数返回较为精确的加法结果。 
//调用：accAdd(arg1,arg2) 
//返回值：arg1加上arg2的精确结果 
function accAdd(arg1,arg2){ 
var r1,r2,m; 
try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0} 
try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0} 
m=Math.pow(10,Math.max(r1,r2)) 
return (arg1*m+arg2*m)/m 
} 
//给Number类型增加一个add方法，调用起来更加方便。 
Number.prototype.add = function (arg){ 
return accAdd(arg,this); 
}

$(function(){
	//var str="";
//	$(".tr").each(function(i, v) {
//        str =accAdd(accMul($(v).children("td:eq(2)").val(),$(v).children("td:eq(4)").val()),str);
//    });
//	$("#kczj").html(str);
})
</script>
</body>
</html>
