class Relationship < ActiveRecord::Base
  belongs_to :master, :class_name => "Entity"
  belongs_to :slave, :class_name => "Entity"  
end
