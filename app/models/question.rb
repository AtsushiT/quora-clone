class Question < ActiveRecord::Base
  belongs_to :user

  validates :question_title, presence: true
  validates :question_content, presence: true

end
