defmodule Dungeon.EntActions do
  # These are operations for Player and Mob entities
  # to use.

  def sub_room(ent, room_id) do
    Phoenix.PubSub.unsubscribe(Dungeon.PubSub, self(), "rooms:#{ent.room_id}")
    Phoenix.PubSub.subscribe(Dungeon.PubSub, self(), "rooms:#{room_id}")
  end

  def move_to(ent, room_id) do
    sub_room(ent, room_id)

    change = Dungeon.Ent.changeset(ent, %{room_id: room_id})
    Dungeon.Repo.update(change)
  end
end
