defmodule DragonElixir.Trainer do
  require Logger

  alias DragonElixir.WeatherService

  @lookup %{
    "agility" => "wingStrength",
    "armor" => "clawSharpness",
    "attack" => "scaleThickness",
    "endurance" => "fireBreath"
  }

  def prepare_dragon(game) do
    %{"knight" => knight, "gameId" => gameId} = game

    IO.puts "\n"
    # knight stats with the knight's name deleted, he will die anyway
    knight_stats = knight
      |> Enum.sort(fn ({_, a}, {_, b}) -> a >= b end)
      |> List.delete_at(0)
      |> IO.inspect

    IO.puts "VS."

    dragon_stats = for stat <- 0..3 do
      knight_stats |> Enum.at(stat) |> train_dragon(stat)
    end |> IO.inspect

    case WeatherService.forecast(gameId) do
      'NMR' ->
        take_note "It was sunny", gameId, knight["name"], "our finest dragon"
        %{"dragon" => DragonElixir.Dragon.spawn dragon_stats}
      'FUNDEFINEDG' ->
        take_note "The fog was hanging low", gameId, knight["name"], "due to the weather it did not matter which dragon"
        %{"dragon" => DragonElixir.Dragon.spawn dragon_stats}
      'HVA' ->
        take_note "The rain poured down, drowning lots of knights", gameId, knight["name"], "Nessi itself"
        %{"dragon" => DragonElixir.Dragon.spawn :water_dragon}
      'T E' ->
        take_note "There was this megadrought", gameId, knight["name"], "having achieved complete balance our zennest dragon"
        %{"dragon" => DragonElixir.Dragon.spawn :zen_dragon}
      _ ->
        take_note "We could not reach the weather service (broken communicator or whatever)", gameId, knight["name"], "no dragon"
        %{}
    end
  end

  defp take_note(weather, game, knight, dragon) do
    IO.puts "\n"
    Logger.debug "+++"
    Logger.info "#{weather} in #{game} when #{knight} set out to free the the beautiful princess."
    Logger.info "However, #{dragon} came to get rid of this tincan-dressed nuisance."
    Logger.info "Let's see how the enounter ended..."
  end

  defp train_dragon({attr, val}, 0), do: {@lookup[attr], val + 2}
  defp train_dragon({attr, val}, 1), do: {@lookup[attr], val - 1}
  defp train_dragon({attr, val}, 2), do: {@lookup[attr], val - 1}
  defp train_dragon({attr, val}, 3), do: {@lookup[attr], val}
end
