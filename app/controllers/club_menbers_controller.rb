class ClubMenbersController < ApplicationController
  before_action :authenticate_user!
  before_action :master_admin?, only: [:edit, :update]
  before_action :admin?, only: [:requests, :approve, :destroy]
  def create
    @club = Club.find(params[:club_id])
    club_menber = ClubMenber.new
    club_menber.club_id = @club.id
    club_menber.user_id = current_user.id
    if club_menber.save
      flash[:noteice] = "加入リクエストを送信しました"
      redirect_to club_path(@club.id)
    else
      render "clubs/show"
    end
  end

  def index
    @club_menbers = ClubMenber.where(club_id: params[:club_id])
  end

  def edit
    @club_menber = ClubMenber.find(params[:id])
  end

  def update
    @club_menber = ClubMenber.find(params[:id])
    if club_menber.update(status_params)
      flash[:notice] = "メンバー権限を変更しました"
      redirect_to club_club_menbers_path
    else
      render "edit"
    end
  end

  def destroy
    request = ClubMenber.find(params[:id])
    if request.destroy
      flash[:notice] = "リクエストを削除しました"
      redirect_to club_club_menbers_requests_path
    end
  end

  def requests
    @requests = ClubMenber.where(club_id: params[:club_id]).where(status: "requesting")
  end

  def approve
    request = ClubMenber.find(params[:id])
    if request.update(status: "normal")
      flash[:notice] = "ユーザーの加入を承認しました"
      redirect_to club_club_menbers_requests_path
    end
  end

  private

  def status_params
    params.require(:club_menber).permit(:status)
  end

  def master_admin?
    if current_user.club_menbers.find_by(club_id: params[:club_id]).blank? || current_user.club_menbers.find_by(club_id: params[:club_id]).status_before_type_cast != 1000
      redirect_to club_path(params[:club_id])
    end
  end

  def admin?
    if current_user.club_menbers.find_by(club_id: params[:club_id]).blank? || current_user.club_menbers.find_by(club_id: params[:club_id]).status_before_type_cast < 200
      redirect_to club_path(params[:club_id])
    end
  end

end
