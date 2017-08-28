class AddRequiredSkillToCharacterSkills < ActiveRecord::Migration[4.2]
  def change
    add_column :character_skills, :required_skill, :string
  end
end
