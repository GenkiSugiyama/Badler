class CreateEntryUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :entry_users do |t|
      t.integer :user_id
      t.integer :event_category_id
      t.integer :category_result_id
      t.timestamps
    end
  end
end
