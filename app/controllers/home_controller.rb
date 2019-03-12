class HomeController < ApplicationController
  before_action :authenticate_user!
  def top
    @user = current_user
    @clubs = @user.clubs
  end

  def about
  end
end
