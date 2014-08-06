class Users::RulesController < ApplicationController

  def mark_complete
    @user = current_user
    @rule = Rule.find(params[:id])
    @user_rule_entry = UserRule.new(user_id:@user.id , rule_id:@rule.id )

    respond_to do |format|
      if @user_rule_entry.update_status(:complete)
        @game = Game.find_by(@rule.game_id)
        user_points = @user.pts + @game.pts_per_rule
        @user.update_points(user_points)
        format.html { redirect_to @user, notice: "Rule \"#{@rule.description.truncate(40)}\" was successfully marked as complete." }
        format.json { head :no_content }
      else
        format.html { redirect_to @user, notice: "Rule \"#{@rule.description.truncate(40)}\" was NOT marked as complete. Please try again." }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

end