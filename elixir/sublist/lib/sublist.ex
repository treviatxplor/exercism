defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, b) do
    cond do
      is_equal?(a, b) -> :equal
      is_empty?(a) -> :sublist
      is_empty?(b) -> :superlist
      is_sublist?(a, b) -> :sublist
      is_sublist?(b, a) -> :superlist
      true -> :unequal
    end
  end

  def is_equal?(a, b) do
    a === b
  end

  def is_empty?(list) do
     Enum.count(list) == 0
  end

  def is_sublist?(a, b) do
    Enum.chunk_every(b, Enum.count(a), 1)
    |> Enum.any?(fn(chunk) -> is_equal?(chunk, a) end)
  end
end