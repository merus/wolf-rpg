class ChangeVisibilityTypeInCampaigns < ActiveRecord::Migration[4.2]
  class Campaign < ActiveRecord::Base
     #ensures this migration will run even if campaign class is renamed
  end


  def up
  	add_column :campaigns, :visible, :integer, default: 1
  	Campaign.where(visibility: "closed").update_all(visible: 0)
  	remove_column :campaigns, :visibility
  	rename_column :campaigns, :visible, :visibility
  end

  def down
  	add_column :campaigns, :visible, :string
  	Campaign.where(visibility: 1).update_all(visible: "open")
  	Campaign.where(visibility: 0).update_all(visible: "closed")
  	remove_column :campaigns, :visibility
  	rename_column :campaigns, :visible, :visibility
  end
end
