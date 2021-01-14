defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(pos_integer) :: String.t()
  def numeral(number) do
    thousands = thousands(div(number, 1000))
    hundreds = hundreds(div(rem(number, 1000), 100))
    tens = tens(div(rem(number, 100), 10))
    ones = ones(rem(number, 10))
    "#{thousands}#{hundreds}#{tens}#{ones}"
  end

  defp thousands(times), do: String.duplicate("M", times)

  defp hundreds(9), do: "C#{thousands(1)}"

  defp hundreds(5), do: "D"

  defp hundreds(4), do: "C#{hundreds(5)}"

  defp hundreds(times) do
    five_hundreds = if div(times, 5) > 0, do: hundreds(5), else: ""
    "#{five_hundreds}#{String.duplicate("C", rem(times, 5))}"
  end

  defp tens(9), do: "X#{hundreds(1)}"

  defp tens(5), do: "L"

  defp tens(4), do: "X#{tens(5)}"

  defp tens(times) do
    five_tens = if div(times, 5) > 0, do: tens(5), else: ""
    "#{five_tens}#{String.duplicate("X", rem(times, 5))}"
  end

  defp ones(9), do: "I#{tens(1)}"

  defp ones(5), do: "V"

  defp ones(4), do: "I#{ones(5)}"

  defp ones(times) do
    five_ones = if div(times, 5) > 0, do: ones(5), else: ""
    "#{five_ones}#{String.duplicate("I", rem(times, 5))}"
  end
end
