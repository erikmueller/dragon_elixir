defmodule DragonElixir.WeatherService do
  require Helpers.AncientLookingGlass

  alias DragonElixir.Communicator

  def forecast(gameId) do
    case Communicator.ask("/weather/api/report/#{gameId}") do
      {:ok, body} ->
        {xml, _} = body |> :binary.bin_to_list |> :xmerl_scan.string
        [code_element] = :xmerl_xpath.string('/report/code', xml)
        [code_content] = Helpers.AncientLookingGlass.xmlElement(code_element, :content)

        Helpers.AncientLookingGlass.xmlText(code_content, :value)
      {:error, e} ->
        {:error, e}
    end
  end
end
