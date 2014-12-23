AnnotameLE::Application.configure do
  config.annotamele_types = [
    AnswerTypes::MultiLabel.new("Please select one answer below", ["First Option", "Second option", "Third option"])
  ]
end