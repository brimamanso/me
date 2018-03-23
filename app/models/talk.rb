class Talk < ApplicationRecord

    belongs_to :sender, :foreign_key => :sender_id, class_name: 'User'
    belongs_to :recipient, :foreign_key => :recipient_id, class_name: 'User'

    has_many :mails, dependent: :destroy

    validates_uniqueness_of :sender_id, :scope => :recipient_id

  scope :between, -> (sender_id,recipient_id) do
    where("(talks.sender_id = ? AND talks.recipient_id =?) OR (talks.sender_id = ? AND talks.recipient_id =?)", sender_id,recipient_id, recipient_id, sender_id)
  end
end
