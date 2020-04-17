defmodule Calm.WWW.Actions.OpenInvite do
  use Raxx.SimpleServer

  def handle_request(request = %{method: :GET}, config) do
    ["i", invite_id, secret] = request.path
    {:ok, invite} = Calm.Invite.fetch_by_id(invite_id)
    {:ok, true} = Calm.Invite.check_secret(invite, secret)

    {:ok, session} = Raxx.Session.extract(request, config.session_config)
    session = session || %{threads: %{}}
    threads = session.threads
    threads = Map.put(threads, invite.thread_id, {invite.id, secret})
    session = %{session | threads: threads}

    redirect("/t/#{invite.thread_id}")
    |> Raxx.Session.embed(session, config.session_config)
  end
end
