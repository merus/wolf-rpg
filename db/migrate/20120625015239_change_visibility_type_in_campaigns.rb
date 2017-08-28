class ChangeVisibilityTypeInCampaigns < ActiveRecord::Migration[4.2]
 	class Campaign < ActiveRecord::Base
 		#ensures this migration will run even if campaign class is renamed
 	end

  def up
  	add_column :campaigns, :is_public, :boolean, default: true
  	Campaign.where(visibility: "closed").update_all(is_public: false)
  	remove_column :campaigns, :visibility
  end

  def down
  	add_column :campaigns, :visibility, :string
  	Campaign.where(is_public: true).update_all(visibility: "open")
  	Campaign.where(is_public: false).update_all(visibility: "closed")
  	remove_column :campaigns, :is_public
  end
end
