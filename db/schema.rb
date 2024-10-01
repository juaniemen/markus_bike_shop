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

ActiveRecord::Schema[7.2].define(version: 2024_09_28_170136) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bike_order_items", force: :cascade do |t|
    t.bigint "bike_order_id", null: false
    t.bigint "component_id", null: false
    t.decimal "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bike_order_id"], name: "index_bike_order_items_on_bike_order_id"
    t.index ["component_id"], name: "index_bike_order_items_on_component_id"
  end

  create_table "bike_orders", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.decimal "total"
    t.text "observations"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_bike_orders_on_user_id"
  end

  create_table "component_constraints", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "component_constraints_components", primary_key: ["component_id", "component_constraint_id"], force: :cascade do |t|
    t.bigint "component_id", null: false
    t.bigint "component_constraint_id", null: false
    t.index ["component_constraint_id"], name: "idx_on_component_constraint_id_2b946c89b7"
    t.index ["component_id"], name: "index_component_constraints_components_on_component_id"
  end

  create_table "component_sets", force: :cascade do |t|
    t.bigint "c_source_id"
    t.float "price"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "component_sets_components", id: false, force: :cascade do |t|
    t.bigint "component_id", null: false
    t.bigint "component_set_id", null: false
    t.index ["component_id", "component_set_id"], name: "idx_on_component_id_component_set_id_4536d0d130"
  end

  create_table "components", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "c_type"
    t.float "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "bike_order_items", "bike_orders"
  add_foreign_key "bike_order_items", "components"
  add_foreign_key "bike_orders", "users"
  add_foreign_key "component_constraints_components", "component_constraints"
  add_foreign_key "component_constraints_components", "components"
end
