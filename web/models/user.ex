defmodule Dungeon.User do
  use Dungeon.Web, :model
  alias Dungeon.Repo

  schema "users" do
    field :email, :string
    field :pw_hash, :string

    timestamps
  end

  @required_fields ~w(email pw_hash)
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

  def find_by_email(email) do
    Repo.one!(from u in Dungeon.User, where: u.email == ^email)
  end
end
