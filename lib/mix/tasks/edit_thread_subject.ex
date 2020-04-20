defmodule Mix.Tasks.EditThreadSubject do
  use Mix.Task
  require Logger

  def run(args) do
    Application.ensure_all_started(:calm)
    [thread_id, subject] = args
    {:ok, thread} = Calm.Thread.edit_subject(thread_id, subject)
    Logger.info("Thread updated with id: #{thread.id}")
  end
end
