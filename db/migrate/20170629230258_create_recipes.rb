class CreateRecipes < ActiveRecord::Migration[5.1]
  def change
    create_table :recipes do |t|
      t.string :name
      t.text :ingredients
      t.text :directions
      t.integer :cook_time
      t.integer :prep_time
      t.integer :servings
      t.string :skill_level
      t.integer :favorite
    end
  end
end
