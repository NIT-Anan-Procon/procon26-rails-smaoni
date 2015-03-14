class OpiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  

  def receiption
  end

  def onigokko
      data = [:account,:password,:x,:y].map{|sym| params[sym]}
     #    = JSON.parse(data)
  end

  def post_comment
    user = User.find_by_email(params[:account])
    if user.valid_password?(params[:password])
      c = Comment.new( user: user, body: params[:comment] )
      c.save
      render json: { result: "success" }
    else
      render json: { result: "failed" }
    end
  end
end
