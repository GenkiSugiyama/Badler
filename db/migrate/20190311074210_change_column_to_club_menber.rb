class ChangeColumnToClubMenber < ActiveRecord::Migration[5.2]
  def up
    change_column_default :club_menbers, :status, 10
  end

  def down
    change_column_default :club_menbers, :status, 0
  end
end
