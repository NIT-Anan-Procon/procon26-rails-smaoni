class OpiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  

  def receiption
    user = User.find_by_email(params[:account])
    if user.valid_password?(params[:password])
      if Player.where(is_in_room: true).count < 4
        player = Player.where(user: user).first
        unless player
          player = Player.new(user: user)
        end
        player.x = params[:x].to_i
        player.y = params[:y].to_i
        player.is_oni = false
	player.is_invisible = false
        player.invisible_end_at = nil
        player.score = 0
        player.is_in_room = true
        player.save!
        render json: create_reception_status
      else
        render json: { reason: "over room limit" }
      end
    else
      render json: { reason: "invalid password" }
    end
  end


  def create_reception_status
    players = Player.where(is_in_room: true).all.map{|p|
      { account: p.user.email, x: p.x, y: p.y, }
    } 
    { player: players, start: false }
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
