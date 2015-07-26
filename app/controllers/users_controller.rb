class UsersController < ApplicationController
	def new 
		@user = User.new
		@user.addresses.build
		@user.donations.build
	end 

  def create
    address = Address.new(user_params[:addresses])
    donation = Donation.new(user_params[:donations])

    @user = User.new(user_params.except(:addresses, :donations))
    @user.addresses << address
    @user.donations << donation
    
    if @user.save
      Resque.enqueue(SendTaxReceiptEmailJob, @user.donations.last.id)
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
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
      ]
    )
  end
end
