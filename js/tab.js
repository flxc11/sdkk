// JavaScript Document

$(function(){
		$("div.subnav:eq(5)").addClass("ml-200");
		$("div.subnav:eq(6)").addClass("ml-50");
		$("ul.topnav li").mouseenter(function() { //When trigger is clicked...		
		$(this).find("div.subnav").slideDown('fast').show(); //Drop down the subnav on click
		$(this).hover(function() {
			$(this).find("div.subnav").slideDown('fast').show(); //Drop down the subnav on click
		}, function(){	
			$(this).find("div.subnav").slideUp('fast'); //When the mouse hovers out of the subnav, move it back up
		});

		}).hover(function() { 
			$(this).addClass("subhover"); //On hover over, add class "subhover"
		}, function(){	//On Hover Out
			$(this).removeClass("subhover"); //On hover out, remove class "subhover"
	});
	
	$(".cnvp-tab-nav>a").bind( 'mouseenter', function() {
		  var tabs =   $(this).parent().children("a");
		  var selectedclass = getClass(tabs);
		  var panels = $(this).parent().parent().children(".cnvp-tab-panle");
		  var index = $.inArray(this, tabs);
		  if (panels.eq(index)[0]) {
			   $(tabs).removeClass(selectedclass)
					.eq(index).addClass(selectedclass);
			   $(panels).addClass("cnvp-tabs-hide")
					.eq(index).removeClass("cnvp-tabs-hide");
			}
	});
		String.prototype.trim = function(){
				return this.replace(/(^\s*)|(\s*$)/g,"");
			}
		getClass = function(items){
		currCls = null;
		items.each(function(i, item){
		 cls = $(item).attr('class');
		 if(cls && !cls.trim()==''){
			 currCls = cls;
			 return cls;
		 }
		 });
		return currCls;
		};
	})