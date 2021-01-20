Rails.application.routes.draw do
  
 
  devise_for :users
  root to: "items#index"
  resources :items , only:[:index,:create,:new,:show,:edit,:update]
  resources :users , only:[:show]

end
