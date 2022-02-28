class Tag < ApplicationRecord
    belongs_to :todo_item, class_name: "TodoItem",optional: true
    validates :tagname, presence: true, length: { minimum: 2 }
end
