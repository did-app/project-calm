defmodule Calm.ThreadTest do
  use Calm.RepoCase
  alias Calm.Thread

  test "Create a new thread" do
    params = %{"subject" => "A new thread has started"}
    {:ok, thread} = Thread.create(params)

    assert thread == Calm.Repo.get(Thread, thread.id)
  end

  test "Cannot create a thread with small subject" do
    params = %{"subject" => "A"}
    {:error, _} = Thread.create(params)
  end

  # params = %{"subject" => Base.encode32(:crypto.strong_rand_bytes(10))}
end
