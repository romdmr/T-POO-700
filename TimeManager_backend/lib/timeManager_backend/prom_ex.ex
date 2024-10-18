defmodule TimeManagerBackend.PromEx do
  use PromEx, otp_app: :timeManager_backend

  alias PromEx.Plugins.Application
  alias PromEx.Plugins.Phoenix
  alias PromEx.Plugins.Ecto

  @impl true
  def plugins do
    [
      Application,
      Phoenix,
      Ecto
    ]
  end
end
