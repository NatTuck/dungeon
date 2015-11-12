defmodule Dungeon.LinkChannel do
  use Dungeon.Web, :channel

  def join("links:" <> link_id, payload, socket) do
    if authorized?(payload) do
      IO.puts "Join #{link_id}"
      {:ok, socket}
    else
      {:error, %{reason: "unauthorized"}}
    end
  end

  # Channels can be used in a request/response fashion
  # by sending replies to requests from the client
  def handle_in("ping", payload, socket) do
    {:reply, {:ok, payload}, socket}
  end

  # It is also common to receive messages from the client and
  # broadcast to everyone in the current topic.
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("heya", link_id, socket) do
    {date, _} = System.cmd("date", [])
    html = Phoenix.View.render_to_string(Dungeon.PlayView, "game.html", [date: date])
    broadcast!(socket, "show", %{game_html: html})

    {:ok, pid} = Dungeon.PlayerBoss.get(link_id)
    Dungeon.Player.poke(pid)

    {:noreply, socket}
  end

  # This is invoked every time a notification is being broadcast
  # to the client. The default implementation is just to push it
  # downstream but one could filter or change the event.
  def handle_out(event, payload, socket) do
    push socket, event, payload
    {:noreply, socket}
  end

  # Add authorization logic here as required.
  defp authorized?(_payload) do
    true
  end
end
