
Fabricator(:todo_list) do
    title { FFaker::TodoList::title }
    description { FFaker::TodoList::description }
end
