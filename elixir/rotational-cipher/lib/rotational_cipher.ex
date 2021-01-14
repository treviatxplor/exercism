defmodule RotationalCipher do
  @doc """
  Given a plaintext and amount to shift by, return a rotated string.

  Example:
  iex> RotationalCipher.rotate("Attack at dawn", 13)
  "Nggnpx ng qnja"
  """
  @spec rotate(text :: String.t(), shift :: integer) :: String.t()
  def rotate(text, shift) do
    Enum.map(String.to_charlist(text), fn(letter_code_point) ->
      shift_letter(letter_code_point, shift)
    end)
    |> List.to_string
  end

  defp shift_letter(letter_code_point, shift) when letter_code_point in ?a..?z do
    calculate_shifted_letter_codepoint(letter_code_point, shift, ?a, ?z)
  end

  defp shift_letter(letter_code_point, shift) when letter_code_point in ?A..?Z do
    calculate_shifted_letter_codepoint(letter_code_point, shift, ?A, ?Z)
  end

  defp shift_letter(letter_code_point, _), do: letter_code_point

  defp calculate_shifted_letter_codepoint(letter_code_point, shift, lower_boundary, upper_boundary) do
    if letter_code_point + shift > upper_boundary do
      lower_boundary + rem(letter_code_point + shift - upper_boundary, 26) - 1
    else
      letter_code_point + shift
    end
  end
end
