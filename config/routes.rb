Rails.application.routes.draw do

  ## -----------
  ## Q-Auth URLS
  ## -----------
  mount QAuthRubyClient::Engine, at: "/q-auth", :as => 'q_auth_ruby_client'

  # ------------
  # Public pages
  # ------------

  root :to => 'public/welcome#home'

  namespace :public do
    resources :events, only: [:index, :show] do
      member do
        post :apply
      end
      resources :career_interests, only: [:show] do
        member do
          get :confirm
        end
      end
    end
  end

  # ------------
  # Admin pages
  # ------------

  get '/admin' => "admin/welcome#home", as: :admin_home

  namespace :admin do
    resources :users, only: [:index, :show] do
      collection do
        get 'refresh'
      end
      member do
        put 'make_q_careers_admin', as: :make_q_careers_admin
        put 'make_recruiter', as: :make_recruiter
        put 'make_volunteer', as: :make_volunteer

        put 'remove_q_careers_admin', as: :remove_q_careers_admin
        put 'remove_recruiter', as: :remove_recruiter
        put 'remove_volunteer', as: :remove_volunteer
      end
    end
    resources :events
    resources :configurations
    resources :candidates
    get 'export_candidate/:id' => "career_interests#export_candidate", as: :export_candidate
  end

  namespace :recruiter do
    resources :events, only: [:index, :show] do
      resources :career_interests do
        member do
          get 'download'
        end
      end
      resources :referrals, only: [:index, :show] do
        member do
          get 'download'
        end
      end
    end
  end

  namespace :volunteer do
    resources :events, only: [:index, :show] do
      resources :registrations do
        member do
          get 'download'
          put 'mark_as_reported'
          put 'mark_as_not_reported'
        end
        collection do
          get 'search'
        end
      end
    end
  end

  namespace :employee do
    resources :events, only: [:index, :show] do
      resources :referrals do
        member do
          get 'download'
        end
      end
    end
  end

  # ------------
  # User pages
  # ------------

  namespace :users do

    # Landing page after sign in
    get   '/dashboard',         to: "dashboard#index",   as:  :dashboard

    resources :events, :only=>[:index, :show] do
      resources :career_interests
    end
    resources :candidates, only: [:show] do
      collection do
        get 'download'
      end
    end
  end

  # ------------
  # Reports
  # ------------

  get   '/reports/registrations',         to: "reports#registrations",   as:  :registrations_report
  get   '/reports/referrals',         to: "reports#referrals",   as:  :referrals_report
  


end
