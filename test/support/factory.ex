defmodule Dungeon.Factory do
  use ExMachina.Ecto, repo: Dungeon.Repo

  def factory(:user, _attrs) do
    %Dungeon.User{
      email: sequence(:email, &"fred#{&1}@example.com"),
      pw_hash: "none",
      ent: build(:ent),
    }
  end

  def factory(:ent, _attrs) do
    %Dungeon.Ent{
      name: sequence(:name, &"Fred#{&1}"),
      desc: "He is unremarkable",
      stats: "{}",
      room: build(:room),
    }
  end

  def factory(:room, _attrs) do
    %Dungeon.Room{
      name: sequence(:name, &"Hall#{&1}"),
      desc: "The hall is dusty.",
      stats: "{}",
    }
  end
end
