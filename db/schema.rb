# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100621124529) do

  create_table "games", :force => true do |t|
    t.string   "name"
    t.integer  "war",        :default => 1
    t.integer  "round",      :default => 1
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "playings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "game_id"
    t.string   "country"
    t.integer  "play_order"
    t.boolean  "pass",       :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "propositions", :force => true do |t|
    t.integer  "playing_id"
    t.integer  "game_id"
    t.integer  "war"
    t.integer  "round"
    t.string   "positionA"
    t.string   "positionB"
    t.integer  "amount"
    t.boolean  "opened"
    t.boolean  "rejected"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "password_salt",                       :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
