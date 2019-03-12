class EventCategory < ApplicationRecord
  belongs_to :event, inverse_of: :event_categories
end
