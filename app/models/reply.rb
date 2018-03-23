class Reply < ApplicationRecord
    belongs_to :faq

    def reply_count
        replies.length
    end
end
  