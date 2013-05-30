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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130529112618) do

  create_table "employees", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_id"
    t.string   "phone_number"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "employees", ["user_id"], :name => "index_employees_on_user_id"

  create_table "reminders", :force => true do |t|
    t.text     "message"
    t.string   "phone_number"
    t.integer  "user_id"
    t.string   "time_to_send"
    t.integer  "sms_id"
    t.boolean  "status"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "reminders", ["user_id"], :name => "index_reminders_on_user_id"

  create_table "sent_sms", :force => true do |t|
    t.integer  "sms_id"
    t.string   "phone_number"
    t.text     "message"
    t.boolean  "status"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "sent_sms", ["user_id"], :name => "index_sent_sms_on_users_id"

  create_table "users", :force => true do |t|
    t.string   "email"
    t.string   "password"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "name"
  end

end
