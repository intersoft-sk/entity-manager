class CreateLocalIdentities < ActiveRecord::Migration
  def up
    create_table :local_identities do |t|
      t.string :local_ID
      t.string :owner
      t.text :description
      # Let Rails automatically keep track of when 
      # localIdentities are added or modified:
      t.timestamps
    end
  end

  def down
    drop_table :local_identities
  end
end
