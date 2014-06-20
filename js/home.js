$(function(){
	/************************ banner  ***********************/
	var btnIndex = 0;

	$("#nav_btn li").click(function () {
		if (btnIndex != $("#nav_btn li").index(this))
		{
			btnIndex = $("#nav_btn li").index(this);
			changeBanner();
		}
	}); 

	function changeBanner(){
		$("#nav_btn li img").css("display", "none");
		$("#nav_btn li img")[btnIndex].style.display = "block";

		var banner_now = $(".banner_now");
		var banner_next = $(".banner").eq(btnIndex);

		banner_now.animate({
			opacity: 'hide'
		}, 800, function(){
			banner_now.removeClass("banner_now");
		});

		banner_next.animate({
			opacity: 'show'
		}, 800, function(){
			banner_next.addClass("banner_now");
		});
	}

	$("#nav_btn li img")[0].style.display = "block";

	$("#btn_left").click(function () {
		if (btnIndex > 0){
			--btnIndex;
		}
		else{
			btnIndex = 2;
		}
		changeBanner();
	}); 

	$("#btn_right").click(function () {
		if (btnIndex < 2){
			++btnIndex;
		}
		else{
			btnIndex = 0;
		}
		changeBanner();
	}); 

	var oInterval = "";
	oInterval = setInterval("$('#btn_right').click()",5000);


});
