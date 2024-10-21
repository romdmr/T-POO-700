defmodule TimeManagerBackend.Application do
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TimeManagerBackendWeb.Telemetry,
      TimeManagerBackend.Repo,
      {DNSCluster, query: Application.get_env(:timeManager_backend, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TimeManagerBackend.PubSub},
      {Finch, name: TimeManagerBackend.Finch},

      TimeManagerBackendWeb.Endpoint
    ]

    opts = [strategy: :one_for_one, name: TimeManagerBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @impl true
  def config_change(changed, _new, removed) do
    TimeManagerBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
