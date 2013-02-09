# This file is app/controllers/entities_controller.rb
class EntitiesController < ApplicationController
  def index
    @entities = Entity.all
  end
  
  # in app/controllers/movies_controller.rb

  def show
    id = params[:id] # retrieve internal entity ID from URI route
    @entity = Entity.find_by_id(id) # look up entity by unique internal ID

    if @entity == nil
      flash[:notice] = "Entity with internal ID '#{id}' does not exist!"
      redirect_to entities_path
    else
      @entity
    end
    # will render app/views/entities/show.html.haml by default
  end
  
  def new
    # default: render 'new' template
  end

  def create
    #raise params.inspect    
    new_params = {}
    new_params.store("uuid", SecureRandom.uuid)
    new_params.store("description", params[:entity][:description])    
    @entity = Entity.create!(new_params)
    flash[:notice] = "'#{@entity.description}' was successfully registered."
    redirect_to entities_path
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
    flash[:notice] = "#{@entity.uuid} was successfully updated."
    redirect_to entity_path(@entity)
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

end
