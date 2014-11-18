class Question < ActiveRecord::Base
  has_many :answers

  scope :without, ->(ids) { where.not(id: ids) }
  scope :random_without, ->(ids) { where.not(id: ids).order("RANDOM()") }

end
