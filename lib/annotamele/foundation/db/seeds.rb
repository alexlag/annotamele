require 'json'

seed_data = JSON.parse File.read('db/seed_data.json')

seed_data['questions'].each do |sd|
  q = Question.new(
    type_id: sd['type'],
    object: sd['object'],
    context: sd['context']
  )
  q.save!
end