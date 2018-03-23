class MessagesController < ApplicationController
    before_filter :authenticate_user!
  
    def create
      @chat = chat.find(params[:chat_id])
      @message = @chat.messages.build(message_params)
      @message.user_id = current_user.id
      @message.save!
  
      @path = chat_path(@chat)
    end
  
    private
  
    def message_params
      params.require(:message).permit(:body)
    end
end