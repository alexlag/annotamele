AnnotameLE::Application.routes.draw do
  devise_for :users

  root 'answers#question'

  get '/question', to: 'answers#question', as: 'new_question'
  post '/answer', to: 'answers#add_answer', as: 'new_answer'

  get '/export(.format)', to: 'answers#index', as: 'export'

  namespace :admin do
    root 'base#index'
    resources :users
    get '/config', to: 'config#index', as: 'config'
    post '/config/types', to: 'config#update_types', as: 'config_types'
    post '/config/questions', to: 'config#update_questions', as: 'config_questions'
    delete '/config', to: 'config#purge', as: 'purge_config'
  end
end
