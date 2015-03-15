class CommentController < ApplicationController
  def index
   @comments = Comment.all
  end
end
