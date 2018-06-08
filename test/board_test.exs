defmodule BoardTest do
  use ExUnit.Case
  doctest Board

  test "has 6 rows and 7 cols by default" do
    board = Board.default
    assert board[:rows] == 6
    assert board[:cols] == 7
  end

  test "should have 6 * 7 indicies" do
    board = Board.default
    assert map_size(board[:indicies]) == 42
  end

  test "should be able to change markers at indicies" do
    board = Board.default
    board = Board.set(board, {1,1}, :x)
    assert Board.get(board, {1,1}) == :x
  end
  
  test "it should know when there are no empty spaces" do
    default = Board.default
    board = Enum.reduce(default.indicies(), default,
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
      Board.default,
      fn(index, board) -> Board.set(board, index, :x) end)
    assert Board.render(board) == ".......\n.......\n.......\n.......\n.......\nXXXXX.."
  end

  test "it should render a board 2" do
    indicies = for row <- 0..4, do: {0, row}
    board = Enum.reduce(
      indicies,
      Board.default,
      fn(index, board) -> Board.set(board, index, :o) end)
    assert Board.render(board) == ".......\nO......\nO......\nO......\nO......\nO......"
  end

  test "it should have 8 directions" do
    assert length(Board.directions()) == 8
  end

  test "it should test emptiness of particular index" do
    default = Board.default
    assert Board.is_empty_at?(default, {1,1})

    board = Board.set(default, {1,1}, :x)
    assert ! Board.is_empty_at?(board, {1,1})
  end
end
