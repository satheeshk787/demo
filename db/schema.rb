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

ActiveRecord::Schema.define(version: 20190214063301) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace",     limit: 255
    t.text     "body",          limit: 65535
    t.integer  "resource_id",   limit: 4
    t.string   "resource_type", limit: 255
    t.integer  "author_id",     limit: 4
    t.string   "author_type",   limit: 255
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "answer_lists", force: :cascade do |t|
    t.integer  "students_answer_id", limit: 4
    t.text     "answer",             limit: 65535
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  create_table "assignments", force: :cascade do |t|
    t.string   "assignment_name", limit: 255
    t.text     "description",     limit: 65535
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
    t.integer  "user_id",         limit: 4
    t.date     "expiry_date"
    t.integer  "status",          limit: 4,     default: 1
  end

  create_table "hobbies", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "hobby",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "materials", force: :cascade do |t|
    t.integer  "assignment_id",      limit: 4
    t.string   "title",              limit: 255
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.string   "stuff_file_name",    limit: 255
    t.string   "stuff_content_type", limit: 255
    t.integer  "stuff_file_size",    limit: 4
    t.datetime "stuff_updated_at"
  end

  create_table "qualifications", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.string   "stream",     limit: 255
    t.string   "subject",    limit: 255
    t.date     "completed"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "question_answer_lists", force: :cascade do |t|
    t.integer  "question_id", limit: 4
    t.text     "answer",      limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  create_table "questions", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "assignment_id", limit: 4
    t.text     "question",      limit: 65535
    t.integer  "choice_type",   limit: 4
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  create_table "shares", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "assignment_id", limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "students_answers", force: :cascade do |t|
    t.integer  "user_id",       limit: 4
    t.integer  "question_id",   limit: 4
    t.integer  "review_status", limit: 4
    t.integer  "score",         limit: 4
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "universities", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at",                                      null: false
    t.datetime "updated_at",                                      null: false
    t.string   "name",                   limit: 255
    t.datetime "dob"
    t.string   "avatar_file_name",       limit: 255
    t.string   "avatar_content_type",    limit: 255
    t.integer  "avatar_file_size",       limit: 4
    t.datetime "avatar_updated_at"
    t.integer  "role",                   limit: 4,   default: 0
    t.integer  "university_id",          limit: 4
    t.integer  "review_status",          limit: 4,   default: 0
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
