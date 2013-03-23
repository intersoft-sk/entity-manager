class LocalIdentity < ActiveRecord::Base
  belongs_to :entity
  belongs_to :owner
#  attr_protected :owner_id
  
  def self.find_by_alias(string, owner)
    lid = LocalIdentity.where("localid = ? AND owner_id = ?", string, owner)
    
    unless lid.nil? or lid.empty?
      lid[0].entity
    end

  end
end
