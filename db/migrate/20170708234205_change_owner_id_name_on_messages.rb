class ChangeOwnerIdNameOnMessages < ActiveRecord::Migration[5.1]
  def change
    change_table(:messages) do |t|
      t.rename :owner_id, :user_id
    end
  end
end
