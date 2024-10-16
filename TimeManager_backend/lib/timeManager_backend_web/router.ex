defmodule TimeManagerBackendWeb.Router do
  use TimeManagerBackendWeb, :router

  pipeline :api do
    plug(:accepts, ["json"])
    # plug(CORSPlug, origin: "http://localhost:5173")
  end

  scope "/api", TimeManagerBackendWeb do
    pipe_through(:api)

    # match(:options, "/*path", TimeManagerBackendWeb.CORSController, :options)

    resources("/teams", TeamController, except: [:new, :edit])
    resources("/roles", RoleController, except: [:new, :edit])
    resources("/users", UserController, except: [:new, :edit])
    resources("/working_times", WorkingTimeController, except: [:new, :edit])
    resources("/clocks", ClockController, except: [:new, :edit])
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:timeManager_backend, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through([:fetch_session, :protect_from_forgery])

      live_dashboard("/dashboard", metrics: TimeManagerBackendWeb.Telemetry)
      forward("/mailbox", Plug.Swoosh.MailboxPreview)
    end
  end
end
