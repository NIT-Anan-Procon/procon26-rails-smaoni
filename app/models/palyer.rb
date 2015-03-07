class Palyer < ActiveRecord::Base
  belongs_to :user
  belongs_to :room
end
