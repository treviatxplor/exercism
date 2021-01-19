defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new(), do: {nil, nil}

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem), do: {elem, list}

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length({nil, nil}), do: 0
  def length({_, tail}), do: 1 + LinkedList.length(tail)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({nil, _}), do: true
  def empty?(_), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({nil, _}), do: {:error, :empty_list}
  def peek({head, _}), do: {:ok, head}

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({_, nil}), do: {:error, :empty_list}
  def tail({_, tail}), do: {:ok, tail}

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({nil, _}), do: {:error, :empty_list}
  def pop({head, tail}), do: {:ok, head, tail}

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    Enum.reverse(list)
    |> Enum.reduce(LinkedList.new(), fn(value, linked_list) ->
         LinkedList.push(linked_list, value)
       end)
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list({nil, _}), do: []
  def to_list({head, tail}), do: [head] ++ to_list(tail)

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    to_list(list)
    |> Enum.reverse
    |> from_list
  end
end
