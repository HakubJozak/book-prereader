Rails.application.routes.draw do
  get 'words/update'

  resources :books, only: [ :new, :create, :show ]
  resources :words
  
  # post 'books'
  # get 'books/new'
  root to: 'books#new'
end
