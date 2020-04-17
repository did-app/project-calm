defmodule Calm.InviteTest do
  use Calm.RepoCase
  alias Calm.Invite

  setup do
    params = %{"subject" => Base.encode32(:crypto.strong_rand_bytes(10))}
    {:ok, thread} = Calm.Thread.create(params)
    {:ok, %{thread: thread}}
  end

  test "Can create an invite", setup do
    %{thread: thread} = setup
    secret = Invite.generate_secret()
    {:ok, invite} = Invite.create(thread, %{"nickname" => "Bill", "color" => "blue"}, secret)
    # Can't do same name twice
    {:error, _} = Invite.create(thread, %{"nickname" => "Bill", "color" => "blue"}, secret)
    # Can't save invalid color
    {:error, _} = Invite.create(thread, %{"nickname" => "Rango", "color" => "puce"}, secret)
    # Can't save invalid nickname
    {:error, _} = Invite.create(thread, %{"nickname" => "R", "color" => "puce"}, secret)
  end

  test "can load from id", setup do
    %{thread: thread} = setup
    secret = Invite.generate_secret()
    {:ok, %{id: id}} = Invite.create(thread, %{"nickname" => "Bill", "color" => "blue"}, secret)

    {:ok, invite} = Invite.fetch_by_id(id)
    assert invite.thread == thread
  end

  test "check secret", setup do
    %{thread: thread} = setup
    secret = Invite.generate_secret()
    {:ok, invite} = Invite.create(thread, %{"nickname" => "Bill", "color" => "blue"}, secret)

    assert {:ok, true} = Invite.check_secret(invite, secret)
    assert {:error, _} = Invite.check_secret(invite, Invite.generate_secret())
  end
end
