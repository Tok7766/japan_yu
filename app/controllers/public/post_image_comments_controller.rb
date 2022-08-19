class Public::PostImageCommentsController < ApplicationController

  def create
    @post_image = PostImage.find(params[:post_image_id])
    @comment = current_customer.post_image_comments.new(post_image_comment_params)
    @comment.post_image_id = @post_image.id
    @comment.save
    redirect_to request.referer
  end

  def destroy
    @post_image = PostImage.find(params[:post_image_id])
    PostImageComment.find_by(id: params[:id], post_image_id: params[:post_image_id]).destroy
    redirect_to request.referer
  end

  private
  def post_image_comment_params
    params.require(:post_image_comment).permit(:comment)
  end
end
