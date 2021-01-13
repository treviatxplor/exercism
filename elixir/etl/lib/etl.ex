defmodule ETL do
  @doc """
  Transform an index into an inverted index.

  ## Examples

  iex> ETL.transform(%{"a" => ["ABILITY", "AARDVARK"], "b" => ["BALLAST", "BEAUTY"]})
  %{"aardvark" => "a", "ability" => "a", "ballast" => "b", "beauty" => "b"}
  """
  @spec transform(map) :: map
  def transform(input) do
    Enum.reduce(input, %{}, fn({point, words}, result) ->
      Enum.into(transform_words(point, words), result)
    end)
  end

  defp transform_words(point, words) do
    Enum.reduce(words, [], fn(word, result) ->
      result ++ [{String.downcase(word), point}]
    end)
  end
end
