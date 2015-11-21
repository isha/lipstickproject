class AddAboutToDonations < ActiveRecord::Migration
  def change
  	add_column :donations, :about, :text
  end
end
