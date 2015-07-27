class DonationsController < ApplicationController
  def new
  	@donation = Donation.new
  end

  def send_tax_receipt
  	Resque.enqueue(SendTaxReceiptEmailJob, params[:id])
  	render nothing: true
  end
end
