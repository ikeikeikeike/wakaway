defmodule Wakaway do

  alias Wakaway.WalkersAliasMethod
  alias Wakaway.WeightedChoice

  def walker_choice(item) do
    item
    |> WalkersAliasMethod.resource
    |> WalkersAliasMethod.choice
  end

  def weighted_choice(item) do
    item
    |> WeightedChoice.resource
    |> WeightedChoice.choice
  end

end
