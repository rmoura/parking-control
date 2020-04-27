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

ActiveRecord::Schema.define(version: 2020_04_27_162645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "payments", force: :cascade do |t|
    t.bigint "ticket_id"
    t.integer "cost_cents", default: 0, null: false
    t.string "cost_currency", default: "USD", null: false
    t.integer "discount_cents", default: 0, null: false
    t.string "discount_currency", default: "USD", null: false
    t.integer "total_cents", default: 0, null: false
    t.string "total_currency", default: "USD", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ticket_id"], name: "index_payments_on_ticket_id"
  end

  create_table "tickets", force: :cascade do |t|
    t.string "plate", null: false
    t.string "code", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["code"], name: "index_tickets_on_code", unique: true
    t.index ["plate"], name: "index_tickets_on_plate", unique: true
  end

  add_foreign_key "payments", "tickets"
end
