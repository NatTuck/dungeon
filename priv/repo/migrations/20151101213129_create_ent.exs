defmodule Dungeon.Repo.Migrations.CreateEnt do
  use Ecto.Migration

  def change do
    create table(:ents) do
      add :name, :string
      add :desc, :text
      add :stats, :text
      add :room_id, :integer

      timestamps
    end

  end
end
