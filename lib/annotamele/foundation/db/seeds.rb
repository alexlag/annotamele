require 'json'

seed_data = JSON.parse File.read('db/seed_data.json')
text = Rails.application.config.annotamele_text

seed_data['questions'].each do |sd|
  q = Question.new(
    text: text,
    object: sd['object'],
    context: sd['context']
  )
  q.save!
end