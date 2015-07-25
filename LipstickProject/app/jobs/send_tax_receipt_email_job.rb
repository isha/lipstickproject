class SendTaxReceiptEmailJob
  @queue = :default

  def self.perform(donation)
  	# generate pdf from html template
  	# TaxReceiptMaile.send(donation, attachment)
  end
end  