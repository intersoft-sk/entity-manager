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
  
  #if range is -1 -> get all masters
  #if range > 0 -> it defines how far in the graph we will search
  #if range == 0 -> stop finding the predecessors
  def getAllMasters(range)
    result = []
    parents = self.masters
    if parents.length == 0 || range == 0
      return result
    elsif range > 0
      result = result | parents
      range = range - 1
      masters.each do |entity|
        result = result | entity.getAllMasters(range)
      end
    else
      result = result | parents
      masters.each do |entity|
        result = result | entity.getAllMasters(-1) 
      end
    end
    result
  end
  
  #if range is -1 -> get all slaves
  #if range > 0 -> it defines how far in the graph we will search
  #if range == 0 -> stop finding the children
  def getAllSlaves(range)
    result = []
    children = self.slaves
    if children.length == 0 || range == 0
      return result
    elsif range > 0
      result = result | children
      range = range - 1
      children.each do |entity|
        result = result | entity.getAllSlaves(range)
      end
    else
      result = result | children
      children.each do |entity|
        result = result | entity.getAllSlaves(-1) 
      end
    end
    result
  end
end
 
