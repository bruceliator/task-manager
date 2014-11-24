var ready;
ready = function() {

 $(".check_all").click(function() {
		$(this).parent().find('.box').prop('checked', true)	
	})

	$(".uncheck_all").click(function() {
		$(this).parent().find('.box').prop('checked', false)	
 })


 $('.task_wrap').hover(function() {
     $(this).find('.icons_wrap').stop().animate({
        'left':'350px'},
                            'slow');
    },function() {
      $(this).find('.icons_wrap').stop().animate({
        'left':'-100px'},
                            'slow');
 });
	

	$("#link_id a").live(function() {
		$.getScript(this.href);
		return false;
	});


};

$(document).ready(ready);
$(document).on('page:load', ready);


