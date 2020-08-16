# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_16_155505) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "promises", id: :string, limit: 255, force: :cascade do |t|
    t.string "bmid", limit: 255
    t.string "urtext", limit: 255
    t.string "slug", limit: 255
    t.string "what", limit: 255
    t.boolean "firm", default: false
    t.boolean "void", default: false
    t.float "cred"
    t.datetime "tini"
    t.datetime "tdue"
    t.datetime "tfin"
    t.float "xfin", default: 1.0
    t.integer "clix", default: 1
    t.text "note"
    t.string "ip", limit: 255
    t.string "timezone", limit: 255
    t.json "useragent"
    t.datetime "createdAt", null: false
    t.datetime "updatedAt", null: false
    t.integer "userId"
    t.index ["urtext"], name: "promises_urtext"
  end

  create_table "sample_data", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "pond_zone"
    t.integer "sample_count"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "username", limit: 255
    t.float "score"
    t.datetime "createdAt", null: false
    t.datetime "updatedAt", null: false
    t.integer "counted"
    t.integer "pending"
    t.index ["username"], name: "users_username_key", unique: true
  end

  add_foreign_key "promises", "users", column: "userId", name: "promises_userId_fkey", on_update: :cascade, on_delete: :nullify
end
