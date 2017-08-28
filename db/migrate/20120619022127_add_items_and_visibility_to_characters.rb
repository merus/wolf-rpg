class AddItemsAndVisibilityToCharacters < ActiveRecord::Migration[4.2]
  def change
    add_column :characters, :items, :text
    add_column :characters, :visibility, :string
  end
end
