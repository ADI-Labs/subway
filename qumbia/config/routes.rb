Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  # devise_scope :user do
  #   get 'sign_in', :to => 'devise/sessions#new' #see platformatec
  #   get 'sign_out', :to => 'devise/sessions#destroy'
  #   delete 'sign_out', :to => 'devise/sessions#destroy'
  # end

  resources :questions, :defaults => { :format => 'json' } do
    resources :answers, :defaults => { :format => 'json' } 
  end

  resources :answers, :defaults => { :format => 'json' } do 
      resources :upvotes, :defaults => { :format => 'json'}
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'questions#index'

  post 'searches/index' => 'searches#index', as: 'searches'

  get 'searches/search_questions' => 'searches#search_questions', as: 'search_questions'

  get 'searches/search_answers' => 'searches#search_answers', as: 'search_answers'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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
