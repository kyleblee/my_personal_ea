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

ActiveRecord::Schema.define(version: 20171113183140) do

  create_table "contact_plans", force: :cascade do |t|
    t.integer "contact_id"
    t.integer "plan_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.string "category"
    t.string "expertise"
    t.string "preferences"
    t.integer "user_id"
  end

  create_table "last_interactions", force: :cascade do |t|
    t.string "date"
    t.string "details"
    t.integer "contact_id"
  end

  create_table "plans", force: :cascade do |t|
    t.string "name"
    t.string "date"
    t.string "time"
    t.string "location"
    t.string "context"
    t.string "pre_notes"
    t.string "post_notes"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "password_digest"
    t.string "email"
  end

end
