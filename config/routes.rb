Rails.application.routes.draw do
  #get 'users/index'
  #resources :mailing_lists

  resources :challenge_statements
  #, except: :show do
  #  post 'join', on: :member
  #  post 'close', on: :member
  #  resources :submissions, except: :destroy
  #end
  #match 'submit', to: 'challenge_statements#submit', as: 'all_submissions', :via => :get

  #static-pages
  get 'static_pages/home'
  get 'static_pages/faq'
  get 'static_pages/rules'
  get 'static_pages/challenge_statement_1'
  get 'static_pages/challenge_statement_2'
  get 'static_pages/challenge_statement_3'

  #contact-us
  get 'contact-us', to: 'messages#new', as: 'new_message'
  post 'contact-us', to: 'messages#create', as: 'create_message'

  #users
  #devise_for :users, controllers: { sessions: 'users/sessions' }
  #get '/user' => "challenge_statements#submit", :as => :user_root
  #match '/users',   to: 'users#index',   via: 'get'
  #post '/download-attachments', to: "users#process_and_create_zip_file", as: 'download_documents'
  #get 'users/:id/uploads' => 'users#uploads', :as => :user_uploads

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "static_pages#home"
end
