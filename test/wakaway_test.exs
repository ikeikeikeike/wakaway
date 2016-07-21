defmodule WakawayTest do
  use ExUnit.Case
  doctest Wakaway

  alias Wakaway.WeightedChoice
  alias Wakaway.WalkersAliasMethod

  test "Wakaway.WalkersAliasMethod with keyword" do
    count =
      Enum.map(0..100, fn _ ->
        [s100: 100, s200: 200, s50: 50, s3: 3, s2: 2, s1: 1,]
        |> WalkersAliasMethod.resource
        |> WalkersAliasMethod.choice
      end)
      # |> Enum.sort(&(&1 > &2))
      |> Enum.reduce(0, fn(atom, t) ->
        {n, _} =
          Atom.to_string(atom)
          |> String.replace("s", "")
          |> Integer.parse

        if n >= 50, do: t + 1, else: t
      end)

    assert 90 < count
  end

  test "Wakaway.WalkersAliasMethod with map" do
    count =
      Enum.map(0..100, fn _ ->
        %{100 => 100, 200 => 200, 50 => 50, 3 => 3, 2 => 2, 1 => 1}
        |> WalkersAliasMethod.resource
        |> WalkersAliasMethod.choice
      end)
      # |> Enum.sort(&(&1 > &2))
      |> Enum.reduce(0, fn(n, t) ->
        if n >= 50, do: t + 1, else: t
      end)

    assert 90 < count
  end

  test "Wakaway.WalkersAliasMethod key:weight" do
    count =
      Enum.map(0..100, fn _ ->
        WalkersAliasMethod.resource(
          [1, 2, 3, 50, 100, 200],
          [1, 2, 3, 50, 100, 200]
        )
        |> WalkersAliasMethod.choice
      end)
      # |> Enum.sort(&(&1 > &2))
      |> Enum.reduce(0, fn(n, t) ->
        if n >= 50, do: t + 1, else: t
      end)

    assert 90 < count
  end

  test "Wakaway.WeightedChoice with map" do
    count =
      Enum.map(0..100, fn _ ->
        %{
          100 => 100,
          200 => 200,
          50 => 50,
          3 => 3,
          2 => 2,
          1 => 1,
        }
        |> WeightedChoice.resource
        |> WeightedChoice.choice
      end)
      |> Enum.sort(&(&1 > &2))
      |> Enum.reduce(0, fn(n, t) ->
        if n >= 50, do: t + 1, else: t
      end)

    assert 90 < count
  end

  test "Wakaway.WalkersAliasMethod call choice a lot" do
    resource =
      WalkersAliasMethod.resource(
        [1, 2, 3, 50, 100, 200],
        [1, 2, 3, 50, 100, 200]
      )

    count =
      Enum.map(0..100, fn _ ->
        WalkersAliasMethod.choice(resource)
      end)
      # |> Enum.sort(&(&1 > &2))
      |> Enum.reduce(0, fn(n, t) ->
        if n >= 50, do: t + 1, else: t
      end)

    assert 90 < count
  end

  test "Wakaway.WeightedChoice with keyword" do
    count =
      Enum.map(0..100, fn _ ->
        [
          s100: 100,
          s200: 200,
          s50: 50,
          s3: 3,
          s2: 2,
          s1: 1,
        ]
        |> WeightedChoice.resource
        |> WeightedChoice.choice
      end)
      # |> Enum.sort(&(&1 > &2))
      |> Enum.reduce(0, fn(atom, t) ->
        {n, _} =
          Atom.to_string(atom)
          |> String.replace("s", "")
          |> Integer.parse

        if n >= 50, do: t + 1, else: t
      end)

    assert 90 < count
  end

  test "Wakaway.WeightedChoice with key:weight" do
    count =
      Enum.map(0..100, fn _ ->
        WeightedChoice.resource(
          [100, 200, 50, 3, 2, 1],
          [100, 200, 50, 3, 2, 1]
        )
        |> WeightedChoice.choice
      end)
      # |> Enum.sort(&(&1 > &2))
      |> Enum.reduce(0, fn(n, t) ->
        if n >= 50, do: t + 1, else: t
      end)

    assert 90 < count
  end

  test "Wakaway.WeightedChoice call choice a lot" do
    resource =
      WeightedChoice.resource(
        [100, 200, 50, 3, 2, 1],
        [100, 200, 50, 3, 2, 1]
      )

    count =
      Enum.map(0..100, fn _ ->
        WeightedChoice.choice(resource)
      end)
      # |> Enum.sort(&(&1 > &2))
      |> Enum.reduce(0, fn(n, t) ->
        if n >= 50, do: t + 1, else: t
      end)

    assert 90 < count
  end


  test "Wakaway.weighted_choice" do
    count =
      Enum.map(0..100, fn _ ->
        Wakaway.weighted_choice( %{
          100 => 100,
          200 => 200,
          50 => 50,
          3 => 3,
          2 => 2,
          1 => 1,
        })
      end)
      # |> Enum.sort(&(&1 > &2))
      |> Enum.reduce(0, fn(n, t) ->
        if n >= 50, do: t + 1, else: t
      end)

    assert 90 < count
  end

  test "Wakaway.walker_choice" do
    count =
      Enum.map(0..100, fn _ ->
        Wakaway.walker_choice(%{
          100 => 100,
          200 => 200,
          50 => 50,
          3 => 3,
          2 => 2,
          1 => 1,
        })
      end)
      # |> Enum.sort(&(&1 > &2))
      |> Enum.reduce(0, fn(n, t) ->
        if n >= 50, do: t + 1, else: t
      end)

    assert 90 < count
  end
end
