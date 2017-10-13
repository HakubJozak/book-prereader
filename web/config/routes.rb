Rails.application.routes.draw do
  resources :books, only: [ :new, :create, :show ]

  # post 'books'
  # get 'books/new'
  root to: 'books#new'
end
