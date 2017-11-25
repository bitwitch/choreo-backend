class CreateChoreographies < ActiveRecord::Migration[5.1]
  def change
    create_table :choreographies do |t|
      t.integer :user_id 
      t.string :name 
      t.text :poses_json
      
      t.timestamps
    end
  end
end
