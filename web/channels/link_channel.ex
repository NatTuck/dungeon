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
  # broadcast to everyone in the current topic (links:lobby).
  def handle_in("shout", payload, socket) do
    broadcast socket, "shout", payload
    {:noreply, socket}
  end

  def handle_in("click", data, socket) do
    IO.puts("click: " <> Poison.encode!(data))
    {date, _} = System.cmd("date", [])
    broadcast!(socket, "show", %{date: date})
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
