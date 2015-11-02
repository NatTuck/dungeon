defmodule Dungeon.Router do
  use Dungeon.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Dungeon do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/play", PageController, :play

    resources "/users", UserController
    resources "/ents",  EntController
    resources "/rooms", RoomController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Dungeon do
  #   pipe_through :api
  # end
end
