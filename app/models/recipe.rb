class Recipe < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :name, on: :create
  validates_presence_of :ingredients, on: :create
  validates_presence_of :directions, on: :create
  validates_presence_of :cook_time, on: :create
  validates_presence_of :prep_time, on: :create
  validates_presence_of :servings, on: :create
  validates_presence_of :skill_level, on: :create

  def total_time
    cook_time + prep_time
  end

  def ingredients_array
    self.ingredients.split(",").collect{|ingredient| ingredient.strip}
  end

  def directions_array
    self.directions.split("\r\n").collect{|step| step.strip}
  end
end
