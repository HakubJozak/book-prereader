Rails.application.routes.draw do
  

  get 'books/create'

  get 'books/new'

  root to: 'books#new'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
