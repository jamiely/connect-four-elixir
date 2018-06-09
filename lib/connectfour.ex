defmodule ConnectFour do
  @moduledoc """
  Documentation for ConnectFour.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ConnectFour.main(1)

  """
  def main(_) do
    loop(Game.default)    
  end

  @doc """
  The primary game loop.
  """
  def loop(game) do
    IO.puts Game.render(game)

    winner = Game.is_win?(game)
    cond do
      winner -> IO.puts "#{winner} has won"
      ! Game.moves_left?(game) -> IO.puts "There are no moves left"
      true -> game_in_progress(game)
    end
  end

  @doc """
  Retrieves the column which the user wants to make a move in
  """
  def get_column(game) do
    IO.gets("#{game[:current_marker]}'s move? [0-6]")
      |> String.trim |> Integer.parse
  end

  @doc """
  Called when the parsed column is invalid because it cannot be converted to
  an integer.
  """
  def bad_column_parse(game) do
    IO.puts "Invalid column. Please try again"
    loop(game)
  end

  @doc """
  Attempts to place a marker in the passed column. If it is full, or out of
  bounds, then the game loop continues with the same state.
  """
  def attempt_move(game, column) do
    if Game.column_available?(game, column) do
      loop(Game.make_move(game, column))
    else
      invalid_column(game)
    end
  end

  @doc """
  Called when an invalid or full column is specified by the user.
  """
  def invalid_column(game) do
    IO.puts "That column is full or an invalid column. Try another one."
    loop(game)
  end

  @doc """
  Called from the game loop while the game is still in progress, meaning no
  one has won and the board is not full.
  """
  def game_in_progress(game) do
    case get_column(game) do
      :error -> bad_column_parse(game)
      {column, _} -> attempt_move(game, column)
    end
  end
end
