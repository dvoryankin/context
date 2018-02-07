class AddColumnsToTasks < ActiveRecord::Migration[5.1]
  def change
    add_column :tasks, :completed, :boolean, default: false
    add_column :tasks, :progress, :integer, default: 0
    add_column :tasks, :incontext, :boolean, default: false
  end
end
