class Tag < ApplicationRecord
    belongs_to :todo_item, class_name: "TodoItem",optional: true
end
