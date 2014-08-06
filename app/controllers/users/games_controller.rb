class Users::GamesController < ApplicationController
  before_filter :authenticate_user!
  before_action :prepare_user
  before_action :set_game

  # GET /games/1
  # GET /games/1.json
  def show
    @rules = @game.rules
    @users = @game.users.order(pts: :desc)
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
