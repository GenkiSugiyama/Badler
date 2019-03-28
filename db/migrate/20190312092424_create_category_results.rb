class CreateCategoryResults < ActiveRecord::Migration[5.2]
  def change
    create_table :category_results do |t|
      t.integer :event_category_id
      t.string :result
      t.integer :result_point
      t.timestamps
    end
  end
end
