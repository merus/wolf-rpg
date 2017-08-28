class RemoveItemsFromCharacters < ActiveRecord::Migration[4.2]
  def up
    remove_column :characters, :items
      end

  def down
    add_column :characters, :items, :text
  end
end
