// JavaScript Document

$(document).ready(function(){
	$(".Nav ul li").eq(NavID).addClass("hover")
	$(".Nav ul li").hover(function(){
		$(this).addClass("hover")
	 },function(){
		if($(this).index() != NavID)
		{
			$(this).removeClass("hover")		
		}	
	})
	$(".Nav ul").hover(function(){
		$(this).find('div').show()
	 },function(){
		$(this).find('div').hide()
	})
	$(".Nav ul li span").click(function(){
	  var url=$(this).attr("url");
	  if(url)
	  {
		  window.location.href=url;	
	  }
  	})	
	SetTwoNav(LeftID)
	$(".PageLeft dl dt").hover(function(){
		$(this).addClass("hover")
	 },function(){
		 if($(this).parent().index() != LeftID)
		 {
			$(this).removeClass("hover")
		 }
	})	
	$(".PageLeft dl dt").click(function(){
		if($(this).next().children("a").length>0)
		{
			if($(this).next().css('display') == "none")
			{
				$(this).next().slideDown(200)
				$(this).addClass("select")
			}
			else
			{
				$(this).next().slideUp(150)
				$(this).removeClass("select")
			}
		} else {
			var nosubid = $(this).parent().attr("id");
			//var curcolname = $(this).html();
			var curlink = "/col/col" + nosubid + "/index.aspx";
			//$(this).html('<a href="' + curlink + '">' + curcolname + '</a>');
			window.location.href=curlink;
		}
	})
});
function SetTwoNav(id)
{
	var curid = id;
	$(".PageLeft dl").each(function(i, v) {
        if($(v).attr("id") == curid) {
			$(v).find('dt').addClass("hover");
			if($(v).find('dt').next().length>0) {
				$(v).find('dt').next().slideDown(200)
				$(v).find('dt').addClass("select")
			}
		}
    });
}