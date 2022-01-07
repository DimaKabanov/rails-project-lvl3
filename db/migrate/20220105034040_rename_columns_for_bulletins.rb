class RenameColumnsForBulletins < ActiveRecord::Migration[6.1]
  def change
    rename_column :bulletins, :aasm_state, :state
    rename_column :bulletins, :body, :description
    rename_column :bulletins, :creator, :user
  end
end
