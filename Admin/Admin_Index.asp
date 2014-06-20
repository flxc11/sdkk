<!--#include File="../Config/config.asp"-->
<!--#include File="CheckLogin.asp"-->
<!--#include file="../Include/Class_Function.asp" -->

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title><%=SiteName%></title>
<link href="Style/Layout.css" rel="stylesheet" type="text/css" />
<link href="Style/LeftFrame.css" rel="stylesheet" type="text/css" />
<link href="Style/Loading.css" rel="stylesheet" type="text/css" />
<link rel="stylesheet" href="../css/Base.css" />
<script language="javascript" type="text/javascript" src="../js/Flash.js"></script> 
<script language="javascript" type="text/javascript" src="Common/Menu.js"></script>
<script language="javascript" type="text/javascript" src="Common/Prototype.js"></script>
<script language="javascript" type="text/javascript" src="Common/MenuOnclickEvent.js"></script>
<script language="javascript" type="text/javascript" src="Common/InitPage.js"></script>
<script language="javascript" type="text/javascript" src="Common/Utils.js"></script>
<script language="javascript" type="text/javascript" src="Common/DivDialog.js"></script>
<script language="javascript" type="text/javascript" src="Common/Dialog.js"></script>
<script type="text/javascript">
<!--
var LastLeftID = "ChildMenu1";
var LastChild = "";
function DoMenu(emid)
{
	var obj = document.getElementById(emid);
	obj.className = (obj.className.toLowerCase() == "expanded"?"collapsed":"expanded");
	if((LastLeftID!="")&&(emid!=LastLeftID))	//关闭上一个Menu
	{
		document.getElementById(LastLeftID).className = "collapsed";
	}
	LastLeftID = emid;
}
function GetMenuID()
{
	var MenuID="";
	var _paramStr = new String(window.location.href);
	var _sharpPos = _paramStr.indexOf("#");
	if (_sharpPos >= 0 && _sharpPos < _paramStr.length - 1)
	{
		_paramStr = _paramStr.substring(_sharpPos + 1, _paramStr.length);
	}
	else
	{
		_paramStr = "";
	}
	if (_paramStr.length > 0)
	{
		var _paramArr = _paramStr.split("&");
		if (_paramArr.length>0)
		{
			var _paramKeyVal = _paramArr[0].split("=");
			if (_paramKeyVal.length>0)
			{
				MenuID = _paramKeyVal[1];
			}
		}
	}
	if(MenuID!="")
	{
		DoMenu(MenuID)
	}
}
GetMenuID();//*这两个function的顺序要注意一下，不然在Firefox里GetMenuID()不起效果
-->
</script>
<script language="javascript">
/*************获取对话框的多语言信息开始*************/
//点击刷新
var Dialog_Btn_Refresh = "点击刷新";
//Div对话框提交按钮
var Dialog_Btn_Submit = "确  定";
//Div对话框取消按钮
var Dialog_Btn_Cancel = "取  消";
//Div对话框关闭按钮
var Dialog_Btn_Close = "";
//退出系统的标题
var Logout_Title = "退出捷点科技网站管理系统";
//Logout_Msg
var Logout_Msg = "您确定要退出网站管理系统吗？";
//Save
var Dialog_Btn_Save = "保  存";
//页面加载中
var Dialog_Loading = "页面载入中，请稍候...";
//操作进行中
var Dialog_Operating = "操作正在进行中，请等待...";
//权限值
var CpFeatures = "-1";
//消息头文字
var SysMsgTitle = "友情提示";
//消息
var SysMsg = "对不起，你不具备操作本模块的权限。";
/*************获取对话框的多语言信息结束*************/
function Time()
{
    today = new Date();
    var hours = today.getHours();
    var Message;
    if(parseInt(hours)>=0&&parseInt(hours)<=11)
    {
        Message="早上好";
        return Message;
    }
    else if(parseInt(hours)>11&&parseInt(hours)<=13)
    {
        Message="中午好";
        return Message;				
    }
    else if(parseInt(hours)>13&&parseInt(hours)<=17)
    {
        Message="下午好";
        return Message;	
    }
    else if(parseInt(hours)>17)
    {
        Message="晚上好";
        return Message;	
    }
}
function Logou()
{
    window.location.href = "LoginOut.asp";
}
function ReturnDefault()
{
    var objTop = window.top.document;
    var iframeList = objTop.getElementsByTagName("IFRAME");
    for(var i=0;i<iframeList.length;i++)
    {
        var url = iframeList[i].contentWindow.document.URL.toLowerCase();
        if(url.indexOf("WelCome.asp")>-1||url.indexOf("Login.asp")>-1){
            window.top.location.href = "Login.asp";
        }  
    }
}
</script>
<script type="text/Javascript">
function showleftmenu(){
	document.getElementById("Div_Left").style.display= "none";
}
//<![CDATA[
function fDragging(obj, e, limit){
if(!e) e=window.event;
var x=parseInt(obj.style.left);
var y=parseInt(obj.style.top);
var x_=e.clientX-x;
var y_=e.clientY-y;
if(document.addEventListener){
	document.addEventListener('mousemove', inFmove, true);
	document.addEventListener('mouseup', inFup, true);
} else if(document.attachEvent){
	document.attachEvent('onmousemove', inFmove);
	document.attachEvent('onmouseup', inFup);
}
inFstop(e);    
inFabort(e)
function inFmove(e){
	var evt;
	if(!e)e=window.event;
	if(limit){
		var op=obj.parentNode;
		var opX=parseInt(op.style.left);
		var opY=parseInt(op.style.top);
		
		if((e.clientX-x_)<0) return false;
		else if((e.clientX-x_+obj.offsetWidth+opX)>(opX+op.offsetWidth)) return false;
		
		if(e.clientY-y_<0) return false;
		else if((e.clientY-y_+obj.offsetHeight+opY)>(opY+op.offsetHeight)) return false;
		//status=e.clientY-y_;
	}
	obj.style.left=e.clientX-x_+'px';
	obj.style.top=e.clientY-y_+'px';
	inFstop(e);
} 
function inFup(e){
var evt;
if(!e)e=window.event;
if(document.removeEventListener){
	document.removeEventListener('mousemove', inFmove, true);
	document.removeEventListener('mouseup', inFup, true);
} else if(document.detachEvent){
	document.detachEvent('onmousemove', inFmove);
	document.detachEvent('onmouseup', inFup);
}
inFstop(e);
}
function inFstop(e){
	if(e.stopPropagation) return e.stopPropagation();
	else return e.cancelBubble=true;            
}
function inFabort(e){
	if(e.preventDefault) return e.preventDefault();
	else return e.returnValue=false;
}
}
//]]>
</script>
</head>
<body scroll="no">
<div id="layout" style="width: 100%; height: 100%;" class="wrapper">
<div id="container">
<table width="100%" border="0" height="100%" cellspacing="0" cellpadding="0">
<tr>
<td colspan="2" style="background:url(Images/bgtop.jpg) repeat-x;">
<!-----头部开始----->
<div id="header">
<div class="logo"></div>
<div id="right">
<table width="50%" border="0" align="right" cellpadding="0" cellspacing="0">
<tr>
<td style="color:#FFFFFF;height:35px; text-align:right">
<script>document.write(Time());</script>，<font style="color:#fff000;"><%=UserName%></font>，欢迎回来！ <a href="#" onclick="DivDialog.Logout(Logout_Msg,'Logou()');" style="color:#FFFFFF">退出系统</a>
</td>
</tr>
<tr>
<td>
</td>
</tr>
</table>
</div>
</div>
<!-----头部结束----->
</td>
</tr>
<tr>
<td colspan="2" align="left" valign="top" class="wrapper">
<!-----中间开始----->
<div id="div_Content" class="wrapper" style="height:100%;">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
<td id="Div_Left" valign="top" width="196px">
<!-----左菜单开始----->
<script language="javascript">
// JavaScript Document
//构建菜单内容
var GV = new GlobalVar();
GV.title = "";
GV.td_target = "";
GV.href_target = "";
/*主菜单说明
	rootMenu为菜单头。
	写法表示：[[第一个菜单],[第二个菜单],[第三个菜单],...]
	菜单内参数：[菜单名称,链接地址,所调用子项的索引值,鼠标移上样式,鼠标移走样式,默认是否展开]
 */
