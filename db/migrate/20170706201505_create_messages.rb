class CreateMessages < ActiveRecord::Migration[5.1]
  def change
    create_table :messages do |t|
      t.integer :owner_id
      t.integer :sender_id
      t.string :content
    end
  end
end
