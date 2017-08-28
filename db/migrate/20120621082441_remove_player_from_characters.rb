class RemovePlayerFromCharacters < ActiveRecord::Migration[4.2]
  def up
    remove_column :characters, :player
      end

  def down
    add_column :characters, :player, :string
  end
end
