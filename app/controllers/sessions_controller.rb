class SessionsController < ApplicationController
	skip_before_action :authenticate_user!, :only => [:new, :create]
	def new
		redirect_to root_path if current_user
	end

	def create
		flash.clear
		uname = params[:username]
		uname.sub!(/@commercial.demo/i,"");
		ldap_user = Adauth.authenticate(uname, params[:password])
		if ldap_user
        	user = User.return_and_create_from_adauth(ldap_user)
			flash[:error]= ("User id is  " + user.id)
        	session[:user_id] = user.id
        	redirect_to root_path
    		else
			flash[:error]= ("Invalid Login for user: " + uname + ".")
       		 	render  new_session_path 
    		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end
end
