Rails.application.routes.draw do

  get 'entries/index'

  get 'entries/show'

  get 'entries/new'

  get 'entries/edit'

  get 'admins/index'

  get 'admins/show'

  get 'users/index'

  get 'users/show'

  devise_for :admins
  devise_for :users
  root 'entries#index', controllers: {
  sessions:      'admins/sessions',
  passwords:     'admins/passwords',
  registrations: 'admins/registrations'
  }, controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
  }

  resources :groups, except: [:show, :destroy] do
    resources :messages, except: [:show]
  end

  resources :users, :only => [:index, :show]
  resources :admins, :only => [:index, :show]
  
  resources :users do
    collection {get "search"}
    resources :entries, only:[:index]
  end

  resources :ariticles
  resources :entries do 
    collection {get "search"}
  end
end
