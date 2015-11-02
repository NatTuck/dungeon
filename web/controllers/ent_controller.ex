defmodule Dungeon.EntController do
  use Dungeon.Web, :controller

  alias Dungeon.Ent

  plug :scrub_params, "ent" when action in [:create, :update]

  def index(conn, _params) do
    ents = Repo.all(Ent)
    render(conn, "index.html", ents: ents)
  end

  def new(conn, _params) do
    changeset = Ent.changeset(%Ent{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"ent" => ent_params}) do
    changeset = Ent.changeset(%Ent{}, ent_params)

    case Repo.insert(changeset) do
      {:ok, _ent} ->
        conn
        |> put_flash(:info, "Ent created successfully.")
        |> redirect(to: ent_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    ent = Repo.get!(Ent, id)
    render(conn, "show.html", ent: ent)
  end

  def edit(conn, %{"id" => id}) do
    ent = Repo.get!(Ent, id)
    changeset = Ent.changeset(ent)
    render(conn, "edit.html", ent: ent, changeset: changeset)
  end

  def update(conn, %{"id" => id, "ent" => ent_params}) do
    ent = Repo.get!(Ent, id)
    changeset = Ent.changeset(ent, ent_params)

    case Repo.update(changeset) do
      {:ok, ent} ->
        conn
        |> put_flash(:info, "Ent updated successfully.")
        |> redirect(to: ent_path(conn, :show, ent))
      {:error, changeset} ->
        render(conn, "edit.html", ent: ent, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    ent = Repo.get!(Ent, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(ent)

    conn
    |> put_flash(:info, "Ent deleted successfully.")
    |> redirect(to: ent_path(conn, :index))
  end
end
