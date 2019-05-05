Rails.application.routes.draw do
  
  root to: 'tasks#index'
  
  get 'signup', to: 'users#new'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  resources :users, only: [:new, :create]
  resources :tasks, only: [:show, :new, :create, :edit, :update, :destroy]
end

# Prefix Verb   URI Pattern                       Controller#Action
#        login GET    /login(.:format)                  sessions#new
#         root GET    /                                 tasks#index
#              POST   /login(.:format)                  sessions#create
#       logout DELETE /logout(.:format)                 sessions#destroy
#       signup GET    /signup(.:format)                 users#new
#        users POST   /users(.:format)                  users#create
#     new_user GET    /users/new(.:format)              users#new
#        tasks GET    /tasks(.:format)                  tasks#index
#              POST   /tasks(.:format)                  tasks#create
#     new_task GET    /tasks/new(.:format)              tasks#new
#    edit_task GET    /tasks/:id/edit(.:format)         tasks#edit
#         task GET    /tasks/:id(.:format)              tasks#show
#              PATCH  /tasks/:id(.:format)              tasks#update
#              PUT    /tasks/:id(.:format)              tasks#update
#              DELETE /tasks/:id(.:format)              tasks#destroy













