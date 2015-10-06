class ChargesController < ApplicationController
	# the controller will do two things: show a 
	# credit card form and create the actual charges
	def create(token, amount) 
		Stripe.api_key = "sk_test_47WSgDMSGAE8OrlTNbQQHAG4"
		token = params[:stripeToken]
		# if payment is one-time
		begin
			charge = Stripe::Charge.create(
				:amount => 1000, #reminder: amount in cents
				:currency => 'cad', 
				:source => token, 
				:description => "The Lipstick Project Donation"
			)
		rescue Stripe::CardError => e
			# the card has been declined
		end 
	end 
end
	