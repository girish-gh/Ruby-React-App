Rails.application.routes.draw do
  root "todos#index"
 
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
