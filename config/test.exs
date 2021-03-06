use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :dungeon, Dungeon.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :dungeon, Dungeon.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "dungeon",
  password: "xoochoh4if0M",
  database: "dungeon_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
