Obits::Application.routes.draw do
  resources :obituaries, :only => :index

  namespace(:admin){ resources :obituaries }  
end
