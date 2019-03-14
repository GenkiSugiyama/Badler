class EntryUser < ApplicationRecord
  belongs_to :user
  belongs_to :event_category
  belongs_to :category_result, optional: true

  def can_result?(id)
    Date.today > EntryUser.find(id).event_category.event.date
  end
end
