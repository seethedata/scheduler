class UsersController < ApplicationController
        def show
                @user=User.find(params[:id])
        end
        def index
                @users=User.all
        end
        def create
#                @user=User.new(user_params)
#                @user.save
                @user=User.create_from_adauth(adauth_model) 
                redirect_to @user
        end
        def new
#                @user= User.new
                @user=User.create_from_adauth(adauth_model) 
        end
        def edit
                @user=User.find(params[:id])
        end
        def update
                @user=User.find(params[:id])
                if @user.update(user_params)
                        redirect_to @user
                else
                        render edit
                end
        end
        def destroy
                @user=User.find(params[:id])
                @user.destroy
                redirect_to users_path
        end
 	def deactivate
                @user=User.find(params[:id])
                @user.update(active: 'N')
                redirect_to users_path
        end
        def activate
                @user=User.find(params[:id])
                @user.update(active: 'Y')
                redirect_to users_path
        end

       private
       def user_params
       params.require(:user).permit(:first_name,:last_name,:login, :email, :active)
       end
end
