defmodule Game do
  @moduledoc """
  Documentation for ConnectFour.
  """


  def index_in_direction(direction, index) do
    {dc, dr} = direction
    {c, r} = index
    {dc + c, dr + r}
  end

  def check_board_pos(_, _, _, _, 0), do: true
  def check_board_pos(board, index, marker, _, 1) do
    Board.marker_at(board, index) == marker
  end
  def check_board_pos(board, index, marker, direction, steps) do
    if Board.marker_at(board, index) == marker do
      next_index = index_in_direction(direction, index)
      check_board_pos(board, next_index, marker, direction, steps - 1)
    else
      false
    end
  end

  def first_empty_row(board, column) do
    %{rows: rows} = board
    Enum.find(0..rows-1, fn (row) -> Board.is_empty_at?(board, {column, row}) end)
  end

  def default do
    %{board: Board.default, current_marker: :x}
  end

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

  def is_win?(game) do
    %{board: board} = game
    index = Enum.find(
      Board.indicies(board), nil,
      fn index -> win_at_index?(game, index) end)
    # todo: why do we need to check win_at_index? again? There is a bug here.
    if index, do: Board.get(board, index)
  end

  def next_marker(game) do
    %{current_marker: current} = game
    case current do
      :x -> :o
      :o -> :x
      _  -> :BAD
    end
  end

  def make_move(game, column) do
    %{board: board, current_marker: current} = game
    row = first_empty_row(board, column)
    new_board = Board.set(board, {column, row}, current)
    marker = next_marker(game)

    %{game | board: new_board, current_marker: marker}
  end

  def render(game) do
    %{board: board} = game
    Board.render(board)
  end
end
