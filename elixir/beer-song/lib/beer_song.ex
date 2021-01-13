defmodule BeerSong do
  @doc """
  Get a single verse of the beer song
  """
  @spec verse(integer) :: String.t()
  def verse(number) do
    """
    #{String.capitalize(number_of_bottles(number))} of beer on the wall, #{number_of_bottles(number)} of beer.
    #{second_line(number)}
    """
  end

  @doc """
  Get the entire beer song for a given range of numbers of bottles.
  """
  @spec lyrics(Range.t()) :: String.t()
  def lyrics(range) do
    Enum.reduce(range, [], fn(number, lyrics) ->
      lyrics ++ [verse(number)]
    end)
    |> Enum.join("\n")
  end

  def lyrics() do
    lyrics(99..0)
  end

  defp second_line(0) do
    "Go to the store and buy some more, #{number_of_bottles(99)} of beer on the wall."
  end

  defp second_line(number) do
    "Take #{taken_number_of_bottles(number)} down and pass it around, #{number_of_bottles(number - 1)} of beer on the wall."
  end

  defp taken_number_of_bottles(1), do: "it"

  defp taken_number_of_bottles(number), do: "one"

  defp number_of_bottles(0), do: "no more bottles"

  defp number_of_bottles(1), do: "1 bottle"

  defp number_of_bottles(number), do: "#{number} bottles"
end
