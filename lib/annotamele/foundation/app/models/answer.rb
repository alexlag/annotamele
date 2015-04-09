class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  serialize :body

  validates_presence_of :user_id, :question_id, :body
  before_save :type_validation

  private

  def type_validation
    question.type.validation(body)
  end
end
