class RockPaperScissors
  def initialize
    @players = []
  end

  def entry(name)
    @players.push(Player.new(name))
  end

  def shoot
    @players.each {|player| player.setHand}
  end

  def judge
    playersHands = @players.map {|player| player.hand}
    @players.each {|player| player.setResult(playersHands)}
  end

  def printResult
    @players.each {|player| puts player.name + ":" + player.hand + "(#{player.result})"}
  end
end

class Player
  HAND_PATTERN = [["Rock","Scissors"],["Paper","Rock"],["Scissors","Paper"]]
  attr_reader :name
  attr_reader :hand
  attr_reader :result

  def initialize(name)
    @name = name
    @hand = ""
    @breakableHand = ""
    @result = ""
  end

  def setHand
    handsSet = HAND_PATTERN[rand(0..HAND_PATTERN.length - 1)]
    @hand = handsSet.first
    @breakableHand = handsSet.last
  end

  def setResult(hands)
    handsTypeCount = hands.uniq.length

    if handsTypeCount != 2
      @result = "Draw"
    else
      if hands.include?(@breakableHand)
        @result = "Win"
      else
        @result = "Lose"
      end
    end
  end
end
