defmodule Dungeon.PageControllerTest do
  use Dungeon.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Dungeon Demo"
  end
end
