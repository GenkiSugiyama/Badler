class EntryUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :club_admin?, only: [:index]
  def new
    @entry_user = EntryUser.new
    @event_categories = EventCategory.where(event_id: params[:event_id])
  end

  def create
    entry_user = EntryUser.new(entry)
    entry_user.user_id = current_user.id
    if entry_user.save
      flash[:notice] = "エントリーが完了しました"
      redirect_to event_path(params[:event_id])
    end
  end

  def index
    @categories = EventCategory.where(event_id: params[:event_id])
  end

  def edit
  end

  def update
  end

  private
  def entry
    params.require(:entry_user).permit(:event_category_id)
  end

  def club_admin?
    event = Event.find(params[:event_id])
    user = event.club.club_menbers.find_by(status: "master_admin").user
    unless current_user == user then
      redirect_to event_path(params[:event_id])
    end
  end

end
