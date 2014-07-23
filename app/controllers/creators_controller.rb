class CreatorsController < ApplicationController
  before_filter :authenticate_creator!
  before_filter :prepare_creator

  def index
  end

  private
  def prepare_creator
    @creator = current_creator
  end
end
