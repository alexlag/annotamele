class MultiLabel < AnswerType
  def text=(text)
    body[:text] = text
  end

  def text
    body[:text]
  end

  def options=(options)
    body[:options] = options
  end

  def options
    body[:options]
  end

  def view_partial
    {
      partial: 'answer_types/multi_label',
      locals: export
    }
  end

  def export
    {
      type: self.class.name,
      text: text,
      options: options
    }
  end

  def validation(answer)
    return false unless answer.is_a?(Array)
    answer.all? { |a| options.include? a }
  end
end
