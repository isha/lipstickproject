class DonationsController < ApplicationController
  def new
  	@donation = Donation.new
  end

  def send_tax_receipt
  	Resque.enqueue(SendTaxReceiptEmailJob, params[:id])
  	render nothing: true
  end

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
