defmodule Dungeon.PlayController do
  use Dungeon.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
