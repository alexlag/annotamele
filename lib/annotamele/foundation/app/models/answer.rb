class Answer < ActiveRecord::Base
  belongs_to :user
  belongs_to :question

  serialize :body

  validates_presence_of :user_id, :question_id, :body
end
