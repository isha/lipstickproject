class UsersController < ApplicationController
	def new 
		@user = User.new
		1.times { @user.addresses.build }
	end 
end
