defmodule Wakaway.WalkersAliasMethod do

  def choice({:walker, {keys, prob, inx, len} = _resource}) do
    j = round(Float.floor(:rand.uniform * len))
    case :rand.uniform <= Enum.at(prob, j) do
      true  ->
        Enum.at keys, j
      false ->
        Enum.at keys, Enum.at(inx, j)
    end
  end

  def resource(item) do
    items =
      Enum.reduce item, {[], []}, fn({key, weight}, {tk, tw}) ->
        {tk ++ [key], tw ++ [weight]}
      end

    resource elem(items, 0), elem(items, 1)
  end
  def resource(keys, weights) do
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

    {inx, prob} = calc_resource(short, long, inx, prob)

    {:walker, {keys, prob, inx, len}}
  end

  defp calc_resource([], _long, inx, prob), do: {inx, prob}
  defp calc_resource(_short, [], inx, prob), do: {inx, prob}
  defp calc_resource(short, long, inx, prob) do
    {sval, lval} = {List.last(short), List.last(long)}

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

    calc_resource(short, long, inx, prob)
  end

end
