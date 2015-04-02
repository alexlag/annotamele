require 'json'

AnnotameLE::Application.configure do
  config.annotamele_types =  JSON.parse(IO.read('config/answer_types.json'), symbolize_names: true).map do |entry|
    AnswerTypes.send(entry[:name], *entry[:params])
  end
end