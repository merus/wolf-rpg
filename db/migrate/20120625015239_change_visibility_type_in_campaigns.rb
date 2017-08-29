class ChangeVisibilityTypeInCampaigns < ActiveRecord::Migration[4.2]
  def up
  	change_column :campaigns, :visibility, :integer
  end

  def down
  	change_column :campaigns, :visibility, :string
  end
end
