ActiveRecord::Schema.define(version: 20170715182913) do

  create_table "friendships", force: :cascade do |t|
    t.integer "user_id"
    t.integer "user_friend_id"
    t.index ["user_friend_id", "user_id"], name: "index_friendships_on_user_friend_id_and_user_id", unique: true
    t.index ["user_id", "user_friend_id"], name: "index_friendships_on_user_id_and_user_friend_id", unique: true
  end

  create_table "messages", force: :cascade do |t|
    t.integer "user_id"
    t.integer "sender_id"
    t.string "content"
    t.integer "recipe_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "composition"
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
