class RemoveDescriptionFromTodoItems < ActiveRecord::Migration[7.0]
  def change
    remove_column :todo_items, :description, :string
  end
end
