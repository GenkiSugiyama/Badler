Rails.application.routes.draw do
  root to: 'home#top'
  get 'ranking', to: 'home#ranking', as: 'ranking'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show, :edit, :update] do
    get 'entries', to: 'users#entry_index', as: 'entries'
    get 'entry_result/:id', to: 'users#entry', as: 'entry'
    patch 'entry_result/:id', to: 'users#entry_update', as: 'entry_user'
    delete 'entry_result/:id', to: 'users#entry_destroy', as: 'destroy_entry_user'
  end
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  resources :clubs do
    resources :club_menbers, only: [:create, :index, :edit, :update, :destroy]
    get 'club_menbers/requests', to: 'club_menbers#requests'
    post 'club_menbers/requests', to: 'club_menbers#approve'
  end
  resources :events do
    resources :event_categories, only: [:new, :create, :index, :edit, :update]
    resources :entry_users, only: [:new, :create, :index]
  end
end
