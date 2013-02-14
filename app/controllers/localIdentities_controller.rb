class LocalIdentitiesController < ApplicationController
	def create
    #raise params.inspect    
    new_params = {} # params for LocalID
    new_params.store("owner", session[:user_id])
    new_params.store("local_ID", params[:localIdentities][:local_ID])
    new_params.store("description", params[:localIdentities][:description])
    @localIdentity = LocalIdentity.create!(new_params)
    return
  end
end
