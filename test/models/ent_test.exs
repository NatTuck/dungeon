defmodule Dungeon.EntTest do
  use Dungeon.ModelCase

  alias Dungeon.Ent

  @valid_attrs %{desc: "some content", name: "some content", room_id: 42, stats: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Ent.changeset(%Ent{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Ent.changeset(%Ent{}, @invalid_attrs)
    refute changeset.valid?
  end
end
