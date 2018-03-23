Rails.application.routes.draw do

  resources :search_suggestions
  get "mailbox/inbox" => "mailbox#inbox", as: :mailbox_inbox
  get "mailbox/sent" => "mailbox#sent", as: :mailbox_sent
  get "mailbox/trash" => "mailbox#trash", as: :mailbox_trash

  get 'notifications/:id/link_through', to: 'notifications#link_through',
                                        as: :link_through
  get 'notifications', to: 'notifications#index'

  get '/posts/hashtag/:name', to:'posts#hashtags'

  resources :faqs do 
    resources :replies
  end 

  resources :chats do
    member do
      post :reply
      post :trash
      post :untrash
    end
  end

  resources :posts do 
    resources :comments 
    collection do # new path for search input 
      get :search 
    end 
  end
  devise_for :users
  resources :users do
    post 'search',  :on => :collection
    member do
      get :friends
      get :followers
      get :deactivate
      get :mentionable
    end
  end

  resources :chats do
    resources :messages
  end
  
  authenticated :user do
    root to: 'home#index', as: 'home'
  end
  unauthenticated :user do
    root 'home#front'
  end

  match :follow, to: 'follows#create', as: :follow, via: :post
  match :unfollow, to: 'follows#destroy', as: :unfollow, via: :post
  match :like, to: 'likes#create', as: :like, via: :post
  match :unlike, to: 'likes#destroy', as: :unlike, via: :post
  match :find_friends, to: 'home#find_friends', as: :find_friends, via: :get
  match :about, to: 'home#about', as: :about, via: :get
  match :privacy, to: 'home#privacy', as: :privacy, via: :get
  match :Terms, to: 'home#terms', as: :terms, via: :get

  resources :talks do
    resources :mails
  end

 
end