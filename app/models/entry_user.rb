class EntryUser < ApplicationRecord
  belongs_to :user
  belongs_to :event_category

end
