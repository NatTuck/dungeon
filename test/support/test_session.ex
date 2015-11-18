defmodule Dungeon.TestSession do
  alias Plug.Conn
  alias Plug.Session
  alias Dungeon.Factory

  def init_session(data) do
    sess = Session.init(
      store: :cookie,
      key: "_app",
      encryption_salt: "doofus",
      signing_salt: "doofus",
    )

    user = Factory.create(:user)

    Map.put(:secret_key_base, String.duplicate("abcdefgh", 8))
  end
end
