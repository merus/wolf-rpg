class AddActivesToUsers < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :active_character_id, :integer
    add_column :users, :character2_id, :integer
    add_column :users, :character3_id, :integer
    add_column :users, :active_campaign_id, :integer
    add_column :users, :campaign2_id, :integer
    add_column :users, :campaign3_id, :integer
  end
end
