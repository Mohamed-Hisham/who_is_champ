class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :prepare_user

  def show
    @game = @user.game
    @rules = @game.rules.joins('LEFT OUTER JOIN user_rules ON user_rules.rule_id = rule_id').order('user_rules.status DESC').distinct
    @pend_rules = UserRule.where(user_id: @user, status: UserRule.statuses[:pending]).all.count
    @comp_rules = UserRule.where(user_id: @user, status: UserRule.statuses[:complete]).all.count
    @position = @game.users.order(pts: :desc).all.to_a.index(@user) + 1
    @badges = Badge.joins('LEFT OUTER JOIN user_badges ON user_badges.user_id = user_id AND user_badges.game_id ='+ @game.id.to_s).distinct
    @user.award_badge
    @earned_badges = UserBadge.where(user_id: @user.id, game_id: @game.id, achieved: true).all.to_a.count
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(users_params)
        format.html { redirect_to @user, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def prepare_user
    @user = User.find(params[:id]) if params[:id]
  end

  def users_params
    params.require(:user).permit(:name, :avatar)
  end
end
