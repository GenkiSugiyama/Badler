class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user1, only: [:edit, :update]
  before_action :correct_user2, only: [:entry, :entry_update, :entry_destroy]
  before_action :input_result, only: [:entry, :entry_update, :entry_destroy]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @clubs = @user.clubs
    # 総獲得ポイントを計算
    entry_results = EntryUser.where(user_id: @user.id)
      total = 0
      entry_results.each do |result|
        if result.category_result.present?
          total += result.category_result.result_point
        else
        end
      end
    @total_points = total
    # グラフ用の変数    @test = @result_point.pluck(:date, :result_point)
    # 各大会ごとの獲得ポイント取得
    @result_graph = EntryUser.joins({:category_result => {:event_category => :event}}).where(user_id: @user.id)
    # 合算値を取得
    @total_graph = @result_graph.pluck(:date, :result_point)
    # 初回は一つ前の値はいらないので配列の2番目（[1]）から繰り返す
    # 配列は0から始まってくので繰り返しの回数の上限は「配列の個数（.length）-1」となる
    for i in 1..@total_graph.length-1
      @total_graph[i][1] += @total_graph[i-1][1]
    end
    # チャット判断
    currentUserEntry = Entry.where(user_id: current_user.id)
    userEntry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      currentUserEntry.each do |cu|
        userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:notice] = "プロフィールを更新しました！"
      redirect_to user_path(@user.id)
    else
      render "edit"
    end
  end

  def entry_index
    @user = User.find(params[:user_id])
    @entries = @user.entry_users.page(params[:page]).per(15).order("created_at DESC")
  end

  def entry
    @entry_event = EntryUser.find(params[:id]).event_category.event
    @entry_category = EntryUser.find(params[:id]).event_category
    @entry_user = EntryUser.find(params[:id])
    @category_results = EntryUser.find(params[:id]).event_category.category_results
    @user = current_user
    # @user = User.find(params[:user_id])
  end

  def entry_update
    entry_user = EntryUser.find(params[:id])
    entry_user.user_id = current_user.id
    if entry_user.update(result_params)
      flash[:notice] = "出場結果を入力しました"
      redirect_to user_entries_path(entry_user.user_id)
    else
      render 'entry'
    end
  end

  def entry_destroy
    entry_user = EntryUser.find(params[:id])
    if entry_user.destroy
      flash[:alert] = "エントリーを取り消しました"
      redirect_to user_entries_path(user_id: entry_user.user_id)
    else
      render 'entries'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :birthday, :sex, :address, :profile)
  end

  def result_params
    params.require(:entry_user).permit(:category_result_id, :user_id)
  end

  def correct_user1
    user = User.find(params[:id])
    if current_user != user
      redirect_to user_path(current_user)
    end
  end

  def correct_user2
    user = User.find(params[:user_id])
    if current_user != user
      redirect_to user_path(current_user)
    end
  end

  def input_result
    event = EntryUser.find(params[:id]).event_category.event
    unless Date.today > event.date
      flash[:alert] = "大会が未開催です"
      redirect_to user_path(current_user)
    end
  end

end
