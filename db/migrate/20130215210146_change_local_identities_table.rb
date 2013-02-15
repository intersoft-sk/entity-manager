class ChangeLocalIdentitiesTable < ActiveRecord::Migration
  def up
  	drop_table :localIdentities
  	
	create_table :local_identities do |t|
      t.string :local_ID
      t.string :name
      t.references :owner
      t.text :description
      t.references :entity
      # Let Rails automatically keep track of when 
      # localIdentities are added or modified:
      t.timestamps
    end
  end

  def down
  	drop_table :local_identities
  end
end
