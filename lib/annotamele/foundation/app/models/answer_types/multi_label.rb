class MultiLabel < AnswerType
  custom_fields :text, :options

  validate_answer do |ans|
    ans.is_a?(Array) && ans.all? { |a| options.include? a }
  end
end
