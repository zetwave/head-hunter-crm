Rails.application.routes.draw do

  root 'static_pages#home'

  get  '/search',     to: 'static_pages#search'
  get  '/help',       to: 'static_pages#help'
  get  '/about',      to: 'static_pages#about'
  get  '/contact',    to: 'static_pages#contact'

  get '/signup',      to: 'users#new'
  post '/signup',     to: 'users#create'


  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get    '/people/searchByName',   to: 'people#search'
  get    '/people/:id/addCompany',   to: 'people#add_company'

  resources :account_activations,               only: [:edit]
  resources :users , :jobs , :people , :missions
  resources :companies do
    member do
      get 'list_people'
    end
  end
  resources :password_resets,                   only: [:new, :create, :edit, :update]

end
