class ApplicationController < ActionController::Base
	before_action :authenticate_user!
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  	protect_from_forgery with: :exception
	helper_method :current_user
    	def current_user
        	@current_user ||= User.find(session[:user_id]) if session[:user_id]
    	end
    	def authenticate_user!
       		if current_user.nil?
       			redirect_to '/sessions/new', :error => "Invalid Login" 
       		end
    	end
end
