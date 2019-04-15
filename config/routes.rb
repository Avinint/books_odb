Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "home#index"
  get "home", to: "home#index"
  resources :books, only: [:index, :show, :new, :edit, :create, :update, :destroy], param: :identifier
end
 