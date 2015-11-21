$(document).ready(function(){
	// init listeners for the first form
	$('.donation-amount').on('click', function(e){
		var amount = $(this).attr('val');
		$('.donation-box').val(amount);
	});
	// make the one time donation form appear on button click.
	$('.sub-initial-now').on('click', function(e){
		$('.first_form_view').css('display', 'none');
		$('.second_form_view').css('display', 'block');
		var amount = $('.donation-box').val();
		$('.final-amount').val(amount);
		$('.back-button').css('display', 'block');

	});
	// make the monthly donation form appear on button click.
	$('.sub-initial-monthly').on('click', function(e){
		$('.first_form_view').css('display', 'none');
		$('.third_form_view').css('display', 'block');
		var amount = $('.donation-box').val();
		$('.final-amount').val(amount);
		$('.back-button').css('display', 'block');
	});

	$('.donation-box').on('change', function(e){

	});

	$('.back-button').on('click', function(){
		$('.first_form_view').css('display', 'block');
		$('.third_form_view').css('display', 'none');
		$('.second_form_view').css('display', 'none');
		$('.back-button').css('display', 'none');
	});


});