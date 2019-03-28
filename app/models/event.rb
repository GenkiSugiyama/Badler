class Event < ApplicationRecord
  belongs_to :club
  has_many :event_categories
  has_many :entry_users, through: :event_categories
  has_many :category_results, through: :event_categories
  accepts_nested_attributes_for :event_categories, allow_destroy: true

  def user_entried?(user)
    entry_users.find_by(user_id: user.id).present?
  end

  def can_entry?(id)
    Date.today < Event.find(id).deadline
  end

end
