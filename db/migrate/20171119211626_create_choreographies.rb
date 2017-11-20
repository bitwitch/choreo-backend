class CreateChoreographies < ActiveRecord::Migration[5.1]
  def change
    create_table :choreographies do |t|
      t.integer :user_id 
      
      t.timestamps
    end
  end
end
