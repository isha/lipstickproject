class TaxReceiptMailer < ApplicationMailer
  default from: "noreply@lipstickproject.com"	

  def send(donation) 
  	@user = donation.user

  	mail(to: user.email, subject: 'Thanks for your donation!')
  end
end
