require "sinatra"
require "sinatra/reloader" if development?

require_relative "mastermind"
require_relative "stats"

$mastermind_cpu = MasterMind.new
$game_stats = Stats.new

get "/" do
  @guesses = $mastermind_cpu.guess_history
  @results = $mastermind_cpu.result_history
  haml :gameboard
end

post "/" do
  result = $mastermind_cpu.guess [params["Peg1"],
                                  params["Peg2"],
                                  params["Peg3"],
                                  params["Peg4"]]

  if $mastermind_cpu.result_win?(result)
    $game_stats.increment_played
    $game_stats.increment_won
    if $game_stats.min_to_win > $mastermind_cpu.guess_count
      $game_stats.min_to_win = $mastermind_cpu.guess_count
    end
    redirect "/win"
  elsif $mastermind_cpu.guess_count >= 10
    $game_stats.increment_played
    redirect "/lose"
  else
    redirect "/"
  end
end

get "/player1_picks" do
  haml :player1
end

post "/player1_picks" do
  $mastermind_cpu.player_secret = [params["Peg1"],
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
