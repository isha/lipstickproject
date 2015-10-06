
class UsersController < ApplicationController
	def new 
		@user = User.new
		@user.addresses.build
		@user.donations.build
	end 

  def create
    address = Address.new(user_params[:addresses])
    
    if User.exists?(email: user_params[:email])
      @user = User.where(email: user_params[:email]).first
    else
      @user = User.new(user_params.except(:addresses, :donations))
    end

    if(!user_params[:recurring])
      donation = Donation.new(user_params[:donations])
      @user.donations << donation
    else 
      donation = RecurringDonation.new(user_params[:donations])
    end
    @user.addresses << address
    # refactor this mess into the donation and/or charge controller
    if @user.save
      token = params[:stripeToken]
      if(!user_params[:recurring])
        amount = @user.donations.last.amount * 100
        Resque.enqueue(SendTaxReceiptEmailJob, @user.donations.last.id)
        create_single_stripe_charge(amount, token)
      else
        amount = donation.amount * 100
        # byebug
        donation.create(amount, @user.id, @user.email, token)
        # should create a new recurring donation.
        puts 'Creating a new recurring donation.'
      end
      redirect_to "http://www.thelipstickproject.ca/thank-you"
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.page(params[:page])
  end

  def create_single_stripe_charge(amount, token) 
    # Stripe.api_key = Rails.configuration.stripe[:secret_key]
    Stripe.api_key = 'sk_test_47WSgDMSGAE8OrlTNbQQHAG4'
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

  private
  def user_params
    params.require(:user).permit(
      :first_name, 
      :last_name, 
      :email, 
      :accepts_marketing,
      :recurring,
      addresses: [
        :street,
        :house,
        :postal_code,
        :city,
        :province
      ],
      donations: [
        :amount
      ], 
    )
  end
end
