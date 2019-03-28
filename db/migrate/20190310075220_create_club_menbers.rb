class CreateClubMenbers < ActiveRecord::Migration[5.2]
  def change
    create_table :club_menbers do |t|
      t.integer :user_id
      t.integer :club_id
      t.integer :status, default: 10
      t.timestamps
    end
  end
end
