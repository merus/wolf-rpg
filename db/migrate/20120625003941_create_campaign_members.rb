class CreateCampaignMembers < ActiveRecord::Migration[4.2]
  def change
    create_table :campaign_members do |t|
      t.integer :campaign_id
      t.integer :user_id
      t.integer :membership

      t.timestamps
    end
  end
end
