class AddRequiredSkillIdToSkills < ActiveRecord::Migration[4.2]
  def change
    add_column :skills, :required_skill_id, :integer
  end
end
