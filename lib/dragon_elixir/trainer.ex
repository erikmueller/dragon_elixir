defmodule DragonElixir.Trainer do
  require Logger

  @lookup %{
    "agility" => "wingStrength",
    "armor" => "clawSharpness",
    "attack" => "scaleThickness",
    "endurance" => "fireBreath"
  }

  # We have some special dragons for certain weather conditions. Doesn't matter which knight comes
  # Note: Yes I wanted a `fog_dragon`! Sending any other felt wrong.
  def prepare_dragon({story, :dry}, _) do
    {["having achieved complete balance our zennest dragon" | story], %{"dragon" => DragonElixir.Dragon.spawn :zen_dragon}}
  end

  def prepare_dragon({story, :fog}, _) do
    {["the sneaky fog dragon (but really it didn't matter)" | story], %{"dragon" => DragonElixir.Dragon.spawn :fog_dragon}}
  end

  def prepare_dragon({story, :rain}, _) do
    {["Nessi itself" | story], %{"dragon" => DragonElixir.Dragon.spawn :water_dragon}}
  end

  def prepare_dragon({story, :storm_or_unknown}, _) do
    {["no dragon" | story], %{}}
  end

  def prepare_dragon({story, _}, knight) do
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

    {["our finest dragon" | story], %{"dragon" => DragonElixir.Dragon.spawn dragon_stats}}
  end

  defp train_dragon({attr, val}, 0), do: {@lookup[attr], val + 2}
  defp train_dragon({attr, val}, 1), do: {@lookup[attr], val - 1}
  defp train_dragon({attr, val}, 2), do: {@lookup[attr], val - 1}
  defp train_dragon({attr, val}, 3), do: {@lookup[attr], val}
end
