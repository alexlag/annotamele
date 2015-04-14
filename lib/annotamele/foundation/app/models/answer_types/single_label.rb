class SingleLabel < AnswerType
  custom_fields :text, :options

  def validation(answer)
    return false unless answer.is_a?(Array) && answer.length < 2
    answer.all? { |a| options.include? a }
  end
end
