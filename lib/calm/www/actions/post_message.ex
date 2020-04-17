defmodule Calm.WWW.Actions.PostMessage do
  use Raxx.SimpleServer

  def handle_request(request, config) do
    ["t", thread_id, "post"] = request.path
    {thread_id, ""} = Integer.parse(thread_id)

    params = get_form(request)
    {:ok, csrf_token} = Map.fetch(params, "_csrf_token")

    {:ok, session} = Raxx.Session.extract(request, csrf_token, config.session_config)
    {:ok, invite_id} = Map.fetch(session.threads, thread_id)
    {:ok, invite} = Calm.Invite.fetch_by_id(invite_id)

    {:ok, message} = Calm.Invite.post_message(invite, params)
    redirect("/t/#{invite.thread_id}##{message.cursor}")
  end

  def get_form(request) do
    URI.decode_query(request.body || "")
  end
end
