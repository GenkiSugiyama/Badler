class CreateClubMenbers < ActiveRecord::Migration[5.2]
  def change
    create_table :club_menbers do |t|
      t.integer :user_id
      t.integer :club_id
      t.integer :positon_status
      t.integer :join_status
      t.timestamps
    end
  end
end
