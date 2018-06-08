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
    if winner do
      IO.puts "#{winner} has won"
    else
      IO.puts Game.render(game)
      column = IO.gets("Your move? [0-6]")
      loop(Game.make_move(game, column |> String.trim |> String.to_integer))
    end
  end
end
