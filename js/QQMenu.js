(function(){
	QQMenuInt=_QQMenuInt;
 	moveQQmenu=_moveQQmenu;
 	function _QQMenuInt(){
 		QQMenu.style.position="absolute";
 		QQMenu.style.display="";
 		//if(parseInt(document.documentElement.offsetWidth)>1024){
// 			QQMenuPosition.Left+=(parseInt(document.documentElement.offsetWidth)-1024-20);
//			
// 		}
 		if(QQMenuPosition.isRight){
			QQMenu.style.right=QQMenuPosition.Left+"px";
		}else{
			QQMenu.style.left=QQMenuPosition.Left+"px";
		}
		QQMenu.style.top=QQMenuPosition.Top+"px";
		moveQQmenu();
 	}
	function _moveQQmenu(){
		var from=parseInt(QQMenu.style.top,10);
		var yOffset;
		var to=window.pageYOffset?window.pageYOffset:document.documentElement.scrollTop;
		to=to+QQMenuPosition.Top;
		if(to!=from){
			yOffset = Math.ceil(Math.abs(to-from)/20);
			if(to<from)yOffset=-yOffset;
			var oldTop=parseInt(QQMenu.style.top,10);
			QQMenu.style.top=(oldTop+yOffset)+"px";
		}
		if(QQMenu.style.display!="none"){
			window.setTimeout("moveQQmenu()",QQMenuPosition.timeout);
		}
	}
})()