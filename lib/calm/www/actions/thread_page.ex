defmodule Calm.WWW.Actions.ThreadPage do
  use Raxx.SimpleServer
  use Calm.WWW.Layout, arguments: [:invite, :messages, :csrf_token]

  def handle_request(request, config) do
    ["t", thread_id] = request.path
    {thread_id, ""} = Integer.parse(thread_id)
    {:ok, session} = Raxx.Session.extract(request, config.session_config)
    {:ok, invite_id} = Map.fetch(session.threads, thread_id)
    {:ok, invite} = Calm.Invite.fetch_by_id(invite_id)

    messages = Calm.Message.load_thread(invite.thread_id)

    {csrf_token, session} = Raxx.Session.get_csrf_token(session)

    response(:ok)
    |> render(invite, messages, csrf_token)
    |> Raxx.Session.embed(session, config.session_config)
  end
end
