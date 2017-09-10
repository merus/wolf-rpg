class CampaignsController < ApplicationController
	before_action :find_campaign, only: [:show, :combat, :order, :join, :invite, :deny, :clear, :admin, :edit, :update, :destroy]
	before_action :find_user, only: [:invite, :deny, :clear, :admin]
	before_action :signed_in_user, except: [:show, :index]
	before_action :correct_user, except: [:show, :index, :new, :create, :join]
	before_action :find_campaign, only:

	def new
		@campaign = Campaign.new
	end

	def create
		@campaign = Campaign.new(strong_parameters)
		if @campaign.save
			@campaign.add_member current_user, :admin
			current_user.push_active_campaign(@campaign) if signed_in?
			redirect_to @campaign, flash: { success: "Campaign Created Successfully" }
		else
			render 'new'
		end
	end

	def show

		if @campaign.visible_to? current_user
			current_user.push_active_campaign(@campaign) if signed_in?
			@characters = Character.where(campaign_id: @campaign.id).paginate(page: params[:character_page], per_page: 12)
		else
			redirect_to campaigns_path, flash: { error: "Cannot access Campaign" }
		end
	end

	def combat
		@characters = @campaign.characters.select { |character| character.visible_to? current_user }.sort_by &:name
	end

	def order
		@character_list = []
		params.select { |param, value| param[0..9] == 'character_'}.each do |param, character_name|
			character = Character.find_by(name: character_name)
			index = param.sub('character_','').to_i
			quantity = params["quantity_#{index}"].to_i
			initiative = params["initiative_#{index}"]

			case quantity
			when 0 then
			when 1
				if initiative == 'Generate'
					# init = character.skill('Initiative')
					# dice = character.power(init, init.effects[0], true)
					# initiative = "#{character.initiative} #{dice[0]}d#{dice[1]}"
					initiative = character.roll('Initiative')
				else
					initiative = initiative.to_i
				end
				@character_list << { character: character, name: character.name, initiative: initiative }
			else
				quantity.times do |i|
					if initiative == 'Generate'
						# init = character.skill('Initiative')
						# dice = character.power(init, init.effects[0], true)
						# this_init = "#{character.initiative} #{dice[0]}d#{dice[1]}"
						this_init = character.roll('Initiative')
					else
						this_init = initiative.to_i
					end
					@character_list << { character: character, name: "#{character.name} #{i+1}", initiative: this_init }
				end
			end
		end

		@character_list.sort_by! { |char| -char[:initiative] }

		render 'fight'
	end

	def fight
		@character_list ||= []
	end

	def index
		user_ids = current_user.campaign_ids if signed_in?
		user_ids ||= []

		@user_campaigns = Campaign.where(id: user_ids).order('name').paginate(page: params[:user_page], per_page: 10) if signed_in?
		@open_campaigns = Campaign.where(is_public: true).where.not(id: user_ids).order('name').paginate(page: params[:open_page], per_page: 10)
	end

	def join
		@membership = @campaign.membership_for current_user

		case @membership.membership
		when :none
			@membership.membership = :request
			@membership.save
			redirect_to @campaign, flash: { success: 'Requested to Join' }
		when :invite
			@membership.membership = :member
			@membership.save
			redirect_to @campaign, flash: { success: "Joined Campaign" }
		when :member, :admin
			redirect_to @campaign, flash: { error: "Already a Member" }
		when :request
			redirect_to @campaign, flash: { warning: "Already Requested Membership" }
		when :denied
			redirect_to @campaign, flash: { error: "Denied Membership" }
		end
	end

	def invite
		@membership = @campaign.membership_for params[:user_id].to_i

		case @membership.membership
		when :request
			@membership.membership = :member
			@membership.save
			redirect_to @campaign, flash: { success: "Added Member: #{@user.handle}" }
		when :none, :denied
			@membership.membership = :invite
			@membership.save
			redirect_to @campaign, flash: { success: "Invited Member: #{@user.handle}" }
		when :member, :admin
			redirect_to @campaign, flash: { error: "Already a Member: #{@user.handle}" }
		when :invite
			redirect_to @campaign, flash: { warning: "Already Invited: #{@user.handle}" }
		end
	end

	def deny
		@membership = @campaign.membership_for params[:user_id].to_i

		case @membership.membership
		when :none, :request, :invite
			@membership.membership = :denied
			@membership.save
			redirect_to @campaign, flash: { success: "Denied Member: #{@user.handle}" }
		when :member
			@membership.membership = :denied
			@membership.save
			redirect_to @campaign, flash: { success: "Kicked Member: #{@user.handle}" }
		when :admin
			redirect_to @campaign, flash: { error: "Cannot Kick Admin: #{@user.handle}" }
		when :denied
			redirect_to @campaign, flash: { warning: "Already Denied: #{@user.handle}" }
		end
	end

	def clear
		@membership = @campaign.membership_for params[:user_id].to_i

		case @membership.membership
		when :invite, :request, :denied
			@membership.delete
			redirect_to @campaign, flash: { success: "Cleared Member: #{@user.handle}" }
		when :member, :admin
			redirect_to @campaign, flash: { error: "Cannot Clear Full Member: #{@user.handle}" }
		when :none
			redirect_to @campaign, flash: { warning: "Alread Cleared: #{@user.handle}" }
		end
	end

	def admin
		@membership = @campaign.membership_for params[:user_id].to_i

		case @membership.membership
		when :admin
			redirect_to @campaign, flash: { warning: "Already Admin: #{@user.handle}" }
		else
			@membership.membership = :admin
			@membership.save
			redirect_to @campaign, flash: { success: "Added Admin: #{@user.handle}" }
		end
	end

	def edit
	end

	def update

		if @campaign.update_attributes(strong_parameters)
			redirect_to @campaign, flash: { success: "Successfully Modified Campaign" }
		else
			flash.now[:error] = "Error: #{@campaign.errors.full_messages.join(', ')}"
			@campaign.reload
			render 'show'
		end
	end

	def destroy
		# destroy required
	end

	private

	def find_campaign
		@campaign = Campaign.find(params[:id])
	end

	def find_user
		@user = User.find(params[:user_id])
	end

	def strong_parameters
		params.require(:campaign).permit(:name, :description, :is_public)
	end

	def signed_in_user
		redirect_to signin_path, notice: 'Please Sign In' unless signed_in?
	end

	def correct_user
		@campaign = Campaign.find(params[:id])
		redirect_to @campaign, flash: { error: 'You do not have permission for that action' } unless @campaign.has_admin? current_user
	end
end
