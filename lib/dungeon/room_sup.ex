defmodule Dungeon.RoomSup do
  use GenServer
  @name :room_sup

  # Client operations.
  def start_link() do
    GenServer.start_link(__MODULE__, %{}, [name: @name])
  end

  def get(room_id) do
    GenServer.call(@name, {:get, room_id})
  end

  # Server operations.
  def init(rooms) do
    Process.flag(:trap_exit, true)
    {:ok, rooms}
  end

  def handle_call({:get, room_id}, _from, rooms) do
    case rooms[room_id] do
      nil ->
        {:ok, pid} = Dungeon.RoomSv.start_link(room_id)
        rooms = Dict.put(rooms, room_id, pid)
        {:reply, {:ok, pid}, rooms}
      pid ->
        {:reply, {:ok, pid}, rooms}
    end
  end
  
  def handle_info({:EXIT, _pid, {:bored, room_id}}, rooms) do
    rooms = Dict.delete(rooms, room_id)
    {:noreply, rooms}
  end
  
  def handle_info({:EXIT, _pid, reason}, state) do
    {:stop, {"Child failed", reason}, state}
  end
end
