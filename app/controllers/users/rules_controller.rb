class Users::RulesController < ApplicationController
  def mark_pending
    @user = current_user
    @rule = Rule.find(params[:id])
    @user_rule_entry = UserRule.new(user_id: @user.id , rule_id: @rule.id, game_id: @rule.game.id)

    respond_to do |format|
      if @user_rule_entry.update_status(:pending)
        format.html { redirect_to @user, notice: "Rule #{@rule.description.truncate(40)} was marked as pending. Awaiting Creator to approve." }
        format.json { head :no_content }
      else
        format.html { redirect_to @user, notice: "Rule \"#{@rule.description.truncate(40)}\" was NOT marked as pending. Please try again." }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end