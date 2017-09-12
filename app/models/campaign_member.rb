# == Schema Information
#
# Table name: campaign_members
#
#  id          :integer         not null, primary key
#  campaign_id :integer
#  user_id     :integer
#  membership  :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class CampaignMember < ActiveRecord::Base
	belongs_to :user
	belongs_to :campaign
	enum membership: [:non_member, :admin, :member, :invite, :request, :denied]

	scope :members, -> { where(membership: [:member, :admin]) }
	scope :admins, -> { where(membership: :admin) }
	scope :requested, -> { where(membership: [:invite, :request, :denied]) }

	validates :campaign_id, presence: true
	validates :user_id, presence: true
	validates :membership, presence: true

	def self.admin_of?(user, campaign)
		self.exists? campaign_id: campaign.id, user_id: user.id, membership: :admin
	end

	def member?
		[:member, :admin].contains? membership
	end
end
