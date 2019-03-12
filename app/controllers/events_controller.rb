class EventsController < ApplicationController
  before_action :authenticate_user!
  def new
    @event = Event.new
    @event_category = @event.event_categories.build
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
  end

  def index
    @events = Event.all
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
  end

  private
  def event_params
    params.require(:event).permit(:event, :deadline, :date, :entry_fee, :total_capacity, :event_place, :place_address, :payment_method, :event_detail, event_categories_attributes: [:id, :category_title, :category_detail, :_destroy])
  end
end