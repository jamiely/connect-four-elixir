defmodule Board do
  @moduledoc """
  Documentation for ConnectFour.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ConnectFour.hello
      :world

  """
  def hello do
    :world
  end

  def defaultBoard do
    %{rows: 6, cols: 7, indicies: %{}}
  end

  def isEmpty(board) do
    Enum.all?(Map.values(board[:indicies]), &{&1 == :empty})
  end
end
