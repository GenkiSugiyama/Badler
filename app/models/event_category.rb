class EventCategory < ApplicationRecord
  belongs_to :event, inverse_of: :event_categories
  has_many :entry_users, dependent: :destroy
  has_many :category_results, dependent: :destroy
  accepts_nested_attributes_for :category_results, allow_destroy: true
end
 