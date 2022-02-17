Rails.application.routes.draw do
  get 'todo_item/index'
  get 'todo_item/create'
  get 'todo_item/delete'
  get 'todo_item/update'
  get 'todo_list/index'
  post 'todo_list/create'
  get 'todo_list/delete'
  get 'todo_list/update'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