GV.rootMenu =	[
                ["系统维护","",0,"1","1",true],
				["学生管理","",3,"1","1",false],
				["教师管理","",4,"1","1",false],
				//["年级管理","",5,"1","1",false],
				["班级管理","",6,"1","1",false]
				//,["数据清理","",7,"1","1",false]
				,["备注列表","",7,"1","1",false]
				];
<% if (checkpermission(UserGroup,"1")) then%>
GV.menus[0] =	[
				["站点基本信息维护","CreateNewTab('Sys_SiteInfo.asp','Sys_SiteInfo','站点基本信息维护')","2","2"]
				];
<%end if%>
<% if (checkpermission(UserGroup,"1")) then%>
//GV.menus[1] =	[
				<%
					Set Rs=Server.CreateObject("Adodb.Recordset")
					Sql="select * from [TableInfo] where ClassID='1'"
					Rs.open Sql,Conn,1,1
					if not Rs.eof then
				%>
				//["单页类别管理","CreateNewTab('ClassPage.asp','ClassPage','单页类别管理')","2","2"],
				<%
					Response.Cookies("CNVP_CMS2")("ClassPage")="true"
					else
					Response.Cookies("CNVP_CMS2")("ClassPage")="false"
					end if
					Rs.close
					Set Rs=Nothing
				%>
				//["单页内容管理","CreateNewTab('Nav_Explain.asp','Nav_Explain','单页内容管理')","2","2"]
				//];
