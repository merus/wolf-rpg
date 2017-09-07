class ChangeCampaignVisibilityToBoolean < ActiveRecord::Migration[5.1]
  class Campaign < ActiveRecord::Base
     #ensures this migration will run even if campaign class is renamed
  end

  def up
  	add_column :campaigns, :is_public, :integer, default: true
  	Campaign.where(visibility: 0).update_all(is_public: false)
  	remove_column :campaigns, :visibility
  end

  def down
  	add_column :campaigns, :visibility, :integer, default: 1
  	Campaign.where(is_public: false).update_all(visibility: 0)
  	remove_column :campaigns, :is_public
  end
end
