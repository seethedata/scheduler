class CreateReservations < ActiveRecord::Migration
  def change
    create_table :reservations do |t|
      t.string :reservation_type
      t.date :start_date
      t.date :end_date
      t.time :start_time
      t.time :end_time
      t.string :partner
      t.string :customer
      t.integer :quarter
      t.integer :year
      t.string :active

      t.timestamps
    end
  end
end
