defmodule LiberatorExample.Repo do
  use Ecto.Repo,
    otp_app: :liberator_example,
    adapter: Ecto.Adapters.Postgres
end
