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

ActiveRecord::Schema.define(version: 20170907031057) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abilities", id: :serial, force: :cascade do |t|
    t.integer "character_id"
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "campaign_members", id: :serial, force: :cascade do |t|
    t.integer "campaign_id"
    t.integer "user_id"
    t.integer "membership"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "campaigns", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "is_public", default: true
  end

  create_table "character_skills", id: :serial, force: :cascade do |t|
    t.integer "character_id"
    t.string "name", limit: 255
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "required_skill", limit: 255
    t.string "synergy_name", limit: 255
  end

  create_table "characters", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.integer "str"
    t.integer "dex"
    t.integer "int"
    t.integer "fai"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "race", limit: 255
    t.integer "user_id"
    t.integer "campaign_id"
    t.integer "privacy"
    t.integer "synergy_hp"
  end

  create_table "equipment", id: :serial, force: :cascade do |t|
    t.integer "character_id"
    t.string "slot", limit: 255
    t.string "name", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "item_type", limit: 255
  end

  create_table "skills", id: :serial, force: :cascade do |t|
    t.integer "character_id"
    t.string "name", limit: 255
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "required_skill_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name", limit: 255
    t.string "email", limit: 255
    t.string "handle", limit: 255
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest", limit: 255
    t.integer "active_character_id"
    t.integer "character2_id"
    t.integer "character3_id"
    t.integer "active_campaign_id"
    t.integer "campaign2_id"
    t.integer "campaign3_id"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
