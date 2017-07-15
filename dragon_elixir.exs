require Logger

battles = case System.argv() do
  [count] -> String.to_integer(count)
  [] -> 10
end

battle_results = for battle <- 1..battles do
  case DragonElixir.gulp() do
    {:ok, %{"status" => status, "message" => message}} ->
      Logger.warn "#{status}! #{message}"
      Logger.debug "+++\n"

      status === "Victory"
    _ ->
      :unfair
  end
end

# Maybe some were unfair because our dragon-API did not work
valid_battles = Enum.filter(battle_results, &(&1 !== :unfair))
# Get battles that were marked as victorious (`true`)
battles_won = Enum.count(valid_battles, &(&1))

# sum up
Logger.debug "==="
Logger.info "There were #{Enum.count(valid_battles)} battles of which #{battles_won} were won by our lovely dragons."
Logger.info "May the defeated #{(1 - battles_won / Enum.count(valid_battles)) * 100}% rest in Peace"
Logger.debug "===\n"
