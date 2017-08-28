class AddSynergyNameToCharacterSkills < ActiveRecord::Migration[4.2]
  def change
    add_column :character_skills, :synergy_name, :string
  end
end
