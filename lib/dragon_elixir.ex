defmodule DragonElixir do
  alias DragonElixir.Trainer
  alias DragonElixir.Historian
  alias DragonElixir.WeatherService

  @communicator Application.get_env(:dragon_elixir, :communicator)

  def gulp do
    case assess_battlefield() do
      {:ok, battlefield} ->
        %{"gameId" => day, "knight" => knight} = battlefield

        WeatherService.forecast(day)
          |> Trainer.prepare_dragon(knight)
          |> encounter(battlefield)
      {:error, e} -> {:error, e}
    end
  end

  defp assess_battlefield() do
    case @communicator.ask("/api/game") do
      {:ok, body} -> Poison.decode body
      {:error, e} -> {:error, e}
    end
  end

  defp encounter({story, dragon}, game) do
    knight = game["knight"]["name"]

    case @communicator.command("/api/game/#{game["gameId"]}/solution", dragon) do
      {:ok, body} ->
        {:ok, %{"status" => status, "message" => message}} = Poison.decode body
        {String.to_atom(status), ["#{status}! #{message}", knight] ++ story}
      {:error, e} ->
        {:error, e}
    end
  end
end
