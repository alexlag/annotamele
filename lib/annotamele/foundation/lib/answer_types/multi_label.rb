module AnswerTypes

  class MultiLabel
    attr_accessor :text, :options

    def initialize(text, answer_options)
      self.text = text
      self.options = answer_options
    end

    def view_partial
      {
        partial: 'multilabel',
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

  end

end