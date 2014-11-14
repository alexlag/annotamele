ANNOTAMELE_APP_NAME::Application.routes.draw do
  devise_for :users

  root "questions#new"
  
  get "/question", to: "questions#new", as: "new_question"
  post "/answer", to: "answers#new", as: "new_answer"
  
end
