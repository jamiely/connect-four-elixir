defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  test "has 6 rows and 7 cols by default" do
    board = Board.defaultBoard
    assert board[:rows] == 6
    assert board[:cols] == 7
  end

  test "is empty" do
    board = Board.defaultBoard
    assert Board.isEmpty(board)
  end
end
