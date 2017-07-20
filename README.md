# DragonElixir

# 👸🏰🤺🔥🐉
> Solving problems in the kingdom of Mugloar, with Elixir

## Running

Well, drinking to be more precise.

You need some [prerequisites](https://elixir-lang.org/install.html) before you can start `mix`ing your elixir.

Afterwards, the easiest way is to simply

```elixir
  mix run dragon_elixir.exs
```
This will take you into a world of 10 rounds of epic knight VS. Dragon fighting.
To stay little longer, just specify the number of rounds with

```elixir
  mix run dragon_elixir.exs 20
```

## But what does it actually do

So there is this [kingdom](http://www.dragonsofmugloar.com/), right. With the princess. And every now and then a knight comes to look for the wench and take her (for whatever purpose). That's what we have dragons for.

But you can't just take each and every dragon and throw him at the charging lad. We have to choose wisely. Moreover the weather is sometimes kind of nasty so it was recommended to check the weather forecast once in a while. This would of course be way too much effort to do alone. So we have some helpers with awesome tech to support our daily knight-killing.

### It goes like this

First, we `assess` the `battlfield`: Which year is it? Who's the knight? _Edward_, the dragon `trainer`, has an awesome device called the `Communicator` with which he can contact the `WeatherService` and `ask` for the `forecast`. Sadly the responses are pretty scribbled so we need an `AcientLookingGlass` to make some sense out of them.
Once this is done we have a look at the Sir knight coming on his dead horse. Just then can we pick a fine dragon, `train` it and `prepare` it for an epic `encounter` on the `battlefield`. Once all preparations are complete _Edward_ issues `commands` for the battle strategy and off the dragon goes.

### Clean up

After all battles are fought we check what's left. Most of the time it should be our dragon and some pieces of the knight.

## Lookout

Currently we have a dragon `testing` ground under construction to rip appart tin cans even better. You can run

```elixir
mix test
```

to see what we acomplished so far.
Stay tuned.