<%end if%>


GV.menus[3] =	[
				["添加学生","CreateNewTab('Experiment_Add.asp','Experiment_Add','添加学生')","2","2"],
				["学生列表","CreateNewTab('Experiment_List.asp','Experiment_List','学生列表')","2","2"]
				];


<% if (checkpermission(UserGroup,"1,2")) then%>
GV.menus[4]=	[
				["添加教师","CreateNewTab('Member_Add.asp','Member_Add','添加教师')","2","2"],
				["教师列表","CreateNewTab('Member_List.asp','Member_List','教师列表')","2","2"],
				["师德考核","CreateNewTab('SorceResult.asp','SorceResult','师德考核')","2","2"],
				["专技年度考核","CreateNewTab('Sorcezjkh.asp','Sorcezjkh','专技年度考核')","2","2"]
				];
<%end if%>
//GV.menus[5]=	[
//				["添加年级","CreateNewTab('Grade_ClassAdd.asp','Grade_ClassAdd','添加年级')","2","2"],
//				["年级列表","CreateNewTab('Grade_Class.asp','Grade_Class','添加年级')","2","2"]
//				];
GV.menus[6]=	[
				["添加班级","CreateNewTab('Room_ClassAdd.asp','Room_ClassAdd','添加班级')","2","2"],
				["班级列表","CreateNewTab('Room_Class.asp','Room_Class','添加班级')","2","2"]
				];
//GV.menus[7]=	[
//				["清空表","CreateNewTab('ClearTable.asp','ClearTable','清空表')","2","2"]
//				];
GV.menus[7]=	[
				["师德考核备注","CreateNewTab('contentlist.asp','contentlist','师德考核备注')","2","2"],
				["专技考核备注","CreateNewTab('contentzjkh.asp','contentzjkh','专技考核备注')","2","2"],
				["评分记录","CreateNewTab('pfjl.asp','pfjl','评分记录')","2","2"]
				];

