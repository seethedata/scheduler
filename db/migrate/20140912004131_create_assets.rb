class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :name
      t.string :ip_address
      t.string :test_ping
      t.string :site
      t.string :active

      t.timestamps
    end
  end
end
