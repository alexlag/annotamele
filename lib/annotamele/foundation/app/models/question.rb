class Question < ActiveRecord::Base
  has_many :answers, dependent: :destroy
  belongs_to :type, class_name: 'AnswerType', foreign_key: :type_id

  validates_presence_of :type_id

  scope :without, ->(ids) { where.not(id: ids) }
  scope :random_without, ->(ids) { where.not(id: ids).order('RANDOM()') }
end
