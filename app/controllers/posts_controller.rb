class PostsController < ApplicationController
    before_action :require_author, only: [:edit, :update]

    def new
        @post = Post.new
        render :new
    end

    def create
        @post = Post.new(post_params)
        @post.author_id = current_user.id
        if @post.save
            redirect_to post_url(@post)
        else 
            flash.now[:errors] = @post.errors.full_messages
            render :new
        end
    end

    def show
        @post = Post.find(params[:id])
        @all_comments = Hash.new {|h, k| h[k] = Array.new}
        @post.comments.includes(:author).each do |comment|
            @all_comments[comment.parent_comment_id] << comment
        end

        render :show
    end
    
    def edit
        @post = Post.find(params[:id])
        render :edit
    end
    
    def update
        @post = Post.find(params[:id])
        if @post.update(post_params)
            redirect_to post_url(@post)
        else
            flash[:errors] = @post.errors.full_messages
            redirect_to edit_post_url(@post)
        end
    end

    private
    def require_author
        @post = Post.find(params[:id])
        redirect_to post_url(@post) unless current_user.id == @post.author_id
    end

    def post_params
        params.require(:post).permit(:title, :url, :content, sub_ids:[])
    end
end
