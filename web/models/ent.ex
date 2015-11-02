defmodule Dungeon.Ent do
  use Dungeon.Web, :model

  schema "ents" do
    field :name, :string
    field :desc, :string
    field :stats, :string
    field :room_id, :integer

    timestamps
  end

  @required_fields ~w(name desc stats room_id)
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
end
