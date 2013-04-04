class AddIndices < ActiveRecord::Migration
  def up
    add_index 'entities', 'uuid', :unique => true
  end

  def down
  end
end
