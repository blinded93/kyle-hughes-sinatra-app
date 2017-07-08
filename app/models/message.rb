class Message <ActiveRecord::Base
  belongs_to :user

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
