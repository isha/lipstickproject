class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
    	t.string :first_name
    	t.string :last_name 
    	t.string :email 
    	t.boolean :accepts_marketing
    	t.boolean :recurring
    end
  end
end
