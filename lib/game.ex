defmodule Game do
  @moduledoc """
  Documentation for ConnectFour.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ConnectFour.hello
      :world

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
end
