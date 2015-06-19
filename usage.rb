require './lib/rock_paper_scissors'

rock_paper_scissors = RockPaperScissors.new
players = %w(John Jane Matz).map{|name| Player.new(name)}

players.each {|player| rock_paper_scissors.entry player}

10.times do
  rock_paper_scissors.shoot!
  p rock_paper_scissors.results
end
