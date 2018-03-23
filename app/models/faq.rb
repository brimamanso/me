class Faq < ApplicationRecord
    has_many :replies

    def reply_count
        replies.length
    end
    
   
end
