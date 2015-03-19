class OpiController < ApplicationController
  skip_before_filter :verify_authenticity_token
  
  N = 2

  def receiption
    user = User.find_by_email(params[:account])
    if user.valid_password?(params[:password])
      already = Player.where(is_in_room: true, user: user).first
      if already || Player.where(is_in_room: true).count < N
        player = Player.where(user: user).first
        unless player
          player = Player.new(user: user)
        end
        player.x = params[:x].to_i
        player.y = params[:y].to_i
        player.is_oni = false
	player.is_invisible = false
        player.invisible_end = nil
        player.score = 0
        player.is_in_room = true
        player.save!
        render json: (create_reception_status user)
      else
        render json: { reason: "over room limit" }
      end
    else
      render json: { reason: "invalid password" }
    end
  end


  def create_reception_status me
    ps = Player.where(is_in_room: true).all.map{|p|
      { account: p.user.email, name: p.user.name,
        x: p.x, y: p.y,
        is_oni: p.is_oni, is_invisible: p.is_invisible,
        invisible_end: p.invisible_end.to_i, score: p.score
      }
    }
    {
      me: ps.find{|p| p[:account] == me.email},
      player: ps.select{|p| p[:account] != me.email},
      start: ps.length == N,
      limit: N,
    }
  end

  def quitall
    Player.where(is_in_room: true).all.each{|player|
      player.is_in_room = false
      player.save
    }
    render json: ""
  end

  def onigokko
    user = User.find_by_email(params[:account])
    if user.valid_password?(params[:password])
       # update a player
       player = Player.where(user: user).first
       player.x = params[:x].to_i
       player.y = params[:y].to_i
       player.save!
       
       # game logic
       ## detect new oni
       oni = Player.where(is_in_room: true, is_oni: true).first
       ## decide initial oni
       unless oni
         xs = Player.where(is_in_room: true).all
         oni = xs[rand(xs.length)]
         oni.is_oni = true
         oni.save
       end       

       ## get candidates except oni
       candidates = Player.where(is_in_room: true, is_oni: false,
           is_invisible: false, x: oni.x, y: oni.y).all
       unless candidates.empty?
         new_oni = candidates[rand(candidates.length)]
         new_oni.is_oni = true
         oni.is_oni = false
         t = Time.now + 10.minutes
         (candidates+[oni]).select{|c|!c.is_oni}.each{|c|
           c.is_invisible = true
           c.invisible_end = t
         }
         candidates.each{|c| c.save }
         oni.save
       end
       
       ## check invisible time
       Player.where(is_in_room: true).all.each{|p|
         if p.invisible_end && p.invisible_end > Time.now
           p.is_invisible = false
           p.invisible_end = nil
           p.save
         end
       }

       ## score bornus
       # Player.where(is_in_room: true,is_oni:false).all.
       # get players
       render json: (create_reception_status user)
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
