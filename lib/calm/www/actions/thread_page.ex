defmodule Calm.WWW.Actions.ThreadPage do
  use Raxx.SimpleServer
  use Calm.WWW.Layout, arguments: [:csrf_token]

  def handle_request(_request, _config) do
    response(:ok)
    |> render("dummy")
  end
end
