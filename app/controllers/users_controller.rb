class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :prepare_user

  def show
    @game = @user.game
    @rules = @game.rules.joins('LEFT OUTER JOIN user_rules ON user_rules.rule_id = rule_id').order('user_rules.status DESC').distinct
    @comp_rules = UserRule.where(user_id: @user).all.count
    @position = @game.users.order(pts: :desc).all.to_a.index(@user) + 1
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
    @user = current_user if user_signed_in?
  end

  def users_params
    params.require(:user).permit(:name, :avatar)
  end
end
