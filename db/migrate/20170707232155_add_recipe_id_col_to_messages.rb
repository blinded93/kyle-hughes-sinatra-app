class AddRecipeIdColToMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :recipe_id, :integer
  end
end
