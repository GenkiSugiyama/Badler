class EntryUser < ApplicationRecord
  belongs_to :user
  belongs_to :event_category
  belongs_to :category_result, optional: true

end
