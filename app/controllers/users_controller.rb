class UsersController < ApplicationController
	before_action :find_user, only: [:show, :edit, :update, :password]
	before_action :signed_in_user, only: [:edit, :update, :password]
	before_action :correct_user, only: [:edit, :update, :password]


	def new
		@user = User.new
	end

	def create
		@user = User.new(strong_parameters)
		if @user.save
			sign_in @user
			redirect_to @user
		else
			render 'new'
		end
	end

	def show
		if @user == current_user
			@invitations = CampaignMember.find_by(user: @user.id, membership: CampaignMember.membership(:invite))
			@campaigns_to_invite = []
		else
			@invitations = []
			@campaigns_to_invite = current_user.campaigns.reject { |campaign| [:member, :admin, :invite].include? campaign.member_type(@user) } if signed_in?
			@campaigns_to_invite ||= []
		end

		@campaigns = Campaign.where(id: @user.campaigns.collect { |campaign| campaign.id }).paginate(page: params[:campaign_page], per_page: 10)
		@characters = Character.where(user_id: @user.id).order('name').paginate(page: params[:character_page], per_page: 12)
	end

	def index
		@users = User.paginate(page: params[:page], per_page: 30)
	end

	def edit
	end

	def password
		if @user and @user.authenticate(params[:user][:old_password])
			@user.password = params[:user][:new_password]
			@user.password_confirmation = params[:user][:new_password_confirmation]
			if @user.save
				redirect_to @user, flash: { success: "Password Changed" }
			else
				flash.now[:error] = "Error: #{@user.errors.full_messages.join(', ')}"
				render 'edit'
			end
		else
			flash.now[:error] = "Incorrect Password"
			render 'edit'
		end

	end

	def update
		if @user and @user.authenticate(params[:user][:password])
			# change user details
			params[:user][:password_confirmation] = params[:user][:password]

			if @user.update_attributes(strong_parameters)
				redirect_to @user, flash: { success: "Updated Details" }
			else
				flash.now[:error] = "Error: #{@user.errors.full_messages.join(', ')}"
				render 'edit'
			end
		else
			flash.now[:error] = "Incorrect Password"
			render 'edit'
		end
	end

	private

	def find_user
		@user = User.find(params[:id])
	end

	def strong_parameters
		params.require(:user).permit(:email, :handle, :name, :password, :password_confirmation)
	end

	def signed_in_user
		redirect_to signin_path, notice: 'Please Sign In' unless signed_in?
	end

	def correct_user
		redirect_to @user, flash: { error: 'You may only edit your own profile' } unless @user == current_user
	end
end
