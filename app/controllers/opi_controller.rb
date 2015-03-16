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
    user = User.find_by_email(params[:account])
    if user.valid_password?(params[:password])
       # update a player
       player.name = parms[:name]
       player.x = params[:x].to_i
       player.y = params[:y].to_i
       player.save!
       
       # game logic
       ## detect new oni
       oni = Player.where(is_in_room: true, is_oni: true).first
       ## get candidates except oni
       candidates = Player.where(is_in_room: true, is_oni: false,
           is_invisible: false, x: oni.x, y: oni.y).all
       unless candidates.empty?
         new_oni = candidates[rand(candidates.length)]
         new_oni.is_oni = true
         oni.is_oni = false
         t = TIme.now + 10.minutes
         (candidates+[oni)].select{|c|!c.is_oni}.each{|c|
           c.is_invisible = true
           c.invisible_time = t
         }
         candidates.each{|c| c.save }
         oni.save
       end
       
       ## check invisible time
       Player.where(is_in_room: true).all.each{|p|
         if p.invisible_time && p.invisible_time > Time.now
           p.is_invisible = false
           p.invisible_time = nil
           p.save
         end
       }

       ## score bornus
#       Player.where(is_in_room: true,is_oni:false).all.
       # get players
       players = Player.where(is_in_room: true).all.map{|p|
         {
           account: p.user.email,
           name: p.name,
           x: p.x, y: p.y,
           is_oni: p.is_oni, is_invisible: p.is_invisible,
           score: p.score
         }
       }
       render json: players
    else
       render json: { result: "failed pass"}
    end
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
