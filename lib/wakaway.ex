defmodule Wakaway do

  # defdelegate walker_choice(%{} = item), to: __MODULE__, as: :walkers_alias_method
  # defdelegate walker_choice(keys, weights), to: __MODULE__, as: :walkers_alias_method
  # def walkers_alias_method(%{} = item), do: nil
  # def walkers_alias_method(item) do
  def walkers_alias_method(keys, weights) do
    len = length weights
    sumw = Enum.reduce weights, 0.0, fn n, t ->
      n + t
    end

    {inx, prob} =
      Enum.reduce weights, {[], []}, fn(w, {inx, prob}) ->
        {inx ++ [-1], prob ++ [w * len / sumw]}
      end

    {short, long} =
      Enum.with_index(prob)
      |> Enum.reduce({[], []}, fn({p, index}, {short, long})  ->
        if p < 1, do: short = short ++ [index]
        if p > 1, do: long  = long  ++ [index]

        {short, long}
      end)

    {inx, prob} = walkercalc(short, long, inx, prob)

    j = round(Float.floor(:rand.uniform * len))
    case :rand.uniform <= Enum.at(prob, j) do
      true  ->
        Enum.at keys, j
      false ->
        Enum.at keys, Enum.at(inx, j)
    end
  end

  defp walkercalc([], _long, inx, prob), do: {inx, prob}
  defp walkercalc(_short, [], inx, prob), do: {inx, prob}
  defp walkercalc(short, long, inx, prob) do
      sval = List.last(short)
      lval = List.last(long)

      inx = List.replace_at(inx, sval, lval)
      prob = List.update_at prob, lval, fn value ->
        value - (1 - Enum.at(prob, sval))
      end

      short = List.delete_at short, -1

      {short, long} =
        case Enum.at(prob, lval) < 1 do
          true ->
            {short ++ [lval], List.delete_at( long, -1)}
          false ->
            {short, long}
        end

      walkercalc(short, long, inx, prob)
  end

  # def random(item) do
    # {keys, prob, len} = item

    # j = round(Float.floor(:rand.uniform * len))
    # case :rand.uniform <= prob[j] do
      # true  -> keys[j]
      # false -> keys[inx[j]]
    # end
  # end

  def weighted_choice(keys, weights) when is_list(keys) and is_list(weights),
      do: weighted_choice(Enum.zip(keys, weights))
  def weighted_choice(item) do
    {_, sum} =
      Enum.map_reduce item, 0, fn({_, weight}, t) ->
        {weight, weight + t}
      end

    Enum.map(item, fn {key, weight} ->
      {key, weight / sum}
    end)
    |> do_weighted_choice(:rand.uniform)
    |> elem(0)
  end

  defp do_weighted_choice([h|tail], pick) do
    {key, weight} = {elem(h, 0), elem(h, 1)}

    case pick <= weight do
      true -> {key, weight}
      _    -> do_weighted_choice(tail, pick - weight)
    end
  end

end
