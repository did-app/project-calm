defmodule Calm.WWW.Actions.HomePage do
  use Raxx.SimpleServer
  use Calm.WWW.Layout, arguments: [:unread, :recent]

  @impl Raxx.SimpleServer
  def handle_request(request = %{method: :GET}, config) do
    {:ok, session} = Raxx.Session.extract(request, config.session_config)
    session = session || %{threads: %{}}
    thread_ids = Map.keys(session.threads)

    latest = load_latest(thread_ids)

    # NOTE this shows up as a charlist
    invite_ids = for {_key, {invite_id, _invite_secret}} <- session.threads, do: invite_id

    latest =
      Enum.group_by(latest, fn message ->
        Enum.member?(invite_ids, message.invite_id)
      end)

    unread = Map.get(latest, false, [])
    recent = Map.get(latest, true, [])

    response(:ok)
    |> render(unread, recent)
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
