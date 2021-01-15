defmodule Bob do
  def hey(input) do
    trimmed_input = String.trim(input)

    cond do
      when_not_saying_anything?(trimmed_input) -> "Fine. Be that way!"
      when_shouting_question?(trimmed_input) -> "Calm down, I know what I'm doing!"
      when_shouting?(trimmed_input) -> "Whoa, chill out!"
      when_asking_question?(trimmed_input) -> "Sure."
      true -> "Whatever."
    end
  end

  defp when_not_saying_anything?(input) do
    String.length(input) == 0
  end

  defp when_shouting?(input) do
    String.upcase(input) == input && String.downcase(input) != input
  end

  defp when_asking_question?(input) do
    String.ends_with?(input, "?")
  end

  defp when_shouting_question?(input) do
    when_shouting?(input) && when_asking_question?(input)
  end
end