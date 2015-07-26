if Rails.env.production?
	Airbrake.configure do |config|
	  config.api_key = 'f6a3005ad272a00410f8ca8774276fae'
	end
end