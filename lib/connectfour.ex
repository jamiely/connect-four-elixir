defmodule ConnectFour do
  @moduledoc """
  Documentation for ConnectFour.
  """

  @doc """
  Hello world.

  ## Examples

      iex> ConnectFour.main(1)

  """
  def main(args) do
    loop(Game.default)    
  end

  def loop(game) do
    winner = Game.is_win?(game)
    IO.puts Game.render(game)
    cond do
      Game.is_win?(game) -> IO.puts "#{winner} has won"
      ! Game.moves_left?(game) -> IO.puts "There are no moves left"
      true ->
        case IO.gets("#{game[:current_marker]}'s move? [0-6]")
          |> String.trim |> Integer.parse do
          :error ->
            IO.puts "Invalid column. Please try again"
            loop(game)
          {column, _} ->
            if game |> Game.column_available?(column) do
              loop(Game.make_move(game, column))
            else
              IO.puts "That column is full or an invalid column. Try another one."
              loop(game)
            end
        end
    end
  end
end
