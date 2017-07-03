class User < ActiveRecord::Base
  has_secure_password

  validates_presence_of :username, on: :create
  validates_presence_of :email, on: :create
  validates_presence_of :password, on: :create

  has_and_belongs_to_many :friends,
    class_name: "User",
    join_table: :friendships,
    foreign_key: :user_id,
    association_foreign_key: :user_friend_id

  has_many :recipes

  def add_friend(friend)
    self.friends << friend
    friend.friends << self
    friend
  end

  def remove_friend(friend)
    self.friends.delete(friend)
    friend.friends.delete(self)
    friend
  end
end
