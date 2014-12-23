class Question < ActiveRecord::Base
  has_many :answers
  attr_accessor :type

  after_find do |question|
    question.type = Rails.application.config.annotamele_types[question.type_id]
  end

  validates_presence_of :type_id

  scope :without, ->(ids) { where.not(id: ids) }
  scope :random_without, ->(ids) { where.not(id: ids).order("RANDOM()") }

end
