defmodule Mix.Tasks.StartConversation do
  use Mix.Task
  require Logger

  def run(args) do
    Application.ensure_all_started(:calm)
    [nickname] = args

    subject = "#{nickname} & Peter Conversation"
    {:ok, thread} = Calm.Thread.create(%{"subject" => subject})
    Logger.info("Thread created with id: #{thread.id}")

    secret = Calm.Invite.generate_secret()

    {:ok, invite} =
      Calm.Invite.create(thread, %{"nickname" => "Peter", "color" => "gray"}, secret)

    Logger.info("Invite created for Peter with path: '/i/#{invite.id}/#{secret}'")

    color =
      Enum.random(["red", "orange", "yellow", "green", "teal", "blue", "indigo", "purple", "pink"])

    secret = Calm.Invite.generate_secret()

    {:ok, invite} =
      Calm.Invite.create(thread, %{"nickname" => nickname, "color" => color}, secret)

    Logger.info("Invite created for #{nickname} with path: '/i/#{invite.id}/#{secret}'")
  end
end
