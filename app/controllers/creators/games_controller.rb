class Creators::GamesController < ApplicationController
  before_filter :authenticate_creator!
  before_action :prepare_creator
  before_action :set_game, only: [:show, :edit, :update, :destroy]

  # GET /games/1
  # GET /games/1.json
  def show
    @user = User.new
    @rule = @game.rules.new
    @users = @game.users.order(pts: :desc).where.not(name: "")
    @pending_rules = @game.rules.joins(:user_rules).where(user_rules: {status: UserRule.statuses[:pending]}).order(:updated_at).all.to_a
  end

  # GET /games/new
  def new
    @game = @creator.games.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = @creator.games.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to creator_game_path(@creator, @game), notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to creator_game_path(@creator, @game), notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to creator_path(@creator), notice: 'Game was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_game
      @game = @creator.games.find(params[:id])
    end

    def prepare_creator
      @creator = current_creator if current_creator
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def game_params
      params[:game].permit(:creator_id, :name, :description, :pts_per_rule, :expert_rank, :normal_rank, :starter_rank)
    end
end
