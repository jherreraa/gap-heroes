Rails.application.routes.draw do  
  namespace :api do
  	namespace :v1 do
  		resources :universes
   		resources :heroes
  	end
 end
end
