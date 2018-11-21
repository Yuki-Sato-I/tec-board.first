Rails.application.routes.draw do
  ################  boards_controller  #####################
  get '/boards/:group_id/new', to:'boards#new'
  get '/boards/:group_id/show/:id', to:'boards#show'
  get '/boards/:group_id/index', to:'boards#index' #ここまで変更した
  get '/boards/:group_id/edit/:id', to:'boards#edit'
  post '/boards/:group_id', to:'boards#create'
  patch '/boards/:group_id/:id' ,to:'boards#update'
  delete '/boards/:group_id/:id' ,to:'boards#destroy'

  #################  groups_controller  ##################
  get '/groups/new', to:'groups#new'
  get '/groups/board',to:'groups#board'
  get '/groups/member/:id',to:'groups#member'
  get '/groups/picture',to:'groups#picture'
  get '/groups/chat',to:'groups#chat'
  post '/group', to: 'groups#create'
  get '/groups/:id',to:'groups#index' 

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
