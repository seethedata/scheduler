class User < ActiveRecord::Base
include Adauth::Rails::ModelBridge

AdauthMappings = {
	:login => :login,
	:group_strings => :cn_groups

	}

AdauthSearchField = [ :login, :login ]

#validates :first_name, :last_name, :login, :email, :active, presence: true
validates :first_name, :last_name, :login, :email,  presence: true
has_many :reservations, inverse_of: :user
end
