class CategoryResult < ApplicationRecord
  belongs_to :event_category, inverse_of: :category_results
  has_many :entry_users
end
