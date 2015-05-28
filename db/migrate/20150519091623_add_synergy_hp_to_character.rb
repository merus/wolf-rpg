class AddSynergyHpToCharacter < ActiveRecord::Migration
  def change
    add_column :characters, :synergy_hp, :integer
  end
end
