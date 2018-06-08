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

  test "gets first empty row" do
    b1 = Board.default
    assert Game.first_empty_row(b1, 0) == 0

    b2 = Board.set(b1, {0, 0}, :x)
    assert Game.first_empty_row(b2, 0) == 1

    b3 = Board.set(b2, {0, 1}, :x)
    assert Game.first_empty_row(b3, 0) == 2
  end

  test "can make move" do
    game = Game.default |>
      Game.make_move(0) |>
      Game.make_move(0) |>
      Game.make_move(1)

    %{board: board} = game    
    assert Board.render(board) <> "\n" == """
      .......
      .......
      .......
      .......
      O......
      XX.....
      """
  end

  test "win at index" do
    game = Game.default |>
      Game.make_move(0) |>
      Game.make_move(1) |>
      Game.make_move(0) |>
      Game.make_move(1) |>
      Game.make_move(0) |>
      Game.make_move(1)
    assert ! Game.win_at_index?(game, {0, 0})
    won_game = game |> Game.make_move(0)
    assert Game.win_at_index?(won_game, {0, 0})
  end

  test "is win" do
    game = Game.default |>
      Game.make_move(0) |>
      Game.make_move(1) |>
      Game.make_move(0) |>
      Game.make_move(1) |>
      Game.make_move(0) |>
      Game.make_move(1)
    assert ! Game.is_win?(game)
    won_game = game |> Game.make_move(0)
    assert Game.is_win?(won_game)
  end
end
