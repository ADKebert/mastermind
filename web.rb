require "sinatra"
require "sinatra/reloader" if development?

require_relative "mastermind"

$mastermind_cpu = MasterMind.new

get "/" do
  @guesses = $mastermind_cpu.guess_history
  haml :gameboard
end

post "/" do
  $mastermind_cpu.guess %w{red green blue green}
  redirect "/"
end

get "/win" do
  haml :win
end

get "/lose" do
  haml :lose
end

post "/restart" do
  $mastermind_cpu = MasterMind.new
  redirect "/"
end
