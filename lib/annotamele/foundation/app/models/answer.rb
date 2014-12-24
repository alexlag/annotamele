class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  serialize :body

  validates_presence_of :user_id, :question_id, :body
  before_save :type_validation

  private 
    def type_validation
      self.question.type.validation(self.body)
    end
end
