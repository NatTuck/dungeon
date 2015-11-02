defmodule Dungeon.Repo.Migrations.CreateRoom do
  use Ecto.Migration

  def change do
    create table(:rooms) do
      add :name, :string
      add :desc, :text
      add :stats, :text

      timestamps
    end

  end
end
