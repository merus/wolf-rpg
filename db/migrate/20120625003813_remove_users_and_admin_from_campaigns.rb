class RemoveUsersAndAdminFromCampaigns < ActiveRecord::Migration[4.2]
  def up
    remove_column :campaigns, :users
        remove_column :campaigns, :admin_id
      end

  def down
    add_column :campaigns, :admin_id, :integer
    add_column :campaigns, :users, :text
  end
end
