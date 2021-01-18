defmodule RunLengthEncoder do
  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  @spec encode(String.t()) :: String.t()
  def encode(string) do
    String.codepoints(string)
    |> Enum.reduce([], fn(letter, letter_buckets) ->
      cond do
        when_encounter_new_letter?(letter, letter_buckets) -> add_new_letter_to_buckets(letter, letter_buckets)
        true -> increase_letter_count(letter_buckets)
      end
    end)
    |> Enum.reduce("", fn(letter_bucket, encoded_string) ->
      {letter, count} = letter_bucket
      encoded_string <> if count > 1, do: "#{count}#{letter}", else: letter
    end)
  end

  defp when_encounter_new_letter?(letter, letter_buckets) do
    length(letter_buckets) == 0 || elem(List.last(letter_buckets), 0) != letter
  end

  defp add_new_letter_to_buckets(letter, letter_buckets) do
    letter_buckets ++ [{letter, 1}]
  end

  defp increase_letter_count(letter_buckets) do
    {letter, count} = List.last(letter_buckets)
    List.replace_at(letter_buckets, length(letter_buckets) - 1, {letter, count + 1})
  end

  @spec decode(String.t()) :: String.t()
  def decode(string) do
    String.codepoints(string)
    |> Enum.reduce({"",""}, fn(letter, decoded_string_tuple) ->
         cond do
           when_encounter_digit?(letter) -> append_digit(letter, decoded_string_tuple)
           true -> decode_letter(letter, decoded_string_tuple)
         end
    end)
    |> elem(1)
  end

  defp when_encounter_digit?(letter) do
    String.match?(letter, ~r/^[[:digit:]]+$/)
  end

  defp append_digit(digit, decoded_string_tuple) do
    {digit_string, decoded_string} = decoded_string_tuple
    {digit_string <> digit, decoded_string}
  end

  defp decode_letter(letter, decoded_string_tuple) do
    {digit_string, decoded_string} = decoded_string_tuple
    {"", decoded_string <> generate_decoded_string_from_letter(digit_string, letter)}
  end

  defp generate_decoded_string_from_letter(digit_string, letter) do
    cond do
      String.length(digit_string) > 0 -> String.duplicate(letter, String.to_integer(digit_string))
      true -> letter
    end
  end
end
