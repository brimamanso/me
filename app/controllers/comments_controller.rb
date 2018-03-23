class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :find_post 
    before_action :find_comment, only: [:edit, :update, :destroy] 
    def create 
        @comment = @post.comments.create(comment_params)
        @comment.user_id = current_user.id

        if @comment.save
            create_notification @post, @comment
            redirect_to post_path(@post)
        else
            render 'new'
        end 
    end

    def edit         
    end 

    def update 
        if @comment.update(comment_params)
            redirect_to post_path(@post)
        else
            render 'edit'
        end 
    end 

    def destroy 
        @comment.destroy 
        redirect_to post_path(@post)
    end 
    
    private
        def comment_params
            params.require(:comment).permit(:content)
        end 

        def find_post
            @post = Post.find(params[:post_id])
        end 

        def find_comment
            @comment = @post.comments.find(params[:id])
        end 

        def create_notification(post, comment)
            return if post.user.id == current_user.id
            Notification.create(user_id: post.user.id,
                                notified_by_id: current_user.id,
                                post_id: post.id,
                                identifier: comment.id,
                                notice_type: 'comment')
        end


end

