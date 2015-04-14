class MultiLabel < AnswerType
  custom_fields :text, :options

  def validation(answer)
    return false unless answer.is_a?(Array)
    answer.all? { |a| options.include? a }
  end
end
