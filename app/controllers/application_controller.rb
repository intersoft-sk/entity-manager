class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_current_user, :unless => :format_xml?, :except => [:index]
    
  if (defined? ActiveRecord)
    rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  end
   
  def format_xml?
    request.format.xml?
  end

  protected # prevents method from being invoked by a route
  def set_current_user
    # we exploit the fact that find_by_id(nil) returns nil
    @current_user ||= Owner.find_by_id(session[:user_id])
    redirect_to entities_path and return unless @current_user
  end
  
  def signin_path(provider)
    "/auth/#{provider.to_s}"
  end
  
  #exception handling
  def record_not_found(exception)
    handle_error('no record', :status => :not_found)
  end
  
  def entity_not_found(exception)
    handle_error('Entity not found - can not create local alias.', :status => :not_found)
  end
  
  def localid_already_used(exception)
    handle_error('Local ID for selected entity already exists.', :status => :not_found)
  end
  
  def handle_error(message, params)
    error = {
      :error => message
#      :request => request.request_method.to_s.upcase! + ' ' + request.request_uri
    }
    status = params[:status] || :not_found
 
    respond_to do |format|
      format.xml  { render :xml  => error.to_xml, :status => status }
      format.json { render :json => error.to_json, :status => status }
      format.yaml { render :text => error.to_yaml, :status => status }
    end
  end
end
