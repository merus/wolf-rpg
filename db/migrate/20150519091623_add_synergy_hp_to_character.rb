class AddSynergyHpToCharacter < ActiveRecord::Migration[4.2]
  def change
    add_column :characters, :synergy_hp, :integer
  end
end
