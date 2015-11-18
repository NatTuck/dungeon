defmodule Dungeon.RoomSv do
  use GenServer
  import Ecto.Query
  
  # Client
  def start_link(room_id) do
    GenServer.start_link(__MODULE__, room_id, [])
  end

  def get(pid) do
    GenServer.call(pid, :get)
  end

  # Server
  def init(room_id) do
    room = Dungeon.Repo.get!(Dungeon.Room, room_id)
    ents = Dungeon.Repo.all from e in Dungeon.Ent, where: e.room_id == ^room_id
    
    data = %{
      room: room,
      ents: ents,
    }
    {:ok, data}
  end

  def handle_call(:get, _pid, data) do
    {:reply, data, data}
  end
end
