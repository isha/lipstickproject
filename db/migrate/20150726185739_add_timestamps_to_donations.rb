class AddTimestampsToDonations < ActiveRecord::Migration
  def change
  	add_column :donations, :tax_receipt_date, :timestamp
  	add_column :donations, :donation_date, :timestamp
  end
end
