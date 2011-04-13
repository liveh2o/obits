Obits::Application.routes.draw do
  match 'admin' => redirect('/admin/obituaries')

  resources :obituaries, :only => :index

  namespace(:admin){ resources :obituaries }  
end
