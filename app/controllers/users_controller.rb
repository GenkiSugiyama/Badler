class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @clubs = @user.clubs
    # 総獲得ポイントを計算
      # entry_results = EntryUser.where(user_id: @user.id)
      #   total = 0
      #   entry_results.each do |result|
      #     total += result.category_result.result_point
      #   end
      # @total_points = total
    total_points = CategoryResult.joins(:entry_users).group(:user_id).sum(:result_point)
    
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
    @entries = @user.entry_users
  end

  def entry
    @entry_event = EntryUser.find(params[:id]).event_category.event
    @entry_category = EntryUser.find(params[:id]).event_category
    @entry_user = EntryUser.find(params[:id])
    @category_results = EntryUser.find(params[:id]).event_category.category_results
  end

  def entry_update
    entry_user = EntryUser.find(params[:id])
    if entry_user.update(result_params)
      flash[:notice] = "出場結果を入力しました"
      redirect_to user_entries_path
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
    params.require(:entry_user).permit(:category_result_id)
  end

end
