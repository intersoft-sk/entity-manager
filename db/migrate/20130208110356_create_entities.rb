class CreateEntities < ActiveRecord::Migration
  def up
    create_table :entities do |t|
      t.string :uuid
      t.text :description
      # Let Rails automatically keep track of when 
      # entities are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :entities
  end
end
