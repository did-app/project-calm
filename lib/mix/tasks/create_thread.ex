defmodule Mix.Tasks.CreateThread do
  use Mix.Task
  require Logger

  def run(args) do
    Application.ensure_all_started(:calm)
    [subject] = args
    {:ok, thread} = Calm.Thread.create(%{"subject" => subject})
    Logger.info("Thread created with id: #{thread.id}")
  end
end
