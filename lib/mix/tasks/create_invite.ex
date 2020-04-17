defmodule Mix.Tasks.CreateInvite do
  use Mix.Task
  require Logger

  def run(args) do
    Application.ensure_all_started(:calm)
    [thread_id, nickname, color] = args
    {:ok, thread} = Calm.Thread.fetch_by_id(thread_id)
    secret = Calm.Invite.generate_secret()
    IO.inspect(thread)

    {:ok, invite} =
      Calm.Invite.create(thread, %{"nickname" => nickname, "color" => color}, secret)

    IO.inspect(invite)
    Logger.info("Invite created with path: '/i/#{invite.id}/#{secret}'")
  end
end
