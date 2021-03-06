$(document).on('ready', function() {

	$('#donation-details').on('click', function() {
		var class_selector = 'user-'+ $(this).parent().attr('id');
		if($('.'+class_selector).hasClass('show')){
			$('.'+class_selector).removeClass('show');
		} else {
			$('.'+class_selector).addClass('show');
		}
	});

	$('.resend').on('click', function(){
		$(this).val('Sent');
	});

	$('#mailing-address').on('click', function() {
		var class_selector = 'user-address'+$(this).parent().attr('id');
		if($('.'+class_selector).hasClass('show')){
			$('.'+class_selector).removeClass('show');
		} else {
			$('.'+class_selector).addClass('show');
		}
	});

	$('.address-button').on('click', function(){
		var address = $(this).parents('.user').find('.address');
		toggle(address);
	});

	$('.donation-button').on('click', function(){
		var donation = $(this).parents('.user').find('.donations');
		toggle(donation);
	});

	var toggle = function(ele){
		if(ele.css('display') === "none"){
			ele.css('display', 'block');
		} else {
			ele.css('display', 'none');
		}

	}
});