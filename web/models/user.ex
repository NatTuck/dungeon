defmodule Dungeon.User do
  use Dungeon.Web, :model
  alias Dungeon.Repo

  schema "users" do
    field :email, :string
    field :pw_hash, :string
    field :ent_id, :integer

    timestamps
  end

  @required_fields ~w(email pw_hash ent_id)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def find_by_email!(email) do
    Repo.get_by!(Dungeon.User, email: email)
  end

  def find!(id) do
    Repo.get!(Dungeon.User, id)
  end
end
