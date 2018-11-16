Rails.application.routes.draw do
  #################  home_controller  #####################
  get '/' ,to: 'home#top'
  get '/about', to: 'home#about' #about_path, about_url

  #################  sessions_controller  ################
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to:'sessions#destroy'


  #################  users_controller  ####################
  resources :users;









  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
