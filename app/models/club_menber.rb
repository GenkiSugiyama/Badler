class ClubMenber < ApplicationRecord
  enum status: {
    rejected: 0,
    requesting: 10,
    normal: 100,
    admin: 200,
    master_admin: 1000,
  }
  belongs_to :user
  belongs_to :club
end
