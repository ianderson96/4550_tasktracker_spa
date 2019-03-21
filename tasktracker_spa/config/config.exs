# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :tasktracker_spa,
  ecto_repos: [TasktrackerSpa.Repo]

# Configures the endpoint
config :tasktracker_spa, TasktrackerSpaWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "NDcV7npjhzOxkcq2+rzlZimiU56qaW/aEF1ua25NpBqTK3crJH07GZwNvSn3YYqL",
  render_errors: [view: TasktrackerSpaWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TasktrackerSpa.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
