class ReservationsController < ApplicationController
	def show
                @reservation=Reservation.find(params[:id])
		@user_full_name=User.find(@reservation.user_id).first_name + " " + User.find(@reservation.user_id).last_name
        end

	def reports
		render "reports"
	end

	def report
		@year=params[:year]
		@quarter=params[:quarter]
		@reservations=Reservation.joins(:user).where("quarter = ? and year = ?", @quarter, @year).order(:start_date).order(:start_time).select(:start_date, :start_time, 
								:end_time, :reservation_type, :partner, :customer, :quarter, :year, :user_id, "users.login" )
		@userReservationsCount=Reservation.joins(:user).where("quarter = ? and year = ?", @quarter, @year).group("users.login").count
		@typeCount=Reservation.where("quarter = ? and year = ?", @quarter, @year).group(:reservation_type).count

		@filename="Scheduler Report-" + @year + "Q" +@quarter + ".xls"
		headers["Content-Disposition"] = "attachment; filename=\"#{@filename}\"" 		
		respond_to do |format|
			format.xls 
		end 
	end
        def index
		if ( params[:mine] == "Y" ) 
			@reservations=Reservation.where(:user_id => current_user.id).order(start_date: :desc).order(start_time: :desc)
		else
                	@reservations=Reservation.order(start_date: :desc).order(start_time: :desc)
		end
        end

        def create
                @reservation=Reservation.new(reservation_params)
		@all_assets=Asset.where(active: "Y").order(:name)
		@all_sites= Asset.select(:site).order(:site).distinct
		@ip_list=Asset.where(active: "Y").order(:site).order(:name).select(:site,:name, :ip_address)


		if (@reservation.start_date.nil?) 
			@reservation.errors.add(:start_date, " cannot be blank.")
		end

		if (@reservation.start_time.nil?) 
			@reservation.errors.add(:start_time, " cannot be blank.")
		end
		if (@reservation.end_time.nil?) 
			@reservation.errors.add(:end_time, " cannot be blank.")
		end

		if (@reservation.errors.blank? and @reservation.start_time >= @reservation.end_time)
			@reservation.errors.add(:start_time, "must preceed End time.")
		end
		unless (@reservation.assets.any?)
			@reservation.errors.add(:base, "Please select at least one asset to reserve.")
		end

		@start_time=@reservation.start_time.strftime("%H:%M:%S")
		@end_time=@reservation.end_time.strftime("%H:%M:%S")

		unless (@reservation.errors.blank? and all_assets_available?(@reservation,@start_time, @end_time))
			@reservation.assets.each do |a|
			if(Asset.joins(:reservations).exists?(["reservations.start_date= ? and assets.id = ? and ((? between reservations.start_time and reservations.end_time) or (? between reservations.start_time and reservations.end_time)  or (reservations.start_time between ? and ? ) or (reservations.end_time between ? and ? ))",
						 @reservation.start_date,a.id, @start_time, @end_time, @start_time,  @end_time,@start_time, @end_time]))
					@reservation.errors.add(:base, Asset.find(a.id).name + " is not available at this time.")
				end
			end
		end


		if (@reservation.errors.any?)
			@all_sites= Asset.select(:site).distinct
			@all_assets= Asset.where("active='Y'")
			render action: :new
		else
			@reservation.user_id=current_user.id
			@reservation.year=@reservation.start_date.year
			@reservation.quarter=get_quarter(@reservation.start_date.month)
			@reservation.active="Y"
                	if (@reservation.save )
                		redirect_to @reservation
			else
				redirect_to action: :new
			end
		end
        end
        def new
                @reservation= Reservation.new
		@all_assets=Asset.where(active: "Y").order(:name)
		@all_sites= Asset.select(:site).order(:site).distinct
		@ip_list=Asset.where(active: "Y").order(:site).order(:name).select(:site,:name, :ip_address)
        end
        def edit
                @reservation=Reservation.find(params[:id])
		@all_assets=Asset.where(active: "Y").order(:name)
		@all_sites= Asset.select(:site).order(:name).distinct
        end

        def update
                @reservation=Reservation.find(params[:id])
		if @reservation.assets.blank?
			@reservation.errors.add(:base, "Please select at least one asset to reserve.")
		end
                if @reservation.errors.blank? and @reservation.update(reservation_params)
                        redirect_to @reservation
                else
                        render edit
                end
        end
        def destroy
                @reservation=Reservation.find(params[:id])
                @reservation.destroy
                redirect_to reservations_path
        end

	private
	def reservation_params
		params.require(:reservation).permit(:start_date, :start_time, :end_time, :reservation_type, :partner, :customer, {:asset_ids => []})
	end

	def get_quarter(the_month)
		if (the_month >= 10) 
			quarter=4
		elsif (the_month >=7)
			quarter=3
		elsif (the_month >=4)
			quarter=2
		elsif (the_month >=1)
			quarter=1	
		end
		return  quarter
	end
	
	def all_assets_available?(reservation, start_time, end_time) 
		result=true
		reservation.assets.each do |a|
			if(Asset.joins(:reservations).exists?(["reservations.start_date= ? and assets.id = ? and ((? between reservations.start_time and reservations.end_time) or (? between reservations.start_time and reservations.end_time) or (reservations.start_time between ? and ? ) or (reservations.end_time between ? and ? ))",
						 reservation.start_date, a.id, start_time, end_time, start_time,  end_time,start_time, end_time]))
				result=false
				break
			end
		end
		return result
	end
end
