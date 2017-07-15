require Logger

defmodule DragonElixir.Historian do
  def write_down([weather, dragon, knight, encounter]) do
    IO.puts "\n"
    Logger.info "#{weather} when #{knight} set out to free the the beautiful princess."
    Logger.info "However, #{dragon} came to get rid of this tincan-dressed nuisance."
    Logger.info "#{encounter}"
  end
end
