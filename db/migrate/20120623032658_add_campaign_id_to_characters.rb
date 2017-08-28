class AddCampaignIdToCharacters < ActiveRecord::Migration[4.2]
  def change
    add_column :characters, :campaign_id, :integer
  end
end
