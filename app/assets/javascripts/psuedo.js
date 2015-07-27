$(document).on('ready', function() {

	$('.collapsible-header').on('click', function() {
		var class_selector = 'user-'+ $(this).attr('id');
		if($('.'+class_selector).hasClass('show')){
			$('.'+class_selector).removeClass('show');
		} else {
			$('.'+class_selector).addClass('show');
		}
	})

	$('.resend').on('click', function(){
		$(this).val('Sent');
	})
})