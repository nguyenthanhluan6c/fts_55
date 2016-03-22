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

ActiveRecord::Schema.define(version: 20160322033009) do

  create_table "activities", force: :cascade do |t|
    t.integer  "type"
    t.integer  "user_id"
    t.string   "target_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "activities", ["user_id"], name: "index_activities_on_user_id"

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.time     "time_limit"
    t.integer  "number_of_words_in_examination"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "examinations", force: :cascade do |t|
    t.integer  "number_of_right_answer"
    t.integer  "status"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "examinations", ["category_id"], name: "index_examinations_on_category_id"
  add_index "examinations", ["user_id"], name: "index_examinations_on_user_id"

  create_table "question_options", force: :cascade do |t|
    t.string   "content"
    t.boolean  "is_correct"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "question_options", ["question_id"], name: "index_question_options_on_question_id"

  create_table "questions", force: :cascade do |t|
    t.string   "content"
    t.integer  "type"
    t.integer  "status"
    t.integer  "user_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "questions", ["category_id"], name: "index_questions_on_category_id"
  add_index "questions", ["user_id"], name: "index_questions_on_user_id"

  create_table "result_options", force: :cascade do |t|
    t.string   "content"
    t.integer  "question_option_id"
    t.integer  "result_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  add_index "result_options", ["question_option_id"], name: "index_result_options_on_question_option_id"
  add_index "result_options", ["result_id"], name: "index_result_options_on_result_id"

  create_table "results", force: :cascade do |t|
    t.integer  "status"
    t.integer  "question_id"
    t.integer  "examination_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "results", ["examination_id"], name: "index_results_on_examination_id"
  add_index "results", ["question_id"], name: "index_results_on_question_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "chatwork_id"
    t.integer  "role"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
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
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
