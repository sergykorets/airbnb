require 'sidekiq/web'

Rails.application.routes.draw do

  resources :appartments, except: :show do
  	get 'update_earning', on: :member
  end

  devise_for :authors, :controllers => { registrations: 'registrations' }
  root to: 'appartments#index'

  mount Sidekiq::Web, at: '/sidekiq'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
