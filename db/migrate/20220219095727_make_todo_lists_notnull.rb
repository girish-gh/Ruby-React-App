class MakeTodoListsNotnull < ActiveRecord::Migration[7.0]
  def change
    change_column_null :todo_lists, :title, false, "TITLE"
    change_column_null :todo_lists, :description, false, "DESC"
  end
end
