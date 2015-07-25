class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.belongs_to :user, index: true		
      t.string :type
      t.integer :amount
      t.datetime :date

      t.timestamps null: false
    end
  end
end
