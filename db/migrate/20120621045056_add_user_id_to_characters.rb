class AddUserIdToCharacters < ActiveRecord::Migration[4.2]
  def change
    add_column :characters, :user_id, :integer
  end
end
