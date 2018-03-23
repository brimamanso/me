module ApplicationHelper
    def belongs_to_user?(resource)
      resource.user == current_user
    end

    def active_page(active_page)
      @active == active_page ? "active" : ""
    end
  
    def activity_resources_exist?(activity)
      activity && activity.trackable && activity.owner
    end
    def parse(content)
      #content.gsub(/(?:^|\W)@(\w+)/, link_to(" @#{'\1'}", '/users/\1'))
      content = content.gsub(/(?:\s|^)(?:#(?!\d+(?:\s|$)))(\w+)(?=\s|$)/i) do |match|
        link_to(match, '', class: 'hashtags') 
      end
  
      content.gsub(/(?:^|\W)@(\w+)/) do |match|
        link_to(match, user_path(match.gsub('@', '')), class: 'mention')
      end
  
    end

    
end