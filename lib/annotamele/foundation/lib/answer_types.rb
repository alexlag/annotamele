Dir["answer_types/*.rb"].each { |file| require file }

module AnswerTypes

  def self.multilabel(*args)
    MultiLabel.new(*args)
  end

  def self.singlelabel(*args)
    SingleLabel.new(*args)
  end

end