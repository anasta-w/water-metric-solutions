# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160906051818) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "addresses", force: :cascade do |t|
    t.string   "address_one",   null: false
    t.string   "address_two",   null: false
    t.string   "state",         null: false
    t.string   "city",          null: false
    t.string   "post_code",     null: false
    t.integer  "farm_block_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "alerts", force: :cascade do |t|
    t.string   "condition",      null: false
    t.integer  "value",          null: false
    t.string   "action",         null: false
    t.string   "node_attribute", null: false
    t.integer  "alertable_id",   null: false
    t.string   "alertable_type", null: false
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "alerts", ["alertable_id"], name: "index_alerts_on_alertable_id", using: :btree
  add_index "alerts", ["alertable_type"], name: "index_alerts_on_alertable_type", using: :btree

  create_table "farm_blocks", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "farm_blocks", ["user_id"], name: "index_farm_blocks_on_user_id", using: :btree

  create_table "inflow_meters", force: :cascade do |t|
    t.integer  "farm_block_id",    null: false
    t.string   "name"
    t.integer  "calibration_unit"
    t.string   "device_EUI",       null: false
    t.integer  "daily_consent"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "inflow_meters", ["farm_block_id"], name: "index_inflow_meters_on_farm_block_id", using: :btree

  create_table "locations", force: :cascade do |t|
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.integer  "locationable_id",   null: false
    t.string   "locationable_type", null: false
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "locations", ["locationable_id"], name: "index_locations_on_locationable_id", using: :btree
  add_index "locations", ["locationable_type"], name: "index_locations_on_locationable_type", using: :btree

  create_table "meters", force: :cascade do |t|
    t.integer  "farm_block_id",    null: false
    t.string   "name"
    t.integer  "calibration_unit"
    t.float    "output"
    t.string   "type",             null: false
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "meters", ["farm_block_id"], name: "index_meters_on_farm_block_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",                      null: false
    t.string   "last_name",                       null: false
    t.string   "email",                           null: false
    t.string   "password_digest",                 null: false
    t.string   "phone",                           null: false
    t.string   "type"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.boolean  "email_confirmed", default: false
    t.string   "confirm_token"
    t.string   "auth_token"
  end

  create_table "water_tanks", force: :cascade do |t|
    t.integer  "farm_block_id",                        null: false
    t.float    "height",                               null: false
    t.integer  "capacity"
    t.string   "name",          default: "Water Tank"
    t.string   "device_EUI",                           null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
  end

  add_index "water_tanks", ["farm_block_id"], name: "index_water_tanks_on_farm_block_id", using: :btree

end
