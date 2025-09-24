class CreateShoppingItems < ActiveRecord::Migration[8.0]
  def change
    create_table :shopping_items do |t|
      t.string :name
      t.integer :category, default: 5
      t.boolean :completed, default: false
      t.references :user, null: false, foreign_key: true
      t.references :roommate, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
