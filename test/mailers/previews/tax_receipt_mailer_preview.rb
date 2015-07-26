# Preview all emails at http://localhost:3000/rails/mailers/tax_receipt_mailer
class TaxReceiptMailerPreview < ActionMailer::Preview
  def mail_preview
  	TaxReceiptMailer.send(Donation.first)
  end
end
