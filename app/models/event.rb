class Event < ApplicationRecord
  belongs_to :club
  has_many :event_categories
  has_many :category_results, through: :event_categories
  accepts_nested_attributes_for :event_categories, allow_destroy: true

end
