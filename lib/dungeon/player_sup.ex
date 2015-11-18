defmodule Dungeon.PlayerSup do
  use GenServer
  @name :player_sup

  # Client Operations
  def start_link() do
    GenServer.start_link(__MODULE__, %{}, [name: @name])
  end

  def get(player_id) do
    GenServer.call(@name, {:get, player_id})
  end

  # Server Operations
  def init(players) do
    Process.flag(:trap_exit, true)
    {:ok, players}
  end

  def handle_call({:get, player_id}, _from, players) do
    case players[player_id] do
      nil ->
        {:ok, pid} = Dungeon.PlayerSv.start_link(player_id)
        players = Dict.put(players, player_id, pid)
        {:reply, {:ok, pid}, players}
      pid ->
        {:reply, {:ok, pid}, players}
    end
  end

  def handle_info({:EXIT, _pid, {:bored, player_id}}, players) do
    players = Dict.delete(players, player_id)
    {:noreply, players}
  end
  
  def handle_info({:EXIT, _pid, reason}, state) do
    {:stop, {"Child failed", reason}, state}
  end
end
