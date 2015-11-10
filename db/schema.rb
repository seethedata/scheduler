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

ActiveRecord::Schema.define(version: 20140912010134) do

  create_table "assets", force: true do |t|
    t.string   "name"
    t.string   "ip_address"
    t.string   "test_ping"
    t.string   "site"
    t.string   "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assets_reservations", id: false, force: true do |t|
    t.integer "asset_id",       null: false
    t.integer "reservation_id", null: false
  end

  create_table "reservations", force: true do |t|
    t.string   "reservation_type"
    t.date     "start_date"
    t.date     "end_date"
    t.time     "start_time"
    t.time     "end_time"
    t.string   "partner"
    t.string   "customer"
    t.integer  "quarter"
    t.integer  "year"
    t.string   "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "reservations", ["user_id"], name: "index_reservations_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "login"
    t.string   "group_strings"
    t.string   "email"
    t.string   "admin"
    t.string   "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
