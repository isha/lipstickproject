class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.belongs_to :user, index: true
      t.string :street
      t.string :house
      t.string :postal_code
      t.string :city
      t.string :province

      t.timestamps null: false
    end
  end
end
