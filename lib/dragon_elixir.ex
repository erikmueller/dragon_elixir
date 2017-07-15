defmodule DragonElixir do
  alias DragonElixir.Communicator
  alias DragonElixir.Trainer

  def gulp do
    case get_game() do
      {:ok, game} -> game |> Trainer.prepare_dragon |> encounter(game)
      {:error, e} -> {:error, e}
    end
  end

  defp get_game() do
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
