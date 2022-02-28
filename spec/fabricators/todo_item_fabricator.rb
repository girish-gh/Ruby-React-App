
Fabricator(:todo_item) do
    name { FFaker::TodoItem::name }
    isRecurring false
end
