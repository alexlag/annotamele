class AnswerType < ActiveRecord::Base
  serialize :body

  self.inheritance_column = :type

  # def self.types
  #   %w(SingleLabel MultiLabel)
  # end
end
