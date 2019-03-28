class EntryUsersController < ApplicationController
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

  def show
    
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

end
