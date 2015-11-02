defmodule Dungeon.RoomTest do
  use Dungeon.ModelCase

  alias Dungeon.Room

  @valid_attrs %{desc: "some content", name: "some content", stats: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Room.changeset(%Room{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Room.changeset(%Room{}, @invalid_attrs)
    refute changeset.valid?
  end
end
