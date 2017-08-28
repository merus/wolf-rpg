class CreateSkills < ActiveRecord::Migration[4.2]
  def change
    create_table :skills do |t|
      t.integer :character_id
      t.string :name
      t.integer :level
      t.string :required_skill

      t.timestamps
    end
  end
end
