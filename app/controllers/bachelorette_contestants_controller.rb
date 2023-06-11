class BacheloretteContestantsController < ApplicationController
  def index
    @bachelorette = Bachelorette.find(params[:bachelorette_id])
  end

  def show
    require 'pry'; binding.pry
  end
end