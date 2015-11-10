Rails.application.routes.draw do
  match "/signout" => "sessions#destroy", via: [ :get, :post ]
  match "/adauth" => "sessions#create" , via: [ :get, :post ]
  resources :sessions
  get 'welcome/index'

post 'assets/:id/activate'  => "assets#activate", as: 'activate_asset'
post 'assets/:id/deactivate'  => "assets#deactivate", as: 'deactivate_asset'

post 'users/:id/activate'  => "users#activate", as: 'activate_user'
post 'users/:id/deactivate'  => "users#deactivate", as: 'deactivate_user'

get 'reservations/reports' => "reservations#reports", as: 'report_reservations'
post 'reservations/report' => "reservations#report", as: 'export_reservation'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'reservations#new'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products
	resources :users 
	resources :reservations 
	resources :assets

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
