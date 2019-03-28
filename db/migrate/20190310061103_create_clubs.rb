class CreateClubs < ActiveRecord::Migration[5.2]
  def change
    create_table :clubs do |t|
      t.string :club_name
      t.text :club_profile
      t.integer :practice_area
      t.string :area_detail
      t.integer :menber_amount
      t.string :club_level
      t.timestamps
    end
  end
end
