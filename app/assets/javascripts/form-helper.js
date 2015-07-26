$(document).ready(function(){
	// init listeners for the first form
	$('.donation-amount').on('click', function(e){
		var amount = $(this).attr('val');
		$('.donation-box').val(amount);
	})
	$('.sub-initial').on('click', function(e){
		$('.first_form_view').css('display', 'none');
		$('.second_form_view').css('display', 'block');
		var amount = $('.donation-box').val();
		$('.final-amount').val(amount);
	})
});