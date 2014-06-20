<!--#include File="CheckLogin.asp"-->
<!--#include File="../Config/Config.asp"-->
<!--#include File="../Include/Class_Function.asp"-->
<!--#include File="../Include/Class_MD5.asp"-->
<%
Action=ReplaceBadChar(Trim(Request("Action")))
ExperiType=ReplaceBadChar(Trim(Request("ExperiType")))
If ExperiType="" Then ExperiType=0
ID=ReplaceBadChar(Trim(Request("ID")))
Select Case Action
Case "Delete"
	Page=ReplaceBadChar(Trim(Request("Page")))
	AryID = Split(ID,",")
	For i = LBound(AryID) To UBound(AryID)
		If IsNumeric(AryID(i))=True Then
			Conn.Execute("Delete From experiment Where ID="&AryID(i)&"")
		End If
	Next
	Conn.Close
	Set Conn=Nothing
	Response.Write("<script>alert('申请记录删除成功');window.location.href='?Page="&Page&"';</script>")
	Response.End()
End Select
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Main.css" rel="stylesheet" type="text/css" />
<script language="javascript" type="text/javascript" src="Common/Jquery.js"></script>
<script language="javascript" type="text/javascript" src="Common/Common.js"></script>
<script language="javascript" type="text/javascript">
$(document).ready(function(){
	$("#ExperiType").val("<%=ExperiType%>");
	$("#ExperiType").change(function(){
		window.location.href='?ExperiType='+$("#ExperiType").val();
	});
});
</script>
</head>
<body>
<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:80%">当前位置：<a href="Experiment_list.asp">申请记录</a>
</td>
<td style="border-bottom:solid 1px #dde4e9;height:30px;width:20%; text-align:right">
<!-- <select id="ExperiType" name="ExperiType" style="width:150px;">
<option value="0">|--所有实验记录</option>
<option value="1">课堂演示实验</option>
<option value="2">学生分组实验</option>
</select> -->&nbsp;</td>
</tr>
<tr>
<td height="80" colspan="2">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td width="60"><img src="Images/SiteInfo.jpg" width="60" height="61"></td>
<td width="75%" valign="top">&nbsp;</td>
<td width="15%" valign="bottom" style="text-align:right">&nbsp;</td>
</tr>
</table>
</td>
</tr>
<tr>
<td colspan="2" valign="top">
<form id="form1" name="form1" method="post">
<%
Set Rs=Server.CreateObject("Adodb.RecordSet")
Sql = "Select * From Experiment "
if UserGroup=3 then
	Sql= Sql +" Where ExperiTec like '%"&RealName&"%' Order By ID Desc"
else
	Sql = Sql + " order by ID Desc"
