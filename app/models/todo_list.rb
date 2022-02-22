class TodoList < ApplicationRecord
    has_many :todo_items, class_name: "TodoItem", :dependent => :destroy 
    validates :title, presence: true, length: { minimum: 2 }
    validates :description, presence: true, length: { minimum: 2 }
    has_many :tags, through: :todo_items
end
