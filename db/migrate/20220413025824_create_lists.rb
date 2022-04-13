class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.string :name, length: 100, null: false
      t.integer :sort_order, default: 1, null: false
      t.boolean :active, default: 1
      t.timestamps
    end
  end
end
