defmodule PigLatin do
  @doc """
  Given a `phrase`, translate it a word at a time to Pig Latin.

  Words beginning with consonants should have the consonant moved to the end of
  the word, followed by "ay".

  Words beginning with vowels (aeiou) should have "ay" added to the end of the
  word.

  Some groups of letters are treated like consonants, including "ch", "qu",
  "squ", "th", "thr", and "sch".

  Some groups are treated like vowels, including "yt" and "xr".
  """
  @vowels ["a", "e", "i", "o", "u"]

  @spec translate(phrase :: String.t()) :: String.t()
  def translate(phrase) do
    String.split(phrase)
    |> Enum.map(fn(word) ->
        cond do
          starts_with_vowel?(String.at(word, 0), String.at(word, 1)) -> convert_phrase_starts_with_vowel_to_pig_latin(word)
          true -> convert_phrase_starts_with_consonants_to_pig_latin(word)
        end
    end)
    |> Enum.join(" ")
  end

  defp starts_with_vowel?("x", second_letter) when second_letter not in @vowels do
    true
  end

  defp starts_with_vowel?("y", second_letter) when second_letter not in @vowels do
    true
  end

  defp starts_with_vowel?(first_letter, _) do
    first_letter in @vowels
  end

  defp convert_phrase_starts_with_vowel_to_pig_latin(phrase) do
    "#{phrase}ay"
  end

  defp convert_phrase_starts_with_consonants_to_pig_latin(phrase) do
    last_consonant_pos = String.codepoints(phrase)
    |> Enum.reduce_while(0, fn(letter, last_consonant_index) ->
         if letter in @vowels, do: {:halt, last_consonant_index}, else: {:cont, last_consonant_index + 1}
       end)
    |> (&adjust_last_consonant_pos(&1, String.at(phrase, &1 - 1), String.at(phrase, &1))).()

    {consonants, rest_of_phrase}= String.split_at(phrase, last_consonant_pos)
    "#{rest_of_phrase}#{consonants}ay"
  end

  defp adjust_last_consonant_pos(last_consonant_pos, "q", "u") do
    last_consonant_pos + 1
  end

  defp adjust_last_consonant_pos(last_consonant_pos, _, _) do
    last_consonant_pos
  end
end
