# This file is app/controllers/entities_controller.rb
class EntitiesController < ApplicationController
  def index
    @entities = Entity.all
  end
end
