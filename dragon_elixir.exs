require Logger

battles = case System.argv() do
  [count] -> String.to_integer(count)
  [] -> 10
end

battle_results = for battle <- 1..battles do
  case DragonElixir.gulp() do
    {:ok, %{"status" => status, "message" => message}} ->
      Logger.warn "#{status} in battle ##{battle}! #{message}"
      Logger.debug "+++\n"

      status === "Victory"
    {:error, reason} ->
      Logger.error reason

      :unfair
  end
end

# Maybe some were unfair because our dragon-API did not work
valid_battles = Enum.filter(battle_results, &(&1 !== :unfair))
# Get battles that were marked as victorious (`true`)
battles_won = Enum.count(valid_battles, &(&1))

# sum up
ratio = battles_won / Enum.count(valid_battles)

Logger.debug "==="
Logger.info "There were #{Enum.count(valid_battles)} battles of which #{battles_won} were won by our lovely dragons."

statement = case ratio do
  1.0 -> "Disclaimer: No dragons were harmed."
  _ -> "#{ratio * 100}% of battles won! We'll get revenge for the defeated!"
end

Logger.info statement
Logger.debug "===\n"
