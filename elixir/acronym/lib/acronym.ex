defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    String.replace(string, ~r{[,\_\-]}, "")
    |> String.split
    |> Enum.reduce("", fn(word, acronym) ->
      [first_letter | rest_of_the_word] = String.codepoints(word)
      acronym = acronym <> String.upcase(first_letter)
      if String.upcase(word) != word do
        acronym <> extract_acronym_from_rest_of_word(rest_of_the_word)
      else
        acronym
      end
    end)
  end

  defp extract_acronym_from_rest_of_word(rest_of_the_word) do
    Enum.reduce(rest_of_the_word, "", fn(letter, acronym) ->
      if String.match?(letter, ~r/^[[:upper:]]+$/), do: acronym <> letter, else: acronym
    end)
  end
end
