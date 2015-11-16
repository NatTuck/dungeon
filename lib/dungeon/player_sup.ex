defmodule Dungeon.PlayerSup do
  use GenServer
 
  # Client Operations
  def start_link() do
    GenServer.start_link(__MODULE__, %{}, [name: :player_boss])
  end

  def get(player_id) do
    GenServer.call(:player_boss, {:get, player_id})
  end

  # Server Operations
  def init(players) do
    Process.flag(:trap_exit, true)
    {:ok, players}
  end

  def handle_call({:get, player_id}, _from, players) do
    case players[player_id] do
      nil ->
        {:ok, pid} = Dungeon.Player.start_link(player_id)
        players = Dict.put(players, player_id, pid)
        {:reply, {:ok, pid}, players}
      pid ->
        {:reply, {:ok, pid}, players}
    end
  end

  def handle_info({:EXIT, _pid, :bored}, state) do
    {:noreply, state}
  end
  
  def handle_info({:EXIT, _pid, reason}, state) do
    {:stop, {"Child failed", reason}, state}
  end
end
