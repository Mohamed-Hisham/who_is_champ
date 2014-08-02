class UsersController < ApplicationController
  before_filter :authenticate_user!
  before_filter :prepare_user

  def show
    # @games = @creator.games.all.to_a
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
