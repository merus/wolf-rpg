class RemoveRequiredSkillFromSkills < ActiveRecord::Migration[4.2]
  def up
    remove_column :skills, :required_skill
      end

  def down
    add_column :skills, :required_skill, :string
  end
end
