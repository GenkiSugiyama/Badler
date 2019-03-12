Rails.application.routes.draw do
  root to: 'home#top'
  get 'home/about', to: 'home#about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show, :edit, :update] do
    get 'entry_index', to: 'users#entry_index', as: 'entry'
    get 'entry_result/:id', to: 'users#result', as: 'event_result'
    post 'entry_result/id', to: 'users#result_update', as: 'result_update'
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
