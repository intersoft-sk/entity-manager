class RelationshipsController < ApplicationController
	respond_to :html, :xml, :json
	
	def create	  
    master_uuid = params[:master]
    slave_uuid = params[:slave] 
    @entity_master = Entity.find_by_uuid(master_uuid) 
    @entity_slave = Entity.find_by_uuid(slave_uuid) 
    
    if @entity_master == nil or @entity_slave == nil
      raise EntityManager::EntityNotFound
    else
      @entity_master.slaves << @entity_slave unless @entity_master.slaves.where(uuid: @entity_slave.uuid).any?
      @slaves = @entity_master.slaves
      respond_with(@slaves) do |format|  
        format.xml { render :xml => @slaves }  
      end  
    end 
	end
	
	def getMasters
	  uuid = params[:uuid]
    @entity = Entity.find_by_uuid(uuid) 
    
    if @entity == nil 
      raise EntityManager::EntityNotFound
    else
      @masters = @entity.masters 
      respond_with(@masters) do |format|  
        format.xml { render :xml => @masters }  
      end  
    end 
	end
	
	def getSlaves
	  uuid = params[:uuid]
    @entity = Entity.find_by_uuid(uuid) 
    
    if @entity == nil 
      raise EntityManager::EntityNotFound
    else
      @slaves = @entity.slaves 
      respond_with(@slaves) do |format|  
        format.xml { render :xml => @slaves }  
      end  
    end 
	end
	
end
