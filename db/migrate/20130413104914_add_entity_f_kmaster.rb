class AddEntityFKmaster < ActiveRecord::Migration
  def up   
    create_table :relationships, :id => false do |t|
      t.integer :master_id
      t.integer :slave_id
      # Let Rails automatically keep track of when 
      # entities are added or modified:
      t.timestamps
    end
    
  end

  def down
    drop_table :relationships
  end
end
