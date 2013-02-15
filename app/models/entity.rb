class Entity < ActiveRecord::Base
  has_many :local_identities, :dependent => :destroy
  has_many :owners, :through => :local_identities
end
