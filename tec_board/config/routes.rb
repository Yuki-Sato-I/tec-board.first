Rails.application.routes.draw do
  get '/' ,to: 'home#top'
  get '/about', to: 'home#about' #about_path, about_url











  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
