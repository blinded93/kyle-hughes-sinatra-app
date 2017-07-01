class CreateFriendships < ActiveRecord::Migration[5.1]
  def change
    create_table :friendships do |t|
      t.integer :user_id
      t.integer :user_friend_id
    end

    add_index(:friendships, [:user_id, :user_friend_id], unique: true)
    add_index(:friendships, [:user_friend_id, :user_id], unique: true)
  end
end
