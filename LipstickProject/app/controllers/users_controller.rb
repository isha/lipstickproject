class UsersController < ApplicationController
	def new 
		@user = User.new
		@user.addresses.build
		@user.donations.build
	end 

  def create
    @user = User.new(params[:user])

    @user.save
    redirect_to @user
  end

  def show
    @user = User.find(params[:id])
  end
end
