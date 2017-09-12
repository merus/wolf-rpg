# == Schema Information
#
# Table name: campaigns
#
#  id          :integer         not null, primary key
#  name        :string(255)
#  description :text
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  visibility  :integer(255)
#

class Campaign < ActiveRecord::Base
	has_many :characters
	has_many :campaign_members
	has_many :users, through: :campaign_members

	validates :name, presence: true

	def add_member(member, membership_type=:member)
		member_id = (member.is_a?(User) ? member.id : member.to_i)
		campaign_members.create user_id: member_id, membership: membership_type
	end

	def has_member?(member)
		member_id = (member.is_a?(User) ? member.id : member.to_i)
		campaign_members.members.exists? id: member_id
	end

	def has_admin?(member)
		member_id = (member.is_a?(User) ? member.id : member.to_i)
		campaign_members.admins.exists? id: member_id
	end

	def members
		users.where("campaign_members.membership IN (?)", [CampaignMember.memberships[:member], CampaignMember.memberships[:admin]])
	end

	def member_type(member)
		member_id = (member.is_a?(User) ? member.id : member.to_i)
		campaign_members.where(user_id: member_id).first.try(:membership)
	end

	def membership_for(member)
		member_id = (member.is_a?(User) ? member.id : member.to_i)
		campaign_members.find_or_create(user_id: member_id)
	end

	def requested
		users.where("campaign_members.membership IN (?)", 
			[CampaignMember.memberships[:invite], CampaignMember.memberships[:request], CampaignMember.memberships[:denied]])
	end

	def visible_to?(user)
		return true if is_public

		#TODO: this has a bad smell. I suspect this entire function needs to be scrapped.

		case user
		when User then type = self.campaign_members.find_by(user_id: user.id)
		when Integer then type = self.campaign_members.find_by(user_id: user)
		else return false
		end

		return (type and [:member, :admin, :invite].include? type.membership)
	end
end
