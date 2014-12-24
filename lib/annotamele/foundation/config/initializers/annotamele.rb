AnnotameLE::Application.configure do
  config.annotamele_types = [
    AnswerTypes.multilabel("Please select one answer below", ["First Option", "Second option", "Third option"])
  ]
end