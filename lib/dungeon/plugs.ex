defmodule Dungeon.Plugs do
  import Plug.Conn
  import Phoenix.Controller

  def bail_out(conn, _args) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, "Lolface")
    |> halt
  end

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
    end
  end
end
