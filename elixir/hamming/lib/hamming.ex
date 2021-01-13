defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) do
    strand1_str = to_string(strand1)
    strand2_str = to_string(strand2)
    if String.length(strand1_str) != String.length(strand2_str) do
      {:error, "Lists must be the same length"}
    else
      distance = Enum.reduce(0..String.length(strand1_str), 0, fn(index, distance) ->
        if (String.at(strand1_str, index)) != (String.at(strand2_str, index)) do
          distance + 1
        else
          distance
        end
      end)
      {:ok, distance || 0}
    end
  end
end
