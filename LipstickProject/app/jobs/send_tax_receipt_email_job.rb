class SendTaxReceiptEmailJob
  @queue = :default

  def self.perform(donation_id)
  	# generate pdf from html template
  	TaxReceiptMailer.thank_you_email(donation_id).deliver_now
  	donation.tax_receipt_sent = true
  	donation.save
  end
end  