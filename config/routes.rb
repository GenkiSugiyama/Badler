Rails.application.routes.draw do
  root to: 'home#top'
  get 'home/about' => 'home#about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :show, :edit, :update]
  resources :messages, :only => [:create]
  resources :rooms, :only => [:create, :show, :index]
  resources :clubs do
    resources :club_menbers, only: [:create, :index, :edit, :update, :destroy]
    get 'club_menbers/requests' => 'club_menbers#requests'
    post 'club_menbers/requests' => 'club_menbers#approve'
  end
  resources :events do
    resources :event_categories, only: [:new, :create, :index, :edit, :update]
  end
end
