# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_09_24_162156) do
  create_table "expenses", force: :cascade do |t|
    t.decimal "amount", precision: 10, scale: 2
    t.string "description"
    t.integer "category", default: 4
    t.integer "status", default: 0
    t.integer "user_id", null: false
    t.integer "roommate_id", null: false
    t.datetime "settled_at"
    t.integer "settled_by_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["roommate_id"], name: "index_expenses_on_roommate_id"
    t.index ["settled_by_id"], name: "index_expenses_on_settled_by_id"
    t.index ["user_id"], name: "index_expenses_on_user_id"
  end

  create_table "shopping_items", force: :cascade do |t|
    t.string "name"
    t.integer "category", default: 5
    t.boolean "completed", default: false
    t.integer "user_id", null: false
    t.integer "roommate_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["roommate_id"], name: "index_shopping_items_on_roommate_id"
    t.index ["user_id"], name: "index_shopping_items_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "expenses", "users"
  add_foreign_key "expenses", "users", column: "roommate_id"
  add_foreign_key "expenses", "users", column: "settled_by_id"
  add_foreign_key "shopping_items", "users"
  add_foreign_key "shopping_items", "users", column: "roommate_id"
end
