class CreateEats < ActiveRecord::Migration[7.0]
  def change
    create_table :eats do |t|
      t.references :user, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