//构建菜单
createMenu();
// JavaScript Document
//主菜单参数名称[菜单名称,菜单链接,子项索引,鼠标移上样式,鼠标移走样式,默认展开]
//子菜单参数名称[菜单名称,菜单链接,鼠标移上样式,鼠标移走样式]
function GlobalVar(){
	this.rootMenu = new Object();
	this.menus = new Array();
	this.title = null;
	this.td_target = null;
	this.href_target = null;
}
function createMenu(){
	var name,url,currIndex,currOverClass,currOutClass,extended,tdID;
	var subName,subUrl,subOverClass,subOutClass,subTdId;
	var sHtml = "";
	sHtml += '<div style="position:absolute; left:189px;"><img src="images/left-top-right.gif" /></div>';
	sHtml += '<div id="leftmenu" ><div><img src="images/menu_topimg.gif"></div>';
	sHtml += '<table width="182" border="0" cellpadding="0" cellspacing="0" style="background:url(images/menu_linebg.gif)">';
	sHtml += '	<tr><td class="menuTitle">' + GV.title + '</td></tr>';
	for(var i=0; i<GV.rootMenu.length; i++){
		name = GV.rootMenu[i][0];	url = GV.rootMenu[i][1];	currIndex = GV.rootMenu[i][2];
		currOverClass = GV.rootMenu[i][3];	currOutClass = GV.rootMenu[i][4];	extended = GV.rootMenu[i][5];
		tdID = "rootMenu_" + i;
		sHtml += ' <tr>';
		//链接为加在单元格上时将调用以下代码
		sHtml += '<td' + (currOutClass?' class="' + (extended?'cTD' + currOverClass:'oTD' + currOutClass) + '"':'') + ' id="' + tdID + '" onclick="setBg(\'' + tdID + '\',\'' + currOverClass + '\',\'' + tdID + '\'); hideDiv(\'subMenu_' + i + '\');' + ((url)?((GV.td_target)?GV.td_target + '.':'') + 'location.href=\'' + url + '\';':'') + ';"';
		sHtml += ' onmouseover="over(\'' + tdID + '\',\'' + currOverClass + '\',\'' + tdID + '\');" onmouseout="out(\'' + tdID + '\',\'' + currOutClass + '\',\'' + tdID + '\');">'
		sHtml += '' + name + '&nbsp;&nbsp;</td>';
		sHtml += '</tr>';
		sHtml += ' <tr><td>';
		sHtml += '<div id="subMenu_' + i + '" style="display:' + (extended?'block':'none') + '">';
		//sHtml += '<div id="subMenu_' + i + '" style="display:block">';
		sHtml += '<img src="images/menu_topline.gif">';
		sHtml += '<table width="100%" border="0" cellpadding="0" cellspacing="0" style="background:#ff3300;">';
		for(var j = 0; j<GV.menus[currIndex].length; j++){
			subName = GV.menus[currIndex][j][0]; subUrl = GV.menus[currIndex][j][1];
			subOverClass = GV.menus[currIndex][j][2]; subOutClass = GV.menus[currIndex][j][3]
			subTdId = "subMenu_" + i + "_" + j;
			sHtml += '  <tr>';
			sHtml += '<td' + (subOutClass?' class="oTD' + subOutClass + '"':'') + ' id="' + subTdId + '" onclick="setBg(\'' + subTdId + '\',\'' + subOverClass + '\',\'' + tdID + '\');' + ((subUrl)?((GV.td_target)?GV.td_target + '':'') + subUrl + ';':'') + '"';
			sHtml += ' onmouseover="over(\'' + subTdId + '\',\'' + subOverClass + '\',\'' + tdID + '\');" onmouseout="out(\'' + subTdId + '\',\'' + subOutClass + '\',\'' + tdID + '\');">';
			sHtml += '' + subName + '</td>';

			sHtml += '</tr>';
		}
		sHtml += '</table>';
		sHtml += '</div>';
		sHtml += '</td></tr>';
	}
	sHtml += ' </table>';
	sHtml +='<div style="height: 2px; margin-top: -2px;"><img src="images/menu_bottomimg.gif" /></div><div style="height: 2px; margin-top: -2px;">    <img src="images/menu_bottomimg.gif" /></div></div>'
	document.write(sHtml);
}
//菜单的样式 被点击状态
var cObj,sObj,lastrCSS,lastCSS;
function over(id,css,rObj){		//移上操作
	var obj = document.getElementById(id);
	obj.className = "cTD" + css;
}
function out(id,css,rObj){		//移走操作
	var obj = document.getElementById(id);
	var rObj = document.getElementById(rObj);
	
	if(obj == rObj){	//属于目录操作
		if(sObj == undefined){
			obj.className = "oTD" + css;
		}else{
			if(sObj == rObj){
				obj.className = "sTD" + lastrCSS;
			}else{
				obj.className = "oTD" + css;
			}
		}
	}else{
		if(cObj == undefined){
			obj.className = "oTD" + css;
		}else{
			if(cObj == obj){
				obj.className = "sTD" + lastCSS;
			}else{
				obj.className = "oTD" + css;
			}
		}
	}
}
function setBg(id,css,rObj){		//点击操作
	var obj = document.getElementById(id);
	var rObj = document.getElementById(rObj);
	
	if(obj == rObj){		//属于父目录操作
		if(sObj != undefined){
			sObj.className = "oTD" + lastrCSS;
		}
		rObj.className = "sTD" + css;
		if(cObj != undefined){
			cObj.className = "oTD" + lastCSS;
			cObj = undefined;
		}
		lastrCSS = css;
		sObj = rObj;
		//alert(cObj);
	}else{		//属于子目录操作
		if(cObj != undefined){
			cObj.className = "oTD" + lastCSS;
		}
		obj.className = "sTD" + css;
		lastCSS = css;
		cObj = obj;
	}
}
function setDefault(obj,css){
	var obj = document.getElementById(obj);
	obj.className = "sTD" + css;
	cObj = obj;
	lastCSS = css;
}
function hideDiv(id){
    var obj = document.getElementById(id);
	var menuc = new Array();
	for(var i = 0; i < GV.rootMenu.length; i++){
		menuc[menuc.length] = "subMenu_" + i;
	}
	for(var i = 0; i<menuc.length;i++){
		var td = document.getElementById(menuc[i]);
		obj.id!= menuc[i]||td.style.display == "block" ? td.style.display = "none":td.style.display = "block";
	}
}
	
