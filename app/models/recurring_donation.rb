class RecurringDonation < ActiveRecord::Base
	belongs_to :user
	validates :amount, :presence => true
	validates :amount, numericality: true
	validates :amount, numericality: { greater_than: 1}

	# def initialize(donation_info)
	# end 


	# NOTES: plan_name will be displayed on invoices and in the web interface.
	# plan_name_amount is to make the plan_name more customer friendly

	def create(amount, user_id, email, token)
	
		plan_name_amount = amount/100
		plan_name = "LipstickProject_#{plan_name_amount}"
 	
 		Stripe.api_key = Rails.configuration.stripe[:secret_key]
	
		# check to see if a plan with that name exists 
		# if not create plan - then subscribe customer to it. 
	
		begin
			plan = Stripe::Plan.retrieve(plan_name)
		rescue Stripe::InvalidRequestError
			create_plan(amount, plan_name)
		end 
		create_customer(plan_name, email, token)

	end 

	def create_plan(amount, plan_name)
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

	def create_customer(plan_name, email, token) 
		customer = Stripe::Customer.create(
			'plan' => plan_name, 
			'email' => email, 
			'source' => token
		)
	end 
end
