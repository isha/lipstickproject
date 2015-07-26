class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.belongs_to :user, index: true		
      t.string :payment_type, default: "web"
      t.integer :amount
      t.datetime :date
      t.boolean :tax_receipt_sent, default: false

      t.timestamps null: false
    end
  end
end
