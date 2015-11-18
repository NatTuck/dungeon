defmodule Dungeon.Plugs do
  import Plug.Conn
  import Phoenix.Controller

  def authenticate(conn, _args) do
    user_id = get_session(conn, "user_id")
    if user_id do
      user = Dungeon.User.find!(user_id)
      conn
      |> assign(:user, user)
    else
      conn
      |> put_flash(:error, "Must be logged in")
      |> redirect(to: "/")
      |> halt
    end
  end
end
