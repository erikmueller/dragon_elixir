defmodule DragonElixir do
  require XML
  require Logger

  @base_url Application.get_env(:dragon_elixir, :base_url)
  @water_dragon %{"scaleThickness" => 5, "clawSharpness" => 10, "wingStrength" => 5, "fireBreath" => 0}
  @zen_dragon %{"scaleThickness" => 5, "clawSharpness" => 5, "wingStrength" => 5, "fireBreath" => 5}

  def gulp do
    case get_game() do
      {:ok, game} ->
        game
          |> prepare_dragon
          |> encounter(game)
      {:error, reason} -> nil
    end
  end

  defp get_game() do
    case HTTPoison.get("#{@base_url}/api/game") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.decode(body)
      {:ok, %HTTPoison.Response{body: body}} ->
        {:error, "Got a non-200 reponse: #{body}"}
      {:error, reason} ->
        {:error, "Error while getting game"}
    end
  end

  defp fetch_weather(gameId) do
    case HTTPoison.get("#{@base_url}/weather/api/report/#{gameId}") do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {xml, _} = body
          |> :binary.bin_to_list
          |> :xmerl_scan.string

        [code_element] = :xmerl_xpath.string('/report/code', xml)
        [code_content] = XML.xmlElement(code_element, :content)

        XML.xmlText(code_content, :value)
      {:ok, %HTTPoison.Response{body: body}} ->
        {:error, "Got a non-200 reponse: #{body}"}
      {:error, reason} ->
        {:error, "Error while fetching the weather, reason: #{reason}"}
    end
  end

  defp prepare_dragon(game) do
    map_knight_to_dragon = %{
      "agility" => "wingStrength",
      "armor" => "clawSharpness",
      "attack" => "scaleThickness",
      "endurance" => "fireBreath"
    }

    %{"knight" => knight, "gameId" => gameId} = game

    sorted_knight_stats = knight
      |> Enum.sort(fn ({_, a}, {_, b}) -> a >= b end)
      # remove the knight's name, he will die anyway
      |> List.delete_at(0)

    dragon = for stat <- 0..3 do
      {attr, val} = sorted_knight_stats |> Enum.at(stat)

      case stat do
        0 -> {map_knight_to_dragon[attr], val + 2}
        1 -> {map_knight_to_dragon[attr], val - 1}
        2 -> {map_knight_to_dragon[attr], val - 1}
        3 -> {map_knight_to_dragon[attr], val}
      end
    end |> Enum.into(%{})

    case fetch_weather(gameId) do
      'NMR' ->
        scribe("It was sunny", gameId, knight["name"], "our finest dragon")
        dragon
      'FUNDEFINEDG' -> dragon
      'HVA' -> @water_dragon
      'T E' -> @zen_dragon
      _ -> %{} # weather does not seem to look good, not sacrificing our dragon
    end
  end

  defp encounter(dragon, game) do
    gameId = game["gameId"]

    headers = [{"Content-type", "application/json"}]
    {:ok, body} = Poison.encode(%{"dragon" => dragon})

    case HTTPoison.put("#{@base_url}/api/game/#{gameId}/solution", body, headers) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        Poison.Parser.parse(body)
      {:ok, %HTTPoison.Response{body: body}} ->
        {:error, "Got a non-200 reponse: #{body}"}
      {:error, reason} ->
        {:error, "Error while putting solution, reason: #{reason}"}
    end
  end

  defp scribe(weather, game, knight, dragon) do
    Logger.debug "+++"
    Logger.info "#{weather} in #{game} when #{knight} set out to free the the beautiful princess."
    Logger.info "However, #{dragon} came to get rid of this tincan-dressed nuisance."
    Logger.info "Let's see how the enounter ends..."
  end
end
