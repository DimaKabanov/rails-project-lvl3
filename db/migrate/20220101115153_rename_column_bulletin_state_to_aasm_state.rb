class RenameColumnBulletinStateToAasmState < ActiveRecord::Migration[6.1]
  def change
    rename_column :bulletins, :bulletin_state, :aasm_state
  end
end
