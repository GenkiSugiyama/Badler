class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:ranking]
  def top
    @clubs = Club.limit(3).order("created_at desc")
    @events = Event.limit(3).order("created_at desc")
  end

  def about
  end

  def ranking
    ranks = CategoryResult.joins(:entry_users).group(:user_id).sum(:result_point).sort_by { |_, b| b }.reverse.first(10)
    @ranking = [];
    count_h = 0

    ranks.each do |rank|
      r = {}
      user = User.find(rank[0])
      r = {:id => user.id.to_s, :name => user.name, :point=> rank[1].to_s}
      @ranking[count_h] = r
      count_h += 1
    end
  end
end
