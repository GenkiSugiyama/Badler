class AddColumnToEvent < ActiveRecord::Migration[5.2]
  def change
    add_column :events, :event_detail, :text
  end
end
