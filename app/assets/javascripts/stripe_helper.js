$(function(){
	console.log("LET'S DO THIS");
	var form;
	$('#payment-form-one').on('submit', function(event) {
		console.log('payment form one');

		form = $(this);
		// Disable the submit button to prevent repeated clicks;
		form.find('button').prop('disabled', true);
		Stripe.card.createToken(form, stripeResponseHandler);
		// Prevent the form from submitting with the default action;
		return false;
	});

	$('#payment-form-two').on('submit', function(event) {
		console.log('payment form two');
		form = $(this);
		form.find('button').prop('disabled', true);
		Stripe.card.createToken(form, stripeResponseHandler)
		return false
	});
	// callback for createToken function;
	function stripeResponseHandler(status, response) {
		// var form = $('#payment-form');
		if(response.error) { 
			form.find('.payment-errors').text(response.error.message);
			form.find('button').prop('disabled', false);
		} else {
			// response contains id and card, which contains additional card details
			var token = response.id;
			// Insert the token into the form so it gets submitted to the server
			form.append($('<input type="hidden" name="stripeToken"/>').val(token))
			// and submit
			form.get(0).submit();
		}
	}
});