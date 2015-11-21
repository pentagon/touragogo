class HomeController < ApplicationController
  def show
    redirect_to tours_path and return if current_user && current_user.guide?
  end

  def get_the_guide

  end
end
