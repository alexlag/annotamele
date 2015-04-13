require 'json'

# Admin user

u = User.new(
    email: 'admin@example.com',
    password: 'passw0rd',
    admin: true
)
u.save!

# Answer Types
answer_types = JSON.parse IO.read('db/answer_types.json'), symbolize_names: true

answer_types.each do |at|
  t = at[:name].constantize.new at[:params]
  # Much unsafe. Wow.
  t.id = AnswerType.count
  t.save!
end

# Dataset
seed_data = JSON.parse IO.read('db/seed_data.json'), symbolize_names: true

seed_data[:questions].each do |sd|
  q = Question.new(
    type_id: sd[:type],
    object: sd[:object],
    context: sd[:context]
  )
  q.save!
end
