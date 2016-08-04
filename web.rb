require "sinatra"

require_relative "mastermind"

$mastermind_cpu = MasterMind.new
get "/" do
  @guesses = $mastermind_cpu.guess_history
  haml :gameboard
end
