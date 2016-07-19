defmodule WakawayTest do
  use ExUnit.Case
  doctest Wakaway

  test "Wakaway.walkers_alias_method" do
    Enum.map(0..100, fn _ -> Wakaway.walkers_alias_method([1, 2, 3, 50, 100, 200], [1, 2, 3, 50, 100, 200]) end)
  end

  test "Wakaway.weighted_choice with map" do
    count =
      Enum.map(0..100, fn _ ->
        Wakaway.weighted_choice(%{
          100 => 100,
          200 => 200,
          50 => 50,
          3 => 3,
          2 => 2,
          1 => 1,
        })
      end)
      |> Enum.sort(&(&1 > &2))
      |> Enum.reduce(0, fn(n, t) ->
        if n >= 50, do: t + 1, else: t
      end)

    assert 90 < count
  end

  test "Wakaway.weighted_choice with keyword" do
    count =
      Enum.map(0..100, fn _ ->
        Wakaway.weighted_choice([
          s100: 100,
          s200: 200,
          s50: 50,
          s3: 3,
          s2: 2,
          s1: 1,
        ])
      end)
      |> Enum.sort(&(&1 > &2))
      |> Enum.reduce(0, fn(atom, t) ->
        {n, _} =
          Atom.to_string(atom)
          |> String.replace("s", "")
          |> Integer.parse

        if n >= 50, do: t + 1, else: t
      end)

    assert 90 < count
  end

  test "Wakaway.weighted_choice with list" do
    count =
      Enum.map(0..100, fn _ ->
        Wakaway.weighted_choice(
          [100, 200, 50, 3, 2, 1],
          [100, 200, 50, 3, 2, 1]
        )
      end)
      |> Enum.sort(&(&1 > &2))
      |> Enum.reduce(0, fn(n, t) ->
        if n >= 50, do: t + 1, else: t
      end)

    assert 90 < count
  end

end
