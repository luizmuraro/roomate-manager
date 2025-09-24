class CreateReceipts < ActiveRecord::Migration[8.0]
  def change
    create_table :receipts do |t|
      t.string :title, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.references :expense, null: true, foreign_key: true  # Can be unlinked initially
      t.references :user, null: false, foreign_key: true
      t.integer :category, default: 0
      t.integer :status, default: 0

      t.timestamps
    end

    add_index :receipts, :category
    add_index :receipts, :status
    add_index :receipts, :created_at
  end
end
