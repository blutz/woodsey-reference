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

ActiveRecord::Schema.define(version: 20150211080423) do

  create_table "co_groups", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "co_groups_users", id: false, force: :cascade do |t|
    t.integer "user_id",     limit: 4, null: false
    t.integer "co_group_id", limit: 4, null: false
  end

  add_index "co_groups_users", ["co_group_id", "user_id"], name: "index_co_groups_users_on_co_group_id_and_user_id", using: :btree
  add_index "co_groups_users", ["user_id", "co_group_id"], name: "index_co_groups_users_on_user_id_and_co_group_id", using: :btree

  create_table "program_comments", force: :cascade do |t|
    t.integer  "program_id", limit: 4
    t.integer  "user_id",    limit: 4
    t.text     "comment",    limit: 65535
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "program_comments", ["program_id"], name: "index_program_comments_on_program_id", using: :btree
  add_index "program_comments", ["user_id"], name: "fk_rails_433d687521", using: :btree

  create_table "program_steps", force: :cascade do |t|
    t.integer  "order",       limit: 4
    t.integer  "duration",    limit: 4
    t.text     "description", limit: 4294967295
    t.text     "materials",   limit: 4294967295
    t.text     "notes",       limit: 4294967295
    t.integer  "program_id",  limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "program_steps", ["program_id"], name: "index_program_steps_on_program_id", using: :btree

  create_table "programs", force: :cascade do |t|
    t.integer  "status",      limit: 4
    t.string   "title",       limit: 255
    t.text     "outcome",     limit: 16777215
    t.text     "indicators",  limit: 4294967295
    t.integer  "co_group_id", limit: 4
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "programs", ["co_group_id"], name: "index_programs_on_co_group_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "camp_name",       limit: 255
    t.string   "email",           limit: 255
    t.string   "password_digest", limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_foreign_key "program_comments", "programs"
  add_foreign_key "program_comments", "users"
  add_foreign_key "program_steps", "programs"
end
