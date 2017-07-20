require Logger

alias DragonElixir.Historian

battles = case System.argv() do
  [count] -> String.to_integer(count)
  [] -> 10
end

battle_results = for _ <- 1..battles do
  case DragonElixir.gulp() do
    {:error, reason} ->
      Logger.error reason

      :unfair
    {status, story} ->
      Historian.write_down Enum.reverse(story)

      status === :Victory
  end
end

# Battles with our dragon-API not working don't count
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
