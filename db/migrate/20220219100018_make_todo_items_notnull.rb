class MakeTodoItemsNotnull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :todo_items, :name, false, "NAME"
    change_column_null :todo_items, :isRecurring, false, "isREC"
  end
end
