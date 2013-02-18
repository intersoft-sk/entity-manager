class AddFk2LocalId < ActiveRecord::Migration
  def up
#	add_column :localIdentities, :entity_id, :reference
	add_column :entities, :schema, :string
  end

  def down
#  	remove_column :localIdentities, :entity_id
  	remove_column :entities, :schema
  end
end
