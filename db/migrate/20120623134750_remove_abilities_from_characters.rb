class RemoveAbilitiesFromCharacters < ActiveRecord::Migration[4.2]
  def up
    remove_column :characters, :abilities
      end

  def down
    add_column :characters, :abilities, :text
  end
end
