class User < ActiveRecord::Base
  devise :database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  has_many :answers

  def answered_question_ids
    Answer.where(user_id: id).pluck(:question_id)
  end

  def self.search_and_order(search)
    if search
      where('email LIKE ?', "%#{search.downcase}%").order(
        admin: :desc, email: :asc
      )
    else
      order(admin: :desc, email: :asc)
    end
  end

  def self.last_signups(count)
    order(created_at: :desc).limit(count).select('id', 'email', 'created_at')
  end

  def self.last_signins(count)
    order(last_sign_in_at:
    :desc).limit(count).select('id', 'email', 'last_sign_in_at')
  end

  def self.users_count
    where('admin = ? AND locked = ?', false, false).count
  end
end
