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

  def default do
    rows = 6
    cols = 7
    indicies = for col <- 0..cols-1, row <- 0..rows-1, do: {{col, row}, :empty}
    %{rows: rows, cols: cols, indicies: Map.new(indicies)}
  end

  def is_empty(board) do
    Enum.all?(Map.values(board[:indicies]), &{&1 == :empty})
  end

  def is_empty_at(board, index) do
    get(board, index) == :empty
  end

  def set(board, index, marker) do
    put_in(board, [:indicies, index], marker)
  end

  def get(board, index) do
    board[:indicies][index]
  end

  def indicies(board) do
    Map.keys(board[:indicies])
  end

  def is_full(board) do
    Enum.all?(Map.values(board[:indicies]), &{&1 != :empty})
  end

  def marker_str(:x), do: "X"
  def marker_str(:o), do: "O"
  def marker_str(:empty), do: "."
  def marker_str(_), do: "?"

  def render(board) do
    %{cols: cols, rows: rows} = board
    render_row = fn(row) ->
      row_parts = for col <- 0..cols-1, do: marker_str(board[:indicies][{col, row}])
      Enum.join(row_parts, "")
    end
    row_strs = for row <- rows-1..0, do: render_row.(row)
    Enum.join(row_strs, "\n")
  end

  def marker_at(board, index) do
    board[:indicies][index]
  end

  def directions() do
    r = -1..1
    directions = for x <- r, y <-r, do: {x, y}
    not_zero = fn
      {0, 0} -> false
      _      -> true
    end
    Enum.filter(directions, not_zero)
  end
end
