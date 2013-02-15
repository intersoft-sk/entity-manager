class Entity < ActiveRecord::Base
  has_many :local_identities
end
