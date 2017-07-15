defmodule DragonElixir.Dragon do
  defstruct wingStrength: 0, clawSharpness: 0, scaleThickness: 0, fireBreath: 0

  def spawn(:zen_dragon), do: DragonElixir.Dragon.spawn([
    {"wingStrength", 5},
    {"clawSharpness", 5},
    {"scaleThickness", 5},
    {"fireBreath", 5}
  ])

  def spawn(:water_dragon), do: DragonElixir.Dragon.spawn([
    {"wingStrength", 5},
    {"clawSharpness", 10},
    {"scaleThickness", 5},
    {"fireBreath", 0}
  ])

  def spawn(:fog_dragon), do: DragonElixir.Dragon.spawn([
    {"wingStrength", 0},
    {"clawSharpness", 10},
    {"scaleThickness", 0},
    {"fireBreath", 10}
  ])

  def spawn(stats) when is_list(stats) do
    # we need atom keys for contructing our dragon (`struct`)
    atomic_stats = for {k, v} <- stats, into: %{}, do: {String.to_atom(k), v}
    struct DragonElixir.Dragon, atomic_stats
  end
end
