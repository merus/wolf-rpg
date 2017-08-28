class CreateAbilities < ActiveRecord::Migration[4.2]
  def change
    create_table :abilities do |t|
      t.integer :character_id
      t.string :name

      t.timestamps
    end
  end
end
