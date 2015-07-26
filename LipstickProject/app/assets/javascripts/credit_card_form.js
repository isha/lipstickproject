$(document).on('ready', function(){
	console.log("LET'S DO THIS");
	$('#payment-form').on('submit', function(event) {
		console.log("submitting payment form!");
		var form = $(this);
		debugger;
		// Disable the submit button to prevent repeated clicks;
		form.find('button').prop('disabled', true);
		Stripe.card.createToken(form, stripeResponseHandler);
		// Prevent the form from submitting with the default action;
		return false;
	});

	function stripeResponseHandler(status, response) {
		var form = $('#payment-form');
		console.log(status, response);
		if(response.error) { 
			form.find('.payment-errors').text(response.error.message);
			form.find('button').prop('disabled', false);
		} else {
			// response contains id and card, which contains additional card details
			var token = response.id;
			console.log("TOKEN: ", token);
			// Insert the token into the form so it gets submitted to the server
			form.append($('<input type="hidden" name="stripeToken"/>').val(token))
			// and submit
			form.get(0).submit();
		}
	}
});