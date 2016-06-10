class AnswerType < ActiveRecord::Base
  serialize :body

  self.inheritance_column = :type

  class << self
    attr_accessor :custom_fields_list, :validations, :preprocesses
  end

  def custom_fields_list
    self.class.custom_fields_list || []
  end

  def validations
    self.class.validations || []
  end

  def preprocesses
    self.class.preprocesses || []
  end

  def self.custom_fields(*args)
    args.each do |arg|
      (@custom_fields_list ||= []) << arg
      class_eval "def #{arg}; body[:#{arg}];end"
      class_eval "def #{arg}=(val);body[:#{arg}]=val;end"
    end
  end

  def self.preprocess_answer(&block)
    (@preprocesses ||= []) << block
  end

  def self.validate_answer(&block)
    (@validations ||= []) << block
  end

  def view_partial
    {
      partial: "answer_types/#{self.class.to_s.underscore}",
      locals: export
    }
  end

  def export
    custom_fields_list.each_with_object(type: self.class.name) do |field, total|
      total[field] = body[field]
    end
  end

  def preprocess(answer)
    preprocesses.inject(answer) do |res, callback|
      instance_exec res, &callback
    end
  end

  def validation(answer)
    validations.all? do |callback|
      instance_exec answer, &callback
    end
  end
end
