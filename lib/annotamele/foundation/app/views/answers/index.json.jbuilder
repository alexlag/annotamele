json.array! @answers do |answer|
  
  json.question({
    object: answer.question.object, 
    context: answer.question.context
  }.merge(answer.question.type.export))

  json.user do
    json.(answer.user, :email, :created_at)
  end

  json.answer answer.body

  json.created answer.created_at
end