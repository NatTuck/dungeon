defmodule Dungeon.RoomSvr do
  use GenServer
  import Ecto.Query

  # Client Operations
  def start_link(room_id) do
    GenServer.start_link(__MODULE__, room_id)
  end

  def move_to(pid, ent_id) do
    GenServer.call(:move_to, ent_id)
  end

  def ents(pid) do
    GenServer.call(pid, :ents)
  end

  # Server Callbacks
  defp db_load(room_id) do
    room = Dungeon.Repo.get!(Dungeon.Room, room_id, [])
    ents = Dungeon.Repo.all(from e in Dungeon.Ent, where: e.room_id == ^room_id)
    %{
      room: room,
      ents: ents,
    }
  end

  defp db_save(data) do
    :ok
  end

  def init(room_id) do
    {:ok, db_load(room_id)}
  end

  def handle_cast(:reload, data) do
    {:noreply, db_load(data[:room].id)}
  end

  def handle_call(:ents, _from, data) do
    {:reply, data[:ents], data}
  end

  def handle_call(:state, _from, data) do
    {:reply, data, data}
  end
end
