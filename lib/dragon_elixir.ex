defmodule DragonElixir do
  alias DragonElixir.Trainer
  alias DragonElixir.WeatherService

  @communicator Application.get_env(:dragon_elixir, :communicator)

  def gulp do
    with {:ok, game} <- @communicator.ask("/api/game"), {:ok, battlefield} <- Poison.decode game do
      %{"gameId" => day, "knight" => knight} = battlefield

        WeatherService.forecast(day)
          |> Trainer.prepare_dragon(knight)
          |> encounter(battlefield)
    end
  end

  defp encounter({story, dragon}, game) do
    knight = game["knight"]["name"]

    with{:ok, body} <- @communicator.command("/api/game/#{game["gameId"]}/solution", dragon),
        {:ok, %{"status" => status, "message" => message}} <- Poison.decode(body),
    do: {String.to_atom(status), ["#{status}! #{message}", knight] ++ story}
  end
end
