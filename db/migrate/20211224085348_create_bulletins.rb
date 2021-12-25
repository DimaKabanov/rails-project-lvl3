class CreateBulletins < ActiveRecord::Migration[6.1]
  def change
    create_table :bulletins do |t|
      t.string :title
      t.text :body
      t.string :creator

      t.timestamps
    end
  end
end
