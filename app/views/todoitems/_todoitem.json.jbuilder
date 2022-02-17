json.extract! todoitem, :id, :todolist_id, :name, :recurring, :created_at, :updated_at
json.url todoitem_url(todoitem, format: :json)
