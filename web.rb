require "sinatra"
require "sinatra/reloader" if development?

require_relative "mastermind"

$mastermind_cpu = MasterMind.new

get "/" do
  @guesses = $mastermind_cpu.guess_history
  haml :gameboard
end

post "/" do
  $mastermind_cpu.guess [params["Peg1"],
                         params["Peg2"],
                         params["Peg3"],
                         params["Peg4"]]
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
