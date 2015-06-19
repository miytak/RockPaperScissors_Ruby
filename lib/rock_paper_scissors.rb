class RockPaperScissors
  def initialize
    @players = []
  end

  def entry player
    @players << player
  end

  def shoot!
    @players.each(&:shoot!)
    players_hands = @players.map(&:hand)
    @players.each {|player| player.settle! players_hands}
  end

  def results
    @players.map {|player| "#{player.name} : #{player.hand} (#{player.result})"}
  end
end

class Player
  attr_reader :name, :hand, :result

  def initialize name
    @name = name
    @hand = nil
    @breakable_hand = nil
    @result = nil
  end

  def shoot!
    hand_pattern = [["Rock","Scissors"],["Paper","Rock"],["Scissors","Paper"]]
    @hand,@breakable_hand = hand_pattern.sample
  end

  def settle! hands
    @result = hands.uniq.length != 2 ?
      "Draw" : hands.include?(@breakable_hand) ?
        "Win" : "Lose"
  end
end
