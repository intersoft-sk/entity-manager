class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_current_user, :except => [:index]
  protected # prevents method from being invoked by a route
  def set_current_user
#  debugger
    # we exploit the fact that find_by_id(nil) returns nil
    @current_user ||= Owner.find_by_id(session[:user_id])
    redirect_to signin_path(:google_oauth2) and return unless @current_user
  end
  
  def signin_path(provider)
    "/auth/#{provider.to_s}"
  end
end
