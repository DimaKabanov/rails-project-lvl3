class AddBulletinStateToBulletin < ActiveRecord::Migration[6.1]
  def change
    add_column :bulletins, :bulletin_state, :string
  end
end
