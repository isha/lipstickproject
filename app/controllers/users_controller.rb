
class UsersController < ApplicationController
	def new 
		@user = User.new
		@user.addresses.build

	end 

  def create
    address = Address.new(user_params[:addresses])
    if User.exists?(email: user_params[:email])
      @user = User.where(email: user_params[:email]).first
    else
      if(!user_params[:recurring])
        @user = User.new(user_params.except(:addresses, :donations))
        donation = @user.donations.build(user_params[:donations])
        @user.save
      else 
        @user = User.new(user_params.except(:addresses, :recurring_donations))
        donation = @user.recurring_donations.build(user_params[:recurring_donations])
        @user.save
      end 
    end

    # if(!user_params[:recurring])
    #   donation = Donation.new(user_params[:donations])
    #   @user.donations.build
    #   @user.donations << donation
    # else 
    #   donation = RecurringDonation.new(user_params[:recurring_donations])
    #   @user.recurring_donations.build 
    #   @user.recurring_donations << donation
    # end
    @user.addresses << address
    # refactor this mess into the donation and/or charge controller
    if @user.save
      token = params[:stripeToken]
      if(!user_params[:recurring])
        amount = @user.donations.last.amount * 100
        Resque.enqueue(SendTaxReceiptEmailJob, @user.donations.last.id)
        donation.create_single_stripe_charge(amount, token)
        redirect_to "http://www.thelipstickproject.ca/thank-you"
      else
        amount = donation.amount * 100
        donation.create(amount, @user.id, @user.email, token)
        redirect_to '/thankyou'
      end
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

  # def create_single_stripe_charge(amount, token) 
  #   # Stripe.api_key = Rails.configuration.stripe[:secret_key]
  #   Stripe.api_key = 'sk_test_KZeR5mKmb2I9KCv6q5rXTPRs'
  #   begin

  #     charge = Stripe::Charge.create(
  #       :amount => amount, #reminder: amount in cents
  #       :currency => 'cad', 
  #       :source => token, 
  #       :description => "The Lipstick Project Donation"
  #     )
  #   rescue Stripe::CardError => e
  #     # the card has been declined
  #   end 
  # end

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
      recurring_donations: [
        :amount
      ]
    )
  end
end
