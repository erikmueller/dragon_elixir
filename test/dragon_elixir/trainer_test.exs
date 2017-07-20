defmodule DragonElixir.TrainerTest do
  alias DragonElixir.Trainer

  use ExUnit.Case
  doctest DragonElixir.Trainer

  @some_knight %{
    agility: 1,
    armor: 2,
    attack: 7,
    endurance: 10
  }

  test "prepare a dragon for dry weather" do
    assert Trainer.prepare_dragon({[], :dry}, @some_knight) == {
      ["having achieved complete balance our zennest dragon"],
      %{"dragon" => :zen_dragon}
    }
  end
end
