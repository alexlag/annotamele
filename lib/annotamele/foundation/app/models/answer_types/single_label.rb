class SingleLabel < AnswerType
  custom_fields :text, :options

  validate_answer do |ans|
    ans.is_a?(Array) && ans.length < 2 && ans.all? { |a| options.include? a }
  end
end
