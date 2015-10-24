class Donation < ActiveRecord::Base
	belongs_to :user
	validates :amount, :presence => true
	validates :amount, numericality: true
	validates :amount, numericality: { greater_than: 1}

	 def create_single_stripe_charge(amount, token)
  	  # Stripe.api_key = Rails.configuration.stripe[:secret_key]
    Stripe.api_key = 'sk_test_KZeR5mKmb2I9KCv6q5rXTPRs'
    begin

      charge = Stripe::Charge.create(
        :amount => amount, #reminder: amount in cents
        :currency => 'cad', 
        :source => token, 
        :description => "The Lipstick Project Donation"
      )
    rescue Stripe::CardError => e
      # the card has been declined
    end 
  end 
end
