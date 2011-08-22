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

ActiveRecord::Schema.define(:version => 20110822211219) do

  create_table "admins", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "username"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "answers", :force => true do |t|
    t.integer  "question_id"
    t.string   "answer"
    t.string   "correct"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "answers", ["question_id"], :name => "index_answers_on_question_id"

  create_table "lesson_templates", :force => true do |t|
    t.string   "name"
    t.integer  "questions_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "lessons", :force => true do |t|
    t.integer  "lesson_template_id"
    t.integer  "user_id"
    t.boolean  "video_watched"
    t.boolean  "complete"
    t.text     "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lessons", ["lesson_template_id"], :name => "index_lessons_on_lesson_template_id"
  add_index "lessons", ["user_id"], :name => "index_lessons_on_user_id"

  create_table "pictures", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "attachable_id"
    t.string   "attachable_type"
    t.string   "pic_file_name"
    t.string   "pic_content_type"
    t.integer  "pic_file_size"
    t.datetime "pic_updated_at"
  end

  create_table "questions", :force => true do |t|
    t.string   "question"
    t.string   "question_type"
    t.integer  "score"
    t.integer  "order"
    t.integer  "lesson_template_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "questions", ["lesson_template_id"], :name => "index_questions_on_lesson_template_id"

  create_table "states", :force => true do |t|
    t.string   "abbreviation"
    t.string   "full_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "username"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "viewable_id"
    t.string   "viewable_type"
    t.string   "video_file_name"
    t.string   "video_content_type"
    t.integer  "video_file_size"
    t.datetime "video_updated_at"
  end

end
