defmodule Calm.WWW.Actions.OpenInvite do
  use Raxx.SimpleServer

  def handle_request(request, _config) do
    ["i", invite_id, secret] = request.path
    {:ok, invite} = Calm.Invite.fetch_by_id(invite_id)
    {:ok, true} = Calm.Invite.check_secret(invite, secret)

    # TODO :update_session
    redirect("/t/#{invite.thread_id}")
  end
end
