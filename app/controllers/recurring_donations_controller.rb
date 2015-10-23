class RecurringDonationsController < ApplicationController

	def new 
		puts 'DOES THIS EVER GET CALLED?'
		@recurring_donation = RecurringDonation.new
	end 
end
