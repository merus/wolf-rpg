class AddRaceToCharacters < ActiveRecord::Migration[4.2]
  def change
    add_column :characters, :race, :string
  end
end
