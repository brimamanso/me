class RepliesController < ApplicationController
    before_action :find_reply 
    before_action :find_reply, only: [:edit, :update, :destroy] 

    def create 
        @faq = Faq.find(params[:faq_id])
        @reply = @faq.replies.create(params[:reply].permit(:content))
        redirect_to faq_path(@faq) 
    end

    def destroy 
        @fay.destroy 
        redirect_to faq_path(@faq)
    end

    def update 
        if @reply.update(reply_params)
            redirect_to faq_path(@faq)
        else
            render 'edit'
        end 
    end  
    
    private 

        def find_faq
            @faq = Faq.find(params[:faq_id])
        end 

        def find_reply
            @reply = @faq.replies.find(params[:id])
        end 

    
end

