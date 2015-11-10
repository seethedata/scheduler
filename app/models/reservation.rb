class Reservation < ActiveRecord::Base
	validates :reservation_type, :start_date, :start_time, :end_time, :quarter, :year, :active, presence: true
	has_and_belongs_to_many :assets, inverse_of: :reservation
	accepts_nested_attributes_for :assets, allow_destroy: true
	belongs_to :user , inverse_of: :reservations

	def self.to_csv(options = {})
		CSV.generate(options) do |csv|
			csv << column_names
			all.each do |product|
				csv << reservation.attributes.values_at(*column_names)
      			end
    		end
  	end
end

