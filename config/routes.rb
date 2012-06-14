Spree::Core::Engine.routes.append do
  namespace :admin do
    resources :user_groups
  end
end
