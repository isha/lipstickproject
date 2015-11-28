class AddPhoneNumberToUser < ActiveRecord::Migration
  def change
  	add_column :users, :phone_num, :integer
  end
end
