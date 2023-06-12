Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # namespace :bachelorettes, only: [:show] do
  # resources :bachelorettes, only: [:show] do
  #   resources :contestants, only: [:index, :show], controller: "bachelorette_contestants" do
  #     # resources :outings, only: [:show], controller: "contestant_outings#show"
  #   end
  # end

  resources :bachelorettes, only: [:index, :show] do
    resources :contestants, only: [:index, :show], controller: "bachelorette_contestants" do
      resources :outings, only: [:index, :show], controller: "contestant_outings"
    end
  end

  # How do I resource this...?
  # get "/bachelorettes/:id/contestants/:id/outings/:id", to: "contestant_outings#show"

  # resources :outings, only: [:show], controller: "contestant_outings"
  # namespace :outings do, only: [:show], controller: "contestant_outings"
end
