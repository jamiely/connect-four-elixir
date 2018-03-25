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
    rows = 6
    cols = 7
    indicies = for col <- 1..cols, row <- 1..rows, do: {{col, row}, :empty}
    %{rows: rows, cols: cols, indicies: Map.new(indicies)}
  end

  def isEmpty(board) do
    Enum.all?(Map.values(board[:indicies]), &{&1 == :empty})
  end

  def set(board, index, marker) do
    put_in(board, [:indicies, index], marker)
  end

  def get(board, index) do
    board[:indicies][index]
  end
end
