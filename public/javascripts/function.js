// JavaScript Document
$(function(){
	
	autoroll();
	var i=-1; 
	var offset = 5000;
	var timer = null;
	function autoroll(){
		n = $('.tab_menu a').length-1;
		i++;
		if(i > n){
			i = 0;
		}
	 	slide(i);
		timer = window.setTimeout(autoroll, offset);
	 }
	function slide(i){
		$('.tab_menu a').eq(i).addClass('active').siblings().removeClass('active');
		$('.tab_imgs li').eq(i).fadeIn("slow").siblings('.tab_imgs li').fadeOut("slow");
	}
   
	$('.tab_menu a').click(
		function () {
			if (timer) {
				//clearTimeout(timer);
				i = $(this).prevAll().length;
				slide(i); 
			}
		}
	)
	
	
})
