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

ActiveRecord::Schema.define(version: 20140811102500) do

  create_table "admins", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "badges", force: true do |t|
    t.string   "name"
    t.string   "badge"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "badge_type"
  end

  create_table "creators", force: true do |t|
    t.string   "name",                   default: "", null: false
    t.string   "avatar"
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "creators", ["confirmation_token"], name: "index_creators_on_confirmation_token", unique: true, using: :btree
  add_index "creators", ["email"], name: "index_creators_on_email", unique: true, using: :btree
  add_index "creators", ["reset_password_token"], name: "index_creators_on_reset_password_token", unique: true, using: :btree

  create_table "games", force: true do |t|
    t.string   "name",                       null: false
    t.text     "description",                null: false
    t.integer  "pts_per_rule", default: 100, null: false
    t.string   "expert_rank",                null: false
    t.string   "normal_rank",                null: false
    t.string   "starter_rank",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "creator_id"
  end

  create_table "rules", force: true do |t|
    t.string   "description"
    t.integer  "priority",    default: 0
    t.integer  "status",      default: 0
    t.integer  "game_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_badges", force: true do |t|
    t.integer  "user_id"
    t.integer  "badge_id"
    t.integer  "game_id"
    t.boolean  "achieved",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_rules", force: true do |t|
    t.integer  "user_id"
    t.integer  "rule_id"
    t.integer  "status",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: ""
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.integer  "invitations_count",      default: 0
    t.string   "name"
    t.string   "avatar"
    t.integer  "game_id"
    t.integer  "pts",                    default: 0
    t.string   "rank"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["invitations_count"], name: "index_users_on_invitations_count", using: :btree
  add_index "users", ["invited_by_id"], name: "index_users_on_invited_by_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
