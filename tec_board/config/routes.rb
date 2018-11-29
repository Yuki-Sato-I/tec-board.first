Rails.application.routes.draw do
  get '/contacts/new', to:'contacts#new'
  get '/contacts/index', to:'contacts#index'
  get '/contacts', to:'contacts#new'
  post '/contacts', to: 'contacts#create'
  delete '/contacts/:id', to: 'contacts#destroy'
  ################  albums_controller  ################
  get '/albums/:group_id/new', to:'albums#new'
  get '/albums/:group_id/show/:id', to:'albums#show'
  get '/albums/:group_id/index', to:'albums#index'
  get '/albums/:group_id/edit/:id', to:'albums#edit'
  post '/albums/:group_id', to:'albums#create'
  get '/albums/:group_id', to:'albums#edit'
  get '/albums/:group_id', to:'albums#new'
  patch '/albums/:group_id/:id' ,to:'albums#update'
  delete '/albums/:group_id/:id' ,to:'albums#destroy'

  ################  boards_controller  #####################
  get '/boards/:group_id/new', to:'boards#new'
  get '/boards/:group_id/show/:id', to:'boards#show'
  get '/boards/:group_id/index', to:'boards#index'
  get '/boards/:group_id/edit/:id', to:'boards#edit'
  post '/boards/:group_id', to:'boards#create'
  get '/boards/:group_id' , to:'boards#new'
  patch '/boards/:group_id/:id' ,to:'boards#update'
  delete '/boards/:group_id/:id' ,to:'boards#destroy'

  #################  groups_controller  ##################
  get '/groups/new', to:'groups#new'
  get '/groups/invited',to:'groups#invited'
  get '/groups/permission', to:'groups#invited'
  post '/groups/permission', to:'groups#permission'
  get '/groups/member/:id',to:'groups#member'
  get '/groups/picture',to:'groups#picture'
  get '/groups/:group_id/chat',to:'groups#chat'
  post '/groups/:group_id/chat',to:'groups#chat_create' 
  post '/group', to: 'groups#create'
  get '/group', to: 'groups#new'
  get '/groups/:id',to:'groups#index' 

  #################  home_controller  #####################
  get '/' ,to: 'home#top'
  get '/about', to: 'home#about' #about_path, about_url
  get '/terms', to: 'home#terms_of_service'
  get '/policy', to: 'home#policy'
  #################  sessions_controller  ################
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to:'sessions#destroy'


  #################  users_controller  ####################
  resources :users;

  #################  account_activations_controller  #############
  resources :account_activations,only: [:edit]

  #################  passwordreset_controller  ###############
  resources :password_resets, only: [:new, :create, :edit, :update]







  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
