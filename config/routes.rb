Rails.application.routes.draw do
  root to: "api/v1/nodes#index"
  namespace :api do
    namespace :v1 do

      resources :nodes, only: [:index] do
        member do
          get :find_parent
          get :find_childs
        end
      end
    end
  end
end
