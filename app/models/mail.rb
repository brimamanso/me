class Mail < ApplicationRecord

    belongs_to :talk
    belongs_to :user
    validates_presence_of :body, :talk_id, :user_id

  def mail_time
    created_at.strftime("%m/%d/%y at %l:%M %p")
  end
end
