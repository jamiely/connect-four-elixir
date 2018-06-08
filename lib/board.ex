defmodule Board do
  @moduledoc """
  Documentation for ConnectFour.
  """

  @doc """
  Returns an empty board with the default columns and rows.

  ## Examples

  ```
  iex> Board.default[:rows]
  6
  iex> Board.default[:cols]
  7
  iex> Board.default[:indicies][{0, 0}]
  :empty
  iex> Board.default |> Board.is_empty?
  true
  ```
  """
  def default do
    rows = 6
    cols = 7
    indicies = for col <- 0..cols-1, row <- 0..rows-1, do: {{col, row}, :empty}
    %{rows: rows, cols: cols, indicies: Map.new(indicies)}
  end

  @doc """
  Returns true if the passed board is empty.

  ## Examples

  ```
  iex> Board.default |> Board.is_empty?
  true
  ```
  """
  def is_empty?(board) do
    Enum.all?(Map.values(board[:indicies]), &{&1 == :empty})
  end

  @doc """
  Returns true if the board is empty at the passed index.

  ## Examples

  ```
  iex> Board.is_empty_at?(Board.default, {0, 0})
  true
  ```
  """
  def is_empty_at?(board, index) do
    get(board, index) == :empty
  end

  @doc """
  Sets the marker at the board index

  ## Examples

  ```
  iex> Board.default |> Board.set({0, 0}, :m) |> Board.is_empty_at?({0, 0})
  false
  ```
  """
  def set(board, index, marker) do
    put_in(board, [:indicies, index], marker)
  end

  @doc """
  Gets the marker at the board index

  ## Examples

  ```
  iex> Board.default |> Board.set({0, 0}, :m) |> Board.get({0, 0}) == :m
  true
  ```
  """
  def get(board, index) do
    board[:indicies][index]
  end

  @doc """
  Retrieves all of the indicies, like `{0, 0}`, of the board as a list.
  """
  def indicies(board) do
    Map.keys(board[:indicies])
  end

  @doc """
  Returns true if there are no empty spots on the board.

  ```
  iex> Board.default |> Board.indicies
  ...> |> Enum.reduce(Board.default,
  ...>                fn(ix, b) -> b |> Board.set(ix, :m) end)
  ...> |> Board.is_full?
  true
  ```
  """
  def is_full?(board) do
    Enum.all?(Map.values(board[:indicies]), &{&1 != :empty})
  end

  @doc """
  Converts the passed symbol into a string for display.
  """
  def marker_str(:x), do: "X"
  def marker_str(:o), do: "O"
  def marker_str(:empty), do: "."
  def marker_str(_), do: "?"

  @doc """
  Renders the board as a string.

  ## Examples

  ```
  iex> Board.default |> Board.set({0, 0}, :x) |> Board.render
  ".......\n.......\n.......\n.......\n.......\nX......"
  ```
  """
  def render(board) do
    %{cols: cols, rows: rows} = board
    render_row = fn(row) ->
      row_parts = for col <- 0..cols-1, do: marker_str(board[:indicies][{col, row}])
      Enum.join(row_parts, "")
    end
    row_strs = for row <- rows-1..0, do: render_row.(row)
    Enum.join(row_strs, "\n")
  end

  @doc """
  Returns a list containing indicies representing compass directions.
  Used to explore a board from a starting position.

  ## Examples

  ```
  iex> Board.directions
  [ {-1, -1}, {-1, 0}, {-1, 1}, {0, -1}, {0, 1}, {1, -1}, {1, 0}, {1, 1} ]
  ```
  """
  def directions do
    r = -1..1
    dirs = for x <- r, y <-r, do: {x, y}
    not_zero = fn
      {0, 0} -> false
      _      -> true
    end
    Enum.filter(dirs, not_zero)
  end
end
