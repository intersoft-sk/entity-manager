# This file is app/controllers/entities_controller.rb

class EntitiesController < ApplicationController
	respond_to :html, :xml, :json
		 
  def index
  	@current_user ||= Owner.find_by_id(session[:user_id])    
    respond_to do |format|
      format.html {
        @entities = Entity.order("updated_at DESC").page(params[:page]).per(15)
      }
      format.xml {
        @entities = Entity.order("updated_at DESC")
      }
    end
    respond_with(@entities)
  end
  
  def get_by_alias    
    respond_to do |format|
      format.html {
        @owner = Owner.find_by_id(params[:owner])
        p @owner.inspect
        @entity = LocalIdentity.find_by_alias(params[:search_terms], @owner.id)
        p @entity.inspect
        unless @entity.nil? or @owner.nil?
          redirect_to entity_path(@entity) and return
        end
        if @owner.nil?
          flash[:notice] = "Unknown owner"
        else   
          flash[:notice] = "Entity with local alias '#{params[:search_terms]}' and owner '#{params[:owner]}' does not exist!"
        end
        redirect_to entities_path
      }
      format.xml {
        unless (@user = Owner.find_by_id(params[:owner]))
          raise EntityManager::OwnerNotFound
        end 
        @entity = LocalIdentity.find_by_alias(params[:search_terms], @user.id)
        if @entity.nil?
          raise EntityManager::EntityNotFound
        else
          respond_with @entity
        end
      }
    end     
    
  end

  def show
    id = params[:id] # retrieve internal entity ID from URI route
    @entity = Entity.find_by_id(id) # look up entity by unique internal ID

    if @entity == nil
      flash[:notice] = "Entity with internal ID '#{id}' does not exist!"
      redirect_to entities_path
    else
      @slaves = @entity.slaves  
      @masters = @entity.masters     
      @entity
    end
    @localIDs = @entity.local_identities
    # will render app/views/entities/show.html.haml by default
  end
  
  def getIdentity
    uuid = params[:uuid] 
    @entity = Entity.find_by_uuid(uuid) 

    if @entity == nil
      respond_to do |format|
        format.html {
          flash[:notice] = "Entity with uuid '#{params[:uuid]}' does not exist!"        
          redirect_to entities_path
        }
        format.xml {
          raise EntityManager::EntityNotFound
        }
      end 
    else
      respond_with @entity
    end                 
  end
  
  def new
    # default: render 'new' template
  end

  def create                  
    #raise params.inspect    
    new_params = {} # params for LocalID
    respond_to do |format|
      format.html { 
        @owner = Owner.find_by_id(session[:user_id]) 
        new_params.store("localid", params[:local_identities][:localid])
        new_params.store("description", params[:local_identities][:description])
        
      }
      format.xml {
        @owner = Owner.find(params[:owner])
        new_params.store("localid", params[:localid])
        new_params.store("description", params[:description])
      }
    end    
    
    @localIdentity = LocalIdentity.create!(new_params)
    @localIdentity.owner = @owner
    new_params2 = {} #params for entity
    new_params2.store("uuid", SecureRandom.uuid)
    new_params2.store("schema", 'urn:entityID:')
    
    respond_to do |format|
      format.html { 
        #for now just copy the description of local identity
        new_params2.store("description", params[:local_identities][:description])        
      }
      format.xml {
        new_params2.store("description", params[:description])        
      }
    end        
    #raise new_params2.inspect
    @entity = Entity.create!(new_params2)
    @entity.local_identities << @localIdentity

    respond_to do |format|
      format.html { 
        flash[:notice] = "'#{@entity.description}' was successfully registered."
        redirect_to entities_path  
        return      
      }
      format.xml {
        respond_with @entity        
      }
    end           
  end
  
  
  def edit
    @entity = Entity.find_by_id(params[:id])
    if @entity == nil
      flash[:notice] = "Entity with internal ID '#{params[:id]}' does not exist!"
      redirect_to entities_path
    else
      @entity
    end
  end

  def update
    @entity = Entity.find_by_id(params[:id])
    if @entity == nil
      flash[:notice] = "Entity with internal ID '#{params[:id]}' does not exist!"
      redirect_to entities_path
    else
      @entity
    end
    @entity.update_attributes!(params[:entity])
    respond_to do |client_wants|
      client_wants.html {  
        flash[:notice] = "#{@entity.uuid} was successfully updated."
        redirect_to entity_path(@entity)
        return
      } # as before
      client_wants.xml  {  render :xml => @entity.to_xml    }
    end
      
  end

  def destroy
    @entity = Entity.find_by_id(params[:id])
    if @entity == nil
      flash[:notice] = "Entity with internal ID '#{params[:id]}' does not exist!"
      redirect_to entities_path    
    end
    @entity.destroy
    flash[:notice] = "Entity '#{@entity.uuid}' deleted."
    redirect_to entities_path
  end

  def login
  end
  
end
