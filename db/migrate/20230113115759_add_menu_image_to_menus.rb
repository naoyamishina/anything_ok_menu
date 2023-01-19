class AddMenuImageToMenus < ActiveRecord::Migration[7.0]
  def change
    add_column :menus, :menu_image, :string
  end
end
