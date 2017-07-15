defmodule DragonElixir do
  alias DragonElixir.Communicator
  alias DragonElixir.Trainer

  def gulp do
    case assess_battlefield() do
      {:ok, battlefield} -> battlefield |> Trainer.prepare_dragon |> encounter(battlefield)
      {:error, e} -> {:error, e}
    end
  end

  defp assess_battlefield() do
    case Communicator.ask("/api/game") do
      {:ok, body} -> Poison.decode body
      {:error, e} -> {:error, e}
    end
  end

  defp encounter(dragon, game) do
    case Communicator.command("/api/game/#{game["gameId"]}/solution", dragon) do
      {:ok, body} -> Poison.decode body
      {:error, e} -> {:error, e}
    end
  end
end