end if
Rs.Open Sql,Conn,1,1
Dim Page
Page=Request("Page") 
PageSize = 10       
Rs.PageSize = PageSize
Total=Rs.RecordCount
PGNum=Rs.PageCount
If Page="" Or clng(Page)<1 Then Page=1
If Clng(Page) > PGNum Then Page=PGNum
If PGNum>0 Then Rs.AbsolutePage=Page                         
i=0
%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="Form" id="GridView1">
<tr>
<th width="4%" class="Right">ID</th>
<th width="4%" class="Right"><input type="checkbox" name="chkSelectAll" onclick="doCheckAll(this)" /></th>
<th width="27%" class="Right">课题<a href="Experiment_app.asp" onclick="top.CreateNewTab('Experiment_app.asp','Experiment_app','添加申请记录')">[+]</a></th>
<th width="15%" class="Right">实验老师</th>
<th width="15%" class="Right">年级</th>
<th width="15%" class="Right">实验时间</th>
<th width="5%" class="Right">状态</th>
<th width="15%">管理操作</th>
</tr>
<%Do While Not Rs.Eof And i<Rs.PageSize%>
<tr onmouseover="this.bgColor='#EEF2FB'" onmouseout="this.bgColor=''">
<td class="Right"><%=Rs("ID")%></td>
<td class="Right"><input type="checkbox" name="ID" value="<%=Rs("ID")%>" /></td>
<td class="Right"><a href="Experiment_appedit.asp?ID=<%=Rs("ID")%>&Page=<%=Page%>"><%=GetSetsExperInfo(Rs("ExperiID"),"ExperiTitle")%></a></td>
<td class="Right">
<%=Rs("ExperiTec")%>
</td>
<td class="Right">
<%=GetSetsExperInfo(Rs("ExperiID"),"ExperiGrade")%>-<%=GetSetsExperInfo(Rs("ExperiID"),"ExperiUnit")%>
</td>
<td class="Right">
<%=Rs("ExperiTime")%>
</td>
<td class="Right"><%if Rs("ExperiStatus")=0 then%>准备中<%elseif Rs("ExperiStatus")=1 then%>已准备<%elseif Rs("ExperiStatus")=2 then%>已完成<%end if%></td>
<td><a href="Experiment_appedit.asp?ID=<%=Rs("ID")%>&Page=<%=Page%>">编辑</a> | <a href="?Action=Delete&ID=<%=Rs("ID")%>&Page=<%=Page%>&ClassID=<%=ClassID%>" onclick="if(!confirm('确定删除该信息吗?')) return false;">删除</a></td>
</tr>
<%
i=i+1
Rs.MoveNext
Loop
%>
<tr>
<th colspan="3" style="font-weight:normal">&nbsp;</th>
<th colspan="4" style="font-weight:normal;text-align:right"><a href="javascript:Delete();" style="font-weight:normal">删除</a>&nbsp;┊&nbsp;共<%=Rs.PageCount%>页&nbsp;第<%=Page%>页&nbsp;<%=PageSize%>条/页&nbsp;共<%=Total%>条&nbsp;
<%if Page=1 then%>
首 页&nbsp;上一页&nbsp;
<%Else%>
<a href="<%=GetUrl("page")%>1">首 页</a>&nbsp;<a href="<%=GetUrl("page")%><%=Page-1%>">上一页</a>&nbsp;
<%End If%>
<%If Rs.PageCount-Page<1 Then%>下一页&nbsp;尾 页&nbsp;
<%Else%><a href="<%=GetUrl("page")%><%=Page+1%>">下一页</a>&nbsp;<a href="<%=GetUrl("page")%><%=Rs.PageCount%>">尾 页</a>&nbsp;
<%End If%>
</th>
<th width="9%">
<select style="FONT-SIZE: 9pt; FONT-FAMILY: 宋体;width:90%;" onChange="location=this.options[this.selectedIndex].value" name="Menu_1"> 
<%For Pagei=1 To Rs.PageCount%>
<%if Cint(Pagei)=Cint(Page) Then%>
<option value="<%=GetUrl("page")%><%=Pagei%>" selected="selected">第<%=Pagei%>页</option>
<%Else%>
<option value="<%=GetUrl("page")%><%=Pagei%>">第<%=Pagei%>页</option>
<%End If%>
<%Next%>
</select>
</th>
</tr>
</table>
</form>
</td>
</tr>
</table>
<script language="javascript" type="text/javascript">
function IsLock()
{
	var l = GetAllChecked();
    if (l == "") {
        alert("\u4f60\u8fd8\u6ca1\u6709\u9009\u62e9\u8981\u64cd\u4f5c\u7684\u8bb0\u5f55\uff01");
        return;
    }
	if (confirm('\u786e\u5b9a\u8981\u5c06\u9009\u4e2d\u7684\u5546\u54c1\u8fdb\u884c\u4e0b\u67b6\u64cd\u4f5c\u5417\uff1f')) {
        window.location.href = '?Action=IsLock&ID='+l+'&Page=<%=Page%>&ClassID=<%=ClassID%>&ShowType=<%=ShowType%>';
    }
}
function ChangeParent()
{
	var l = GetAllChecked();
    if (l == "") {
        alert("\u4f60\u8fd8\u6ca1\u6709\u9009\u62e9\u8981\u64cd\u4f5c\u7684\u8bb0\u5f55\uff01");
        return;
    }
    if (confirm('\u786e\u5b9a\u8981\u66f4\u6539\u9009\u4e2d\u5546\u54c1\u7684\u6240\u5c5e\u7236\u7c7b\u522b\u5417\uff1f')) {
        window.location.href = 'Pro_ContentParent.asp?FileName=Pro_ContentListIn&ShowType=<%=ShowType%>&ID='+l;
    }
}
function Delete() {
    var l = GetAllChecked();
    if (l == "") {
        alert("\u4f60\u8fd8\u6ca1\u6709\u9009\u62e9\u8981\u64cd\u4f5c\u7684\u8bb0\u5f55\uff01");
        return;
    }
    if (confirm('\u786e\u8ba4\u8981\u5c06\u9009\u4e2d\u7684\u5546\u54c1\u4fe1\u606f\u5220\u9664\u5417\uff1f')) {
        window.location.href = '?Action=Delete&ID='+l+'&Page=<%=Page%>&ShowType=<%=ShowType%>&ClassID=<%=ClassID%>';
    }
}
</script>
</body>
</html>