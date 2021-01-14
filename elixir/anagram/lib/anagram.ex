defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    for candidate <- candidates, is_anagram?(String.downcase(base), String.downcase(candidate)), do: candidate
  end

  defp is_anagram?(base, candidate) do
    is_not_equal?(base, candidate) &&
      use_all_letters?(base, candidate)
  end

  defp is_not_equal?(base, candidate) do
    base != candidate
  end

  defp use_all_letters?(base, candidate) do
    Enum.sort(String.codepoints(base)) == Enum.sort(String.codepoints(candidate))
  end
end
