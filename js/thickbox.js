/* <![CDATA[ */
var gallery = function() {

/* show first image and information */

showTime=5000;

timer=0;

absLeft=0;

picCount=0;

var total = $('.thumb img').length;
$totalImgs = $('.thumb img');
thumbWidth = 0;
for (x=0; x<total; x++) {
	thumbWidth = thumbWidth + $($totalImgs[x]).outerWidth();
}
$('#innerContainer') .css({ width: thumbWidth + 'px'});
$('#innerContainer img').css({ display: 'inline'});
firstStr = $('.thumb');
showStr = firstStr.html();
showDiv(showStr)

$('#slideLeft').hover(function(e){
	$('#innerContainer').stop();
	$('#innerContainer').animate({"left": "0px"}, 2000 , "swing")
	},function(){
		$('#innerContainer').stop();
		});

$('#slideRight').hover(function(e){
posLeft = $('#thumbnails').offset().left;
absLeft = e.pageX - posLeft;
hiddenBit = thumbWidth - 635;
$('#innerContainer').stop();
$('#innerContainer').animate({"left": -hiddenBit + "px"}, 2000 , "swing")
},function(){
$('#innerContainer').stop();
});

/* monitor mouse clicks */

$('.thumb').click(function(){
htmlStr = $(this).html();
currentLarge = $(this).attr('class').split(' ').slice(-1);
if ("p"+total == currentLarge) {
$('#clickRight').css("backgroundImage", "url(images/blank.gif)")

    .attr("alt", "")

    .attr("title", "");

}

else {

$('#clickRight').css("backgroundImage", "url(images/next.png)")

    .attr("alt", "Next")

    .attr("title", "Next");

}

if ("p1" == currentLarge) {

$('#clickLeft') .css("backgroundImage", "url(images/blank.gif)")

    .attr("alt", "")

    .attr("title", "");

}

else {

$('#clickLeft').css("backgroundImage", "url(images/previous.png)")

    .attr("alt", "Previous")

    .attr("title", "Prevous");

}

/* swap images and information */

 $('#fullSize') .fadeOut(600, function(){showDiv(htmlStr)});

});

/* show image and information */

function showDiv (htmlStr) {

 $('#fullSize')  .html(htmlStr)

      .fadeIn(600);

 currentLarge = $('#fullSize img').attr('class');

 currentLarge = currentLarge.substr(1,3);

 

}



$('#clickRight').click(function(){

  currentLarge = $('#fullSize img').attr('class');

  if ("p"+(total-1) == currentLarge) {

  $('#clickRight') .css("backgroundImage", "url(images/blank.gif)")

       .attr("alt", "")

       .attr("title", "");

  }

  if ("p" + total != currentLarge) {

  $('#clickLeft') .css("backgroundImage", "url(images/previous.png)")

      .attr("alt", "Previous")

      .attr("title", "Previous");

  htmlStr = $('#innerContainer li.'+currentLarge).next('li').html();

  $('#fullSize') .fadeOut(600, function(){showDiv(htmlStr)});

  }

  hiddenBit =  $('#innerContainer').position().left-113;

  if(hiddenBit>-(thumbWidth - 545))$('#innerContainer').animate({"left": hiddenBit + "px"}, 500 , "swing")

});

$('#clickLeft') .click(function(){

  currentLarge = $('#fullSize img').attr('class');

  if ("p2" == currentLarge) {

  $('#clickLeft') .css("backgroundImage", "url(images/blank.gif)")

      .attr("alt", "")

      .attr("title", "");

  }

  if ("p1" != currentLarge) {

  $('#clickRight') .css("backgroundImage", "url(images/next.png)")

       .attr("alt", "Next")

       .attr("title", "Next");

  htmlStr = $('#innerContainer li.'+currentLarge).prev('li').html();

  $('#fullSize') .fadeOut(600, function(){showDiv(htmlStr)});

  }

  hiddenBit =  $('#innerContainer').position().left+113;

  if(hiddenBit<=0)$('#innerContainer').animate({"left": hiddenBit + "px"}, 500 , "swing")

});

}

function autoPlay () {

currentLarge = $('#fullSize img').attr('class');

if ("p"+(total-1) == currentLarge) {

$('#clickRight') .css("backgroundImage", "url(images/blank.gif)")

     .attr("alt", "")

     .attr("title", "");

}

if ("p" + total != currentLarge) {

$('#clickLeft')  .css("backgroundImage", "url(images/previous.gif)")

     .attr("alt", "Previous")

     .attr("title", "Previous");

htmlStr = $('#innerContainer li.'+currentLarge).next('li').html();

$('#fullSize')  .fadeOut(600, function(){playDiv(htmlStr)});

}

if ("p"+total == currentLarge) {

$('#clickLeft')  .css("backgroundImage", "url(images/blank.gif)")

     .attr("alt", "")

     .attr("title", "");

$('#clickRight') .css("backgroundImage", "url(images/next.gif)")

     .attr("alt", "Next")

     .attr("title", "Next");

htmlStr = $('#innerContainer li.p1').html();

$('#fullSize').fadeOut(600, function(){playDiv(htmlStr)});

}

timer = setTimeout ("autoPlay()", showTime);

}



function playDiv (htmlStr) {

$('#fullSize').html(htmlStr).fadeIn(600);

currentLarge = $('#fullSize img').attr('class');

currentLarge = currentLarge.substr(1,3);

}
/* ]]> */

$(function(){
 gallery();
    timer = setTimeout ("autoPlay()", showTime);
 })