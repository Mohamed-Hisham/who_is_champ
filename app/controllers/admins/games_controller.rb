class Admins::GamesController < AdminsController
  before_filter :authenticate_admin!
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :prepare_admin

  # GET /badges
  # GET /badges.json
  def index
    @games = Game.all
  end

  # DELETE /badges/1
  # DELETE /badges/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_path(@admin), notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = game.find(params[:id])
    end

    def prepare_admin
      @admin = current_admin if admin_signed_in?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def badge_params
      params[:user].permit(:name, :badge, :admin_id)
    end
end
