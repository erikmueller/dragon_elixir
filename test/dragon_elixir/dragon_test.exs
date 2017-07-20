defmodule DragonElixir.DragonTest do
  alias DragonElixir.Dragon

  use ExUnit.Case
  doctest DragonElixir.Dragon

  test "spawning a zen dragon" do
    assert %Dragon{
      wingStrength: 5,
      clawSharpness: 5,
      scaleThickness: 5,
      fireBreath: 5
    } == Dragon.spawn(:zen_dragon)
  end

  test "spawning a water dragon" do
    assert %Dragon{
      wingStrength: 5,
      clawSharpness: 10,
      scaleThickness: 5,
      fireBreath: 0
    } == Dragon.spawn(:water_dragon)
  end

  test "spawning a fog dragon" do
    assert %Dragon{
      wingStrength: 0,
      clawSharpness: 10,
      scaleThickness: 0,
      fireBreath: 10
    } == Dragon.spawn(:fog_dragon)
  end

  test "spawning a matching dragon" do
    assert %Dragon{
      wingStrength: 1,
      clawSharpness: 2,
      scaleThickness: 7,
      fireBreath: 10
    } == Dragon.spawn([
      {"wingStrength", 1},
      {"clawSharpness", 2},
      {"scaleThickness", 7},
      {"fireBreath", 10}
    ])
  end
end
