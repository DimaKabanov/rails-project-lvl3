class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :email
      t.boolean :admin, default: false
      t.string :uid
      t.string :provider

      t.timestamps
    end
  end
end
