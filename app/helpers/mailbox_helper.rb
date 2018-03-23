module MailboxHelper
    def unread_messages_count
        # how to get the number of unread messages for the current user
        # using mailboxer
        @messages_count = current_user.mailbox.inbox({:read => false}).count
    end

end
