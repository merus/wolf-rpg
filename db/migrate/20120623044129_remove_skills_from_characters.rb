class RemoveSkillsFromCharacters < ActiveRecord::Migration[4.2]
  def up
    remove_column :characters, :skills
      end

  def down
    add_column :characters, :skills, :text
  end
end
