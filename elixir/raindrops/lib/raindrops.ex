defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @factor_to_string %{3 => "Pling", 5 => "Plang", 7 => "Plong"}

  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    Enum.reduce(@factor_to_string, "", fn({factor, raindrop}, raindrops) ->
      if is_factor?(number, factor) do
        raindrops <> raindrop
      else
        raindrops
      end
    end)
    |> output_raindrops(number)
  end

  defp output_raindrops("", number), do: "#{number}"

  defp output_raindrops(raindrops, _), do: raindrops

  defp is_factor?(number, factor), do: rem(number, factor) == 0
end
