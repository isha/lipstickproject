class TaxReceiptMailer < ApplicationMailer
  default from: "noreply@lipstickproject.com"	

  def thank_you_email(donation_id) 
  	@donation = Donation.find(donation_id)
  	@user = @donation.user

  	mail(to: @user.email, subject: 'Thanks for your donation!')
  end
end
