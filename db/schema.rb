# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_221_124_182_426) do
  create_table 'completions', force: :cascade do |t|
    t.integer 'user_id', null: false
    t.integer 'problem_id', null: false
    t.integer 'solution_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['problem_id'], name: 'index_completions_on_problem_id'
    t.index ['solution_id'], name: 'index_completions_on_solution_id'
    t.index ['user_id'], name: 'index_completions_on_user_id'
  end

  create_table 'problems', force: :cascade do |t|
    t.text 'code'
    t.integer 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'title'
    t.text 'description'
    t.string 'lang'
    t.text 'test'
    t.boolean 'tested'
    t.string 'status'
    t.index ['user_id'], name: 'index_problems_on_user_id'
  end

  create_table 'solutions', force: :cascade do |t|
    t.integer 'score', default: 0
    t.text 'code'
    t.integer 'user_id', null: false
    t.integer 'problem_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'status'
    t.boolean 'tested'
    t.index ['problem_id'], name: 'index_solutions_on_problem_id'
    t.index ['user_id'], name: 'index_solutions_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'completions', 'problems'
  add_foreign_key 'completions', 'solutions'
  add_foreign_key 'completions', 'users'
  add_foreign_key 'problems', 'users'
  add_foreign_key 'solutions', 'problems'
  add_foreign_key 'solutions', 'users'
end
