# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :elm_dbz, ElmDbz.Endpoint,
  url: [host: "localhost"],
  root: Path.dirname(__DIR__),
  secret_key_base: "M5RXG9wEKL5DTWESQ95iPEMA0mHElQMSWQ6Kgh7WlFXKMgwBlqRQKSb1msh/LVTx",
  render_errors: [accepts: ~w(html json)],
  pubsub: [name: ElmDbz.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :bolt_sips, Bolt,
  hostname: 'localhost',
  basic_auth: [username: "neo4j", password: "dbz"]
  #port: 7474,
  #pool_size: 5,
  #max_overflow: 1

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
