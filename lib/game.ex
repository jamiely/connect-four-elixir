defmodule Game do
  @moduledoc """
  Documentation for ConnectFour.
  """


  @doc """
  Use to get the adjusted index in the direction relative to the passed index

  ```
  iex> Game.index_in_direction({1, 0}, {0, 0})
  {1, 0}
  ```
  """
  def index_in_direction(direction, index) do
    {dc, dr} = direction
    {c, r} = index
    {dc + c, dr + r}
  end

  @doc """
  Returns true if the board contains a matching marker at the passed index
  and direction, for the passed number of steps. Is used to find adjacent
  indicies with the same marker.
  """
  def check_board_pos(_, _, _, _, 0), do: true
  def check_board_pos(board, index, marker, _, 1) do
    Board.get(board, index) == marker
  end
  def check_board_pos(board, index, marker, direction, steps) do
    if Board.get(board, index) == marker do
      next_index = index_in_direction(direction, index)
      check_board_pos(board, next_index, marker, direction, steps - 1)
    else
      false
    end
  end

  @doc """
  Returns the first empty row in the passed column.

  ## Examples

  ```
  iex> Game.default[:board] |> Game.first_empty_row(0)
  0
  iex> Game.default |> Game.make_move(0)
  ...> |> Map.get(:board) |> Game.first_empty_row(0)
  1
  ```
  """
  def first_empty_row(board, column) do
    %{rows: rows} = board
    Enum.find(0..rows-1, fn (row) -> Board.is_empty_at?(board, {column, row}) end)
  end

  @doc """
  A default game with an empty board

  ## Examples

  ```
  iex> Game.default[:current_marker]
  :x
  ```
  """
  def default do
    %{board: Board.default, current_marker: :x}
  end

  @doc """
  Determines if the marker at the passed index has won the game, by comparing
  adjacent markers in the compass directions.
  """
  def win_at_index?(game, index) do
    %{board: board} = game
    marker = Board.get(board, index)
    cond do
      marker == :empty -> nil
      Enum.find(
        Board.directions,
        fn(dir) -> check_board_pos(board, index, marker, dir, 4) end) ->
        marker
      true -> nil
    end
  end

  @doc """
  Determines if any marker has won.
  """
  def is_win?(game) do
    %{board: board} = game
    index = Enum.find(
      Board.indicies(board), nil,
      fn index -> win_at_index?(game, index) end)
    # todo: why do we need to check win_at_index? again? There is a bug here.
    if index, do: Board.get(board, index)
  end

  @doc """
  Returns the next marker to play, based on the current marker.

  ```
  iex> Game.default |> Game.next_marker
  :o
  iex> Game.default |> Game.make_move(0) |> Game.next_marker
  :x
  ```
  """
  def next_marker(game) do
    %{current_marker: current} = game
    case current do
      :x -> :o
      :o -> :x
      _  -> :BAD
    end
  end

  @doc """
  Makes a move by setting the marker in the first empty row of the column.

  ## Examples

  ```
  iex> Game.default |> Game.make_move(0)
  ...> |> Map.get(:board) |> Board.get({0, 0})
  :x
  ```
  """
  def make_move(game, column) do
    %{board: board, current_marker: current} = game
    row = first_empty_row(board, column)
    new_board = Board.set(board, {column, row}, current)
    marker = next_marker(game)

    %{game | board: new_board, current_marker: marker}
  end

  @doc """
  Renders the game as a string.
  """
  def render(game) do
    %{board: board} = game
    Board.render(board)
  end
end
