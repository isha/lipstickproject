class AddAboutToRecurringDonations < ActiveRecord::Migration
  def change
  	 add_column :recurring_donations, :about, :text
  end
end
