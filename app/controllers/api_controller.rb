class ApiController < ApplicationController
  
#   skip_before_filter :verify_authenticity_token
  
   def roomin
     xs = [:num1,:num2,:num3].map{|sym| params[sym].to_i }
     render json: {max: xs.max, min: xs.min}
   end
   def cal
     xs = [:num1,:num2,:num3].map{|sym| params[sym].to_i}
     render json: {max: xs.max, min: xs.min}
   end
   def post_comment
     user = User.find_by_email(params[:account])
     if user.valid_password?(params[:password])
       Comment.new( user: user, body: params[:comment] )
       render json: { result: "success" }
     else
       render json: { result: "failed" }
     end
  end
end
