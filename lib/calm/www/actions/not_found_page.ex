defmodule Calm.WWW.Actions.NotFoundPage do
  use Raxx.SimpleServer

  use Calm.WWW.Layout,
    arguments: [],
    optional: [title: "Nothing Here"]

  @impl Raxx.SimpleServer
  def handle_request(request, _state) do
    IO.inspect(request)

    response(:not_found)
    |> render()
  end
end
