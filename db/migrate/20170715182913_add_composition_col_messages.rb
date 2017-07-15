class AddCompositionColMessages < ActiveRecord::Migration[5.1]
  def change
    add_column :messages, :composition, :text
  end
end
