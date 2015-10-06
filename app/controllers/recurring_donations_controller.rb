class RecurringDonationsController < ApplicationController

	def new 
		@recurring_donation = RecurringDonation.new
	end 

	def create(amount)

		# Notes: Amount must be in cents.
		# Name will be displayed on invoices and in the web interface
		puts 'MAKING A NEW RECURRING DONATION'
		begin
			plan = Stripe::Plan.create (
				:amount => amount, 
				:interval => 'month', 
				:name => 'New User Plan + unique id', 
				:currency => 'can', 
				:id => 'gold'
			)
		rescue Stripe::CardError => e
			# the card has been declined.
		end
	end 
	
	#function that would allow a admin to cancel a users monthly donation	
	def delete

	end 

end
