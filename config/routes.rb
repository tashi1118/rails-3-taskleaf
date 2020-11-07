Rails.application.routes.draw do
  # ルート（/）にアクセスした時にタスクのindexを取得する記述
  root to: 'tasks#index'
  resources :tasks
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
