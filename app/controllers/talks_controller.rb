class TalksController < ApplicationController

    
    before_action :authenticate_user!

    def index
        @users = User.all
        @talks = Talk.all
    end

    def create
        if Talk.between(params[:sender_id],params[:recipient_id]).present?
        @talk = Talk.between(params[:sender_id], params[:recipient_id]).first
        else
        @talk = Talk.create!(talk_params)
        end
        redirect_to talk_mails_path(@talk)
    end

    private
    def talk_params
        params.permit(:sender_id, :recipient_id)
    end
end
