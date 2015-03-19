class HomeController < ApplicationController
  #you can not access if you dont login
  before_action :authenticate_user!, only: [:show]
  def index
     @users = User.all
     @players = Player.all
     @score = Score.all
     @members = Member.all

     if params[:id]
        if player = Player.find(params[:id])
           case params[:column]
              when 'x'
                 player.x = params[:x].to_i
                 player.save
              when 'y'
                 player.y = params[:y].to_i
                 player.save
              when 'score'
                 player.score = params[:score].to_i
                 player.save
              when 'is_in_room'
                 player.is_in_room = params[:is_in_room] == "true"
                 player.save
              
              when 'is_invisible'
                 player.is_invisible = params[:is_invisible] == "true"
                 player.save
              
              when 'is_oni'
                 player.is_oni = params[:is_oni] == "true"
                 player.save
           end
        end
     end

  end

  def show
     @score = Score.all
     
  end
end
