defmodule DragonElixir.Communicator do
  use HTTPoison.Base

  @base_url Application.get_env(:dragon_elixir, :base_url)

  def ask(url) do
    case HTTPoison.get(@base_url <> url) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %HTTPoison.Response{body: body}} -> {:error, "Got a non-200 reponse: #{body}"}
      {:error, _} -> {:error, "Error while asking for #{url}"}
    end
  end

  def command(url, instructions) do
    headers = [{"Content-type", "application/json"}]
    {:ok, body} = Poison.encode(instructions)

    case HTTPoison.put(@base_url <> url, body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} -> {:ok, body}
      {:ok, %HTTPoison.Response{body: body}} -> {:error, "Got a non-200 reponse: #{body}"}
      {:error, _} -> {:error, "Error while commanding #{url}"}
    end
  end
end
