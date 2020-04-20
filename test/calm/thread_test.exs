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

  test "Can edit subject of a thread" do
    params = %{"subject" => "A new thread has started"}
    {:ok, thread} = Thread.create(params)
    {:ok, thread} = Thread.edit_subject(thread.id, "Updated subject")

    assert thread == Calm.Repo.get(Thread, thread.id)
    assert thread.subject == "Updated subject"
  end

  # params = %{"subject" => Base.encode32(:crypto.strong_rand_bytes(10))}
end
