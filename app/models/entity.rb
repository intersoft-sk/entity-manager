class Entity < ActiveRecord::Base
  has_many :local_identities, :dependent => :destroy
  has_many :owners, :through => :local_identities  
  has_many :slavery, :class_name => "Relationship", :foreign_key => "master_id"
  has_many :slaves, :through => :slavery, :source => :slave
  has_many :mastery, :class_name => "Relationship", :foreign_key => "slave_id"
  has_many :masters, :through => :mastery, :source => :master
  validates :uuid, :uniqueness => true
  
  default_scope order('updated_at DESC')
  paginates_per 15
end
 
