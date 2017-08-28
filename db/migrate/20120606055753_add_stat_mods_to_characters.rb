class AddStatModsToCharacters < ActiveRecord::Migration[4.2]
  def change
    add_column :characters, :str_mod, :integer
    add_column :characters, :dex_mod, :integer
    add_column :characters, :int_mod, :integer
    add_column :characters, :fai_mod, :integer
  end
end
