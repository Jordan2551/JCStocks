Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  #USER ROUTES
  get 'my_portfolio', to: 'users#my_portfolio'
  ############

  #STOCK ROUTES
  get 'search_stocks', to: 'stocks#search'
  #############

end
