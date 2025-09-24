class CreateExpenses < ActiveRecord::Migration[8.0]
  def change
    create_table :expenses do |t|
      t.decimal :amount, precision: 10, scale: 2
      t.string :description
      t.integer :category, default: 4
      t.integer :status, default: 0
      t.references :user, null: false, foreign_key: true
      t.references :roommate, null: false, foreign_key: { to_table: :users }
      t.datetime :settled_at
      t.references :settled_by, null: true, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
