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
    club_menber.status = "master_admin"
    if club.save
      flash[:notice] = "新規クラブを作成しました！"
      redirect_to club_path(club.id)
    else
      render "create"
    end
  end

  def index
    @clubs = Club.all
  end

  def show
    @club = Club.find(params[:id])
    @club_menber = ClubMenber.new
    @events = @club.events
  end

  def edit
    @club = Club.find(params[:id])
  end

  def update
    @club = Club.find(params[:id])
  end

  def destroy
    @club = Club.find(params[:id])
  end

  private

  def club_params
    params.require(:club).permit(:club_name, :club_profile, :practice_area, :area_detail, :menber_amount, :club_level)
  end

  def admin?
    if current_user.club_menbers.find(params[:id]).status == "master_admin"
    else
      redirect_to club_path(params[:id])
    end
  end
end
