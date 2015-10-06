class RecurringDonation < ActiveRecord::Base
	belongs_to :user
	validates :amount, :presence => true
	validates :amount, numericality: true
	validates :amount, numericality: { greater_than: 1}

	# def initialize(donation_info)
	# end 

	def create(amount, user_id, email, token)
		# data base needs user_id, amount, stripe_id, current_date
		self.user_id = user_id
		#  Find a way to check if this plan already exists..
		plan_name = "LipstickProject_#{amount}"

 # Stripe.api_key = Rails.configuration.stripe[:secret_key]
    Stripe.api_key = 'sk_test_47WSgDMSGAE8OrlTNbQQHAG4'

		# Notes: Amount must be in cents.
		# Name will be displayed on invoices and in the web interface
		#
		# check to see if a plan with that name exists 
		begin
			plan = Stripe::Plan.retrieve(plan_name)
		rescue Stripe::InvalidRequestError
			plan = false
		end 

		#  STEP 1: MAKE A PLAN
		if(!plan)
			begin
				plan = Stripe::Plan.create(
					:amount => amount, 
					:interval => 'month', 
					:name => plan_name, 
					:currency => 'cad', 
					:id => plan_name
				)
			rescue Stripe::CardError => e
				# the card has been declined.
			end
		end
		# STEP 2: MAKE A CUSTOMER 
			customer = Stripe::Customer.create(
				'plan' => plan_name, 
				'email' => email, 
				'source' => token
			)

	end 

end
