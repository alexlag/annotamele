json.array! @answers do |answer|
  
  json.question do
    json.(answer.question, :text, :context)
  end

  json.user do
    json.(answer.user, :email, :created_at)
  end

  json.answer do 
    json.(answer, *Rails.application.config.annotamele_fields)
  end

  json.created answer.created_at
end