class CreateCampaigns < ActiveRecord::Migration[4.2]
  def change
    create_table :campaigns do |t|
      t.string :name
      t.text :users
      t.text :description

      t.timestamps
    end
  end
end
