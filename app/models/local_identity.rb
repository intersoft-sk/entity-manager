class LocalIdentity < ActiveRecord::Base
  belongs_to :entity
  belongs_to :owner
end
