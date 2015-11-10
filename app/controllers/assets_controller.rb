class AssetsController < ApplicationController
	def show
                @asset=Asset.find(params[:id])
        end
        def index
                @assets=Asset.all.order(:site).order(:name)
        end
        def create
                @asset=Asset.new(asset_params)
                @asset.save
                redirect_to @asset
        end
        def new
                @asset= Asset.new
        end
        def edit
                @asset=Asset.find(params[:id])
        end
        def update
                @asset=Asset.find(params[:id])
                if @asset.update(asset_params)
                        redirect_to @asset
                else
                        render edit
                end
        end
        def destroy
                @asset=Asset.find(params[:id])
                @asset.destroy
                redirect_to assets_path
        end
	def deactivate
		@asset=Asset.find(params[:id])
		@asset.update(active: 'N')
		redirect_to assets_path
	end
	def activate
		@asset=Asset.find(params[:id])
		@asset.update(active: 'Y')
		redirect_to assets_path
	end
	
       private
       def asset_params
       params.require(:asset).permit(:name,:ip_address,:site,:test_ping)
       end
end
