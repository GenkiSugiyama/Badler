class CreateEvents < ActiveRecord::Migration[5.2]
  def change
    create_table :events do |t|
      t.string :event
      t.integer :club_id
      t.date :deadline
      t.date :date
      t.integer :entry_fee
      t.integer :total_capacity
      t.string :event_place
      t.string :place_address
      t.integer :payment_method
      t.text :event_detail
      t.timestamps
    end
  end
end
