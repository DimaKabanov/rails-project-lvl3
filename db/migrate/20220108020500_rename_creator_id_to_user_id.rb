class RenameCreatorIdToUserId < ActiveRecord::Migration[6.1]
  def change
    rename_column :bulletins, :creator_id, :user_id
  end
end
