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
    @comment = current_micropost.comments.build(comment_params)
    if @comment.save
      flash[:success] = 'コメントを投稿しました。'
      redirect_to root_url
    else
      @comments = current_micropost.feed_comments.order(id: :desc).page(params[:page])
      flash.now[:danger] = 'コメントの投稿に失敗しました。'
      render 'toppages/index'
    end
  end

  def destroy
    @comment.destroy
    flash[:success] = 'コメントを削除しました。'
    redirect_back(fallback_location: root_path)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def correct_user
    @comment = current_micropost.comments.find_by(id: params[:id])
    unless @comment
      redirect_to root_url
    end
  end
end
