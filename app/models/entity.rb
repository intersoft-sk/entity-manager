class Entity < ActiveRecord::Base
  has_many :local_identities, :dependent => :destroy
  has_many :owners, :through => :local_identities  
  has_many :elements, :class_name => "Entity", :foreign_key => "set_id"
  belongs_to :set, :class_name => "Entity"
  validates :uuid, :uniqueness => true
end
