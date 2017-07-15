defmodule DragonElixir.WeatherService do
  require Helpers.AncientLookingGlass

  @communicator Application.get_env(:dragon_elixir, :communicator)

  def forecast(gameId) do
    case @communicator.ask("/weather/api/report/#{gameId}") do
      {:ok, body} ->
        {xml, _} = body |> :binary.bin_to_list |> :xmerl_scan.string
        [code_element] = :xmerl_xpath.string('/report/code', xml)
        [code_content] = Helpers.AncientLookingGlass.xmlElement(code_element, :content)

        case Helpers.AncientLookingGlass.xmlText(code_content, :value) do
          'NMR' -> {["It was sunny at #{gameId}"], nil}
          'FUNDEFINEDG' -> {["The fog was hanging low"], :fog}
          'HVA' -> {["The rain poured down, drowning lots of knights"], :rain}
          'T E' -> {["There was this megadrought"], :dry}
          _ -> {["We could not reach the weather service (broken communicator or helluva storm)"], :storm_or_unknown}
        end
      {:error, e} ->
        {:error, e}
    end
  end
end
