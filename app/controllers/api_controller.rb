class ApiController < ApplicationController
  def roomin
#    id = params[:id]
#    pass = params[:pass]
#    profile = { id: id, pass: pass, name: "kojima", age: 29 }
=begin 
    a = params[:num1].to_i
    b = params[:num2].to_i
    c = params[:num3].to_i
    max = a
    min = a
    if max < b
       max = b
    else
       min = b
    end
    
    if max < c
       max = c
    elsif min > c
       min = c
    end
    result = { num1: a, num2: b, num3: c, max: max, min: min}
    render json: result
=end
    xs = [:num1,:num2,:num3].map{|sym| params[sym].to_i }
    render json: {max: xs.max, min: xs.min}
  end
  def cal
    xs = [:num1,:num2,:num3].map{|sym| params[sym].to_i}
    render json: {max: xs.max, min: xs.min}
  end
end
