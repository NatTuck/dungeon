defmodule Dungeon.PageController do
  use Dungeon.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def play(conn, _params) do
    render conn, "play.html", user_id: 5
  end
end
