defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @match_opening_brackets %{")" => "(", "}" => "{", "]" => "["}

  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    result = String.codepoints(str)
    |> Enum.reduce_while({true, []}, fn(letter, acc) ->
         cond do
           is_opening_bracket?(letter) -> encounter_opening_bracket(letter, elem(acc, 1))
           is_closing_bracket?(letter) -> encounter_closing_bracket(letter, elem(acc, 1))
           true -> {:cont, {true, elem(acc, 1)}}
         end
       end)

    if elem(result, 0) == true, do: length(elem(result, 1)) == 0, else: false
  end

  defp is_opening_bracket?(letter) do
    letter in ["[", "{", "("]
  end

  defp is_closing_bracket?(letter) do
    letter in ["]", "}", ")"]
  end

  defp encounter_opening_bracket(opening_bracket, bracket_stacks) do
    {:cont, {true, bracket_stacks ++ [opening_bracket]}}
  end

  defp encounter_closing_bracket(closing_bracket, bracket_stacks) do
    if has_match_opening_brackets?(closing_bracket, bracket_stacks) do
      {:cont, {true, List.delete_at(bracket_stacks, length(bracket_stacks) - 1)}}
    else
      {:halt, {false, bracket_stacks}}
    end
  end

  defp has_match_opening_brackets?(closing_bracket, bracket_stacks) do
    List.last(bracket_stacks) == @match_opening_brackets[closing_bracket]
  end
end
