module AnswerTypes

  class SingleLabel
    attr_accessor :text, :options

    def initialize(text, answer_options)
      self.text = text
      self.options = answer_options
    end

    def view_partial
      {
        partial: 'singlelabel',
        locals: export
      }
    end

    def export
      {
        type: self.class.name,
        text: self.text,
        options: self.options
      }
    end

    def validation(answer)
      return false unless answer.is_a?(Array) && answer.length < 2
      answer.all? { |a| self.options.include? a }
    end
  end

end