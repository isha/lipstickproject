Rails.configuration.stripe = {
	:publishable_key => ENV['PUBLIC_KEY'], 
	:secret_key => ENV['SECRET_KEY']
}

Stripe.api_key = Rails.configuration.stripe[:secret_key]

puts Rails.configuration.stripe