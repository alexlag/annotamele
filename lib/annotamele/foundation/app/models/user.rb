class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :trackable, :validatable

  has_many :answers

  def self.anonymous
    @@static_anonymous = User.new(id: 0) if @@static_anonymous.nil?
    @@static_anonymous
  end

  def answered_question_ids
    Answer.where(user_id: self.id).pluck(:question_id)
  end

end
