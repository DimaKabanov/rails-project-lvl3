class RenameUserIdToCreatorId < ActiveRecord::Migration[6.1]
  def change
    rename_column :bulletins, :user_id, :creator_id
  end
end
