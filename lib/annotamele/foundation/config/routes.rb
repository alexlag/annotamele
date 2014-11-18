ANNOTAMELE_APP_NAME::Application.routes.draw do
  devise_for :users

  root "answers#get_question"
  
  get "/question", to: "answers#get_question", as: "new_question"
  post "/answer", to: "answers#add_answer", as: "new_answer"

  get "/export(.format)", to: "answers#index", as: "export"
  
end
