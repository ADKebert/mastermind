require "sinatra"
require "sinatra/reloader" if development?

require_relative "mastermind"

$mastermind_cpu = MasterMind.new
get "/" do
  puts "testing"
  @guesses = $mastermind_cpu.guess_history
  haml :gameboard
end
