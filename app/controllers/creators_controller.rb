class CreatorsController < ApplicationController
  before_filter :authenticate_creator!
  before_filter :prepare_creator

  def show
    @games = @creator.games.all.to_a
    count = 0
    ucount = 0
    @games.each do |g|
      count+= g.rules.count
      ucount+= g.users.count
    end
    @rules_count = count
    @users_count = ucount
  end

  def edit
  end

  def update
    respond_to do |format|
      if @creator.update(creators_params)
        format.html { redirect_to @creator, notice: 'Your profile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @creator.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def prepare_creator
    @creator = current_creator if creator_signed_in?
  end

  def creators_params
    params.require(:creator).permit(:name, :avatar)
  end
end
