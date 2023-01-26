class AddEatAtToMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :menus, :eat_at, :integer, default: 0, null: false
  end
end
