class CreateMenus < ActiveRecord::Migration[7.0]
  def change
    create_table :menus do |t|
      t.string :name, null: false
      t.text :memo
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
