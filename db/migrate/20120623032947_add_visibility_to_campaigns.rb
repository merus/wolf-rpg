class AddVisibilityToCampaigns < ActiveRecord::Migration[4.2]
  def change
    add_column :campaigns, :visibility, :string
  end
end
