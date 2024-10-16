defmodule TimeManagerBackend.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TimeManagerBackendWeb.Telemetry,
      TimeManagerBackend.Repo,
      {DNSCluster, query: Application.get_env(:timeManager_backend, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: TimeManagerBackend.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: TimeManagerBackend.Finch},
      # Start a worker by calling: TimeManagerBackend.Worker.start_link(arg)
      # {TimeManagerBackend.Worker, arg},
      # Start to serve requests, typically the last entry
      TimeManagerBackendWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: TimeManagerBackend.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TimeManagerBackendWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
