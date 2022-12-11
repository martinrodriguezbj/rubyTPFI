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

ActiveRecord::Schema[7.0].define(version: 2022_12_10_180020) do
  create_table "banks", force: :cascade do |t|
    t.string "name", limit: 255, null: false
    t.string "address", limit: 255, null: false
    t.integer "phone", null: false
    t.integer "locality_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_banks_on_name", unique: true
  end

  create_table "localities", force: :cascade do |t|
    t.string "locality", limit: 255, null: false
    t.string "province", limit: 255, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "schedules", force: :cascade do |t|
    t.integer "bank_id", null: false
    t.string "day"
    t.string "startAttention"
    t.string "endAttention"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_id"], name: "index_schedules_on_bank_id"
  end

  create_table "turns", force: :cascade do |t|
    t.integer "bank_id", null: false
    t.integer "user_id", null: false
    t.date "day", null: false
    t.string "hour", null: false
    t.string "reason", null: false
    t.string "state", default: "pending"
    t.string "result"
    t.string "bank_staff"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bank_id"], name: "index_turns_on_bank_id"
    t.index ["user_id"], name: "index_turns_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", null: false
    t.string "password_digest", null: false
    t.string "roll", null: false
    t.integer "bank_id"
    t.string "name", null: false
    t.string "surname", null: false
    t.string "phone"
    t.string "address", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "schedules", "banks", on_delete: :cascade
  add_foreign_key "turns", "banks", on_delete: :cascade
  add_foreign_key "turns", "users", on_delete: :cascade
end
