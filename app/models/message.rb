class Message <ActiveRecord::Base
  belongs_to :user

  validates_presence_of :user_id, on: :create
  validates_presence_of :sender_id, on: :create
  validates_presence_of :content, on: :create
  
  def sender
    User.find(self.sender_id)
  end

  def recipe
    Recipe.find(self.recipe_id)
  end

  def recipe_name_short
    self.recipe.name.split.first(5).join(" ") + "..."
  end
end
