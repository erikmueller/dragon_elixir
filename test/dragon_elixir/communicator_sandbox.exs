defmodule DragonElixir.Communicator.Sandbox do
  def ask("/valid/game") do
    {:ok, Poison.encode(%{
      gameId: 123,
      knight: %{
        name: "Sir Test of ExUnit"
        armor: 5
        agility: 5
        attack: 5
        endurance: 5
      }
    })}
  end

  def ask("/invalid/game"), do: {:error, "Test Error"}

  def ask("/valid/weather/normal"), do: %{}
  def ask("/valid/weather/rain", do: %{}
  def ask("/valid/weather/dry", do: %{}
  def ask("/valid/weather/storm", do: %{}


  #   case HTTPoison.get(@base_url <> url) do
  #     {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body}
  #     {:ok, %HTTPoison.Response{body: body}} -> {:error, "Got a non-200 reponse: #{body}"}
  #     {:error, _} -> {:error, "Error while asking for #{url}"}
  #   end
  # end

  # def command(url, instructions) do
  #   headers = [{"Content-type", "application/json"}]
  #   {:ok, body} = Poison.encode(instructions)

  #   case HTTPoison.put(@base_url <> url, body, headers) do
  #     {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body}
  #     {:ok, %HTTPoison.Response{body: body}} -> {:error, "Got a non-200 reponse: #{body}"}
  #     {:error, _} -> {:error, "Error while commanding #{url}"}
  #   end
  # end
end
