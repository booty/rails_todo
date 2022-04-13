class CreateTodos < ActiveRecord::Migration[7.0]
  def change
    create_table :todos do |t|
      t.references :list, null: false
      t.string :name, null: false, length: 100
      t.datetime :completed_at, null: true
      t.integer :sort_order, default: 1, null: false
      t.timestamps
    end
  end
end
