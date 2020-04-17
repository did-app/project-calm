defmodule Calm.MessageTest do
  use Calm.RepoCase
  alias Calm.Invite
  alias Calm.Message

  setup do
    params = %{"subject" => Base.encode32(:crypto.strong_rand_bytes(10))}
    {:ok, thread} = Calm.Thread.create(params)
    {:ok, %{thread: thread}}
  end

  test "Will read messages in order", setup do
    %{thread: thread} = setup
    secret = Invite.generate_secret()
    {:ok, invite_a} = Invite.create(thread, %{"nickname" => "Anne", "color" => "blue"}, secret)
    secret = Invite.generate_secret()
    {:ok, invite_b} = Invite.create(thread, %{"nickname" => "Bill", "color" => "gray"}, secret)

    {:ok, _} = Invite.post_message(invite_a, %{"text" => "This is my first message"})
    {:ok, _} = Invite.post_message(invite_b, %{"text" => "Hey, I've sent a reply"})
    {:ok, _} = Invite.post_message(invite_b, %{"text" => "And, one more thing"})

    [m1, m2, m3] = Message.load_thread(thread.id)
    assert m1.cursor == 0
    assert m2.cursor == 1
    assert m3.cursor == 2

    assert m1.text == "This is my first message"
    assert m1.invite.nickname == "Anne"
  end
end
