defmodule Calm.WWW.Actions.ThreadPage do
  use Raxx.SimpleServer
  use Calm.WWW.Layout, arguments: [:invite, :messages, :csrf_token]

  def handle_request(request = %{method: :GET}, config) do
    ["t", thread_id] = request.path
    {thread_id, ""} = Integer.parse(thread_id)
    {:ok, session} = Raxx.Session.extract(request, config.session_config)
    {:ok, {invite_id, _invite_secret}} = Map.fetch(session.threads, thread_id)
    {:ok, invite} = Calm.Invite.fetch_by_id(invite_id)

    messages = Calm.Message.load_thread(invite.thread_id)

    {csrf_token, session} = Raxx.Session.get_csrf_token(session)

    response(:ok)
    |> render(invite, messages, csrf_token, title: invite.thread.subject)
    |> Raxx.Session.embed(session, config.session_config)
  end

  def update_time(message) do
    today = "#{Date.utc_today()}"

    %Calm.Message{inserted_at: inserted_at} = message

    inserted_at
    |> DateTime.to_string()
    |> String.slice(0, 16)
    |> String.replace(today, "Today")
  end
end
