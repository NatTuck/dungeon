# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Can't use any libs here, so we get this:
home = System.get_env("HOME")
secret = "#{home}/.config/dungeon/base.key"
System.cmd("mkdir", ["-p", "#{home}/.config/dungeon"])
unless File.exists?(secret) do
  System.cmd("bash", ["-c", "head -c 16 /dev/urandom | sha256sum | head -c 64 > #{secret}"])
end

# Configures the endpoint
config :dungeon, Dungeon.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: File.read!(secret),
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: Dungeon.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Configure phoenix generators
config :phoenix, :generators,
  migration: true,
  binary_id: false

