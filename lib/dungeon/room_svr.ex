defmodule Dungeon.RoomSvr do
  use GenServer
  import Ecto.Query

  # Client Operations
  def start_link(room_id) do
    GenServer.start_link(__MODULE__, room_id)
  end

  def ents(pid) do
    GenServer.call(pid, :ents)
  end

  # Server Callbacks

  def init(room_id) do
    room = Dungeon.Repo.get!(Dungeon.Room, room_id, [])
    ents = Dungeon.Repo.all from e in Dungeon.Ent, where: e.room_id == ^room_id
    {:ok, %{room: room, ents: ents}}
  end

  def handle_call(:ents, _from, data) do
    {:reply, data[:ents], data}
  end
end
