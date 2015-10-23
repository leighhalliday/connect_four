defmodule ConnectFour.Board do
  use Supervisor

  @registered_name ConnectFourBoard
  @last_row 6
  @last_column 7

  def start_link do
    Supervisor.start_link(__MODULE__, [], [name: @registered_name])
  end

  def init(_args) do
    children =
      for t <- spaces do
        worker(ConnectFour.Space, [t], id: t)
      end
    supervise(children, strategy: :one_for_one)
  end

  def spaces do
    for row <- 1..@last_row, column <- 1..@last_column, do: {row, column}
  end

end