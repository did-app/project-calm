defmodule Calm.WWW.Actions.HomePage do
  use Raxx.SimpleServer
  use Calm.WWW.Layout, arguments: [:latest]

  @impl Raxx.SimpleServer
  def handle_request(request = %{method: :GET}, config) do
    {:ok, session} = Raxx.Session.extract(request, config.session_config)
    session = session || %{threads: %{}}
    thread_ids = Map.keys(session.threads)

    latest = load_latest(thread_ids)

    response(:ok)
    |> render(latest)
  end

  def load_latest(thread_ids) do
    import Ecto.Query

    query =
      Calm.Message
      |> order_by([m], desc: m.inserted_at)
      |> join(:inner, [m], i in Calm.Invite, on: m.invite_id == i.id)
      |> where([m, i], i.thread_id in ^thread_ids)
      |> preload(invite: :thread)
      |> distinct([m, i], i.thread_id)

    Calm.Repo.all(query)
  end
end
