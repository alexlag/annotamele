class AnswerType < ActiveRecord::Base
  serialize :body

  self.inheritance_column = :type

  class_attribute :custom_fields_list
  self.custom_fields_list = []

  def self.custom_fields(*args)
    args.each do |arg|
      custom_fields_list << arg
      class_eval("def #{arg}; body[:#{arg}];end")
      class_eval("def #{arg}=(val);body[:#{arg}]=val;end")
    end
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

  def validation(_answer)
    true
  end
end
