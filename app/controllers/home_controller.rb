class HomeController < ApplicationController
  before_action :authenticate_user!
  def top
    @user = current_user
    @clubs = @user.clubs
  end

  def about
  end

  def ranking
    @ranking = CategoryResult.joins(:entry_users).group(:user_id).sum(:result_point).sort_by { |_, b| b }.reverse
  end
end
