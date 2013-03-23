class LocalIdentitiesController < ApplicationController
  respond_to :html, :xml, :json
  before_filter :has_owner_and_entity, :only => [:new, :create]
  
  class EntityManager::NotExistingEntity < Exception   
  end
  
  protected
  def has_owner_and_entity
    respond_to do |format|
      format.html { 
        unless @current_user
          flash[:warning] = 'You must be logged in to create a local identity.'
          redirect_to login_path
        end    
        unless (@entity = Entity.find_by_id(params[:entity_id]))
          flash[:warning] = 'Local ID must be for an existing entity.'
          redirect_to entities_path
        end    
      }
      format.xml {
        unless (@current_user = Owner.find(params[:entity][:owner]))
          @current_user = Owner.anonymous
        end 
        unless (@entity = Entity.find_by_id(params[:entity_id]))
          raise EntityManager::NotExistingEntity          
        end        
      }
    end         
  end
  
  public
  def new
    @lid = @entity.local_identities.build
  end
  def create
    # since owner_id is a protected attribute that won't get
    # assigned by the mass-assignment from params[:local_identity], we set it
    # by using the << method on the association.  We could also
    # set it manually with local_identity.owner = @current_user.
    #@current_user.local_identities << @entity.local_identities.build(params[:local_identities])
    @lid = @entity.local_identities.build(params[:local_identities])
    @lid.owner = @current_user
    @lid.save!
    respond_to do |format|
      format.html { 
        flash[:notice] = "'#{@lid.name}' was successfully added."
        redirect_to entity_path(@entity)
        return
      }
      format.xml {
        respond_with @lid
      }
    end
  end
  
  def destroy
    @lid = LocalIdentity.find_by_id(params[:id])
    unless @lid.nil?
    	entity = @lid.entity
    	@lid.destroy
    end
    flash[:notice] = "Local alias '#{@lid.name}' deleted."
    redirect_to entity_path(entity)
  end
end
