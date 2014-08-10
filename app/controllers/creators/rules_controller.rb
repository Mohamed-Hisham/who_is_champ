class Creators::RulesController < ApplicationController
  before_filter :authenticate_creator!
  before_action :set_rule, only: [:edit, :update, :destroy]
  before_action :prepare_creator
  before_action :prepare_game, except: :mark_complete

  # GET /rules/new
  def new
    @rule = @game.rules.new
  end

  # GET /rules/1/edit
  def edit
  end

  # POST /rules
  # POST /rules.json
  def create
    @rule = @game.rules.new(rule_params)

    respond_to do |format|
      if @rule.save
        format.html { redirect_to creator_game_path(@creator, @game), notice: 'Rule was successfully created.' }
        format.json { render :show, status: :created, location: @rule }
      else
        format.html { render :new }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rules/1
  # PATCH/PUT /rules/1.json
  def update
    respond_to do |format|
      if @rule.update(rule_params)
        format.html { redirect_to creator_game_path(@creator, @game), notice: 'Rule was successfully updated.' }
        format.json { render :show, status: :ok, location: @rule }
      else
        format.html { render :edit }
        format.json { render json: @rule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rules/1
  # DELETE /rules/1.json
  def destroy
    @rule.destroy
    respond_to do |format|
      format.html { redirect_to creator_game_path(@creator, @game), notice: 'Rule was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  def mark_complete
    @user = User.find(params[:user_id])
    @rule = Rule.find(params[:id])
    @current_game = Game.find(params[:rule][:game_id])
    @user_rule_entry = UserRule.where(user_id: @user.id , rule_id: @rule.id, game_id: @current_game.id).take
    respond_to do |format|
      if @user_rule_entry.update_status(:complete)
        user_points = @user.pts + (@current_game.pts_per_rule * @rule.priority_points)
        @user.update_points(user_points)
        @user.check_rank
        format.html { redirect_to creator_game_path(@creator, @current_game), notice: "Rule \"#{@rule.description.truncate(40)}\" was successfully marked as complete." }
        format.json { head :no_content }
      else
        format.html { redirect_to creator_game_path(@creator, @current_game), notice: "Rule \"#{@rule.description.truncate(40)}\" was NOT marked as complete. Please try again." }
        format.json { render json: @user_rule_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rule
      @rule = Rule.find(params[:id])
    end

    def prepare_game
      @game = Game.find(params[:game_id])
    end

    def prepare_creator
      @creator = current_creator if current_creator
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def rule_params
      params[:rule].permit(:description, :priority, :game_id)
    end
end
