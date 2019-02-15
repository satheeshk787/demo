Rails.application.routes.draw do

  resources :banners
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :assignments
  resources :universities
  get 'admins/list_users'

  root to: "pages#home"

  get 'users/edit' => 'users#edit', as: :users_edit
  get 'users/my_profile' => 'users#view', as: :users_profile

  get 'users/change_password' => 'users#change_password', as: :change_password
  post 'users/change_password_action' => 'users#change_password_action', as: :change_password_action

  post 'users/add_user_action' => 'users#create', as: :add_user_action

  post 'users/submit_answer' => 'users#submit_answer', as: :submit_answer

  get 'users/assignment_view' => 'users#assignment_view', as: :user_assignment_view
  get 'users/assignment_view/:id' => 'users#show_assignment', as: :user_show_assignment

  get 'assignments/:id/share' => 'assignments#share', as: :assignment_share
  get 'assignments/:id/share?search=:search' => 'assignments#share'
  post 'assignments/:id/share_action' => 'assignments#share_action', as: :assignment_share_action

  get 'assignments/:id/show_answers' => 'assignments#show_answers', as: :show_answers
  get 'assignments/:user_id/:assignment_id/review_answer/:student_name' => 'assignments#review_answer', as: :review_answer

  post 'assignments/review_answer_action' => 'assignments#review_answer_action', as: :review_answer_action
  

  devise_for :users

  resources 'users'
  
  #for admin
  get 'admins/student_univercity_change_list', as: :student_univercity_change_list
  get 'admins/:id/univercity_review' => 'admins#univercity_review', as: :admin_univercity_review
  
  get 'admins' => 'admins#index', as: :admins_home
  get 'admins/:id' => 'admins#show', as: :admins_show
  get 'admins/:id/edit' => 'admins#edit', as: :admins_edit
  post 'admins/:id/update' => 'admins#update', as: :admins_update
  delete 'admins/:id/destroy' => 'admins#destroy', as: :admins_destroy
  get 'admins/list_users/search=:search&role=:role' => 'admins#list_users', as: :admins_user_search

  get 'admins/list_users', as: :users_list


 
  
  #root 'pages#home'
  
  get 'pages/home'
  
  get 'pages/mainpage'

  get 'users/view'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
    

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
