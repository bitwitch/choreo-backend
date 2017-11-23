class CreatePoses < ActiveRecord::Migration[5.1]
  def change
    create_table :poses do |t|
      t.integer :choreography_id
      t.text :konva_json

      t.timestamps
    end
  end
end
