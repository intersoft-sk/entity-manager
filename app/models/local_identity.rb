class LocalIdentity < ActiveRecord::Base
  belongs_to :entity
  belongs_to :owner
  attr_protected :owner_id
end
