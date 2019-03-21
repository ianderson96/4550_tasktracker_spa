defmodule TasktrackerSpa.Repo do
  use Ecto.Repo,
    otp_app: :tasktracker_spa,
    adapter: Ecto.Adapters.Postgres
end
