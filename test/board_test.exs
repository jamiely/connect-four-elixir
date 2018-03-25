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
    assert Board.is_empty(board)
  end

  test "should have 6 * 7 indicies" do
    board = Board.defaultBoard
    assert map_size(board[:indicies]) == 42
  end

  test "should be able to change markers at indicies" do
    board = Board.defaultBoard
    board = Board.set(board, {1,1}, :x)
    assert Board.get(board, {1,1}) == :x
  end
  
  test "it should know when there are no empty spaces" do
    defaultBoard = Board.defaultBoard
    board = Enum.reduce(defaultBoard.indicies(), defaultBoard,
      fn(index, board) -> Board.set(board, index, :x) end)
    assert Board.is_full(board)
  end

  test "marker str" do
    assert Board.marker_str(:x) == "X"
  end

  test "it should render a board 1" do
    indicies = for col <- 0..4, do: {col, 0}
    board = Enum.reduce(
      indicies,
      Board.defaultBoard,
      fn(index, board) -> Board.set(board, index, :x) end)
    assert Board.render(board) == ".......\n.......\n.......\n.......\n.......\nXXXXX.."
  end

  test "it should render a board 2" do
    indicies = for row <- 0..4, do: {0, row}
    board = Enum.reduce(
      indicies,
      Board.defaultBoard,
      fn(index, board) -> Board.set(board, index, :o) end)
    assert Board.render(board) == ".......\nO......\nO......\nO......\nO......\nO......"
  end
end
