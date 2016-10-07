Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :user, only: [:new, :show, :create]
  resources :session, only: [:new, :create, :destroy]

  root "bands#index"

  resources :bands, except:[:index] do
    resources :albums, only: [:new]
  end

  resources :albums, except: [:new] do
    resources :tracks, only: [:new]
  end

  resources :tracks, except: [:new]

  get 'not_logged_in', to: 'users#landing'
end
