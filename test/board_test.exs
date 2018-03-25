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

  test "should have 6 * 7 indices" do
    board = Board.defaultBoard
    assert map_size(board[:indicies]) == 42
  end

  test "should be able to change markers at indicies" do
    board = Board.defaultBoard
    board = Board.set(board, {1,1}, :x)
    assert Board.get(board, {1,1}) == :x
  end

end
