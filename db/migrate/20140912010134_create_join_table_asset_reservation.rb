class CreateJoinTableAssetReservation < ActiveRecord::Migration
  def change
    create_join_table :assets, :reservations do |t|
      # t.index [:asset_id, :reservation_id]
      # t.index [:reservation_id, :asset_id]
    end
  end
end
