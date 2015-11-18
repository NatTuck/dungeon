defmodule Dungeon.EntControllerTest do
  use Dungeon.ConnCase

  alias Dungeon.Factory
  alias Dungeon.Ent
  @valid_attrs %{desc: "some content", name: "some content", room_id: 42, stats: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    conn = assign(conn, :user, Factory.create(:user))
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, ent_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing ents"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, ent_path(conn, :new)
    assert html_response(conn, 200) =~ "New ent"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, ent_path(conn, :create), ent: @valid_attrs
    assert redirected_to(conn) == ent_path(conn, :index)
    assert Repo.get_by(Ent, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, ent_path(conn, :create), ent: @invalid_attrs
    assert html_response(conn, 200) =~ "New ent"
  end

  test "shows chosen resource", %{conn: conn} do
    ent = Repo.insert! %Ent{}
    conn = get conn, ent_path(conn, :show, ent)
    assert html_response(conn, 200) =~ "Show ent"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, ent_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    ent = Repo.insert! %Ent{}
    conn = get conn, ent_path(conn, :edit, ent)
    assert html_response(conn, 200) =~ "Edit ent"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    ent = Repo.insert! %Ent{}
    conn = put conn, ent_path(conn, :update, ent), ent: @valid_attrs
    assert redirected_to(conn) == ent_path(conn, :show, ent)
    assert Repo.get_by(Ent, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    ent = Repo.insert! %Ent{}
    conn = put conn, ent_path(conn, :update, ent), ent: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit ent"
  end

  test "deletes chosen resource", %{conn: conn} do
    ent = Repo.insert! %Ent{}
    conn = delete conn, ent_path(conn, :delete, ent)
    assert redirected_to(conn) == ent_path(conn, :index)
    refute Repo.get(Ent, ent.id)
  end
end
