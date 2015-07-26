class TaxReceiptMailer < ApplicationMailer
  default from: "noreply@sandbox1614c4b472d24032b9930151551ba341.mailgun.org"	

  def thank_you_email(donation_id) 
  	@donation = Donation.find(donation_id)
  	@user = @donation.user

  	path = Rails.public_path + "tax_receipt.html.erb"
  	erb = ERB.new(File.open(path, 'rb').read)
  	html = erb.result(binding)
  	kit = PDFKit.new(html)

  	# For testing purposes
  	#file = kit.to_file('/Users/ishak/Desktop/tax_receipt.pdf')

  	attachments['tax_receipt.pdf'] = kit.to_pdf
  	mail(to: @user.email, subject: 'Thank you for your donation!')
  end
end