</script>
<!-----左菜单结束----->
</td>
<td valign="top" align="left" class="content" style="height:100%;">
<div id="div_Main" class="content" style="height:100%;">
<div id="div_Main_Page">
<!-----导航开始----->
<div id="nav">
<div id="tabtitle" class="right">
<table cellpadding="0" cellspacing="0" border="0">
<tr>
<td width="12"><a href="#" id="ATabLeft" onclick="SelectTabList('left')"><img id="imgBtnLeft" src="images/icon-pve.gif" width="12" height="12" border="0" /></a></td>
<td style="width: 5px;"></td>
<td width="12"><a href="#" id="ATabRight" onclick="SelectTabList('right')"><img id="imgBtnRight" src="images/icon-next.gif" width="12" height="12" border="0" /></a></td>
</tr>
</table>
</div>
</div>
<!-----导航结束----->
<!-----主体内容开始----->
<div>
<div id="div_Main_Content">
<div class="list" style="background:none;margin-top:20px;border:none;display:none;">
        	<ul>
            	<%
					
					Set aaa=Server.CreateObject("Adodb.RecordSet")
					Sqls = "Select top 10 * From Experiment order by id desc"
					aaa.Open Sqls,Conn,1,1
					i=0
					do while not aaa.Eof and i<10
				%>
        		<li><span>课题名称：<%=GetSetsExperInfo(aaa("ExperiID"),"ExperiTitle")%></span><span>申请老师：<%=aaa("ExperiTec")%></span><span style="color:red">状态：[<%
	if aaa("ExperiStatus")=0 then
	Response.Write("准备中")
	elseif aaa("ExperiStatus")=1 then
	Response.Write("已准备")
	elseif aaa("ExperiStatus")=2 then
	Response.Write("已完成")
	end if
%>]</span></li>
                <%
					i=i+1
					aaa.MoveNext
					loop
					'Rss1.Close:Set Rss1=Nothing
				%>
        	</ul>
        </div>
</div>
</div>
<!-----主体内容结束----->
</div>
</div></td>
</tr>
</table>
</div>

<!-----中间结束----->
</td>
</tr>
<tr>
<td colspan="2" valign="top">
<div id="buttom">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr>
      <td width="198"><img src="images/buttom-left.gif" /></td>
      <td class="copyright">&nbsp;</td>
      <td align="right" width="161"><img src="images/buttom-right.gif" /></td>
    </tr>
  </table>
</div>
<!-----投票开始----->
<iframe id="iframeFunctionVote" style="display:none"></iframe>
<!-----投票结束----->
</td>
</tr>
</table>
</div>
</div>
</body>
</html>
