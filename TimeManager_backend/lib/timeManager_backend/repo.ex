defmodule TimeManagerBackend.Repo do
  use Ecto.Repo,
    otp_app: :timeManager_backend,
    adapter: Ecto.Adapters.Postgres
end
