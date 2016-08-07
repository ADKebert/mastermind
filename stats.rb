# For adventure mode I need a class seperate from mastermind to track stats
# because I destroy the mastermind instance upon restart and it's really a
# different functionality.  I must track games played, won, and least guesses
# to win a game. I have decided not to count restarts toward the game total

class Stats
  attr_reader :played, :won, :min_to_win

  def initialize
    @played = 0
    @won = 0
    @min_to_win = 10
  end

  def increment_played
    @played += 1
  end

  def increment_won
    @won += 1
  end

  def min_to_win=(new_min)
    @min_to_win = new_min
  end
end
