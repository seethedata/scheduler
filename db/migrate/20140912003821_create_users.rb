class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :login
      t.string :group_strings
      t.string :email
      t.string :admin
      t.string :active

      t.timestamps
    end
  end
end
