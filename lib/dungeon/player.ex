defmodule Dungeon.Player do
  use GenServer
  import Ecto.Query

  # Client
  def start_link(player_id) do
    GenServer.start_link(__MODULE__, player_id, [])
  end

  def get(pid) do
    GenServer.call(pid, :get)
  end

  # Server
  def init(player_id) do
    user = Dungeon.Repo.get!(Dungeon.User, player_id)
    ent  = Dungeon.Repo.get!(Dungeon.Ent, user.ent_id)
    data = %{
      user: user,
      ent:  ent,
    }
    {:ok, data}
  end

  def handle_call(:get, _from, data) do
    {:reply, data, data}
  end

  defp move_to(ent, to_id) do
    Phoenix.PubSub.unsubscribe(Dungeon.PubSub, self(), "rooms:" <> ent.room_id)
    Phoenix.PubSub.subscribe(Dungeon.PubSub, self(), "rooms:" <> to_id)

    change = Dungeon.Ent.changeset(ent, %{room_id: to_id})
    Dungeon.Repo.update(change)
  end
end
