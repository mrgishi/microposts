class CommentsController < ApplicationController
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]

  def new
    @comment = Comment.new
  end

  def index
    @comments = Comment.All
  end

  def create
    micropost = Micropost.find(params[:micropost_id])
    @comment = micropost.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_to root_url
    else
      @comments = current_user.feed_comments.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  def show
    @micropost = Post.find(params[:id])
    @comments = @micropost.comments
    @comment = @micropost.comments.build
  end


  private

  def comment_params
    params.permit(:content)
  end

  def correct_user
    @comment = correct_user.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
end
