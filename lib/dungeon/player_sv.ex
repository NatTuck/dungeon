defmodule Dungeon.PlayerSv do
  use GenServer
  import Ecto.Query

  # Client
  def start_link(player_id) do
    GenServer.start_link(__MODULE__, player_id, [])
  end

  def get(pid) do
    GenServer.call(pid, :get)
  end

  def poke(pid) do
    GenServer.call(pid, :poke)
  end

  # Server
  def init(player_id) do
    user = Dungeon.Repo.get!(Dungeon.User, player_id)
    ent  = Dungeon.Repo.get!(Dungeon.Ent,  user.ent_id)
    room = Dungeon.Repo.get!(Dungeon.Room, ent.room_id)

    data = %{
      user: user,
      ent:  ent,
      room: room,
    }
    {:ok, data}
  end

  def handle_call(:get, _from, data) do
    {:reply, data, data}
  end

  def handle_call(:poke, _from, data) do
    Dungeon.Endpoint.broadcast!(data[:chan], "goats", %{msg: "Hallo!"})

    {:reply, :ok, data}
  end

  def handle_info(msg, data) do
    {:noreply, data}
  end
end
