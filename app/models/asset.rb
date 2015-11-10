class Asset < ActiveRecord::Base
validates :name, :ip_address, :test_ping, :site, :active, presence: true
has_and_belongs_to_many :reservations, inverse_of: :asset
end
