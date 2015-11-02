defmodule Dungeon.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :pw_hash, :string
      add :ent_id, :integer

      timestamps
    end

  end
end
