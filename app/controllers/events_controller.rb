class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :club_admin?, only: [:edit, :update, :destroy]
  def new
    @event = Event.new
    @event_category = @event.event_categories.build
    @category_result = @event_category.category_results.build
  end

  def create
    user = current_user
    event = Event.new(event_params)
    event.club_id = user.club_menbers.find_by(status: "master_admin").club_id
    if event.save
      redirect_to event_path(event.id)
    else
      render 'new'
    end
  end

  def show
    @event = Event.find(params[:id])
    @club = @event.club
    @categories = @event.event_categories
  end

  def index
    @events = Event.page(params[:page]).per(8).order("created_at DESC")
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    event = Event.find(params[:id])
    if event.update(event_params)
      flash[:notice] = "大会情報を更新しました"
      redirect_to event_path(event.id)
    end
  end

  def destroy
    event = Event.find(params[:id])
    if event.destroy
      flash[:notice] = "大会を削除しました"
      redirect_to club_path(event.club_id)
    end
  end

  private
  def event_params
    params.require(:event).permit(:event, :deadline, :date, :entry_fee, :total_capacity, :event_place, :place_address, :payment_method, :event_detail, event_categories_attributes: [:id, :category_title, :category_detail, :_destroy, category_results_attributes: [:id, :result, :result_point, :_destroy]])
  end

  def club_admin?
    event = Event.find(params[:id])
    user = event.club.club_menbers.find_by(status: "master_admin").user
    unless current_user == user then
      redirect_to event_path(params[:id])
    end
  end
end
