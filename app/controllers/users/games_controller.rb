class Users::GamesController < ApplicationController
  before_filter :authenticate_user!
  before_action :prepare_user
  before_action :set_game

  # GET /games/1
  # GET /games/1.json
  def show
    @rules = @game.rules
    @completed_rules = @game.rules.joins(:user_rules).where(user_rules: {user_id: @user.id, status: UserRule.statuses[:complete]}).order(:updated_at).all.to_a
    @top_users = @game.users.order(pts: :desc).take(3)
    @users = @game.users.where.not(id: @top_users).order(pts: :desc).where.not(name: "")
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = @user.game
    end

    def prepare_user
      @user = current_user if current_user
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params[:game].permit(:name, :description, :pts_per_rule, :expert_rank, :normal_rank, :starter_rank)
    end
end
