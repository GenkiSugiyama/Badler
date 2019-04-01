class ClubsController < ApplicationController
  before_action :authenticate_user!
  before_action :admin?, only: [:edit, :update, :destroy]
  def new
    @club = Club.new
  end

  def create
    club = Club.new(club_params)
    # buildでclub_menberのレコードに外部キーであるclub_idを作成
    club_menber = club.club_menbers.build
    club_menber.user_id = current_user.id
    club_menber.master_admin!
    if club.save
      flash[:notice] = "新規クラブを作成しました！"
      redirect_to club_path(club.id)
    else
      render "create"
    end
  end

  def index
    # @clubs = Club.page(params[:page]).per(8).order("created_at DESC")
    # if prams[:practice_area].present?
    #   @clubs = @clubs.get_by_practice_area(params[practice_area])
    # end
    @clubs = Club.search(params[:practice_area])
  end

  def show
    @club = Club.find(params[:id])
    @club_menber = ClubMenber.new
    @events = @club.events
    @admin_user = @club.club_menbers.find_by(status: "master_admin").user
    currentUserEntry = Entry.where(user_id: current_user.id)
    userEntry = Entry.where(user_id: @admin_user.id)
    if @admin_user.id == current_user.id
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
    @club = Club.find(params[:id])
  end

  def update
    club = Club.find(params[:id])
    if club.update(club_params)
      flash[:notice] = "編集が完了しました"
      redirect_to club_path(club.id)
    else
      render 'edit'
    end
  end

  def destroy
    club = Club.find(params[:id])
    user = current_user
    if club.destroy
      flash[:notice] = "削除が完了しました"
      redirect_to user_path(current_user.id)
    else
    end
  end

  private

  def club_params
    params.require(:club).permit(:club_name, :club_profile, :practice_area, :area_detail, :menber_amount, :club_level)
  end

  def admin?
    if current_user.club_menbers.empty? || current_user.club_menbers.find(params[:id]).status != "master_admin"
      redirect_to club_path(params[:id])
    else
    end
  end
end
