# Wakaway

[![Build Status](http://img.shields.io/travis/ikeikeikeike/wakaway.svg?style=flat-square)](http://travis-ci.org/ikeikeikeike/wakaway)
[![Hex version](https://img.shields.io/hexpm/v/wakaway.svg "Hex version")](https://hex.pm/packages/wakaway)
[![Hex downloads](https://img.shields.io/hexpm/dt/wakaway.svg "Hex downloads")](https://hex.pm/packages/wakaway)
[![Inline docs](https://inch-ci.org/github/ikeikeikeike/wakaway.svg)](http://inch-ci.org/github/ikeikeikeike/wakaway)
[![hex.pm](https://img.shields.io/hexpm/l/ltsv.svg)](https://github.com/ikeikeikeike/wakaway/blob/master/LICENSE)

There're `Walker's Alias Method` and `Weighted Choice` that providing weighted random choice algorism in two ways.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `wakaway` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:wakaway, "~> 0.5.0"}]
    end
    ```

## Usage

#### WalkersAliasMethod

```elixir
alias Wakaway.WalkersAliasMethod

resource =
  WalkersAliasMethod.resource(
    ["k1", "k2", "k3", "k50", "k100", "k200"],
    [1, 2, 3, 50, 100, 200]
  )

# resource =
#   [s100: 100, s200: 200, s50: 50, s3: 3, s2: 2, s1: 1,]
#   |> WalkersAliasMethod.resource

# resource =
#   %{100 => 100, 200 => 200, 50 => 50, 3 => 3, 2 => 2, 1 => 1}
#   |> WalkersAliasMethod.resource

result =
  Enum.map(0..50, fn _ ->
    WalkersAliasMethod.choice(resource)
  end)

IO.inspect result
# ["k50",  "k200", "k200", "k200", "k200", "k50",  "k200", "k200", "k100", "k200", "k200", "k100", "k200", "k100", "k200", "k200",
#  "k200", "k200", "k200", "k200", "k200", "k100", "k200", "k200", "k200", "k50",  "k200", "k200", "k200", "k50",  "k200", "k200",
#  "k200", "k200", "k100", "k100", "k200", "k100", "k200", "k100", "k200", "k100", "k100", "k50",  "k200", "k50",  "k200", "k200",
#  "k200", ...]
```

#### WeightedChoice

```elixir
alias Wakaway.WeightedChoice

resource =
  WeightedChoice.resource(
    ["k1", "k2", "k3", "k50", "k100", "k200"],
    [1, 2, 3, 50, 100, 200]
  )

# resource =
#   [s100: 100, s200: 200, s50: 50, s3: 3, s2: 2, s1: 1,]
#   |> WeightedChoice.resource

# resource =
#   %{100 => 100, 200 => 200, 50 => 50, 3 => 3, 2 => 2, 1 => 1}
#   |> WeightedChoice.resource

result =
  Enum.map(0..50, fn _ ->
    WeightedChoice.choice(resource)
  end)

IO.inspect result
# ["k50",  "k200", "k200", "k200", "k200", "k50",  "k200", "k200", "k100", "k200", "k200", "k100", "k200", "k100", "k200", "k200",
#  "k200", "k200", "k200", "k200", "k200", "k100", "k200", "k200", "k200", "k50",  "k200", "k200", "k200", "k50",  "k200", "k200",
#  "k200", "k200", "k100", "k100", "k200", "k100", "k200", "k100", "k200", "k100", "k100", "k50",  "k200", "k50",  "k200", "k200",
#  "k200", ...]
```

#### Simple ways

###### NOTE: This examples are slower than above way when they are called by users a lot of times.

```elixir
iex(1)> item = %{"k100" => 100, "k200" => 200, "k50" => 50, "k3" => 3, "k2" => 2, "1k" => 1}
%{"k100" => 100, "k200" => 200, "k50" => 50, "k3" => 3, "k2" => 2, "1k" => 1}
iex(2)> Wakaway.walker_choice(item)
"k200"
iex(3)> Wakaway.weighted_choice(item)
"k100"
```

[Example more](https://github.com/ikeikeikeike/wakaway/blob/master/test/wakaway_test.exs)
