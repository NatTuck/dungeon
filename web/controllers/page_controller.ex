defmodule Dungeon.PageController do
  use Dungeon.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end

  def login(conn, params) do
    user = Dungeon.User.find_by_email!(params["user"]["email"])
    conn
    |> put_session("user_id", user.id)
    |> redirect(to: "/play")
  end

  def logout(conn, _params) do
    conn
    |> put_session("user_id", nil)
    |> redirect(to: "/")
  end
end
