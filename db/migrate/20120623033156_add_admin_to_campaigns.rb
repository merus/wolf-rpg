class AddAdminToCampaigns < ActiveRecord::Migration[4.2]
  def change
    add_column :campaigns, :admin_id, :integer
  end
end
