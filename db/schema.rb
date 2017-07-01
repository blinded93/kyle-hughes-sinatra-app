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

ActiveRecord::Schema.define(version: 20170630185137) do

  create_table "friendships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "user_friend_id"
    t.index ["user_friend_id", "user_id"], name: "index_friendships_on_user_friend_id_and_user_id", unique: true
    t.index ["user_id", "user_friend_id"], name: "index_friendships_on_user_id_and_user_friend_id", unique: true
  end

  create_table "recipes", force: :cascade do |t|
    t.string "name"
    t.text "ingredients"
    t.text "directions"
    t.integer "cook_time"
    t.integer "prep_time"
    t.integer "servings"
    t.string "skill_level"
    t.integer "favorite"
    t.integer "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username"
    t.string "email"
    t.string "password_digest"
  end

end
