defmodule Wakaway.WeightedChoice do

  def choice({:weight, {resource}}) do
    resource
    |> do_choice(:rand.uniform)
    |> elem(0)
  end

  defp do_choice([h|tail], pick) do
    {key, weight} = {elem(h, 0), elem(h, 1)}

    case pick <= weight do
      true -> {key, weight}
      _    -> do_choice(tail, pick - weight)
    end
  end

  def resource(keys, weights) when is_list(keys) and is_list(weights),
      do: resource(Enum.zip(keys, weights))
  def resource(item) do
    {_, sum} =
      Enum.map_reduce item, 0, fn({_, weight}, t) ->
        {weight, weight + t}
      end

    r =
      Enum.map item, fn {key, weight} ->
        {key, weight / sum}
      end

    {:weight, {r}}
  end

end

