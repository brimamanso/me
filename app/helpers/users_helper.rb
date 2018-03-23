module UsersHelper
    def options_for_seasons
      [['Male', 'male'], ['Female', 'female']]
    end

    def options_for_rains
      [['University', 'University'], ['College', 'College'], ['High School', 'High School'], ['Other', 'Other']]
    end

    def options_for_boys
      [['Single', 'Single'], ['Married', 'Married']]
    end

    def options_for_girls
      [['University', 'University'], ['College', 'College'], ['High School', 'High School'], ['Other', 'Other']]
    end
  
    def age(date_of_birth)
      now = Time.now.utc.to_date
      now.year - date_of_birth.year - (date_of_birth.to_date.change(:year => now.year) > now ? 1 : 0)
    end
  
    def is_current_user?(user)
      user == current_user
    end

    def devise_mapping
      @devise_mapping ||= Devise.mappings[:user]
    end

    def chat_interlocutor(chat)
      chat.recipient == current_user ? chat.sender : chat.recipient
    end
end