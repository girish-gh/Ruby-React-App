class AddIsRecurringToTodoItems < ActiveRecord::Migration[7.0]
  def change
    add_column :todo_items, :isRecurring, :boolean
  end
end
