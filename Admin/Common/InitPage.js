﻿/*
var Event = {
  offsetX : 0,
  offsetY : 0,
  isMouseDown : false,
  MouseDown : function(){
   Event.isMouseDown = true;
   Event.offsetX = event.offsetX;
   Event.offsetY = event.offsetY;
   Util.SetCapture(event.srcElement);
   alert(Event.offsetX + " - " + Event.offsetY);
  },
  MouseMove : function(){
   if(Event.isMouseDown == true){
    var o = Util.CaptureObject(event.srcElement);
    if(o == document.getElementById("float-exit"))return false;
    with(o.style){
     try{
      left = (parseInt(event.clientX?event.clientX:event.pageX) - parseInt(Event.offsetX)) + "px";
      top = (parseInt(event.clientY?event.clientY:event.pageY) - parseInt(Event.offsetY)) + "px";
     }catch(e){}
    }
   }
  },
  MouseUp : function(){
   Event.isMouseDown = false;
   Util.ReleaseCapture(event.srcElement);
  }
 }
 
 var Util = {
  CaptureObject : function(o){
   //while(o.parentNode && o.tagName.toLowerCase() != "body") o = o.parentNode;
   return document.getElementById("float-exit");
  },
  SetCapture : function(o){
   if(o.setCapture) o.setCapture();
   else if(o.captureEvents)o.captureEvents(Event.MOUSEMOVE|Event.MOUSEUP);
  },
  ReleaseCapture : function(o){
   if(o.releaseCapture) o.releaseCapture();
   else if(o.releaseEvents)o.releaseEvents(Event.MOUSEMOVE|Event.MOUSEUP);
  },
  Document : function(){
   return document.documentElement.clientHeight > 0?document.documentElement : document.body;
  }
 }
*/
//重新规划页面工作区框架
//function resizeWorkspace()
//{        
//    //初始化div_Main_Content层里的iframe的高度和宽度
//    var leftMenuWidth = $("leftbar").offsetWidth; 
//    var windowWidth = 1004;
//    
//    var topHeight = $("header").offsetHeight;
//    var bottomHeight = 30;
//    var windowHeight = document.body.offsetHeight;
//    //高度默认值
//    var height = 500;
//       
//    
//    var iframeList = $("div_Main_Content").getElementsByTagName("IFRAME");
//    //宽度默认值
//    var width = width = windowWidth - leftMenuWidth - 20;
//        
//    
//    for(var i=0;i<iframeList.length;i++){
//        try{
//            iframeList[i].style.width = width + "px";
//        }
//        catch(e){}
//    }
//}



////重新规划页面工作区框架
//try{
//    onload=resizeWorkspace;
//    onresize=resizeWorkspace;
//}
//catch(e){}