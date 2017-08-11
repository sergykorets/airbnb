require 'sidekiq/web'

Rails.application.routes.draw do

  resources :appartments, except: :show do
  	get 'update_earning', on: :member
  end

  devise_for :authors, :controllers => { registrations: 'registrations' }
  root to: 'appartments#index'

  mount Sidekiq::Web, at: '/sidekiq'
end
