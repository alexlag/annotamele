class Regression < AnswerType
  custom_fields :text

  preprocess_answer do |ans|
    begin
      Float(ans)
    rescue ArgumentError
      ans
    end
  end

  validate_answer do |ans|
    ans.is_a?(Numeric)
  end
end
