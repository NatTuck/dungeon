
defmodule Dungeon.Router do
  use Dungeon.Web, :router
  import Dungeon.Plugs

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authed do
    plug :authenticate
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Dungeon do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    post "/login", PageController, :login
    post "/logout", PageController, :logout
  end

  scope "/play", Dungeon do
    pipe_through :browser
    pipe_through :authed

    get "/", PlayController, :index
  end

  scope "/build", Dungeon do
    pipe_through :browser
    pipe_through :authed

    get "/", PageController, :build_index
    resources "/users", UserController
    resources "/ents",  EntController
    resources "/rooms", RoomController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Dungeon do
  #   pipe_through :api
  # end
end

