
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

    @user.addresses << address
    # refactor this mess into the donation and/or charge controller
    if @user.save
      token = params[:stripeToken]
      if(!user_params[:recurring])
        # is this the most reliable way to get the correct amount?
        amount = @user.donations.last.amount * 100
        Resque.enqueue(SendTaxReceiptEmailJob, @user.donations.last.id)
        donation.create_single_stripe_charge(amount, token)
        redirect_to "http://www.thelipstickproject.ca/thank-you"
      else
        # see comment above
        puts donation
        amount = donation.amount
        if(!donation)
         donation = @user.recurring_donations.last
        end
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
