Rails.application.routes.draw do
  root "todos#index"
  # get 'todo_items/index'
  # get 'todo_items/create'
  # get 'todo_items/delete'
  # get 'todo_items/update'
  # get 'todo_lists/index'
  # get 'todo_lists/create'
  # get 'todo_lists/delete'
  # get 'todo_lists/update'
  # get 'todo_item/index'
   get 'todo_item/create'
  # get 'todo_item/delete'
  # get 'todo_item/update'
  # get 'todo_list/index'
   post 'todo_list/create'
  # get 'todo_list/delete'
  # get 'todo_list/update'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # namespace :api do
  #   namespace :v1 do
        # resources :todo_lists do
        #   resources :todo_items do
        #     member do
        #       post :complete
        #       post :incomplete
        #       post :move
        #       patch :edit
        #     end
        #   end
        # end
        # resources :todolists do
        #   resources :todoitems do
        #     #post :delete
        #     get :manualDelete
        #     get :getTags
        #   end   
        #   get :manualDelete 
        # end
    #   end
    # end


    namespace :api do
      namespace :v1 do   
        resources :todo_lists do
          resources :todo_items do
            member do
              post :complete
              post :incomplete
              post :move
              patch :edit
            end
          end
        end
      end
    end
  
  
  
    get 'search/index'
    post 'search/index'

end
