defmodule GameTest do
  use ExUnit.Case
  doctest Game

  test "returns true when check_board_pos is called with 0 steps" do
    assert Game.check_board_pos(nil, nil, nil, nil, 0)
  end
  test "returns true when check_board_pos is called with 1 steps" do
    board = Board.default |>
      Board.set({1, 1}, :x)
    assert Game.check_board_pos(board, {1, 1}, :x, {1, 1}, 1)
  end
  test "returns true when check_board_pos is called with 2 steps and goes in right direction" do
    board = Board.default |>
      Board.set({1,1}, :x) |>
      Board.set({1,2}, :x)
    assert Game.check_board_pos(board, {1, 1}, :x, {0, 1}, 2)
  end
  test "returns false when check_board_pos is called with 2 steps and goes in wrong direction" do
    board = Board.default |>
      Board.set({1,1}, :x) |>
      Board.set({1,2}, :x)
    assert ! Game.check_board_pos(board, {1, 1}, :x, {0, -1}, 2)
  end
  test "can get index in direction" do
    assert Game.index_in_direction({1,1}, {0, 0}) == {1,1}
    assert Game.index_in_direction({1,1}, {1, 0}) == {2,1}
  end
end
