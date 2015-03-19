# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

@score_data = Score.new
@score_data.email = '1122320@st.anan-nct.ac.jp'
@score_data.point = 100
@score_data.scored_at = Time.now
@score_data.save

# Same as User.create(:email => '', :passeord => '')
user = User.new(:email => 'yahoo_love@gmail.com', :password => 'kashifuku', :name => "かし")
user.save!
user = User.new(:email => 'hack_u_brilliant@st.anan-nct.ac.jp', :password => 'morikohki', :name => "もりりん")
user.save!
user = User.new(:email => 'happy_turn@yahoo.co.jp', :password => 'happyturn', :name => "ひらっぴ")
user.save!
user = User.new(:email => 'makko_kujira@docomo.ne.jp', :password => 'shironagasu', :name => 'GUCCI')
user.save!

