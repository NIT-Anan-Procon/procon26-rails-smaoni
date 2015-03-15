class HomeController < ApplicationController
  #you can not access if you dont login
  before_action :authenticate_user!#, only: [:index]
  def index
  end

  def show
     @scores = Score.all
     
  end
end
