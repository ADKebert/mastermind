require "sinatra"
require "sinatra/reloader" if development?

require_relative "mastermind"

$mastermind_cpu = MasterMind.new

get "/" do
  @guesses = $mastermind_cpu.guess_history
  @results = $mastermind_cpu.result_history
  haml :gameboard
end

post "/" do
  guess = [params["Peg1"],
           params["Peg2"],
           params["Peg3"],
           params["Peg4"]]
  $mastermind_cpu.guess(guess)
  if $mastermind_cpu.result_win?(guess)
    redirect "/win"
  elsif $mastermind_cpu.guess_count >= 10
    redirect "/lose"
  else
    redirect "/"
  end
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
