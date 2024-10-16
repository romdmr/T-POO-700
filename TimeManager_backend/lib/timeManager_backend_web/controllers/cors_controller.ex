defmodule TimeManagerBackendWeb.CORSController do
  use TimeManagerBackendWeb, :controller

  def options(conn, _params) do
    conn
    |> put_resp_header("access-control-allow-origin", "*")
    |> put_resp_header("access-control-allow-methods", "GET, POST, OPTIONS, DELETE, PUT")
    |> put_resp_header("access-control-allow-headers", "authorization, content-type")
    |> send_resp(204, "")
  end
end
