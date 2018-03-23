class MailsController < ApplicationController
    before_action do
        @talk = Talk.find(params[:talk_id])
    end
    
    def index
        @mails = @talk.mails
        if @mails.length > 10
          @over_ten = true
          @mails = @mails[-10..-1]
        end
        if params[:m]
          @over_ten = false
          @mails = @talk.mails
        end
        if @mails.last
          if @mails.last.user_id != current_user.id
            @mails.last.read = true;
          end
        end
    
        @mail = @talk.mails.new
    end
    
    def new
        @mail = @talk.mails.new
    end
    
    def create
        @mail = @talk.mails.new(mail_params)
        if @mail.save
          redirect_to talk_mails_path(@talk)
        end
    end
    
    private
    def mail_params
        params.require(:mail).permit(:body, :user_id)
    end
end
