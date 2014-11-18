ANNOTAMELE_APP_NAME::Application.configure do
  config.annotamele_type = :multilabel  
  config.annotamele_fields = [:first_option, :second_option, :third_option]
  config.annotamele_text = "Please select answer below"
end