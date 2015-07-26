class AddRecurringDonationTable < ActiveRecord::Migration
  def change
  	create_table :recurring_donations do |t|
    	t.belongs_to :user, index: true		
    	t.integer :amount
    	t.string :stripe_id
    	t.timestamp :start_date
    end
  end
end
