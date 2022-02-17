class TodoList < ApplicationRecord
    has_many :todo_items, class_name: "TodoItem", :dependent => :destroy 
    has_many :tags, through: :todo_items
end
